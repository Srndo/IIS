-- ---------------------------------------------------------------------- --
-- ------------------------VYMAZANIE TABS.------------------------------- --
-- ---------------------------------------------------------------------- --

DROP TABLE PLAN_RIDICE  ;
DROP TABLE PROVOZNA     ;
DROP TABLE DENNI_MENU   ;
DROP TABLE STALA_NABIDKA;
DROP TABLE NABIDKA      ;
DROP TABLE POLOZKY      ;
DROP TABLE OBJEDNAVKA   ;
DROP TABLE NEREGISTROVANY_UZIVATEL;
DROP TABLE STRAVNIK     ;
DROP TABLE ADMIN        ;
DROP TABLE RIDIC        ;
DROP TABLE OPERATOR     ;
DROP TABLE UZIVATEL     ;

-- ---------------------------------------------------------------------- --
-- ------------------------VYTVORENIE TABS.------------------------------ --
-- ---------------------------------------------------------------------- --

CREATE TABLE UZIVATEL(
    id          VARCHAR(20) NOT NULL PRIMARY KEY, -- login
    meno        VARCHAR(20) NOT NULL,
    priezvisko  VARCHAR(20) NOT NULL,
    adresa      VARCHAR(20) NOT NULL,
    tel_cislo   SMALLINT(13) NOT NULL,
    email       VARCHAR(20) NOT NULL,
    heslo       VARCHAR(20) NOT NULL

    -- TODO: admin editing UZIVATEL (need model via ALTER TABLE?)
);

CREATE TABLE OPERATOR(
    sluzobny_tel    VARCHAR(20) NOT NULL,
    id              VARCHAR(5) NOT NULL,
    CONSTRAINT id_operator FOREIGN KEY (id) REFERENCES UZIVATEL(id)
);

CREATE TABLE RIDIC(
    spz     VARCHAR(10) NOT NULL,
    id      VARCHAR(5) NOT NULL,

    CONSTRAINT id_ridic FOREIGN KEY (id) REFERENCES UZIVATEL(id)
);


CREATE TABLE ADMIN(
    id_ntb     VARCHAR(10) NOT NULL,
    id         VARCHAR(5) NOT NULL,

    CONSTRAINT id_admin FOREIGN KEY (id) REFERENCES UZIVATEL(id)
);

CREATE TABLE STRAVNIK(
    limit_jedal TINYINT(10) NOT NULL,
    id          VARCHAR(5) NOT NULL,

    CONSTRAINT id_stravnik FOREIGN KEY (id) REFERENCES UZIVATEL(id)
);

CREATE TABLE NEREGISTROVANY_UZIVATEL(
    adresa      VARCHAR(20) NOT NULL,
    meno        VARCHAR(20) NOT NULL,
    tel_cislo   SMALLINT(13)
);
  
CREATE TABLE OBJEDNAVKA(
	id		            VARCHAR(5) NOT NULL PRIMARY KEY,
    cena_celkom         SMALLINT(5) NOT NULL,
    stav                VARCHAR(10) NOT NULL,
    cas_objednania		TIMESTAMP NOT NULL,
    cas_dorucenia   	TIMESTAMP NOT NULL, -- DATE

    id_operatora    VARCHAR(20),
    id_stravnika    VARCHAR(20),

    CONSTRAINT ukoncuje_objednavku FOREIGN KEY (id_operatora) REFERENCES OPERATOR(id),
    CONSTRAINT objednal_objednavku FOREIGN KEY (id_stravnika) REFERENCES STRAVNIK(id)
);

