CREATE DATABASE IF NOT EXISTS tasty ;
USE tasty;
SET autocommit = 1;

CREATE TABLE client (phone VARCHAR(30) NOT NULL PRIMARY KEY , name_clt VARCHAR(20),
prenom_clt VARCHAR(20),adr_clt VARCHAR(30) ,email VARCHAR(30) );

CREATE TABLE restaurant (id_rest INT NOT NULL PRIMARY KEY AUTO_INCREMENT, name_rest VARCHAR(20) NOT NULL,dureeliv VARCHAR(10),
adr_rest VARCHAR(20) NOT NULL,horaire VARCHAR(50) NOT NULL,service VARCHAR(50),favori BOOLEAN,
cuisine VARCHAR(100),img VARCHAR(50) NOT NULL,logo VARCHAR(50) NOT NULL, rating INT );

CREATE TABLE favori (id_fav INT NOT NULL PRIMARY KEY AUTO_INCREMENT,id_rest INT NOT NULL,phone VARCHAR(30) NOT NULL,favori BOOLEAN,
FOREIGN KEY (id_rest) REFERENCES restaurant(id_rest),
FOREIGN KEY (phone) REFERENCES client(phone)  );

CREATE TABLE categorie (id_cat INT NOT NULL PRIMARY KEY AUTO_INCREMENT, name_cat VARCHAR(20) NOT NULL,
id_rest INT NOT NULL, CONSTRAINT fk_categorie FOREIGN KEY (id_rest) REFERENCES restaurant(id_rest) );

CREATE TABLE article (id_art INT NOT NULL PRIMARY KEY AUTO_INCREMENT, name_art VARCHAR(20) NOT NULL,
prix FLOAT NOT NULL, descri VARCHAR(100),img VARCHAR(50) NOT NULL,id_cat INT NOT NULL, 
FOREIGN KEY (id_cat) REFERENCES categorie(id_cat));

CREATE TABLE taille (id_taille INT NOT NULL PRIMARY KEY AUTO_INCREMENT, name_taille VARCHAR(10) NOT NULL, price_taille FLOAT NULL,
id_cat INT NOT NULL,FOREIGN KEY (id_cat) REFERENCES categorie(id_cat) );

CREATE TABLE viande (id_viande INT NOT NULL PRIMARY KEY AUTO_INCREMENT, name_viande VARCHAR(10) NOT NULL, price_viande FLOAT NULL,
id_cat INT NOT NULL, FOREIGN KEY (id_cat) REFERENCES categorie(id_cat) );

CREATE TABLE sauce (id_sauce INT NOT NULL PRIMARY KEY AUTO_INCREMENT, name_sauce VARCHAR(30) NOT NULL, price_sauce FLOAT NULL,
id_cat INT NOT NULL,FOREIGN KEY (id_cat) REFERENCES categorie(id_cat));

CREATE TABLE frite (id_frite INT NOT NULL PRIMARY KEY AUTO_INCREMENT, name_frite VARCHAR(30) NOT NULL, price_frite FLOAT NULL,
id_cat INT NOT NULL,FOREIGN KEY (id_cat) REFERENCES categorie(id_cat));

CREATE TABLE gratine (id_gratine INT NOT NULL PRIMARY KEY AUTO_INCREMENT, name_gratine VARCHAR(30) NOT NULL, price_gratine FLOAT NULL,
id_cat INT NOT NULL, FOREIGN KEY (id_cat) REFERENCES categorie(id_cat));

CREATE TABLE commande (id_cmd INT NOT NULL PRIMARY KEY AUTO_INCREMENT,total FLOAT NOT NULL,STOTAL FLOAT NOT NULL,
etat_cmd VARCHAR(20) NOT NULL, date DATETIME NOT NULL,xlocyloc VARCHAR(40), phone VARCHAR(30) NOT NULL,idrest INT NOT NULL,
FOREIGN KEY (phone) REFERENCES client(phone),
FOREIGN KEY (idrest) REFERENCES restaurant(id_rest) );

CREATE TABLE detail_cmd (qte INT NOT NULL,S_total FLOAT NOT NULL, id_art INT NOT NULL,
id_cmd INT NOT NULL, PRIMARY KEY(id_art,id_cmd),FOREIGN KEY (id_art) REFERENCES article(id_art),
FOREIGN KEY (id_cmd) REFERENCES commande(id_cmd) );

CREATE TABLE admins (id_admin INT NOT NULL PRIMARY KEY AUTO_INCREMENT, name_admin VARCHAR(20),
prenom_admin VARCHAR(20),email_admin VARCHAR(30), password VARCHAR (20) NOT NULL);

CREATE TABLE livreur (id_livr INT NOT NULL PRIMARY KEY AUTO_INCREMENT, name_livr VARCHAR(20),
prenom_livr VARCHAR(20),adr_livr VARCHAR(30) ,email_livr VARCHAR(30), phone_livr INT NOT NULL,matricule INT NOT NULL,rating_liv INT NOT NULL
);

CREATE TABLE history (id_his INT NOT NULL PRIMARY KEY AUTO_INCREMENT,timestamp INT NOT NULL ,id_livr INT NOT NULL,
FOREIGN KEY (id_livr) REFERENCES livreur(id_livr));

CREATE TABLE position (id_position INT NOT NULL PRIMARY KEY AUTO_INCREMENT, xlocation FLOAT NOT NULL, ylocation FLOAT NOT NULL,id_cmd INT NOT NULL,
id_his INT NOT NULL, id_rest INT NOT NULL,  FOREIGN KEY (id_cmd) REFERENCES commande(id_cmd),
FOREIGN KEY (id_his) REFERENCES history(id_his),
FOREIGN KEY (id_rest) REFERENCES restaurant(id_rest) );


