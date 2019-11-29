-- ---------------------------------------------------------------------- --
-- ------------------------VYMAZANIE TABS.------------------------------- --
-- ---------------------------------------------------------------------- --

DROP TABLE UZIVATEL             ;
DROP TABLE OPERATOR             ;
DROP TABLE RIDIC                ;
DROP TABLE ADMIN                ;
DROP TABLE STRAVNIK             ;
DROP TABLE NEREGISTROVANY_UZIVATEL;
DROP TABLE PLAN_RIDICE          ;
DROP TABLE OBJEDNAVKA           ;
DROP TABLE JIDLO                ;
DROP TABLE PROVOZNA             ;
DROP TABLE TRVALA_NABIDKA       ;
DROP TABLE JIDLO_TRVALA_NABIDKA ;
DROP TABLE DENNI_MENU           ;
DROP TABLE JIDLO_DENNI_MENU     ;

-- ---------------------------------------------------------------------- --
-- ------------------------VYTVORENIE TABS.------------------------------ --
-- ---------------------------------------------------------------------- --

CREATE TABLE UZIVATEL(
    id              VARCHAR(10) NOT NULL PRIMARY KEY, -- login
    meno            VARCHAR(20) NOT NULL,
    priezvisko      VARCHAR(20) NOT NULL,
    adresa          VARCHAR(20) NOT NULL,
    tel_cislo       VARCHAR(13) NOT NULL,
    email           VARCHAR(100) NOT NULL,
    heslo           VARCHAR(20) NOT NULL
    
    -- id_admin_obj    VARCHAR(10) NOT NULL,
    
    -- CONSTRAINT spravuje_uzivatela FOREIGN KEY (id_admin_obj) REFERENCES ADMIN(id)
    -- NEED TEST ...ADMIN NAMODELOVANY NIZSIE !!! ???
    -- TOTO NIE JE DOROBENE ANI TO FILLDAT ->
);

CREATE TABLE OPERATOR(
    sluzobny_tel    VARCHAR(13) NOT NULL,
    id              VARCHAR(10) NOT NULL,
    
    CONSTRAINT id_operator FOREIGN KEY (id) REFERENCES UZIVATEL(id)
);

CREATE TABLE RIDIC(
    spz     VARCHAR(10) NOT NULL,
    id      VARCHAR(10) NOT NULL,

    CONSTRAINT id_ridic FOREIGN KEY (id) REFERENCES UZIVATEL(id)
);

CREATE TABLE ADMIN(
    id_ntb     VARCHAR(10) NOT NULL,
    id         VARCHAR(10) NOT NULL,

    CONSTRAINT id_admin FOREIGN KEY (id) REFERENCES UZIVATEL(id)
);

CREATE TABLE STRAVNIK(
    cislo_karty     INT(16) NOT NULL, 
    id              VARCHAR(10) NOT NULL,

    CONSTRAINT id_stravnik FOREIGN KEY (id) REFERENCES UZIVATEL(id)
);

CREATE TABLE NEREGISTROVANY_UZIVATEL(
    adresa      VARCHAR(20) NOT NULL,
    meno        VARCHAR(20) NOT NULL,
    priezvisko  VARCHAR(20) NOT NULL,
    tel_cislo   VARCHAR(13) NOT NULL,
);

CREATE TABLE PLAN_RIDICE(
    id_planu        VARCHAR(10) NOT NULL,
    region          VARCHAR(10)NOT NULL,
    id_operatora    VARCHAR(10) NOT NULL,
    id_ridica       VARCHAR(10) NOT NULL,

    CONSTRAINT id_operatora_plan_ridice FOREIGN KEY (id_operatora) REFERENCES OPERATOR(id),
    CONSTRAINT id_ridica_plan_ridice FOREIGN KEY (id_ridica) REFERENCES RIDIC(id)
);  