CREATE TABLE POLOZKY (
    id      VARCHAR(5) NOT NULL PRIMARY KEY,
    nazov   VARCHAR(20) NOT NULL,
    typ     VARCHAR(20) NOT NULL,
    popis   VARCHAR(30),
    cena    SMALLINT(10) NOT NULL,
    -- obrázok image
    
    id_objednavky VARCHAR(5),
    id_operator   VARCHAR(5),
    -- TODO: missing connection to table NABIDKA (N:N)
    CONSTRAINT id_objednavky_polozky FOREIGN KEY (id_objednavky) REFERENCES OBJEDNAVKA(id),
    CONSTRAINT id_operator_polozky FOREIGN KEY (id_operator) REFERENCES OPERATOR(id)    
);

CREATE TABLE NABIDKA(
    id      VARCHAR(5) NOT NULL PRIMARY KEY
    -- TODO: missing connection to tables: POLOZKY and STRAVNIK (via ERD)
);

CREATE TABLE STALA_NABIDKA(
    hl_jedlo        VARCHAR(20) NOT NULL,
    priloha         VARCHAR(20) NOT NULL,
    napoj       VARCHAR(20) NOT NULL,
    polievka    VARCHAR(20) NOT NULL,
    id          VARCHAR(5) NOT NULL,

    CONSTRAINT id_stala_nabidka FOREIGN KEY (id) REFERENCES NABIDKA(id)
);

CREATE TABLE DENNI_MENU(
    den     DATETIME NOT NULL,
    jedlo   VARCHAR(20) NOT NULL,
    napoj   VARCHAR(20) NOT NULL,
    polievka VARCHAR(20) NOT NULL,
    id      VARCHAR(5) NOT NULL,

    CONSTRAINT id_denni_menu FOREIGN KEY (id) REFERENCES NABIDKA(id)
);

CREATE TABLE PROVOZNA (
    id          TINYINT(3) NOT NULL PRIMARY KEY,
    nazov       VARCHAR(100) NOT NULL,
    adresa      VARCHAR(100) NOT NULL,
    uzavierka   TIMESTAMP NOT NULL, -- DATETIME ? 
    
    id_operatora    VARCHAR(20),
    id_nabidky      VARCHAR(5),

    CONSTRAINT spravuje_provoznu FOREIGN KEY (id_operatora) REFERENCES OPERATOR(id),
    CONSTRAINT provozana_ma_nabidku FOREIGN KEY (id_nabidky) REFERENCES NABIDKA(id)
);

CREATE TABLE PLAN_RIDICE(
    id_regionu      VARCHAR(5) NOT NULL,
    id_objednavky   VARCHAR(5) NOT NULL,
    id_ridic        VARCHAR(20) NOT NULL,
    id_operator     VARCHAR(20) NOT NULL, 


    CONSTRAINT id_objednavky_plan_ridice FOREIGN KEY (id_objednavky) REFERENCES OBJEDNAVKA(id),
    CONSTRAINT id_ridice_plan_ridice FOREIGN KEY (id_ridic) REFERENCES RIDIC(id),
    CONSTRAINT id_operatora_plan_ridice FOREIGN KEY (id_operator) REFERENCES OPERATOR(id)
);


-- ---------------------------------------------------------------------- --
-- ------------------------ UDELENIA PRAV ------------------------------- --
-- ---------------------------------------------------------------------- --

GRANT ALL ON PROVOZNA TO xjendr03;
GRANT ALL ON OBJEDNAVKA TO xjendr03;
GRANT ALL ON POLOZKY TO xjendr03;
GRANT ALL ON NABIDKA TO xjendr03;
GRANT ALL ON STALA_NABIDKA TO xjendr03;
GRANT ALL ON DENNI_MENU TO xjendr03;
GRANT ALL ON PLAN_RIDICE TO xjendr03;
GRANT ALL ON UZIVATEL TO xjendr03;
GRANT ALL ON OPERATOR TO xjendr03;
GRANT ALL ON RIDIC TO xjendr03;
GRANT ALL ON ADMIN TO xjendr03;
GRANT ALL ON STRAVNIK TO xjendr03;
GRANT ALL ON NEREGISTROVANY_UZIVATEL TO xjendr03;