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

DROP TABLE id_operatora_plan_ridice     ;
DROP TABLE id_ridica_plan_ridice        ;
DROP TABLE ukoncuje_objednavku          ;
DROP TABLE objednal_objednavku          ;
DROP TABLE obsahuje_objednavku          ;
DROP TABLE id_objednavky_jedla          ;
DROP TABLE id_operator_jedla            ;
DROP TABLE spravuje_provoznu            ;
DROP TABLE ponuka_trvala_nabidka        ;
DROP TABLE ponuka_denni_menu            ;

-- ---------------------------------------------------------------------- --
-- ------------------------VYTVORENIE TABS.------------------------------ --
-- ---------------------------------------------------------------------- --

CREATE TABLE UZIVATEL(
    id              VARCHAR(10) NOT NULL, -- login
    meno            VARCHAR(20) NOT NULL,
    priezvisko      VARCHAR(20) NOT NULL,
    adresa          VARCHAR(20) NOT NULL,
    tel_cislo       VARCHAR(13) NOT NULL,
    email           VARCHAR(100) NOT NULL,
    heslo           VARCHAR(20) NOT NULL
);

ALTER TABLE UZIVATEL ADD CONSTRAINT PK_UZIVATEL PRIMARY KEY (id);

CREATE TABLE OPERATOR(
    sluzobny_tel    VARCHAR(13) NOT NULL,
    id              VARCHAR(10) NOT NULL
    
    -- CONSTRAINT id_operator FOREIGN KEY (id) REFERENCES UZIVATEL(id)
);

ALTER TABLE OPERATOR ADD CONSTRAINT FK_OPERATOR FOREIGN KEY (id) REFERENCES UZIVATEL;

CREATE TABLE RIDIC(
    spz     VARCHAR(10) NOT NULL,
    id      VARCHAR(10) NOT NULL

    -- CONSTRAINT id_ridic FOREIGN KEY (id) REFERENCES UZIVATEL(id)
);

ALTER TABLE RIDIC ADD CONSTRAINT FK_RIDIC FOREIGN KEY (id) REFERENCES UZIVATEL;

CREATE TABLE ADMIN(
    id_ntb     VARCHAR(10) NOT NULL,
    id         VARCHAR(10) NOT NULL

    -- CONSTRAINT id_admin FOREIGN KEY (id) REFERENCES UZIVATEL(id)
);

ALTER TABLE ADMIN ADD CONSTRAINT FK_ADMIN FOREIGN KEY (id) REFERENCES UZIVATEL;

CREATE TABLE STRAVNIK(
    cislo_karty     INT(16) NOT NULL, 
    id              VARCHAR(10) NOT NULL

    -- CONSTRAINT id_stravnik FOREIGN KEY (id) REFERENCES UZIVATEL(id)
);

ALTER TABLE STRAVNIK ADD CONSTRAINT FK_STRAVNIK FOREIGN KEY (id) REFERENCES UZIVATEL;

CREATE TABLE NEREGISTROVANY_UZIVATEL(
    adresa      VARCHAR(20) NOT NULL,
    meno        VARCHAR(20) NOT NULL,
    priezvisko  VARCHAR(20) NOT NULL,
    tel_cislo   VARCHAR(13) NOT NULL
);

CREATE TABLE PLAN_RIDICE(
    id_planu        VARCHAR(10) NOT NULL,
    region          VARCHAR(10)NOT NULL,
    id_operatora    VARCHAR(10) NOT NULL,
    id_ridica       VARCHAR(10) NOT NULL

--  CONSTRAINT id_operatora_plan_ridice FOREIGN KEY (id_operatora) REFERENCES OPERATOR(id),
--  CONSTRAINT id_ridica_plan_ridice FOREIGN KEY (id_ridica) REFERENCES RIDIC(id)
);  

CREATE TABLE id_operatora_plan_ridice(
    id_planu        VARCHAR(10) NOT NULL,
    id_operatora    VARCHAR(10) NOT NULL
);

CREATE TABLE id_ridica_plan_ridice(
    id_planu    VARCHAR(10) NOT NULL,
    id_ridica   VARCHAR(10) NOT NULL
);

ALTER TABLE PLAN_RIDICE ADD CONSTRAINT PK_PLAN_RIDICE PRIMARY KEY (id_planu,);
ALTER TABLE id_operatora_plan_ridice ADD CONSTRAINT pk_id_operatora PRIMARY KEY (id_planu,id_operatora);
ALTER TABLE id_ridica_plan_ridice ADD CONSTRAINT pk_id_ridica PRIMARY KEY (id_planu,id_ridica);