INSERT INTO restaurant VALUES (1,'Apex','10-20 min','Avenu SKikda','Saturday-Thursday 9:00-23:00','Park - Wifi',TRUE, 'Dishes-Chawarma',
'assets/images/restaurant0.jpg','assets/images/logo1.jpg',4);

INSERT INTO restaurant VALUES (2,'Pizza Time','20-30 min','Sonatiba Khanchla','Saturday-Thursday 11:00-23:00','Park - Play area',TRUE, 'Burger-Sandwich',
'assets/images/restaurant1.jpg','assets/images/logo2.png',2);

INSERT INTO restaurant VALUES (3,'Frenchy','25-40 min','Jimout Khanchla','Saturday-Thursday 9:00-22:00','Wifi',TRUE, 'Dishes-Pizza',
'assets/images/restaurant2.jpg','assets/images/logo3.png',3);

INSERT INTO restaurant VALUES (4,'Cafeteria Bridge','15-25 min','Belle Vue Constantine','Saturday-Thursday 11:30-00:00','Park - Wifi',TRUE, 'Dishes-Chawarma-Pizza',
'assets/images/restaurant3.jpg','assets/images/logo4.png',1);

INSERT INTO restaurant VALUES (5,'La caleche','10-20 min','Bouzaroura Skikda','Saturday-Thursday 9:00-23:00','Park',TRUE, 'Tacos-Chawarma',
'assets/images/restaurant4.jpg','assets/images/logo5.png',5);

INSERT INTO categorie VALUES (1,'Humbergers',1);
INSERT INTO categorie VALUES(2,'Humbergers',2);
INSERT INTO categorie VALUES(3,'Humbergers',3);
INSERT INTO categorie VALUES(4,'Humbergers',4);
INSERT INTO categorie VALUES(5,'Humbergers',5);
INSERT INTO categorie VALUES(6,'Sandwichs',1);
INSERT INTO categorie VALUES(7,'Sandwichs',2);
INSERT INTO categorie VALUES(8,'Sandwichs',3);
INSERT INTO categorie VALUES(9,'Sandwichs',4);
INSERT INTO categorie VALUES(10,'Sandwichs',5);
INSERT INTO categorie VALUES(11,'Pizza',1);
INSERT INTO categorie VALUES(12,'Pizza',2);
INSERT INTO categorie VALUES(13,'Pizza',3);
INSERT INTO categorie VALUES(14,'Pizza',4);
INSERT INTO categorie VALUES(15,'Pizza',5);
INSERT INTO categorie VALUES(16,'Tacos',1);
INSERT INTO categorie VALUES(17,'Tacos',2);
INSERT INTO categorie VALUES(18,'Tacos',3);
INSERT INTO categorie VALUES(19,'Tacos',4);
INSERT INTO categorie VALUES(20,'Tacos',5);
INSERT INTO categorie VALUES(21,'Plats',1);
INSERT INTO categorie VALUES(22,'Plats',2);
INSERT INTO categorie VALUES(23,'Plats',3);
INSERT INTO categorie VALUES(24,'Plats',4);
INSERT INTO categorie VALUES(25,'Plats',5);
INSERT INTO categorie VALUES(26,'Drinks',1);
INSERT INTO categorie VALUES(27,'Drinks',2);
INSERT INTO categorie VALUES(28,'Drinks',3);
INSERT INTO categorie VALUES(29,'Drinks',4);
INSERT INTO categorie VALUES(30,'Drinks',5);


