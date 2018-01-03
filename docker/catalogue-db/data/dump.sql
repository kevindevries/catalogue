CREATE USER IF NOT EXISTS 'catalogue_user' IDENTIFIED BY 'default_password';

GRANT ALL ON popdb.* TO 'catalogue_user';

CREATE TABLE IF NOT EXISTS pop (
	sock_id varchar(40) NOT NULL, 
	name varchar(20), 
	description varchar(200), 
	price float, 
	count int, 
	image_url_1 varchar(40), 
	image_url_2 varchar(40), 
	PRIMARY KEY(pop_id)
);

CREATE TABLE IF NOT EXISTS tag (
	tag_id MEDIUMINT NOT NULL AUTO_INCREMENT, 
	name varchar(20), 
	PRIMARY KEY(tag_id)
);

CREATE TABLE IF NOT EXISTS pop_tag (
	pop_id varchar(40), 
	tag_id MEDIUMINT NOT NULL, 
	FOREIGN KEY (pop_id) 
		REFERENCES pop(pop_id), 
	FOREIGN KEY(tag_id)
		REFERENCES tag(tag_id)
);

INSERT INTO pop VALUES ("6d62d909-f957-430e-8689-b5129c0bb75e", "Kylo Ren", "Kylo Ren from Star Wars Episode VII. ", 14.99, 19, "/catalogue/images/kylo1.jpeg", "/catalogue/images/kylo2.jpg");
INSERT INTO pop VALUES ("a0a4f044-b040-410d-8ead-4de0446aec7e", "Chucky", "Chucky from Child's Play. ", 12.99, 6, "/catalogue/images/chucky1.jpeg", "/catalogue/images/chucky2.jpeg");
INSERT INTO pop VALUES ("808a2de1-1aaa-4c25-a9b9-6612e8f29a38", "Batman", "Classic Batman. ",  10.99, 32, "/catalogue/images/batman1.jpeg", "/catalogue/images/batman2.jpg");
INSERT INTO pop VALUES ("510a0d7e-8e83-4193-b483-e27e09ddc34d", "Logan", "Logan (aka Wolverine) from the blockbuster by the same name. ",  16.99, 23, "/catalogue/images/logan1.jpeg", "/catalogue/images/logan2.jpg");
INSERT INTO pop VALUES ("03fef6ac-1896-4ce8-bd69-b798f85c6e0b", "Eleven", "Eleven from the critically acclaimed Tv series Stranger Things. ",  14.99, 6, "/catalogue/images/eleven1.jpeg", "/catalogue/images/eleven2.jpeg");
INSERT INTO pop VALUES ("d3588630-ad8e-49df-bbd7-3167f7efb246", "Negan", "The sinister character Negan from the Tv series The Walking Dead. ",  16.99, 22, "/catalogue/images/negan1.jpeg", "/catalogue/images/negan2.jpeg");
INSERT INTO pop VALUES ("819e1fbf-8b7e-4f6d-811f-693534916a8b", "Morty", "The ever nervous Morty from the adult animated series Rick & Morty. ",  14.99, 3, "/catalogue/images/morty1.jpeg", "/catalogue/images/morty2.jpeg");
INSERT INTO pop VALUES ("zzz4f044-b040-410d-8ead-4de0446aec7e", "Jon Snow", "Hero Jon Snow from the critically acclaimed Tv series Game of Thrones. ",  15.99, 9, "/catalogue/images/snow1.jpg", "/catalogue/images/snow2.jpeg");
INSERT INTO pop VALUES ("3395a43e-2d88-40de-b95f-e00e1502085b", "Tracer", "Tracer a character from the game Overwatch. ",  14.99, 31, "/catalogue/images/tracer1.jpeg", "/catalogue/images/tracer2.jpeg");
INSERT INTO pop VALUES ("837ab141-399e-4c1f-9abc-bace40296bac", "Big Daddy", "Big Daddy from the record selling game Bioshock.",  19.99, 4, "/catalogue/images/daddy1.jpg", "/catalogue/images/daddy2.jpeg");
INSERT INTO pop VALUES ("375ff421-34d2-1ad2-3e32-105dd32a6011", "Cuphead", "The main character from the difficult but much loved game Cuphead.",  12.99, 24, "/catalogue/images/cuphead1.jpeg", "/catalogue/images/cuphead2.jpeg");
INSERT INTO pop VALUES ("4563d21e-442e-1a22-65ff-3575ee23a187", "Vault Boy", "Vault Boy from the game Fallout.",  11.99, 2, "/catalogue/images/fallout1.jpg", "/catalogue/images/fallout2.jpeg");
INSERT INTO pop VALUES ("75893ee2-3ae2-4e22-52aa-8902ea12f4d2", "Scorpion", "The poster boy character Scorpion from the Mortal Kombat series",  14.99, 6, "/catalogue/images/mk1.jpeg", "/catalogue/images/mk2.jpeg");
INSERT INTO pop VALUES ("3245ee39-3e21-6a11-628a-753a2284ef41", "Ryu", "The ever-present Ryu from the Street Fighter series. ",  14.99, 17, "/catalogue/images/ryu1.jpg", "/catalogue/images/ryu2.jpeg");

