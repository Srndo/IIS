/* All passwords in the following table are hashed from "asdfasdf" */
INSERT INTO "UZIVATEL" ("id","meno","priezvisko","adresa","tel_cislo","email","heslo") VALUES
 ('0','Leopold','Halaj','Zahrebska 97','+421908013019','admin@admin.com','$5$rounds=535000$j5W2T2N2MrQLbrDU$rDX0Ht1e98BKpl4Lcimo5KUipz63Ml.XSaTj3rMCJE1'), /* password: admin */
 ('1','Izabela','Sokolova','Vodova 61','+420786666954','operator@operator.com','$5$rounds=535000$Fwi7.92RJQj.Wqs0$4kq10RO7vEV3dldJHoOJ/qowpiT7W3t0fuPTScimx6D'), /* password: operator */
 ('2','Julia','Cermakova','Technicka 1','+420778695444','Julia.Cermakova@gmail.com','$5$rounds=535000$fclrBT5bsouAbcjB$ielqqoZFgC7SP2v.ez7YlS1QE28IfjMavXLhc70FkY2'),
 ('3','David','Silber','Gorkeho 42','+421569863457','David.Silber@gmail.com','$5$rounds=535000$fclrBT5bsouAbcjB$ielqqoZFgC7SP2v.ez7YlS1QE28IfjMavXLhc70FkY2'),
 ('4','Andrea','Villova','Botanicka 77','+420968569832','Andrea.Villova@gmail.com','$5$rounds=535000$fclrBT5bsouAbcjB$ielqqoZFgC7SP2v.ez7YlS1QE28IfjMavXLhc70FkY2'),
 ('5','Ingrid','Bartova','Grohova 11','+420789568476','Ingrid.Bartova@gmail.com','$5$rounds=535000$fclrBT5bsouAbcjB$ielqqoZFgC7SP2v.ez7YlS1QE28IfjMavXLhc70FkY2'),
 ('6','Emil','Voda','Kolejni 45','+420156328957','Emil.Voda@gmail.com','$5$rounds=535000$fclrBT5bsouAbcjB$ielqqoZFgC7SP2v.ez7YlS1QE28IfjMavXLhc70FkY2'),
 ('7','Jakub','Cenek','Kounicova 16','+420588996335','Jakub.Cenek@gmail.com','$5$rounds=535000$fclrBT5bsouAbcjB$ielqqoZFgC7SP2v.ez7YlS1QE28IfjMavXLhc70FkY2'),
 ('8','Arnold','Noga','Bozetechova 16','+420123569866','Arnold.Noga@gmail.com','$5$rounds=535000$fclrBT5bsouAbcjB$ielqqoZFgC7SP2v.ez7YlS1QE28IfjMavXLhc70FkY2'),
 ('9','Oliver','Stanek','Husitska 97','+420485967256','Oliver.Stanek@gmail.com','$5$rounds=535000$fclrBT5bsouAbcjB$ielqqoZFgC7SP2v.ez7YlS1QE28IfjMavXLhc70FkY2'),
 ('10','Andrej','Dolnik','Reisigova 785','+421958658489','Andrej.Dolnik@gmail.com','$5$rounds=535000$fclrBT5bsouAbcjB$ielqqoZFgC7SP2v.ez7YlS1QE28IfjMavXLhc70FkY2'),
 ('11','Denis','Dovicic','Hlavna 78','+421456987221','driver@driver.com','$5$rounds=535000$6E.ocpRaWlhC202o$KDal580PDfyGR5du6YojKEXyizt1LU1PkpCkuOqq.29'),
 ('12','Antonia','Horna','Nova 35','+421985625333','Antonia.Horna@gmail.com','$5$rounds=535000$fclrBT5bsouAbcjB$ielqqoZFgC7SP2v.ez7YlS1QE28IfjMavXLhc70FkY2'),
 ('13','Vincent','Kocis','Tererova 51','+421915612359','Vincent.Kocis@gmail.com','$5$rounds=535000$fclrBT5bsouAbcjB$ielqqoZFgC7SP2v.ez7YlS1QE28IfjMavXLhc70FkY2'),
 ('14','Zora','Fererova','Masarikova 154','+420799652114','Zora.Fererova@gmail.com','$5$rounds=535000$fclrBT5bsouAbcjB$ielqqoZFgC7SP2v.ez7YlS1QE28IfjMavXLhc70FkY2'),
 ('15','Hugo','Lovin','Capkova 34','+420784514598','Hugo.Lovin@gmail.com','$5$rounds=535000$fclrBT5bsouAbcjB$ielqqoZFgC7SP2v.ez7YlS1QE28IfjMavXLhc70FkY2');