INSERT INTO article VALUES (1,'Cheese Burger',180,'Meat - Fries - Cheese - Onion - Egg','assets/images/cheeseburger.jpg',1);
INSERT INTO article VALUES (2,'Cheese Burger',180,'French fries-red cheese,Onion','assets/images/cheeseburger.jpg',2);
INSERT INTO article VALUES (3,'Cheese Burger',180,'Minced meat-french fries,red cheese','assets/images/cheeseburger.jpg',3);
INSERT INTO article VALUES (4,'Cheese Burger',180,'Minced meat,french fries,red cheese','assets/images/cheeseburger.jpg',4);
INSERT INTO article VALUES (5,'Cheese Burger',180,'Minced meat,french fries,red cheese','assets/images/cheeseburger.jpg',5);
INSERT INTO article VALUES (6,'Classic Burger',200,'Minced meat','assets/images/bigburger.jpg',1);
INSERT INTO article VALUES (7,'Classic Burger',200,'Minced meat','assets/images/bigburger.jpg',2);
INSERT INTO article VALUES (8,'Classic Burger',200,'Minced meat','assets/images/bigburger.jpg',3);
INSERT INTO article VALUES (9,'Classic Burger',200,'Minced meat','assets/images/bigburger.jpg',4);
INSERT INTO article VALUES (10,'Classic Burger',200,'Minced meat','assets/images/bigburger.jpg',5);
INSERT INTO article VALUES (11,'EGG Burger',300,'Minced meat','assets/images/burger1.jpg',1);
INSERT INTO article VALUES (12,'EGG Burger',300,'Minced meat','assets/images/burger1.jpg',2);
INSERT INTO article VALUES (13,'EGG Burger',300,'Minced meat','assets/images/burger1.jpg',3);
INSERT INTO article VALUES (14,'EGG Burger',300,'Minced meat','assets/images/burger1.jpg',4);
INSERT INTO article VALUES (15,'EGG Burger',300,'Minced meat','assets/images/burger1.jpg',5);
INSERT INTO article VALUES (16,'Big Sandwich',180,'Minced meat,french fries,red cheese','assets/images/bigsandwitch.jpg',6);
INSERT INTO article VALUES (17,'Big Sandwich',180,'Minced meat,french fries,red cheese','assets/images/bigsandwitch.jpg',7);
INSERT INTO article VALUES (18,'Big Sandwichr',180,'Minced meat,french fries,red cheese','assets/images/bigsandwitch.jpg',8);
INSERT INTO article VALUES (19,'Big Sandwich',180,'Minced meat,french fries,red cheese','assets/images/bigsandwitch.jpg',9);
INSERT INTO article VALUES (20,'Big Sandwich',180,'Minced meat,french fries,red cheese','assets/images/bigsandwitch.jpg',10);
INSERT INTO article VALUES (21,'Simple Sandwich',150,'Minced meat,french fries,red cheese','assets/images/burrito.jpg',6);
INSERT INTO article VALUES (22,'Simple Sandwich',150,'Minced meat,french fries,red cheese','assets/images/burrito.jpg',7);
INSERT INTO article VALUES (23,'Simple Sandwich',150,'Minced meat,french fries,red cheese','assets/images/burrito.jpg',8);
INSERT INTO article VALUES (24,'Simple Sandwich',150,'Minced meat,french fries,red cheese','assets/images/burrito.jpg',9);
INSERT INTO article VALUES (25,'Simple Sandwich',150,'Minced meat,french fries,red cheese','assets/images/burrito.jpg',10);
INSERT INTO article VALUES (26,'Tunisian Sandwich',200,'Tunisian bread-Minced meat,french fries,red cheese','assets/images/pasta.jpg',6);
INSERT INTO article VALUES (27,'Tunisian Sandwich',200,'Tunisian bread-Minced meat,french fries,red cheese','assets/images/pasta.jpg',7);
INSERT INTO article VALUES (28,'Tunisian Sandwich',200,'Tunisian bread-Minced meat,french fries,red cheese','assets/images/pasta.jpg',8);
INSERT INTO article VALUES (29,'Tunisian Sandwich',200,'Tunisian bread-Minced meat,french fries,red cheese','assets/images/pasta.jpg',9);
INSERT INTO article VALUES (30,'Tunisian Sandwich',200,'Tunisian bread-Minced meat,french fries,red cheese','assets/images/pasta.jpg',10);
INSERT INTO article VALUES (31,'Pizza 4 cheeses',750,'Minced meat,french fries,red cheese','assets/images/beef.jpg',11);
INSERT INTO article VALUES (32,'Pizza 4 cheeses',750,'Minced meat,french fries,red cheese','assets/images/beef.jpg',12);
INSERT INTO article VALUES (33,'Pizza 4 cheeses',750,'Minced meat,french fries,red cheese','assets/images/beef.jpg',13);
INSERT INTO article VALUES (34,'Pizza 4 cheeses',750,'Minced meat,french fries,red cheese','assets/images/beef.jpg',14);
INSERT INTO article VALUES (35,'Pizza 4 cheeses',750,'Minced meat,french fries,red cheese','assets/images/beef.jpg',15);
INSERT INTO article VALUES (36,'Margherita Pizza',350,'Minced meat','assets/images/idli.jpg',11);
INSERT INTO article VALUES (37,'Margherita Pizza',350,'Minced meat','assets/images/idli.jpg',12);
INSERT INTO article VALUES (38,'Margherita Pizza',350,'Minced meat','assets/images/idli.jpg',13);
INSERT INTO article VALUES (39,'Margherita Pizza',350,'Minced meat','assets/images/idli.jpg',14);
INSERT INTO article VALUES (40,'Margherita Pizza',350,'Minced meat','assets/images/idli.jpg',15);
INSERT INTO article VALUES (41,'Vegetarian Pizza',400,'Minced meat','assets/images/dosa.jpg',11);
INSERT INTO article VALUES (42,'Vegetarian Pizza',400,'Minced meat','assets/images/dosa.jpg',12);
INSERT INTO article VALUES (43,'Vegetarian Pizza',400,'Minced meat','assets/images/dosa.jpg',13);
INSERT INTO article VALUES (44,'Vegetarian Pizza',400,'Minced meat','assets/images/dosa.jpg',14);
INSERT INTO article VALUES (45,'Vegetarian Pizza',400,'Minced meat','assets/images/dosa.jpg',15);
INSERT INTO article VALUES (46,'Mixano Tacos ',200,'Minced meat,french fries,red cheese','assets/images/beef.jpg',16);
INSERT INTO article VALUES (47,'Mixano Tacos',200,'Minced meat,french fries,red cheese','assets/images/beef.jpg',17);
INSERT INTO article VALUES (48,'Mixano Tacos',200,'Minced meat,french fries,red cheese','assets/images/beef.jpg',18);
INSERT INTO article VALUES (49,'Mixano Tacos',200,'Minced meat,french fries,red cheese','assets/images/beef.jpg',19);
INSERT INTO article VALUES (50,'Mixano Tacos',200,'Minced meat,french fries,red cheese','assets/images/beef.jpg',20);
INSERT INTO article VALUES (51,'Classic Tacos',350,'Minced meat','assets/images/idli.jpg',16);
INSERT INTO article VALUES (52,'Classic Tacos',350,'Minced meat','assets/images/idli.jpg',17);
INSERT INTO article VALUES (53,'Classic Tacos',350,'Minced meat','assets/images/idli.jpg',18);
INSERT INTO article VALUES (54,'Classic Tacos',350,'Minced meat','assets/images/idli.jpg',19);
INSERT INTO article VALUES (55,'Classic Tacos',350,'Minced meat','assets/images/idli.jpg',20);
INSERT INTO article VALUES (56,'Simple Tacos',400,'Minced meat','assets/images/dosa.jpg',16);
INSERT INTO article VALUES (57,'Simple Tacos',400,'Minced meat','assets/images/dosa.jpg',17);
INSERT INTO article VALUES (58,'Simple Tacos',400,'Minced meat','assets/images/dosa.jpg',18);
INSERT INTO article VALUES (59,'Simple Tacos',400,'Minced meat','assets/images/dosa.jpg',19);
INSERT INTO article VALUES (60,'Simple Tacos',400,'Minced meat','assets/images/dosa.jpg',20);
INSERT INTO article VALUES (61,'Chicken Dish ',850,'Minced meat,french fries,red cheese','assets/images/beef.jpg',21);
INSERT INTO article VALUES (62,'Chicken Dish',850,'Minced meat,french fries,red cheese','assets/images/beef.jpg',22);
INSERT INTO article VALUES (63,'Chicken Dish',850,'Minced meat,french fries,red cheese','assets/images/beef.jpg',23);
INSERT INTO article VALUES (64,'Chicken Dish',850,'Minced meat,french fries,red cheese','assets/images/beef.jpg',24);
INSERT INTO article VALUES (65,'Chicken Dish',850,'Minced meat,french fries,red cheese','assets/images/beef.jpg',25);
INSERT INTO article VALUES (66,'Breaded Chicken Dish',1000,'Minced meat','assets/images/idli.jpg',21);
INSERT INTO article VALUES (67,'Breaded Chicken Dish',1000,'Minced meat','assets/images/idli.jpg',22);
INSERT INTO article VALUES (68,'Breaded Chicken Dish',1000,'Minced meat','assets/images/idli.jpg',23);
INSERT INTO article VALUES (69,'Breaded Chicken Dish',1000,'Minced meat','assets/images/idli.jpg',24);
INSERT INTO article VALUES (70,'Breaded Chicken Dish',1000,'Minced meat','assets/images/idli.jpg',25);
INSERT INTO article VALUES (71,'Entrocote',1200,'Minced meat','assets/images/dosa.jpg',21);
INSERT INTO article VALUES (72,'Entrocote',1200,'Minced meat','assets/images/dosa.jpg',22);
INSERT INTO article VALUES (73,'Entrocote',1200,'Minced meat','assets/images/dosa.jpg',23);
INSERT INTO article VALUES (74,'Entrocote',1200,'Minced meat','assets/images/dosa.jpg',24);
INSERT INTO article VALUES (75,'Entrocote',1200,'Minced meat','assets/images/dosa.jpg',25);
INSERT INTO article VALUES (76,'Eau',20,'','assets/images/beef.jpg',26);
INSERT INTO article VALUES (77,'Eau',20,'','assets/images/beef.jpg',27);
INSERT INTO article VALUES (78,'Eau',20,'','assets/images/beef.jpg',28);
INSERT INTO article VALUES (79,'Eau',20,'','assets/images/beef.jpg',29);
INSERT INTO article VALUES (80,'Eau',20,'','assets/images/beef.jpg',30);
INSERT INTO article VALUES (81,'Coca Cola',50,'','assets/images/idli.jpg',26);
INSERT INTO article VALUES (82,'Coca Cola',50,'','assets/images/idli.jpg',27);
INSERT INTO article VALUES (83,'Coca Cola',50,'','assets/images/idli.jpg',28);
INSERT INTO article VALUES (84,'Coca Cola',50,'','assets/images/idli.jpg',29);
INSERT INTO article VALUES (85,'Coca Cola',50,'','assets/images/idli.jpg',30);
INSERT INTO article VALUES (86,'Orange Jus',100,'','assets/images/dosa.jpg',26);
INSERT INTO article VALUES (87,'Orange Jus',100,'','assets/images/dosa.jpg',27);
INSERT INTO article VALUES (88,'Orange Jus',100,'','assets/images/dosa.jpg',28);
INSERT INTO article VALUES (89,'Orange Jus',100,'','assets/images/dosa.jpg',29);
INSERT INTO article VALUES (90,'Orange Jus',100,'','assets/images/dosa.jpg',30);