INSERT INTO tag (name) VALUES ("rare");
INSERT INTO tag (name) VALUES ("gaming");
INSERT INTO tag (name) VALUES ("movies");
INSERT INTO tag (name) VALUES ("new");
INSERT INTO tag (name) VALUES ("limited edition");
INSERT INTO tag (name) VALUES ("large");
INSERT INTO tag (name) VALUES ("tv");
INSERT INTO tag (name) VALUES ("offer");
INSERT INTO tag (name) VALUES ("cartoon");
INSERT INTO tag (name) VALUES ("adult");
INSERT INTO tag (name) VALUES ("classic");
INSERT INTO tag (name) VALUES ("evil");
INSERT INTO tag (name) VALUES ("fighting");
INSERT INTO tag (name) VALUES ("beatemup");

INSERT INTO pop_tag VALUES ("6d62d909-f957-430e-8689-b5129c0bb75e", "3");
INSERT INTO pop_tag VALUES ("6d62d909-f957-430e-8689-b5129c0bb75e", "4");
INSERT INTO pop_tag VALUES ("a0a4f044-b040-410d-8ead-4de0446aec7e", "1");
INSERT INTO pop_tag VALUES ("a0a4f044-b040-410d-8ead-4de0446aec7e", "3");
INSERT INTO pop_tag VALUES ("a0a4f044-b040-410d-8ead-4de0446aec7e", "5");
INSERT INTO pop_tag VALUES ("808a2de1-1aaa-4c25-a9b9-6612e8f29a38", "3");
INSERT INTO pop_tag VALUES ("808a2de1-1aaa-4c25-a9b9-6612e8f29a38", "7");
INSERT INTO pop_tag VALUES ("808a2de1-1aaa-4c25-a9b9-6612e8f29a38", "9");
INSERT INTO pop_tag VALUES ("808a2de1-1aaa-4c25-a9b9-6612e8f29a38", "11");
INSERT INTO pop_tag VALUES ("510a0d7e-8e83-4193-b483-e27e09ddc34d", "3");
INSERT INTO pop_tag VALUES ("510a0d7e-8e83-4193-b483-e27e09ddc34d", "4");
INSERT INTO pop_tag VALUES ("510a0d7e-8e83-4193-b483-e27e09ddc34d", "5");
INSERT INTO pop_tag VALUES ("03fef6ac-1896-4ce8-bd69-b798f85c6e0b", "7");
INSERT INTO pop_tag VALUES ("d3588630-ad8e-49df-bbd7-3167f7efb246", "4");
INSERT INTO pop_tag VALUES ("d3588630-ad8e-49df-bbd7-3167f7efb246", "7");
INSERT INTO pop_tag VALUES ("d3588630-ad8e-49df-bbd7-3167f7efb246", "10");
INSERT INTO pop_tag VALUES ("d3588630-ad8e-49df-bbd7-3167f7efb246", "12");
INSERT INTO pop_tag VALUES ("819e1fbf-8b7e-4f6d-811f-693534916a8b", "7");
INSERT INTO pop_tag VALUES ("819e1fbf-8b7e-4f6d-811f-693534916a8b", "9");
INSERT INTO pop_tag VALUES ("zzz4f044-b040-410d-8ead-4de0446aec7e", "4");
INSERT INTO pop_tag VALUES ("zzz4f044-b040-410d-8ead-4de0446aec7e", "7");
INSERT INTO pop_tag VALUES ("3395a43e-2d88-40de-b95f-e00e1502085b", "2");
INSERT INTO pop_tag VALUES ("3395a43e-2d88-40de-b95f-e00e1502085b", "5");
INSERT INTO pop_tag VALUES ("837ab141-399e-4c1f-9abc-bace40296bac", "2");
INSERT INTO pop_tag VALUES ("837ab141-399e-4c1f-9abc-bace40296bac", "6");
INSERT INTO pop_tag VALUES ("837ab141-399e-4c1f-9abc-bace40296bac", "8");
INSERT INTO pop_tag VALUES ("375ff421-34d2-1ad2-3e32-105dd32a6011", "2");
INSERT INTO pop_tag VALUES ("375ff421-34d2-1ad2-3e32-105dd32a6011", "4");
INSERT INTO pop_tag VALUES ("375ff421-34d2-1ad2-3e32-105dd32a6011", "9");
INSERT INTO pop_tag VALUES ("4563d21e-442e-1a22-65ff-3575ee23a187", "2");
INSERT INTO pop_tag VALUES ("4563d21e-442e-1a22-65ff-3575ee23a187", "8");
INSERT INTO pop_tag VALUES ("75893ee2-3ae2-4e22-52aa-8902ea12f4d2", "2");
INSERT INTO pop_tag VALUES ("75893ee2-3ae2-4e22-52aa-8902ea12f4d2", "11");
INSERT INTO pop_tag VALUES ("75893ee2-3ae2-4e22-52aa-8902ea12f4d2", "13");
INSERT INTO pop_tag VALUES ("3245ee39-3e21-6a11-628a-753a2284ef41", "2");
INSERT INTO pop_tag VALUES ("3245ee39-3e21-6a11-628a-753a2284ef41", "11");
INSERT INTO pop_tag VALUES ("3245ee39-3e21-6a11-628a-753a2284ef41", "14");