CREATE TABLE OBJEDNAVKA(
    id                  VARCHAR(10) NOT NULL PRIMARY KEY,
    cena_celkom         INT(10) NOT NULL,
    stav                VARCHAR(10) NOT NULL,
    cas_objednania      TIMESTAMP NOT NULL,
    cas_dorucenia       TIMESTAMP NOT NULL, -- DATE

    id_operatora    VARCHAR(10),
    id_stravnika    VARCHAR(10),
    id_plan_ridice  VARCHAR(5),
    
    CONSTRAINT ukoncuje_objednavku FOREIGN KEY (id_operatora) REFERENCES OPERATOR(id),
    CONSTRAINT objednal_objednavku FOREIGN KEY (id_stravnika) REFERENCES STRAVNIK(id),
    CONSTRAINT obsahuje_objednavku FOREIGN KEY (id_plan_ridice) REFERENCES PLAN_RIDICE(id_planu)
);

CREATE TABLE JIDLO(
    id          VARCHAR(5) NOT NULL PRIMARY KEY,
    nazov       VARCHAR(20) NOT NULL,
    typ         VARCHAR(20) NOT NULL,
    popis       VARCHAR(100),
    alergeny    VARCHAR(20),
    cena        INT(10) NOT NULL,
    -- obrázok image
    
    id_objednavky   VARCHAR(10),
    id_operatora    VARCHAR(10),
   
    CONSTRAINT id_objednavky_jedla FOREIGN KEY (id_objednavky) REFERENCES OBJEDNAVKA(id),
    CONSTRAINT id_operator_jedla FOREIGN KEY (id_operatora) REFERENCES OPERATOR(id)    
);

CREATE TABLE PROVOZNA( 
    id          INTEGER(3) NOT NULL PRIMARY KEY,
    nazov       VARCHAR(100) NOT NULL,
    adresa      VARCHAR(100) NOT NULL,
    uzavierka   TIMESTAMP NOT NULL,
    
    id_operatora    VARCHAR(10),

    CONSTRAINT spravuje_provoznu FOREIGN KEY (id_operatora) REFERENCES OPERATOR(id)
);

CREATE TABLE TRVALA_NABIDKA(
    id              VARCHAR(5) NOT NULL,
    platnost_od     DATE NOT NULL,
    platnost_do     DATE NOT NULL,

    id_provozny INTEGER(3) NOT NULL,

    CONSTRAINT ponuka_trvala_nabidka FOREIGN KEY (id_provozny) REFERENCES PROVOZNA(id)
);

CREATE TABLE JIDLO_TRVALA_NABIDKA( -- N:N  
    jidlo_id            VARCHAR(5) NOT NULL,
    trvala_nabidka_id   VARCHAR(5) NOT NULL,
    
    CONSTRAINT jidlo_trvala_nabidka_jidlo FOREIGN KEY (jidlo_id) REFERENCES JIDLO(id),
    CONSTRAINT jidlo_trvala_nabidka_tn FOREIGN KEY (trvala_nabidka_id) REFERENCES TRVALA_NABIDKA(id),
    CONSTRAINT jidlo_trvala_nabidka_unique UNIQUE (jidlo_id, trvala_nabidka_id)    
);

CREATE TABLE DENNI_MENU(
    id          VARCHAR(5) NOT NULL,
    datum       DATE NOT NULL,
    
    id_provozny INTEGER(3) NOT NULL,
    
    CONSTRAINT ponuka_denni_menu FOREIGN KEY (id_provozny) REFERENCES PROVOZNA(id)
);

-- **************************************************************************************
CREATE TABLE JIDLO_DENNI_MENU( -- N:N ••• OBMEDZENIE -> 0 - 5 POCET JEDAL •••
    jidlo_id            VARCHAR(5) NOT NULL,
    denne_menu_id       VARCHAR(5) NOT NULL,
    
    CONSTRAINT jidlo_denne_menu_jidlo FOREIGN KEY (jidlo_id) REFERENCES JIDLO(id),
    CONSTRAINT jidlo_denne_menu_dm FOREIGN KEY (denne_menu_id) REFERENCES DENNI_MENU(id),
    CONSTRAINT jidlo_denne_menu_unique UNIQUE (jidlo_id, denne_menu_id) 
);