INSERT INTO taille VALUES (1,'Size L',0,1);
INSERT INTO taille VALUES (2,'Size L',0,2);
INSERT INTO taille VALUES (3,'Size L',0,3);
INSERT INTO taille VALUES (4,'Size L',0,4);
INSERT INTO taille VALUES (5,'Size L',0,5);
INSERT INTO taille VALUES (6,'Size L',0,6);
INSERT INTO taille VALUES (7,'Size L',0,7);
INSERT INTO taille VALUES (8,'Size L',0,8);
INSERT INTO taille VALUES (9,'Size L',0,9);
INSERT INTO taille VALUES (10,'Size L',0,10);
INSERT INTO taille VALUES (11,'Size L',0,11);
INSERT INTO taille VALUES (12,'Size L',0,12);
INSERT INTO taille VALUES (13,'Size L',0,13);
INSERT INTO taille VALUES (14,'Size L',0,14);
INSERT INTO taille VALUES (15,'Size L',0,15);
INSERT INTO taille VALUES (16,'Size L',0,16);
INSERT INTO taille VALUES (17,'Size L',0,17);
INSERT INTO taille VALUES (18,'Size L',0,18);
INSERT INTO taille VALUES (19,'Size L',0,19);
INSERT INTO taille VALUES (20,'Size L',0,20);