INSERT INTO "STRAVNIK" ("cislo_karty","id") VALUES
 (4468987566982569,'0'),
 (4587658932561452,'1'),
 (4587652358746589,'2'),
 (1245652366665897,'3');
INSERT INTO "OPERATOR" ("sluzobny_tel","id") VALUES
 ('+420987565369','12'),
 ('+421986654269','1'),
 ('+420777569832','14'),
 ('+421915623587','15');
INSERT INTO "RIDIC" ("spz","id") VALUES
 ('4L09515','2356897845'),
 ('9H97903','0012503654'),
 ('S012025','10'),
 ('BB204FI','11');
INSERT INTO "ADMIN" ("id_ntb","id") VALUES
 ('7946132584','4'),
 ('8569743215','0'),
 ('3625956874','6'),
 ('1346978526','7');
INSERT INTO "JIDLO" ("id","nazov","typ","popis","alergeny","cena","id_objednavky","id_operator") VALUES
 ('12569','Rajec','drink','Sugar-less sparkling water','0',0.8,'1546958732','12'),
 ('14598','Mashed potatoes','side dish','Mashed of home made potatoes with basil','4',3,'9685743625','13'),
 ('24875','Chickpeas soup','soup','Legumes soup with potatoes and carot','7,9',4,'9152364859','14'),
 ('33654','Rice','side dish','Long grain rice with curry','10',3.5,'7589621548','15'),
 ('25896','Veg Madras, Tomato soup','MENU','Cooked vegetables with spicy sauce with Naan','5,6',0.8,'1546958732','12'),
 ('14785','Steak tartare, Vegetable soup','MENU','Grind beef with spices','2,4,7',3,'9685743625','13'),
 ('36985','Spaghetti bolognese, Garlic soup','MENU','Spaghetti with delicious meat sauce','7,8',4,'9152364859','14'),
 ('55589','Cheese pizza, Brocolli soup','MENU','Pizza with three types of cheese','1,2,4,10',3.5,'7589621548','15');
INSERT INTO "PLAN_RIDICE" ("id_planu","region","id_operator","id_ridica") VALUES ('5869745812','Moravsky region','12','2356897845'),
 ('2585554471','Královo pole','13','0012503654'),
 ('9966885575','Bystrc','14','10'),
 ('1111171458','Pisárky','15','11');
INSERT INTO "JIDLO_DENNI_MENU" ("jidlo_id","denne_menu_id") VALUES
 ('14785','16498'),
 ('55589','16498'),
 ('25896','16498'),
 ('36985','12365'),
 ('14785','12365'),
 ('36985','32256'),
 ('25896','32256'),
 ('55589','22215'),
 ('25896','22215'),
 ('55589','15'),
 ('14785','15'),
 ('36985','15');
INSERT INTO "ponuka_denni_menu" ("id","id_provozny") VALUES
 ('16498','123'),
 ('12365','255'),
 ('32256','147'),
 ('22215','012');
INSERT INTO "DENNI_MENU" ("id","datum","id_provozny") VALUES
 ('16498','2019-12-01',123),
 ('12365','2019-12-02',255),
 ('32256','2019-12-03',147),
 ('22215','2019-12-04',12),
 ('15','2019-12-01',149);
INSERT INTO "JIDLO_TRVALA_NABIDKA" ("jidlo_id","trvala_nabidka_id") VALUES
 ('12569','19998'),
 ('14598','16665'),
 ('24875','31156'),
 ('33654','26815');
INSERT INTO "ponuka_trvala_nabidka" ("id","id_provozny") VALUES
 ('19998','123'),
 ('16665','255'),
 ('31156','147'),
 ('26815','012');
INSERT INTO "TRVALA_NABIDKA" ("id","platnost_od","platnost_do","id_provozny") VALUES
 ('19998','2019-09-23','2019-12-20',123),
 ('16665','2019-12-21','2020-03-19',255),
 ('31156','2020-03-20','2020-06-20',147),
 ('26815','2020-06-21','2020-09-22',12);
