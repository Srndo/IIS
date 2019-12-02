BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "TRVALA_NABIDKA" (
    "id"    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "platnost_od"   VARCHAR(10) NOT NULL,
    "platnost_do"   VARCHAR(10) NOT NULL,
    "id_provozny"   INTEGER(3) NOT NULL
);
CREATE TABLE IF NOT EXISTS "OBJEDNAVKA" (
    "id"    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "cena_celkom"   INT(10) NOT NULL,
    "stav"  VARCHAR(10) NOT NULL,
    "cas_objednania"    VARCHAR(19) NOT NULL,
    "cas_dorucenia" VARCHAR(19) NOT NULL,
    "id_operatora"  INTEGER,
    "id_stravnika"  INTEGER,
    "id_plan_ridice"    INTEGER
);
CREATE TABLE IF NOT EXISTS "PROVOZNA" (
    "id"    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nazov" VARCHAR(100) NOT NULL,
    "adresa"    VARCHAR(100) NOT NULL,
    "uzavierka" VARCHAR(19) NOT NULL, /* mozna bych nepouzival? */
    "description"   VARCHAR(4096) NOT NULL,
    "img_src"   VARCHAR(256) NOT NULL,
    "id_operatora"  INTEGER
);
CREATE TABLE IF NOT EXISTS "DENNI_MENU" (
    "id"    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "datum" DATE NOT NULL,
    "id_provozny"   INTEGER(3) NOT NULL
);
CREATE TABLE IF NOT EXISTS "ukoncuje_objednavku" (
    "id"    INTEGER NOT NULL,
    "id_operatora"  INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "spravuje_provoznu" (
    "id"    INTEGER NOT NULL,
    "id_operatora"  INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "ponuka_trvala_nabidka" (
    "id"    INTEGER NOT NULL,
    "id_provozny"   INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "ponuka_denni_menu" (
    "id"    INTEGER NOT NULL,
    "id_provozny"   INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "obsahuje_objednavku" (
    "id"    INTEGER NOT NULL,
    "id_plan_ridice"    INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "objednal_objednavku" (
    "id"    INTEGER NOT NULL,
    "id_stravnika"  INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "id_ridica_plan_ridice" (
    "id_planu"  INTEGER NOT NULL,
    "id_ridica" INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "id_operator_jedla" (
    "id"    INTEGER NOT NULL,
    "id_operatora"  INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "id_objednavky_jedla" (
    "id"    INTEGER NOT NULL,
    "id_objednavky" INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "STRAVNIK" (
    "cislo_karty"   INT(16) NOT NULL,
    "id"    INTEGER NOT NULL,
    FOREIGN KEY("id") REFERENCES "UZIVATEL"("id")
);
CREATE TABLE IF NOT EXISTS "RIDIC" (
    "spz"   VARCHAR(10) NOT NULL,
    "id"    INTEGER NOT NULL,
    FOREIGN KEY("id") REFERENCES "UZIVATEL"("id")
);
CREATE TABLE IF NOT EXISTS "PLAN_RIDICE" (
    "id_planu"  INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "region"    VARCHAR(10) NOT NULL,
    "id_operator"   INTEGER NOT NULL,
    "id_ridica" INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "JIDLO" (
    "id"    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nazov" VARCHAR(20) NOT NULL,
    "typ"   VARCHAR(20) NOT NULL,
    "popis" VARCHAR(100),
    "alergeny"  VARCHAR(20),
    "cena"  INT(10) NOT NULL,
    "id_objednavky" INTEGER,
    "id_operator"   INTEGER
);
CREATE TABLE IF NOT EXISTS "JIDLO_DENNI_MENU" (
    "jidlo_id"  INTEGER NOT NULL,
    "denne_menu_id" INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "JIDLO_TRVALA_NABIDKA" (
    "jidlo_id"  INTEGER NOT NULL,
    "trvala_nabidka_id" INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "OPERATOR" (
    "sluzobny_tel"  VARCHAR(13) NOT NULL,
    "id"    INTEGER NOT NULL,
    FOREIGN KEY("id") REFERENCES "UZIVATEL"("id")
);
CREATE TABLE IF NOT EXISTS "ADMIN" (
    "id_ntb"    VARCHAR(10) NOT NULL,
    "id"    INTEGER NOT NULL,
    FOREIGN KEY("id") REFERENCES "UZIVATEL"("id")
);
CREATE TABLE IF NOT EXISTS "UZIVATEL" (
    "id"    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "meno"  VARCHAR(20) NULL,
    "priezvisko"    VARCHAR(20) NULL,
    "adresa"    VARCHAR(20) NULL,
    "tel_cislo" VARCHAR(13) NULL,
    "email" VARCHAR(100) NOT NULL UNIQUE,
    "heslo" VARCHAR(20) NOT NULL
);
CREATE TABLE IF NOT EXISTS "id_operatora_plan_ridice" (
    "id_planu"  VARCHAR(10) NOT NULL,
    "id_operatora"  VARCHAR(10) NOT NULL
);
