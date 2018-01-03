package catalogue

// service.go contains the definition and implementation (business logic) of the
// catalogue service. Everything here is agnostic to the transport (HTTP).

import (
	"errors"
	"strings"
	"time"

	"github.com/go-kit/kit/log"
	"github.com/jmoiron/sqlx"
)

// Service is the catalogue service, providing read operations on a saleable
// catalogue of pop products.
type Service interface {
	List(tags []string, order string, pageNum, pageSize int) ([]Pop, error) // GET /catalogue
	Count(tags []string) (int, error)                                        // GET /catalogue/size
	Get(id string) (Pop, error)                                             // GET /catalogue/{id}
	Tags() ([]string, error)                                                 // GET /tags
	Health() []Health                                                        // GET /health
}

// Middleware decorates a Service.
type Middleware func(Service) Service

// Pop describes the thing on offer in the catalogue.
type Pop struct {
	ID          string   `json:"id" db:"id"`
	Name        string   `json:"name" db:"name"`
	Description string   `json:"description" db:"description"`
	ImageURL    []string `json:"imageUrl" db:"-"`
	ImageURL_1  string   `json:"-" db:"image_url_1"`
	ImageURL_2  string   `json:"-" db:"image_url_2"`
	Price       float32  `json:"price" db:"price"`
	Count       int      `json:"count" db:"count"`
	Tags        []string `json:"tag" db:"-"`
	TagString   string   `json:"-" db:"tag_name"`
}

// Health describes the health of a service
type Health struct {
	Service string `json:"service"`
	Status  string `json:"status"`
	Time    string `json:"time"`
}

// ErrNotFound is returned when there is no pop for a given ID.
var ErrNotFound = errors.New("not found")

// ErrDBConnection is returned when connection with the database fails.
var ErrDBConnection = errors.New("database connection error")

var baseQuery = "SELECT pop.pop_id AS id, pop.name, pop.description, pop.price, pop.count, pop.image_url_1, pop.image_url_2, GROUP_CONCAT(tag.name) AS tag_name FROM pop JOIN pop_tag ON pop.pop_id=pop_tag.pop_id JOIN tag ON pop_tag.tag_id=tag.tag_id"

// NewCatalogueService returns an implementation of the Service interface,
// with connection to an SQL database.
func NewCatalogueService(db *sqlx.DB, logger log.Logger) Service {
	return &catalogueService{
		db:     db,
		logger: logger,
	}
}

type catalogueService struct {
	db     *sqlx.DB
	logger log.Logger
}

func (s *catalogueService) List(tags []string, order string, pageNum, pageSize int) ([]Pop, error) {
	var pop []Pop
	query := baseQuery

	var args []interface{}

	for i, t := range tags {
		if i == 0 {
			query += " WHERE tag.name=?"
			args = append(args, t)
		} else {
			query += " OR tag.name=?"
			args = append(args, t)
		}
	}

	query += " GROUP BY id"

	if order != "" {
		query += " ORDER BY ?"
		args = append(args, order)
	}

	query += ";"

	err := s.db.Select(&pop, query, args...)
	if err != nil {
		s.logger.Log("database error", err)
		return []Pop{}, ErrDBConnection
	}
	for i, s := range pop {
		pop[i].ImageURL = []string{s.ImageURL_1, s.ImageURL_2}
		pop[i].Tags = strings.Split(s.TagString, ",")
	}

	// DEMO: Change 0 to 850
	time.Sleep(0 * time.Millisecond)

	pop = cut(pop, pageNum, pageSize)

	return pop, nil
}

func (s *catalogueService) Count(tags []string) (int, error) {
	query := "SELECT COUNT(DISTINCT pop.pop_id) FROM pop JOIN pop_tag ON pop.pop_id=pop_tag.pop_id JOIN tag ON pop_tag.tag_id=tag.tag_id"

	var args []interface{}

	for i, t := range tags {
		if i == 0 {
			query += " WHERE tag.name=?"
			args = append(args, t)
		} else {
			query += " OR tag.name=?"
			args = append(args, t)
		}
	}

	query += ";"

	sel, err := s.db.Prepare(query)

	if err != nil {
		s.logger.Log("database error", err)
		return 0, ErrDBConnection
	}
	defer sel.Close()

	var count int
	err = sel.QueryRow(args...).Scan(&count)

	if err != nil {
		s.logger.Log("database error", err)
		return 0, ErrDBConnection
	}

	return count, nil
}

func (s *catalogueService) Get(id string) (Pop, error) {
	query := baseQuery + " WHERE pop.pop_id =? GROUP BY pop.pop_id;"

	var pop Pop
	err := s.db.Get(&pop, query, id)
	if err != nil {
		s.logger.Log("database error", err)
		return Pop{}, ErrNotFound
	}

	pop.ImageURL = []string{pop.ImageURL_1, pop.ImageURL_2}
	pop.Tags = strings.Split(pop.TagString, ",")

	return pop, nil
}

func (s *catalogueService) Health() []Health {
	var health []Health
	dbstatus := "OK"

	err := s.db.Ping()
	if err != nil {
		dbstatus = "err"
	}

	app := Health{"catalogue", "OK", time.Now().String()}
	db := Health{"catalogue-db", dbstatus, time.Now().String()}

	health = append(health, app)
	health = append(health, db)

	return health
}

func (s *catalogueService) Tags() ([]string, error) {
	var tags []string
	query := "SELECT name FROM tag;"
	rows, err := s.db.Query(query)
	if err != nil {
		s.logger.Log("database error", err)
		return []string{}, ErrDBConnection
	}
	var tag string
	for rows.Next() {
		err = rows.Scan(&tag)
		if err != nil {
			s.logger.Log("database error", err)
			continue
		}
		tags = append(tags, tag)
	}
	return tags, nil
}

func cut(pop []Pop, pageNum, pageSize int) []Pop {
	if pageNum == 0 || pageSize == 0 {
		return []Pop{} // pageNum is 1-indexed
	}
	start := (pageNum * pageSize) - pageSize
	if start > len(pop) {
		return []Pop{}
	}
	end := (pageNum * pageSize)
	if end > len(pop) {
		end = len(pop)
	}
	return pop[start:end]
}

func contains(s []string, e string) bool {
	for _, a := range s {
		if a == e {
			return true
		}
	}
	return false
}
