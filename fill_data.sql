-- 1/ vzdy prepojeny prvý v riadku s prvým a tak ...
-- 2/ nevyriesena polievka v menu
-- 3/ pri cene €/Kc nemoze byt INTEGER
-- 4/ ID OBJEDNAVKA aspon VARCHAR(10)
-- 5/ upraveny NEREGISTROVANY_UZIVATEL + "priezvisko" (vsade to tak je ->konzistencia DB)
-- 6/ limit jedal by sme mohli nahradit za nieco ako  pocet vernostnych bodov(1 objednavka=1bod) pri STRAVNIKOVI
-- 7/ potrebne telefonne cisla rovnakeho typu 
-- +/ INTEGER asi neberie "+" potrebny VARCHAR(13)  
-- 8/ vyriesenie HESLA 
------------------------------------------------------------------------------

-- /8

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

-- /7
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

-- /6
INSERT INTO STRAVNIK (limit_jedal, id) 
VALUES('5', '0000123414'); 
INSERT INTO STRAVNIK (limit_jedal, id)
VALUES('6', '0000259896');
INSERT INTO STRAVNIK (limit_jedal, id)
VALUES('5', '9856745848');
INSERT INTO STRAVNIK (limit_jedal, id)
VALUES('4', '0012563598');

-- /5
INSERT INTO NEREGISTROVANY_UZIVATEL (adresa, meno, priezvisko, tel_cislo) 
VALUES('Purkynova 16', 'Anastasia', 'Valova', '+421966855744');
INSERT INTO NEREGISTROVANY_UZIVATEL (adresa, meno, priezvisko, tel_cislo)
VALUES('Kolejni 11', 'Peter', 'Minarik', '+421925836914');
INSERT INTO NEREGISTROVANY_UZIVATEL (adresa, meno, priezvisko, tel_cislo)
VALUES('Namesti miru 66', 'Tibor', 'Mery', '+420917875489');
INSERT INTO NEREGISTROVANY_UZIVATEL (adresa, meno, priezvisko, tel_cislo)
VALUES('Veveri 96', 'Agnesa', 'Varnova', '+420987687487');

-- /4
INSERT INTO OBJEDNAVKA (id, cena_celkom, stav, cas_objednania, cas_dorucenia, id_operatora, id_stravnika) 
VALUES('1546958732', '35', 'Dorucene', '2017-07-23 14:26:00', '2017-07-23 15:06:00', '0000000048', '0000123414');
INSERT INTO OBJEDNAVKA (id, cena_celkom, stav, cas_objednania, cas_dorucenia, id_operatora, id_stravnika)
VALUES('9685743625', '18.6', 'Priprava', '2017-06-23 11:17:00', '2017-06-23 13:17:00', '1526485976', '0000259896');
INSERT INTO OBJEDNAVKA (id, cena_celkom, stav, cas_objednania, cas_dorucenia, id_operatora, id_stravnika)
VALUES('9152364859', '3.5', 'Prijata', '2018-02-01 16:34:00', '2018-02-01 17:34:00', '0001226598', '9856745848');
INSERT INTO OBJEDNAVKA (id, cena_celkom, stav, cas_objednania, cas_dorucenia, id_operatora, id_stravnika)
VALUES('7589621548', '21.7', 'Dorucene', '2018-03-01 19:47:00', '2018-03-01 20:27:00', '0012015486', '0012563598');

-- /3
INSERT INTO POLOZKY (id, nazov, typ, popis, cena, id_objednavky, id_operator)  
VALUES('12569', 'Rajec', 'Perliva', 'Napoj bez cukru', '0.80', '1546958732', '0000000048');
INSERT INTO POLOZKY (id, nazov, typ, popis, cena, id_objednavky, id_operator)
VALUES('14598', 'Zemiakova kasa', 'BIO', 'Kasa varena z domacich zemiakov s bazalkou', '3', '9685743625', '1526485976');
INSERT INTO POLOZKY (id, nazov, typ, popis, cena, id_objednavky, id_operator)
VALUES('24875', 'Cicerova polievka', 'Vegan', 'Strukovinova polievka so zemiakmi a mrkvou', '4', '9152364859', '0001226598');
INSERT INTO POLOZKY (id, nazov, typ, popis, cena, id_objednavky, id_operator)
VALUES('33654', 'Ryza', 'Bezlepkova', 'Gulatozrnna ryza s kari korenim', '3.5', '7589621548', '0012015486');

