BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "UZIVATEL" (
    "id"    INTEGER,
    "meno"  VARCHAR(20) NOT NULL,
    "priezvisko"    VARCHAR(20) NOT NULL,
    "adresa"    VARCHAR(20) NOT NULL,
    "tel_cislo" VARCHAR(13) NOT NULL,
    "email" VARCHAR(100) NOT NULL,
    "heslo" VARCHAR(20) NOT NULL,
    PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "STRAVNIK" (
    "cislo_karty"   INT(16) NOT NULL,
    "id"    VARCHAR(10) NOT NULL,
    FOREIGN KEY("id") REFERENCES "UZIVATEL"("id")
);
CREATE TABLE IF NOT EXISTS "OPERATOR" (
    "sluzobny_tel"  VARCHAR(13) NOT NULL,
    "id"    VARCHAR(10) NOT NULL,
    FOREIGN KEY("id") REFERENCES "UZIVATEL"("id")
);
CREATE TABLE IF NOT EXISTS "RIDIC" (
    "spz"   VARCHAR(10) NOT NULL,
    "id"    VARCHAR(10) NOT NULL,
    FOREIGN KEY("id") REFERENCES "UZIVATEL"("id")
);
CREATE TABLE IF NOT EXISTS "ADMIN" (
    "id_ntb"    VARCHAR(10) NOT NULL,
    "id"    VARCHAR(10) NOT NULL,
    FOREIGN KEY("id") REFERENCES "UZIVATEL"("id")
);
CREATE TABLE IF NOT EXISTS "JIDLO" (
    "id"    VARCHAR(5) NOT NULL,
    "nazov" VARCHAR(20) NOT NULL,
    "typ"   VARCHAR(20) NOT NULL,
    "popis" VARCHAR(100),
    "alergeny"  VARCHAR(20),
    "cena"  INT(10) NOT NULL,
    "id_objednavky" VARCHAR(10),
    "id_operator"   VARCHAR(10)
);
CREATE TABLE IF NOT EXISTS "PLAN_RIDICE" (
    "id_planu"  VARCHAR(10) NOT NULL,
    "region"    VARCHAR(10) NOT NULL,
    "id_operator"   VARCHAR(10) NOT NULL,
    "id_ridica" VARCHAR(10) NOT NULL
);
CREATE TABLE IF NOT EXISTS "JIDLO_DENNI_MENU" (
    "jidlo_id"  VARCHAR(5) NOT NULL,
    "denne_menu_id" VARCHAR(5) NOT NULL
);
CREATE TABLE IF NOT EXISTS "ponuka_denni_menu" (
    "id"    VARCHAR(5) NOT NULL,
    "id_provozny"   VARCHAR(3) NOT NULL
);
CREATE TABLE IF NOT EXISTS "DENNI_MENU" (
    "id"    VARCHAR(5) NOT NULL,
    "datum" DATE NOT NULL,
    "id_provozny"   INTEGER(3) NOT NULL
);
CREATE TABLE IF NOT EXISTS "JIDLO_TRVALA_NABIDKA" (
    "jidlo_id"  VARCHAR(5) NOT NULL,
    "trvala_nabidka_id" VARCHAR(5) NOT NULL
);
CREATE TABLE IF NOT EXISTS "ponuka_trvala_nabidka" (
    "id"    VARCHAR(5) NOT NULL,
    "id_provozny"   VARCHAR(3) NOT NULL
);
CREATE TABLE IF NOT EXISTS "TRVALA_NABIDKA" (
    "id"    VARCHAR(5) NOT NULL,
    "platnost_od"   DATE NOT NULL,
    "platnost_do"   DATE NOT NULL,
    "id_provozny"   INTEGER(3) NOT NULL
);
CREATE TABLE IF NOT EXISTS "spravuje_provoznu" (
    "id"    VARCHAR(3) NOT NULL,
    "id_operatora"  VARCHAR(10) NOT NULL
);
CREATE TABLE IF NOT EXISTS "PROVOZNA" (
    "id"    INTEGER(3) NOT NULL,
    "nazov" VARCHAR(100) NOT NULL,
    "adresa"    VARCHAR(100) NOT NULL,
    "uzavierka" TIMESTAMP NOT NULL,
    "id_operatora"  VARCHAR(10)
);
CREATE TABLE IF NOT EXISTS "id_operator_jedla" (
    "id"    VARCHAR(5) NOT NULL,
    "id_operatora"  VARCHAR(10) NOT NULL
);
CREATE TABLE IF NOT EXISTS "id_objednavky_jedla" (
    "id"    VARCHAR(5) NOT NULL,
    "id_objednavky" VARCHAR(10) NOT NULL
);
CREATE TABLE IF NOT EXISTS "obsahuje_objednavku" (
    "id"    VARCHAR(10) NOT NULL,
    "id_plan_ridice"    VARCHAR(5) NOT NULL
);
CREATE TABLE IF NOT EXISTS "objednal_objednavku" (
    "id"    VARCHAR(10) NOT NULL,
    "id_stravnika"  VARCHAR(10) NOT NULL
);
CREATE TABLE IF NOT EXISTS "ukoncuje_objednavku" (
    "id"    VARCHAR(10) NOT NULL,
    "id_operatora"  VARCHAR(10) NOT NULL
);
CREATE TABLE IF NOT EXISTS "OBJEDNAVKA" (
    "id"    VARCHAR(10) NOT NULL,
    "cena_celkom"   INT(10) NOT NULL,
    "stav"  VARCHAR(10) NOT NULL,
    "cas_objednania"    TIMESTAMP NOT NULL,
    "cas_dorucenia" TIMESTAMP NOT NULL,
    "id_operatora"  VARCHAR(10),
    "id_stravnika"  VARCHAR(10),
    "id_plan_ridice"    VARCHAR(5)
);
CREATE TABLE IF NOT EXISTS "id_ridica_plan_ridice" (
    "id_planu"  VARCHAR(10) NOT NULL,
    "id_ridica" VARCHAR(10) NOT NULL
);
CREATE TABLE IF NOT EXISTS "id_operatora_plan_ridice" (
    "id_planu"  VARCHAR(10) NOT NULL,
    "id_operatora"  VARCHAR(10) NOT NULL
);