INSERT INTO taille VALUES (21,'Size M',200,1);
INSERT INTO taille VALUES (22,'Size M',200,2);
INSERT INTO taille VALUES (23,'Size M',200,3);
INSERT INTO taille VALUES (24,'Size M',200,4);
INSERT INTO taille VALUES (25,'Size M',200,5);
INSERT INTO taille VALUES (26,'Size M',200,6);
INSERT INTO taille VALUES (27,'Size M',200,7);
INSERT INTO taille VALUES (28,'Size M',200,8);
INSERT INTO taille VALUES (29,'Size M',200,9);
INSERT INTO taille VALUES (30,'Size M',200,10);
INSERT INTO taille VALUES (31,'Size M',200,11);
INSERT INTO taille VALUES (32,'Size M',200,12);
INSERT INTO taille VALUES (33,'Size M',200,13);
INSERT INTO taille VALUES (34,'Size M',200,14);
INSERT INTO taille VALUES (35,'Size M',200,15);
INSERT INTO taille VALUES (36,'Size M',200,16);
INSERT INTO taille VALUES (37,'Size M',200,17);
INSERT INTO taille VALUES (38,'Size M',200,18);
INSERT INTO taille VALUES (39,'Size M',200,19);
INSERT INTO taille VALUES (40,'Size M',200,20);

INSERT INTO taille VALUES (41,'Size XL',350,1);
INSERT INTO taille VALUES (42,'Size XL',350,2);
INSERT INTO taille VALUES (43,'Size XL',350,3);
INSERT INTO taille VALUES (44,'Size XL',350,4);
INSERT INTO taille VALUES (45,'Size XL',350,5);
INSERT INTO taille VALUES (46,'Size XL',350,6);
INSERT INTO taille VALUES (47,'Size XL',350,7);
INSERT INTO taille VALUES (48,'Size XL',350,8);
INSERT INTO taille VALUES (49,'Size XL',350,9);
INSERT INTO taille VALUES (50,'Size XL',350,10);
INSERT INTO taille VALUES (51,'Size XL',350,11);
INSERT INTO taille VALUES (52,'Size XL',350,12);
INSERT INTO taille VALUES (53,'Size XL',350,13);
INSERT INTO taille VALUES (54,'Size XL',350,14);
INSERT INTO taille VALUES (55,'Size XL',350,15);
INSERT INTO taille VALUES (56,'Size XL',350,16);
INSERT INTO taille VALUES (57,'Size XL',350,17);
INSERT INTO taille VALUES (58,'Size XL',350,18);
INSERT INTO taille VALUES (59,'Size XL',350,19);
INSERT INTO taille VALUES (60,'Size XL',350,20);

INSERT INTO sauce VALUES (1,' Ketchup Sauce',0,1);
INSERT INTO sauce VALUES (2,'Ketchup Sauce ',0,2);
INSERT INTO sauce VALUES (3,'Ketchup Sauce ',0,3);
INSERT INTO sauce VALUES (4,' Ketchup Sauce',0,4);
INSERT INTO sauce VALUES (5,'Ketchup Sauce',0,5);
INSERT INTO sauce VALUES (6,'Ketchup Sauce',0,6);
INSERT INTO sauce VALUES (7,'Ketchup Sauce',0,7);
INSERT INTO sauce VALUES (8,'Ketchup Sauce',0,8);
INSERT INTO sauce VALUES (9,'Ketchup Sauce',0,9);
INSERT INTO sauce VALUES (10,'Ketchup Sauce',0,10);
INSERT INTO sauce VALUES (11,'Ketchup Sauce',0,11);
INSERT INTO sauce VALUES (12,'Ketchup Sauce',0,12);
INSERT INTO sauce VALUES (13,'Ketchup Sauce',0,13);
INSERT INTO sauce VALUES (14,'Ketchup Sauce',0,14);
INSERT INTO sauce VALUES (15,'Ketchup Sauce',0,15);
INSERT INTO sauce VALUES (16,' Ketchup Sauce',0,16);
INSERT INTO sauce VALUES (17,'Ketchup Sauce',0,17);
INSERT INTO sauce VALUES (18,'Ketchup Sauce',0,18);
INSERT INTO sauce VALUES (19,'Ketchup Sauce',0,19);
INSERT INTO sauce VALUES (20,' Ketchup Sauce',0,20);

INSERT INTO sauce VALUES (21,'Hot Sauce',0,1);
INSERT INTO sauce VALUES (22,'Hot Sauce',0,2);
INSERT INTO sauce VALUES (23,'Hot Sauce',0,3);
INSERT INTO sauce VALUES (24,'Hot Sauce',0,4);
INSERT INTO sauce VALUES (25,'Hot Sauce',0,5);
INSERT INTO sauce VALUES (26,'Hot Sauce',0,6);
INSERT INTO sauce VALUES (27,'Hot Sauce',0,7);
INSERT INTO sauce VALUES (28,'Hot Sauce',0,8);
INSERT INTO sauce VALUES (29,'Hot Sauce',0,9);
INSERT INTO sauce VALUES (30,'Hot Sauce',0,10);
INSERT INTO sauce VALUES (31,'Hot Sauce',0,11);
INSERT INTO sauce VALUES (32,'Hot Sauce',0,12);
INSERT INTO sauce VALUES (33,'Hot Sauce',0,13);
INSERT INTO sauce VALUES (34,'Hot Sauce',0,14);
INSERT INTO sauce VALUES (35,'Hot Sauce',0,15);
INSERT INTO sauce VALUES (36,'Hot Sauce',0,16);
INSERT INTO sauce VALUES (37,'Hot Sauce',0,17);
INSERT INTO sauce VALUES (38,'Hot Sauce',0,18);
INSERT INTO sauce VALUES (39,'Hot Sauce',0,19);
INSERT INTO sauce VALUES (40,'Hot Sauce',0,20);

