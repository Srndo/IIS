/**************
 * Main tables
 **************/
CREATE TABLE IF NOT EXISTS "canteen" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" VARCHAR(256) NOT NULL,
    "address" VARCHAR(256) NOT NULL,
    "description" VARCHAR(4096) NOT NULL,
    "img_src" VARCHAR(256) NOT NULL
);
CREATE TABLE IF NOT EXISTS "food" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" VARCHAR(256) NOT NULL,
    "type" VARCHAR(64) NOT NULL,
    "description" VARCHAR(1024) NOT NULL,
    "allergens" VARCHAR(64) NOT NULL,
    "price" FLOAT NOT NULL,
    "id_canteen" INTEGER NOT NULL,
    "active" INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "order" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "status" VARCHAR(64) NOT NULL,
    "order_time" INTEGER NOT NULL,
    "name" VARCHAR(256) NOT NULL,
    "surname" VARCHAR(256) NOT NULL,
    "address" VARCHAR(256) NOT NULL,
    "postcode" VARCHAR(64) NOT NULL,
    "city" VARCHAR(256) NOT NULL,
    "phone" VARCHAR(64) NOT NULL,
    "email" VARCHAR(256) NOT NULL,
    "id_user" INTEGER,
    "id_driver" INTEGER
);


/************
 * Relations
 ************/
CREATE TABLE IF NOT EXISTS "food_in_order" (
    "id_food" INTEGER NOT NULL,
    "id_order" INTEGER NOT NULL,
    "qty" INTEGER NOT NULL,
    PRIMARY KEY ("id_food", "id_order")
);
CREATE TABLE IF NOT EXISTS "food_in_cart" (
    "id_user" INTEGER NOT NULL,
    "id_food" INTEGER NOT NULL,
    "qty" INTEGER NOT NULL,
    PRIMARY KEY ("id_user", "id_food")
);


/**************
 * Roles
 **************/
CREATE TABLE IF NOT EXISTS "user" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "email" VARCHAR(256) NOT NULL UNIQUE,
    "password" VARCHAR(256) NOT NULL,
    "name" VARCHAR(256) NOT NULL,
    "surname" VARCHAR(256) NOT NULL,
    "address" VARCHAR(256) NOT NULL,
    "postcode" VARCHAR(64) NOT NULL,
    "city" VARCHAR(256) NOT NULL,
    "phone" VARCHAR(64) NOT NULL
);
CREATE TABLE IF NOT EXISTS "driver" (
    "id" INTEGER NOT NULL,
    FOREIGN KEY ("id") REFERENCES "user" ("id")
);
CREATE TABLE IF NOT EXISTS "operator" (
    "id" INTEGER NOT NULL,
    FOREIGN KEY ("id") REFERENCES "user" ("id")
);
CREATE TABLE IF NOT EXISTS "admin" (
    "id" INTEGER NOT NULL,
    FOREIGN KEY ("id") REFERENCES "user" ("id")
);
