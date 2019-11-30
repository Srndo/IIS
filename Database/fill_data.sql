/* 
 1/ vyriesenie HESLA --> hashovacia funkcia   
 
 3/ PLAN_RIDICE 1:1 

 4/ 0..5 JEDAL V MENU 
 
*/

-- STRAVNICI
INSERT INTO UZIVATEL (id, meno, priezvisko, adresa, tel_cislo, email, heslo)  
VALUES('0000123414', 'Leopold', 'Halaj', 'Zahrebska 97', '+421908013019', 'Leopold.Halaj@gmail.com', '???');
INSERT INTO UZIVATEL (id, meno, priezvisko, adresa, tel_cislo, email, heslo)  
VALUES('0000259896', 'Izabela', 'Sokolova', 'Vodova 61', '+420786666954', 'Izabela.Sokolova@gmail.com', '???');
INSERT INTO UZIVATEL (id, meno, priezvisko, adresa, tel_cislo, email, heslo)  
VALUES('9856745848', 'Julia', 'Cermakova', 'Technicka 1', '+420778695444', 'Julia.Cermakova@gmail.com', '???');
INSERT INTO UZIVATEL (id, meno, priezvisko, adresa, tel_cislo, email, heslo)  
VALUES('0012563598', 'David', 'Silber', 'Gorkeho 42', '+421569863457', 'David.Silber@gmail.com', '???');

-- ADMINI
INSERT INTO UZIVATEL (id, meno, priezvisko, adresa, tel_cislo, email, heslo)  
VALUES('0000025698', 'Andrea', 'Villova', 'Botanicka 77', '+420968569832', 'Andrea.Villova@gmail.com', '???');
INSERT INTO UZIVATEL (id, meno, priezvisko, adresa, tel_cislo, email, heslo)  
VALUES('0001234569', 'Ingrid', 'Bartova', 'Grohova 11', '+420789568476', 'Ingrid.Bartova@gmail.com', '???');
INSERT INTO UZIVATEL (id, meno, priezvisko, adresa, tel_cislo, email, heslo)  
VALUES('0789568236', 'Emil', 'Voda', 'Kolejni 45', '+420156328957', 'Emil.Voda@gmail.com', '???');
INSERT INTO UZIVATEL (id, meno, priezvisko, adresa, tel_cislo, email, heslo)  
VALUES('5874692354', 'Jakub', 'Cenek', 'Kounicova 16', '+420588996335', 'Jakub.Cenek@gmail.com', '???');

-- RIDICI
INSERT INTO UZIVATEL (id, meno, priezvisko, adresa, tel_cislo, email, heslo)  
VALUES('2356897845', 'Arnold', 'Noga', 'Bozetechova 16', '+420123569866', 'Arnold.Noga@gmail.com', '???');
INSERT INTO UZIVATEL (id, meno, priezvisko, adresa, tel_cislo, email, heslo)  
VALUES('0012503654', 'Oliver', 'Stanek', 'Husitska 97', '+420485967256', 'Oliver.Stanek@gmail.com', '???');
INSERT INTO UZIVATEL (id, meno, priezvisko, adresa, tel_cislo, email, heslo)  
VALUES('0000125469', 'Andrej', 'Dolnik', 'Reisigova 785', '+421958658489', 'Andrej.Dolnik@gmail.com', '???');
INSERT INTO UZIVATEL (id, meno, priezvisko, adresa, tel_cislo, email, heslo)  
VALUES('0000001548', 'Denis', 'Dovicic', 'Hlavna 78', '+421456987221', 'Denis.Dovicic@gmail.com', '???');