INSERT INTO sauce VALUES (41,'Andalusian Sauce',100,1);
INSERT INTO sauce VALUES (42,'Andalusian Sauce',100,2);
INSERT INTO sauce VALUES (43,'Andalusian Sauce',100,3);
INSERT INTO sauce VALUES (44,'Andalusian Sauce',100,4);
INSERT INTO sauce VALUES (45,'Andalusian Sauce',100,5);
INSERT INTO sauce VALUES (46,'Andalusian Sauce',100,6);
INSERT INTO sauce VALUES (47,'Andalusian Sauce',100,7);
INSERT INTO sauce VALUES (48,'Andalusian Sauce',100,8);
INSERT INTO sauce VALUES (49,'Andalusian Sauce',100,9);
INSERT INTO sauce VALUES (50,'Andalusian Sauce',100,10);
INSERT INTO sauce VALUES (51,'Andalusian Sauce',100,11);
INSERT INTO sauce VALUES (52,'Andalusian Sauce',100,12);
INSERT INTO sauce VALUES (53,'Andalusian Sauce',100,13);
INSERT INTO sauce VALUES (54,'Andalusian Sauce',100,14);
INSERT INTO sauce VALUES (55,'Andalusian Sauce',100,15);
INSERT INTO sauce VALUES (56,'Andalusian Sauce',100,16);
INSERT INTO sauce VALUES (57,'Andalusian Sauce',100,17);
INSERT INTO sauce VALUES (58,'Andalusian Sauce',100,18);
INSERT INTO sauce VALUES (59,'Andalusian Sauce',100,19);
INSERT INTO sauce VALUES (60,'Andalusian Sauce',100,20);

INSERT INTO sauce VALUES (61,'Chili Sauce',150,1);
INSERT INTO sauce VALUES (62,'Chili Sauce',150,2);
INSERT INTO sauce VALUES (63,'Chili Sauce',150,3);
INSERT INTO sauce VALUES (64,'Chili Sauce',150,4);
INSERT INTO sauce VALUES (65,'Chili Sauce',150,5);
INSERT INTO sauce VALUES (66,'Chili Sauce',150,6);
INSERT INTO sauce VALUES (67,'Chili Sauce',150,7);
INSERT INTO sauce VALUES (68,'Chili Sauce',150,8);
INSERT INTO sauce VALUES (69,'Chili Sauce',150,9);
INSERT INTO sauce VALUES (70,'Chili Sauce',150,10);
INSERT INTO sauce VALUES (71,'Chili Sauce',150,11);
INSERT INTO sauce VALUES (72,'Chili Sauce',150,12);
INSERT INTO sauce VALUES (73,'Chili Sauce',150,13);
INSERT INTO sauce VALUES (74,'Chili Sauce',150,14);
INSERT INTO sauce VALUES (75,'Chili Sauce',150,15);
INSERT INTO sauce VALUES (76,'Chili Sauce',150,16);
INSERT INTO sauce VALUES (77,'Chili Sauce',150,17);
INSERT INTO sauce VALUES (78,'Chili Sauce',150,18);
INSERT INTO sauce VALUES (79,'Chili Sauce',150,19);
INSERT INTO sauce VALUES (80,'Chili Sauce',150,20);

INSERT INTO sauce VALUES (81,'Cheese Sauce',200,1);
INSERT INTO sauce VALUES (82,'Cheese Sauce',200,2);
INSERT INTO sauce VALUES (83,'Cheese Sauce',200,3);
INSERT INTO sauce VALUES (84,'Cheese Sauce',200,4);
INSERT INTO sauce VALUES (85,'Cheese Sauce',200,5);
INSERT INTO sauce VALUES (86,'Cheese Sauce',200,6);
INSERT INTO sauce VALUES (87,'Cheese Sauce',200,7);
INSERT INTO sauce VALUES (88,'Cheese Sauce',200,8);
INSERT INTO sauce VALUES (89,'Cheese Sauce',200,9);
INSERT INTO sauce VALUES (90,'Cheese Sauce',200,10);
INSERT INTO sauce VALUES (91,'Cheese Sauce',200,11);
INSERT INTO sauce VALUES (92,'Cheese Sauce',200,12);
INSERT INTO sauce VALUES (93,'Cheese Sauce',200,13);
INSERT INTO sauce VALUES (94,'Cheese Sauce',200,14);
INSERT INTO sauce VALUES (95,'Cheese Sauce',200,15);
INSERT INTO sauce VALUES (96,'Cheese Sauce',200,16);
INSERT INTO sauce VALUES (97,'Cheese Sauce',200,17);
INSERT INTO sauce VALUES (98,'Cheese Sauce',200,18);
INSERT INTO sauce VALUES (99,'Cheese Sauce',200,19);
INSERT INTO sauce VALUES (100,'Cheese Sauce',200,20);

INSERT INTO frite VALUES (1,'Simple Fries',100,1);
INSERT INTO frite VALUES (2,'Simple Fries',100,2);
INSERT INTO frite VALUES (3,'Simple Fries',100,3);
INSERT INTO frite VALUES (4,'Simple Fries',100,4);
INSERT INTO frite VALUES (5,'Simple Fries',100,5);
INSERT INTO frite VALUES (6,'Simple Fries',100,6);
INSERT INTO frite VALUES (7,'Simple Fries',100,7);
INSERT INTO frite VALUES (8,'Simple Fries',100,8);
INSERT INTO frite VALUES (9,'Simple Fries',100,9);
INSERT INTO frite VALUES (10,'Simple Fries',100,10);
INSERT INTO frite VALUES (11,'Simple Fries',100,11);
INSERT INTO frite VALUES (12,'Simple Fries',100,12);
INSERT INTO frite VALUES (13,'Simple Fries',100,13);
INSERT INTO frite VALUES (14,'Simple Fries',100,14);
INSERT INTO frite VALUES (15,'Simple Fries',100,15);
INSERT INTO frite VALUES (16,'Simple Fries',100,16);
INSERT INTO frite VALUES (17,'Simple Fries',100,17);
INSERT INTO frite VALUES (18,'Simple Fries',100,18);
INSERT INTO frite VALUES (19,'Simple Fries',100,19);
INSERT INTO frite VALUES (20,'Simple Fries',100,20);

