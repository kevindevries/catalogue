FROM golang:1.7

RUN mkdir /app
COPY . /go/src/github.com/kevindevries/catalogue/
COPY images/ /images/

RUN go get -u github.com/FiloSottile/gvt
RUN cd /go/src/github.com/kevindevries/catalogue 
#&& gvt restore

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /app/main github.com/kevindevries/catalogue/cmd/cataloguesvc

CMD ["/app/main", "-port=80"]

EXPOSE 80