-- OPERATORI
INSERT INTO UZIVATEL (id, meno, priezvisko, adresa, tel_cislo, email, heslo)  
VALUES('0000000048', 'Antonia', 'Horna', 'Nova 35', '+421985625333', 'Antonia.Horna@gmail.com', '???');
INSERT INTO UZIVATEL (id, meno, priezvisko, adresa, tel_cislo, email, heslo)  
VALUES('1526485976', 'Vincent', 'Kocis', 'Tererova 51', '+421915612359', 'Vincent.Kocis@gmail.com', '???');
INSERT INTO UZIVATEL (id, meno, priezvisko, adresa, tel_cislo, email, heslo)  
VALUES('0001226598', 'Zora', 'Fererova', 'Masarikova 154', '+420799652114', 'Zora.Fererova@gmail.com', '???');
INSERT INTO UZIVATEL (id, meno, priezvisko, adresa, tel_cislo, email, heslo)  
VALUES('0012015486', 'Hugo', 'Lovin', 'Capkova 34', '+420784514598', 'Hugo.Lovin@gmail.com', '???');

INSERT INTO OPERATOR (sluzobny_tel, id) 
VALUES('+420987565369', '0000000048');
INSERT INTO OPERATOR (sluzobny_tel, id) 
VALUES('+421986654269', '1526485976');
INSERT INTO OPERATOR (sluzobny_tel, id) 
VALUES('+420777569832', '0001226598');
INSERT INTO OPERATOR (sluzobny_tel, id) 
VALUES('+421915623587', '0012015486');

INSERT INTO RIDIC (spz, id)
VALUES('4L09515', '2356897845');
INSERT INTO RIDIC (spz, id)
VALUES('9H97903', '0012503654');
INSERT INTO RIDIC (spz, id)
VALUES('S012025', '0000125469');
INSERT INTO RIDIC (spz, id)
VALUES('BB204FI', '0000001548');

INSERT INTO ADMIN (id_ntb, id)
VALUES('7946132584', '0000025698');
INSERT INTO ADMIN (id_ntb, id)
VALUES('8569743215', '0001234569');
INSERT INTO ADMIN (id_ntb, id)
VALUES('3625956874', '0789568236');
INSERT INTO ADMIN (id_ntb, id)
VALUES('1346978526', '5874692354');

INSERT INTO STRAVNIK (cislo_karty, id) 
VALUES('4468987566982569', '0000123414'); 
INSERT INTO STRAVNIK (cislo_karty, id)
VALUES('4587658932561452', '0000259896');
INSERT INTO STRAVNIK (cislo_karty, id)
VALUES('4587652358746589', '9856745848');
INSERT INTO STRAVNIK (cislo_karty, id)
VALUES('1245652366665897', '0012563598');

INSERT INTO NEREGISTROVANY_UZIVATEL (adresa, meno, priezvisko, tel_cislo) 
VALUES('Purkynova 16', 'Anastasia', 'Valova', '+421966855744');
INSERT INTO NEREGISTROVANY_UZIVATEL (adresa, meno, priezvisko, tel_cislo)
VALUES('Kolejni 11', 'Peter', 'Minarik', '+421925836914');
INSERT INTO NEREGISTROVANY_UZIVATEL (adresa, meno, priezvisko, tel_cislo)
VALUES('Namesti miru 66', 'Tibor', 'Mery', '+420917875489');
INSERT INTO NEREGISTROVANY_UZIVATEL (adresa, meno, priezvisko, tel_cislo)
VALUES('Veveri 96', 'Agnesa', 'Varnova', '+420987687487');

INSERT INTO PLAN_RIDICE (id_planu, region, id_operator, id_ridica)
VALUES('5869745812', 'Moravsky region', '0000000048', '2356897845');
INSERT INTO PLAN_RIDICE (id_planu, region, id_operator, id_ridica)
VALUES('2585554471', 'Sumava', '1526485976', '0012503654');
INSERT INTO PLAN_RIDICE (id_planu, region, id_operator, id_ridica)
VALUES('9966885575', 'Plzensky region', '0001226598', '0000125469');
INSERT INTO PLAN_RIDICE (id_planu, region, id_operator, id_ridica)
VALUES('1111171458', 'Prazsky region', '0012015486', '0000001548');