-- ALTER TABLE Orders ADD CONSTRAINT FK_PersonOrder FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);

CREATE TABLE OBJEDNAVKA(
    id                  VARCHAR(10) NOT NULL,
    cena_celkom         INT(10) NOT NULL,
    stav                VARCHAR(10) NOT NULL,
    cas_objednania      TIMESTAMP NOT NULL,
    cas_dorucenia       TIMESTAMP NOT NULL, -- DATE

    id_operatora    VARCHAR(10),
    id_stravnika    VARCHAR(10),
    id_plan_ridice  VARCHAR(5)
    
--    CONSTRAINT ukoncuje_objednavku FOREIGN KEY (id_operatora) REFERENCES OPERATOR(id),
--    CONSTRAINT objednal_objednavku FOREIGN KEY (id_stravnika) REFERENCES STRAVNIK(id),
--  CONSTRAINT obsahuje_objednavku FOREIGN KEY (id_plan_ridice) REFERENCES PLAN_RIDICE(id_planu)
);

CREATE TABLE ukoncuje_objednavku(
    id              VARCHAR(10) NOT NULL,
    id_operatora    VARCHAR(10) NOT NULL
);

CREATE TABLE objednal_objednavku(
    id              VARCHAR(10) NOT NULL,
    id_stravnika    VARCHAR(10) NOT NULL
);

CREATE TABLE obsahuje_objednavku(
    id              VARCHAR(10) NOT NULL,
    id_plan_ridice  VARCHAR(5) NOT NULL
);

ALTER TABLE OBJEDNAVKA ADD CONSTRAINT PK_OBJEDNAVKA PRIMARY KEY (id);
ALTER TABLE ukoncuje_objednavku ADD CONSTRAINT pk_id_operatora PRIMARY KEY (id,id_operatora);
ALTER TABLE objednal_objednavku ADD CONSTRAINT pk_id_stravnika PRIMARY KEY (id,id_stravnika);
ALTER TABLE obsahuje_objednavku ADD CONSTRAINT pk_id_plan_ridice PRIMARY KEY (id,id_plan_ridice);

CREATE TABLE JIDLO(
    id          VARCHAR(5) NOT NULL,
    nazov       VARCHAR(20) NOT NULL,
    typ         VARCHAR(20) NOT NULL,
    popis       VARCHAR(100),
    alergeny    VARCHAR(20),
    cena        INT(10) NOT NULL,
    -- obrázok image
    
    id_objednavky   VARCHAR(10),
    id_operatora    VARCHAR(10)
   
--    CONSTRAINT id_objednavky_jedla FOREIGN KEY (id_objednavky) REFERENCES OBJEDNAVKA(id),
--    CONSTRAINT id_operator_jedla FOREIGN KEY (id_operatora) REFERENCES OPERATOR(id)    
);

CREATE TABLE id_objednavky_jedla(
    id              VARCHAR(5) NOT NULL,
    id_objednavky   VARCHAR(10) NOT NULL
);

CREATE TABLE id_operator_jedla(
    id              VARCHAR(5) NOT NULL,
    id_operatora    VARCHAR(10) NOT NULL
);

ALTER TABLE JIDLO ADD CONSTRAINT PK_JIDLO PRIMARY KEY (id);
ALTER TABLE id_objednavky_jedla ADD CONSTRAINT pk_id_objednavky PRIMARY KEY (id,id_objednavky);
ALTER TABLE id_operator_jedla ADD CONSTRAINT pk_id_operatora PRIMARY KEY (id,id_operatora);

CREATE TABLE PROVOZNA( 
    id          INTEGER(3) NOT NULL,
    nazov       VARCHAR(100) NOT NULL,
    adresa      VARCHAR(100) NOT NULL,
    uzavierka   TIMESTAMP NOT NULL,
    
    id_operatora    VARCHAR(10)

--    CONSTRAINT spravuje_provoznu FOREIGN KEY (id_operatora) REFERENCES OPERATOR(id)
);

CREATE TABLE spravuje_provoznu(
    id              VARCHAR(3) NOT NULL,
    id_operatora    VARCHAR(10) NOT NULL
);