INSERT INTO "spravuje_provoznu" ("id","id_operatora") VALUES
 ('123','12'),
 ('255','13'),
 ('147','14'),
 ('012','15');
INSERT INTO "PROVOZNA" ("id","nazov","adresa","description","img_src","uzavierka","id_operatora") VALUES
 (123,'Pizzeria Mozzarella','Kolejní 2905/2, 612 00 Brno-Královo Pole','Order some genuine italian pizza from Pizzeria Mozzarella.','https://i.imgur.com/mjy5rt7.jpg','2017-07-23 20:00:00','12'),
 (255,'U 3 opic','Palackého tř. 200/77, 612 00 Brno-Královo Pole','Traditionall czech dishes directly to your home can be ordered from restaurant U 3 opic.','https://i.imgur.com/gSMIT7u.jpg','2017-06-23 19:00:00','13'),
 (147,'Everest','Veveří 61, 602 00 Brno-střed','Oriental dishes specially from the Nepal province are available in restaurant Everest.','https://i.imgur.com/qhNgPj8.jpg','2018-02-01 18:30:00','14'),
 (149,'Pivní stáj','Veveří 38, 602 00 Brno-střed','The best burgers in South Moravian Region with great prices are available at Pivní stáj.','https://i.imgur.com/RX8fTFm.jpg','2018-03-01 19:30:00','15'),
 (12,'Klub cestovatelů','Veleslavínova 183/14, 612 00 Brno','Oriental dishes from the whole Asia. Discover the taste of adventure with the Klub cestovatelů restaurant.','https://i.imgur.com/W2NhNwR.jpg','2018-03-01 19:30:00','15'),
 (150,'Borgeska','Palackého tř. 285/47, 612 00 Brno-Královo Pole','Traditionall czech dishes, menu and desserts from Borgeska restaurant.','https://i.imgur.com/42oGtPp.jpg','2018-03-01 19:30:00','15');
INSERT INTO "id_operator_jedla" ("id","id_operatora") VALUES
 ('12569','12'),
 ('14598','13'),
 ('25896','14'),
 ('14785','15');
INSERT INTO "id_objednavky_jedla" ("id","id_objednavky") VALUES
 ('12569','1546958732'),
 ('14598','9685743625'),
 ('25896','9152364859'),
 ('14785','7589621548');
INSERT INTO "obsahuje_objednavku" ("id","id_plan_ridice") VALUES
 ('1546958732','5869745812'),
 ('9685743625','2585554471'),
 ('9152364859','9966885575'),
 ('7589621548','1111171458');
INSERT INTO "objednal_objednavku" ("id","id_stravnika") VALUES
 ('1546958732','0'),
 ('9685743625','1'),
 ('9152364859','2'),
 ('7589621548','3');
INSERT INTO "ukoncuje_objednavku" ("id","id_operatora") VALUES
 ('1546958732','12'),
 ('9685743625','13'),
 ('9152364859','14'),
 ('7589621548','15');
INSERT INTO "OBJEDNAVKA" ("id","cena_celkom","stav","cas_objednania","cas_dorucenia","id_operatora","id_stravnika","id_plan_ridice") VALUES
 ('1546958732',35,'Dorucene','2017-07-23 14:26:00','2017-07-23 15:06:00','12','0','5869745812'),
 ('9685743625',18.6,'Priprava','2017-06-23 11:17:00','2017-06-23 13:17:00','13','1','2585554471'),
 ('9152364859',3.5,'Prijata','2018-02-01 16:34:00','2018-02-01 17:34:00','14','2','9966885575'),
 ('7589621548',21.7,'Dorucene','2018-03-01 19:47:00','2018-03-01 20:27:00','15','3','1111171458');
INSERT INTO "id_ridica_plan_ridice" ("id_planu","id_ridica") VALUES
 ('5869745812','2356897845'),
 ('2585554471','0012503654'),
 ('9966885575','10'),
 ('1111171458','11');
INSERT INTO "id_operatora_plan_ridice" ("id_planu","id_operatora") VALUES
 ('5869745812','12'),
 ('2585554471','13'),
 ('9966885575','14'),
 ('1111171458','15');