INSERT INTO id_operatora_plan_ridice (id_planu, id_operatora) 
VALUES('5869745812', '0000000048');
INSERT INTO id_operatora_plan_ridice (id_planu, id_operatora) 
VALUES('2585554471', '1526485976');
INSERT INTO id_operatora_plan_ridice (id_planu, id_operatora) 
VALUES('9966885575', '0001226598');
INSERT INTO id_operatora_plan_ridice (id_planu, id_operatora) 
VALUES('1111171458', '0012015486');

INSERT INTO id_ridica_plan_ridice (id_planu, id_ridica)
VALUES('5869745812', '2356897845');
INSERT INTO id_ridica_plan_ridice (id_planu, id_ridica)
VALUES('2585554471', '0012503654');
INSERT INTO id_ridica_plan_ridice (id_planu, id_ridica)
VALUES('9966885575', '0000125469');
INSERT INTO id_ridica_plan_ridice (id_planu, id_ridica)
VALUES('1111171458', '0000001548');

INSERT INTO OBJEDNAVKA (id, cena_celkom, stav, cas_objednania, cas_dorucenia, id_operatora, id_stravnika, id_plan_ridice) 
VALUES('1546958732', '35', 'Dorucene', '2017-07-23 14:26:00', '2017-07-23 15:06:00', '0000000048', '0000123414', '5869745812');
INSERT INTO OBJEDNAVKA (id, cena_celkom, stav, cas_objednania, cas_dorucenia, id_operatora, id_stravnika, id_plan_ridice)
VALUES('9685743625', '18.6', 'Priprava', '2017-06-23 11:17:00', '2017-06-23 13:17:00', '1526485976', '0000259896', '2585554471');
INSERT INTO OBJEDNAVKA (id, cena_celkom, stav, cas_objednania, cas_dorucenia, id_operatora, id_stravnika, id_plan_ridice)
VALUES('9152364859', '3.5', 'Prijata', '2018-02-01 16:34:00', '2018-02-01 17:34:00', '0001226598', '9856745848', '9966885575');
INSERT INTO OBJEDNAVKA (id, cena_celkom, stav, cas_objednania, cas_dorucenia, id_operatora, id_stravnika, id_plan_ridice)
VALUES('7589621548', '21.7', 'Dorucene', '2018-03-01 19:47:00', '2018-03-01 20:27:00', '0012015486', '0012563598', '1111171458');

INSERT INTO ukoncuje_objednavku (id, id_operatora) 
VALUES('1546958732', '0000000048');
INSERT INTO ukoncuje_objednavku (id, id_operatora) 
VALUES('9685743625', '1526485976');
INSERT INTO ukoncuje_objednavku (id, id_operatora) 
VALUES('9152364859', '0001226598');
INSERT INTO ukoncuje_objednavku (id, id_operatora) 
VALUES('7589621548', '0012015486');

INSERT INTO objednal_objednavku (id, id_stravnika) 
VALUES('1546958732', '0000123414');
INSERT INTO objednal_objednavku (id, id_stravnika) 
VALUES('9685743625', '0000259896');
INSERT INTO objednal_objednavku (id, id_stravnika) 
VALUES('9152364859', '9856745848');
INSERT INTO objednal_objednavku (id, id_stravnika) 
VALUES('7589621548', '0012563598');

INSERT INTO obsahuje_objednavku (id, id_plan_ridice)
VALUES('1546958732', '5869745812');
INSERT INTO obsahuje_objednavku (id, id_plan_ridice)
VALUES('9685743625', '2585554471');
INSERT INTO obsahuje_objednavku (id, id_plan_ridice)
VALUES('9152364859', '9966885575');
INSERT INTO obsahuje_objednavku (id, id_plan_ridice)
VALUES('7589621548', '1111171458');