INSERT INTO frite VALUES (21,'Spice Fries',150,1);
INSERT INTO frite VALUES (22,'Spice Fries',150,2);
INSERT INTO frite VALUES (23,'Spice Fries',150,3);
INSERT INTO frite VALUES (24,'Spice Fries',150,4);
INSERT INTO frite VALUES (25,'Spice Fries',150,5);
INSERT INTO frite VALUES (26,'Spice Fries',150,6);
INSERT INTO frite VALUES (27,'Spice Fries',150,7);
INSERT INTO frite VALUES (28,'Spice Fries',150,8);
INSERT INTO frite VALUES (29,'Spice Fries',150,9);
INSERT INTO frite VALUES (30,'Spice Fries',150,10);
INSERT INTO frite VALUES (31,'Spice Fries',150,11);
INSERT INTO frite VALUES (32,'Spice Fries',150,12);
INSERT INTO frite VALUES (33,'Spice Fries',150,13);
INSERT INTO frite VALUES (34,'Spice Fries',150,14);
INSERT INTO frite VALUES (35,'Spice Fries',150,15);
INSERT INTO frite VALUES (36,'Spice Fries',150,16);
INSERT INTO frite VALUES (37,'Spice Fries',150,17);
INSERT INTO frite VALUES (38,'Spice Fries',150,18);
INSERT INTO frite VALUES (39,'Spice Fries',150,19);
INSERT INTO frite VALUES (40,'Spice Fries',150,20);

INSERT INTO frite VALUES (41,'Cheese Fries ',200,1);
INSERT INTO frite VALUES (42,'Cheese Fries',200,2);
INSERT INTO frite VALUES (43,'Cheese Fries',200,3);
INSERT INTO frite VALUES (44,'Cheese Fries',200,4);
INSERT INTO frite VALUES (45,'Cheese Fries',200,5);
INSERT INTO frite VALUES (46,'Cheese Fries',200,6);
INSERT INTO frite VALUES (47,'Cheese Fries',200,7);
INSERT INTO frite VALUES (48,'Cheese Fries',200,8);
INSERT INTO frite VALUES (49,'Cheese Fries',200,9);
INSERT INTO frite VALUES (50,'Cheese Fries',200,10);
INSERT INTO frite VALUES (51,'Cheese Fries',200,11);
INSERT INTO frite VALUES (52,'Cheese Fries',200,12);
INSERT INTO frite VALUES (53,'Cheese Fries',200,13);
INSERT INTO frite VALUES (54,'Cheese Fries',200,14);
INSERT INTO frite VALUES (55,'Cheese Fries',200,15);
INSERT INTO frite VALUES (56,'Cheese Fries',200,16);
INSERT INTO frite VALUES (57,'Cheese Fries',200,17);
INSERT INTO frite VALUES (58,'Cheese Fries',200,18);
INSERT INTO frite VALUES (59,'Cheese Fries',200,19);
INSERT INTO frite VALUES (60,'Cheese Fries',200,20);


INSERT INTO viande VALUES (1,'Chicken',0,1);
INSERT INTO viande VALUES (2,'Chicken',0,2);
INSERT INTO viande VALUES (3,'Chicken',0,3);
INSERT INTO viande VALUES (4,'Chicken',0,4);
INSERT INTO viande VALUES (5,'Chicken',0,5);
INSERT INTO viande VALUES (6,'Chicken',0,6);
INSERT INTO viande VALUES (7,'Chicken',0,7);
INSERT INTO viande VALUES (8,'Chicken',0,8);
INSERT INTO viande VALUES (9,'Chicken',0,9);
INSERT INTO viande VALUES (10,'Chicken',0,10);
INSERT INTO viande VALUES (11,'Chicken',0,11);
INSERT INTO viande VALUES (12,'Chicken',0,12);
INSERT INTO viande VALUES (13,'Chicken',0,13);
INSERT INTO viande VALUES (14,'Chicken',0,14);
INSERT INTO viande VALUES (15,'Chicken',0,15);
INSERT INTO viande VALUES (16,'Chicken',0,16);
INSERT INTO viande VALUES (17,'Chicken',0,17);
INSERT INTO viande VALUES (18,'Chicken',0,18);
INSERT INTO viande VALUES (19,'Chicken',0,19);
INSERT INTO viande VALUES (20,'Chicken',0,20);

INSERT INTO viande VALUES (21,'Meat',100,1);
INSERT INTO viande VALUES (22,'Meat',100,2);
INSERT INTO viande VALUES (23,'Meat',100,3);
INSERT INTO viande VALUES (24,'Meat',100,4);
INSERT INTO viande VALUES (25,'Meat',100,5);
INSERT INTO viande VALUES (26,'Meat',100,6);
INSERT INTO viande VALUES (27,'Meat',100,7);
INSERT INTO viande VALUES (28,'Meat',100,8);
INSERT INTO viande VALUES (29,'Meat',100,9);
INSERT INTO viande VALUES (30,'Meat',100,10);
INSERT INTO viande VALUES (31,'Meat',100,11);
INSERT INTO viande VALUES (32,'Meat',100,12);
INSERT INTO viande VALUES (33,'Meat',100,13);
INSERT INTO viande VALUES (34,'Meat',100,14);
INSERT INTO viande VALUES (35,'Meat',100,15);
INSERT INTO viande VALUES (36,'Meat',100,16);
INSERT INTO viande VALUES (37,'Meat',100,17);
INSERT INTO viande VALUES (38,'Meat',100,18);
INSERT INTO viande VALUES (39,'Meat',100,19);
INSERT INTO viande VALUES (40,'Meat',100,20);