ALTER TABLE PROVOZNA ADD CONSTRAINT PK_PROVOZNA PRIMARY KEY (id);
ALTER TABLE spravuje_provoznu ADD CONSTRAINT id_operatora PRIMARY KEY (id,id_operatora);

CREATE TABLE TRVALA_NABIDKA(
    id              VARCHAR(5) NOT NULL,
    platnost_od     DATE NOT NULL,
    platnost_do     DATE NOT NULL,

    id_provozny INTEGER(3) NOT NULL

--    CONSTRAINT ponuka_trvala_nabidka FOREIGN KEY (id_provozny) REFERENCES PROVOZNA(id)
);

CREATE TABLE ponuka_trvala_nabidka(
    id              VARCHAR(5) NOT NULL,
    id_provozny     VARCHAR(3) NOT NULL
);

ALTER TABLE TRVALA_NABIDKA ADD CONSTRAINT PK_TRVALA_NABIDKA PRIMARY KEY (id);
ALTER TABLE ponuka_trvala_nabidka ADD CONSTRAINT id_provozny PRIMARY KEY (id,id_provozny);

CREATE TABLE JIDLO_TRVALA_NABIDKA( -- N:N  
    jidlo_id            VARCHAR(5) NOT NULL,
    trvala_nabidka_id   VARCHAR(5) NOT NULL
    
--    CONSTRAINT jidlo_trvala_nabidka_jidlo FOREIGN KEY (jidlo_id) REFERENCES JIDLO(id),
--    CONSTRAINT jidlo_trvala_nabidka_tn FOREIGN KEY (trvala_nabidka_id) REFERENCES TRVALA_NABIDKA(id),
 --   CONSTRAINT jidlo_trvala_nabidka_unique UNIQUE (jidlo_id, trvala_nabidka_id)    
);

-- ALTER TABLE jidlo_trvala_nabidka_jidlo ADD CONSTRAINT jidlo_id FOREIGN KEY (id) REFERENCES JIDLO;
-- ALTER TABLE jidlo_trvala_nabidka_tn ADD CONSTRAINT trvala_nabidka_id FOREIGN KEY (id) REFERENCES TRVALA_NABIDKA;
ALTER TABLE JIDLO_TRVALA_NABIDKA ADD CONSTRAINT PK_JIDLO_TRVALA_NABIDKA PRIMARY KEY (jidlo_id, trvala_nabidka_id);

CREATE TABLE DENNI_MENU(
    id          VARCHAR(5) NOT NULL,
    datum       DATE NOT NULL,
    
    id_provozny INTEGER(3) NOT NULL
    
--  CONSTRAINT ponuka_denni_menu FOREIGN KEY (id_provozny) REFERENCES PROVOZNA(id)
);

CREATE TABLE ponuka_denni_menu(
    id              VARCHAR(5) NOT NULL,
    id_provozny     VARCHAR(3) NOT NULL
);

ALTER TABLE DENNI_MENU ADD CONSTRAINT PK_DENNI_MENU PRIMARY KEY (id);
ALTER TABLE ponuka_denni_menu ADD CONSTRAINT id_provozny PRIMARY KEY (id,id_provozny);

-- **************************************************************************************
CREATE TABLE JIDLO_DENNI_MENU( -- N:N ••• OBMEDZENIE -> 0 - 5 POCET JEDAL •••
    jidlo_id            VARCHAR(5) NOT NULL,
    denne_menu_id       VARCHAR(5) NOT NULL
    
--    CONSTRAINT jidlo_denne_menu_jidlo FOREIGN KEY (jidlo_id) REFERENCES JIDLO(id),
--   CONSTRAINT jidlo_denne_menu_dm FOREIGN KEY (denne_menu_id) REFERENCES DENNI_MENU(id),
--   CONSTRAINT jidlo_denne_menu_unique UNIQUE (jidlo_id, denne_menu_id) 
);

-- ALTER TABLE jidlo_denne_menu_jidlo ADD CONSTRAINT jidlo_id FOREIGN KEY (id) REFERENCES JIDLO;
-- ALTER TABLE jidlo_denne_menu_dm ADD CONSTRAINT denne_menu_id FOREIGN KEY (id) REFERENCES DENNI_MENU;
ALTER TABLE JIDLO_DENNI_MENU ADD CONSTRAINT PK_JIDLO_DENNI_MENU PRIMARY KEY (jidlo_id, denne_menu_id);