-- TRVALA NABIDKA
INSERT INTO JIDLO (id, nazov, typ, popis, alergeny, cena, id_objednavky, id_operator)  
VALUES('12569', 'Rajec', 'napoj', 'Syteny napoj bez cukru', '0', '0.80', '1546958732', '0000000048');
INSERT INTO JIDLO (id, nazov, typ, popis, alergeny, cena, id_objednavky, id_operator)
VALUES('14598', 'Zemiakova kasa', 'priloha', 'Kasa varena z domacich zemiakov s bazalkou', '4', '3', '9685743625', '1526485976');
INSERT INTO JIDLO (id, nazov, typ, popis, alergeny, cena, id_objednavky, id_operator)
VALUES('24875', 'Cicerova polievka', 'polievka', 'Strukovinova polievka so zemiakmi a mrkvou', '7,9', '4', '9152364859', '0001226598');
INSERT INTO JIDLO (id, nazov, typ, popis, alergeny, cena, id_objednavky, id_operator)
VALUES('33654', 'Ryza', 'priloha', 'Gulatozrnna ryza s kari korenim', '10', '3.5', '7589621548', '0012015486');

-- MENU 
INSERT INTO JIDLO (id, nazov, typ, popis, alergeny, cena, id_objednavky, id_operator)   -- neviem ci typ nechat prezdny alebo "MENU"? 
VALUES('25896', 'Veg Madras, Rajcatova polevka', 'MENU', 'Varena zelenina v stredne palivej omacke a ako priloha Nan', '5,6', '0.80', '1546958732', '0000000048');
INSERT INTO JIDLO (id, nazov, typ, popis, alergeny, cena, id_objednavky, id_operator)
VALUES('14785', 'Tatarsky biftek, Zeleninova polevka', 'MENU', 'Mlete hovadzie maso s korenim', '2,4,7', '3', '9685743625', '1526485976');
INSERT INTO JIDLO (id, nazov, typ, popis, alergeny, cena, id_objednavky, id_operator)
VALUES('36985', 'Spaghety Bolognese, Cesnekova polevka', 'MENU', 'Spagety s lahodnou omackou', '7,8', '4', '9152364859', '0001226598');
INSERT INTO JIDLO (id, nazov, typ, popis, alergeny, cena, id_objednavky, id_operator)
VALUES('55589', 'Pizza Syrova, Brokolicova polevka', 'MENU', 'Pizza s tromi druhmi syra', '1,2,4,10', '3.5', '7589621548', '0012015486');

INSERT INTO id_objednavky_jedla (id, id_objednavky)
VALUES('12569', '1546958732');
INSERT INTO id_objednavky_jedla (id, id_objednavky)
VALUES('14598', '9685743625'); 
INSERT INTO id_objednavky_jedla (id, id_objednavky)
VALUES('25896', '9152364859');
INSERT INTO id_objednavky_jedla (id, id_objednavky)
VALUES('14785', '7589621548');

INSERT INTO id_operator_jedla (id, id_operatora) 
VALUES('12569', '0000000048');
INSERT INTO id_operator_jedla (id, id_operatora) 
VALUES('14598', '1526485976');
INSERT INTO id_operator_jedla (id, id_operatora) 
VALUES('25896', '0001226598');
INSERT INTO id_operator_jedla (id, id_operatora) 
VALUES('14785', '0012015486');

INSERT INTO PROVOZNA (id, nazov, adresa, uzavierka, id_operatora)
VALUES('123', 'Pizzeria Mozarella', 'Kolejni 2 ', '2017-07-23 20:00:00', '0000000048');
INSERT INTO PROVOZNA (id, nazov, adresa, uzavierka, id_operatora)
VALUES('255', 'U troch opic', 'Palackeho trida 77', '2017-06-23 19:00:00', '1526485976');
INSERT INTO PROVOZNA (id, nazov, adresa, uzavierka, id_operatora)
VALUES('147', 'Everest', 'Grohova 6', '2018-02-01 18:30:00', '0001226598');
INSERT INTO PROVOZNA (id, nazov, adresa, uzavierka, id_operatora)
VALUES('012', 'Pivni staj', 'Veveri 38', '2018-03-01 19:30:00', '0012015486');