INSERT INTO viande VALUES (41,'Mixed',200,1);
INSERT INTO viande VALUES (42,'Mixed',200,2);
INSERT INTO viande VALUES (43,'Mixed',200,3);
INSERT INTO viande VALUES (44,'Mixed',200,4);
INSERT INTO viande VALUES (45,'Mixed',200,5);
INSERT INTO viande VALUES (46,'Mixed',200,6);
INSERT INTO viande VALUES (47,'Mixed',200,7);
INSERT INTO viande VALUES (48,'Mixed',200,8);
INSERT INTO viande VALUES (49,'Mixed',200,9);
INSERT INTO viande VALUES (50,'Mixed',200,10);
INSERT INTO viande VALUES (51,'Mixed',200,11);
INSERT INTO viande VALUES (52,'Mixed',200,12);
INSERT INTO viande VALUES (53,'Mixed',200,13);
INSERT INTO viande VALUES (54,'Mixed',200,14);
INSERT INTO viande VALUES (55,'Mixed',200,15);
INSERT INTO viande VALUES (56,'Mixed',200,16);
INSERT INTO viande VALUES (57,'Mixed',200,17);
INSERT INTO viande VALUES (58,'Mixed',200,18);
INSERT INTO viande VALUES (59,'Mixed',200,19);
INSERT INTO viande VALUES (60,'Mixed',200,20);


INSERT INTO gratine VALUES (1,'Red Cheese',100,1);
INSERT INTO gratine VALUES (2,'Red Cheese',100,2);
INSERT INTO gratine VALUES (3,'Red Cheese',100,3);
INSERT INTO gratine VALUES (4,'Red Cheese',100,4);
INSERT INTO gratine VALUES (5,'Red Cheese',100,5);
INSERT INTO gratine VALUES (6,'Red Cheese',100,6);
INSERT INTO gratine VALUES (7,'Red Cheese',100,7);
INSERT INTO gratine VALUES (8,'Red Cheese',100,8);
INSERT INTO gratine VALUES (9,'Red Cheese',100,9);
INSERT INTO gratine VALUES (10,'Red Cheese',100,10);
INSERT INTO gratine VALUES (11,'Red Cheese',100,11);
INSERT INTO gratine VALUES (12,'Red Cheese',100,12);
INSERT INTO gratine VALUES (13,'Red Cheese',100,13);
INSERT INTO gratine VALUES (14,'Red Cheese',100,14);
INSERT INTO gratine VALUES (15,'Red Cheese',100,15);
INSERT INTO gratine VALUES (16,'Red Cheese',100,16);
INSERT INTO gratine VALUES (17,'Red Cheese',100,17);
INSERT INTO gratine VALUES (18,'Red Cheese',100,18);
INSERT INTO gratine VALUES (19,'Red Cheese',100,19);
INSERT INTO gratine VALUES (20,'Red Cheese',100,20);

INSERT INTO gratine VALUES (21,'Gruyère',100,1);
INSERT INTO gratine VALUES (22,'Gruyère',100,2);
INSERT INTO gratine VALUES (23,'Gruyère',100,3);
INSERT INTO gratine VALUES (24,'Gruyère',100,4);
INSERT INTO gratine VALUES (25,'Gruyère',100,5);
INSERT INTO gratine VALUES (26,'Gruyère',100,6);
INSERT INTO gratine VALUES (27,'Gruyère',100,7);
INSERT INTO gratine VALUES (28,'Gruyère',100,8);
INSERT INTO gratine VALUES (29,'Gruyère',100,9);
INSERT INTO gratine VALUES (30,'Gruyère',100,10);
INSERT INTO gratine VALUES (31,'Gruyère',100,11);
INSERT INTO gratine VALUES (32,'Gruyère',100,12);
INSERT INTO gratine VALUES (33,'Gruyère',100,13);
INSERT INTO gratine VALUES (34,'Gruyère',100,14);
INSERT INTO gratine VALUES (35,'Gruyère',100,15);
INSERT INTO gratine VALUES (36,'Gruyère',100,16);
INSERT INTO gratine VALUES (37,'Gruyère',100,17);
INSERT INTO gratine VALUES (38,'Gruyère',100,18);
INSERT INTO gratine VALUES (39,'Gruyère',100,19);
INSERT INTO gratine VALUES (40,'Gruyère',100,20);

INSERT INTO gratine VALUES (41,'Cheddar',100,1);
INSERT INTO gratine VALUES (42,'Cheddar',100,2);
INSERT INTO gratine VALUES (43,'Cheddar',100,3);
INSERT INTO gratine VALUES (44,'Cheddar',100,4);
INSERT INTO gratine VALUES (45,'Cheddar',100,5);
INSERT INTO gratine VALUES (46,'Cheddar',100,6);
INSERT INTO gratine VALUES (47,'Cheddar',100,7);
INSERT INTO gratine VALUES (48,'Cheddar',100,8);
INSERT INTO gratine VALUES (49,'Cheddar',100,9);
INSERT INTO gratine VALUES (50,'Cheddar',100,10);
INSERT INTO gratine VALUES (51,'Cheddar',100,11);
INSERT INTO gratine VALUES (52,'Cheddar',100,12);
INSERT INTO gratine VALUES (53,'Cheddar',100,13);
INSERT INTO gratine VALUES (54,'Cheddar',100,14);
INSERT INTO gratine VALUES (55,'Cheddar',100,15);
INSERT INTO gratine VALUES (56,'Cheddar',100,16);
INSERT INTO gratine VALUES (57,'Cheddar',100,17);
INSERT INTO gratine VALUES (58,'Cheddar',100,18);
INSERT INTO gratine VALUES (59,'Cheddar',100,19);
INSERT INTO gratine VALUES (60,'Cheddar',100,20);