-- DENNI_MENU
INSERT INTO NABIDKA (id)
VALUES('16498');
INSERT INTO NABIDKA (id)
VALUES('12365');
INSERT INTO NABIDKA (id)
VALUES('32256');
INSERT INTO NABIDKA (id)
VALUES('22215');

-- STALA_NABIDKA
INSERT INTO NABIDKA (id)
VALUES('19998');
INSERT INTO NABIDKA (id)
VALUES('16665');
INSERT INTO NABIDKA (id)
VALUES('31156');
INSERT INTO NABIDKA (id)
VALUES('26815');

INSERT INTO STALA_NABIDKA (hl_jedlo, priloha, napoj, polievka, id) 
VALUES('Vyprazany syr', 'Hranolky', 'Kofola', 'Karfiolova polievka', '19998');
INSERT INTO STALA_NABIDKA (hl_jedlo, priloha, napoj, polievka, id)
VALUES('Pecena kacka', 'Opekane zemiaky', 'Rajec', 'Drzkova polievka', '16665');
INSERT INTO STALA_NABIDKA (hl_jedlo, priloha, napoj, polievka, id)
VALUES('Rybie file', 'Zemiakova kasa', 'Mattoni', 'Cicerova polievka', '31156');
INSERT INTO STALA_NABIDKA (hl_jedlo, priloha, napoj, polievka, id)
VALUES('Grilovane kura', 'Ryza', 'Vinea', 'Kapustnica', '26815');

-- /2
INSERT INTO DENNI_MENU (den, jedlo, napoj, polievka, id) 
VALUES('Pondelok', 'Veg Madras', 'CocaCola', 'Brokolicovy krem', '16498');
INSERT INTO DENNI_MENU (den, jedlo, napoj, polievka, id)
VALUES('Utorok', 'Tatarsky biftek', 'Sprite', 'Paradajkova polievka', '12365');
INSERT INTO DENNI_MENU (den, jedlo, napoj, polievka, id)
VALUES('Streda', 'Spaghety Bolognese', 'Bonaqua', 'Gulasova polievka', '32256');
INSERT INTO DENNI_MENU (den, jedlo, napoj, polievka, id)
VALUES('Stvrtok', 'Pizza Syrova', 'Tonic', 'Kuraci vyvar', '22215');

INSERT INTO PROVOZNA (id, nazov, adresa, uzavierka, id_operatora, id_nabidky)
VALUES('123', 'Pizzeria Mozarella', 'Kolejni 2 ', '2017-07-23 20:00:00', '0000000048', '16498');
INSERT INTO PROVOZNA (id, nazov, adresa, uzavierka, id_operatora, id_nabidky)
VALUES('255', 'U troch opic', 'Palackeho trida 77', '2017-06-23 19:00:00', '1526485976', '12365');
INSERT INTO PROVOZNA (id, nazov, adresa, uzavierka, id_operatora, id_nabidky)
VALUES('147', 'Everest', 'Grohova 6', '2018-02-01 18:30:00', '0001226598', '31156');
INSERT INTO PROVOZNA (id, nazov, adresa, uzavierka, id_operatora, id_nabidky)
VALUES('012', 'Pivni staj', 'Veveri 38', '2018-03-01 19:30:00', '0012015486', '26815');

INSERT INTO PLAN_RIDICE (id_regionu, id_objednavky, id_ridic, id_operator)
VALUES('MORAV', '1546958732', '2356897845', '0000000048');
INSERT INTO PLAN_RIDICE (id_regionu, id_objednavky, id_ridic, id_operator)
VALUES('SUMAV', '9685743625', '0012503654', '1526485976');
INSERT INTO PLAN_RIDICE (id_regionu, id_objednavky, id_ridic, id_operator)
VALUES('PLZEN', '9152364859', '0000125469', '0001226598');
INSERT INTO PLAN_RIDICE (id_regionu, id_objednavky, id_ridic, id_operator)
VALUES('PRAHA', '7589621548', '0000001548', '0012015486');