INSERT INTO spravuje_provoznu (id, id_operatora) 
VALUES('123', '0000000048');
INSERT INTO spravuje_provoznu (id, id_operatora) 
VALUES('255', '1526485976');
INSERT INTO spravuje_provoznu (id, id_operatora) 
VALUES('147', '0001226598');
INSERT INTO spravuje_provoznu (id, id_operatora) 
VALUES('012', '0012015486');

INSERT INTO TRVALA_NABIDKA (id, platnost_od, platnost_do, id_provozny) 
VALUES('19998', '2019-09-23', '2019-12-20', '123');
INSERT INTO TRVALA_NABIDKA (id, platnost_od, platnost_do, id_provozny)
VALUES('16665', '2019-12-21', '2020-03-19', '255');
INSERT INTO TRVALA_NABIDKA (id, platnost_od, platnost_do, id_provozny)
VALUES('31156', '2020-03-20', '2020-06-20', '147');
INSERT INTO TRVALA_NABIDKA (id, platnost_od, platnost_do, id_provozny)
VALUES('26815', '2020-06-21', '2020-09-22', '012');

INSERT INTO ponuka_trvala_nabidka (id, id_provozny) 
VALUES('19998', '123');
INSERT INTO ponuka_trvala_nabidka (id, id_provozny) 
VALUES('16665', '255');
INSERT INTO ponuka_trvala_nabidka (id, id_provozny) 
VALUES('31156', '147');
INSERT INTO ponuka_trvala_nabidka (id, id_provozny) 
VALUES('26815', '012');

INSERT INTO JIDLO_TRVALA_NABIDKA (jidlo_id, trvala_nabidka_id) -- prepojenie tabuliek JIDLO a TRVALA_NABIDKA N:N
VALUES('12569', '19998'); 
INSERT INTO JIDLO_TRVALA_NABIDKA (jidlo_id, trvala_nabidka_id)
VALUES('14598', '16665');
INSERT INTO JIDLO_TRVALA_NABIDKA (jidlo_id, trvala_nabidka_id)
VALUES('24875', '31156');
INSERT INTO JIDLO_TRVALA_NABIDKA (jidlo_id, trvala_nabidka_id)
VALUES('33654', '26815');

INSERT INTO DENNI_MENU (id, datum, id_provozny) -- nebude musiet sem ist "ativny datum " ? alebo ako to nazvat ? 
VALUES('16498', '2019-12-01', '123');
INSERT INTO DENNI_MENU (id, datum, id_provozny)
VALUES('12365', '2019-12-02', '255');
INSERT INTO DENNI_MENU (id, datum, id_provozny)
VALUES('32256', '2019-12-03', '147');
INSERT INTO DENNI_MENU (id, datum, id_provozny)
VALUES('22215', '2019-12-04', '012');

INSERT INTO ponuka_denni_menu (id, id_provozny) 
VALUES('16498', '123');
INSERT INTO ponuka_denni_menu (id, id_provozny) 
VALUES('12365', '255');
INSERT INTO ponuka_denni_menu (id, id_provozny) 
VALUES('32256', '147');
INSERT INTO ponuka_denni_menu (id, id_provozny) 
VALUES('22215', '012');

INSERT INTO JIDLO_DENNI_MENU (jidlo_id, denne_menu_id) -- prepojenie tabuliek JIDLO a DENNI_MENU N:N
VALUES('25896', '16498'); 
INSERT INTO JIDLO_DENNI_MENU (jidlo_id, denne_menu_id)
VALUES('14785', '12365');
INSERT INTO JIDLO_DENNI_MENU (jidlo_id, denne_menu_id)
VALUES('36985', '32256');
INSERT INTO JIDLO_DENNI_MENU (jidlo_id, denne_menu_id)
VALUES('55589', '22215');
