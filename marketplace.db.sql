BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "city" (
	"id"	SERIAL,
	"name"	CHAR(50) NOT NULL,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "street" (
	"id"	SERIAL,
	"name"	CHAR(50) NOT NULL,
	"city_id"	INTEGER NOT NULL,
	FOREIGN KEY("city_id") REFERENCES "city"("id") ON DELETE NO ACTION ON UPDATE CASCADE,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "supermarket" (
	"id"	SERIAL,
	"name"	CHAR(50) NOT NULL,
	"street_id"	INTEGER NOT NULL,
	"house_number"	CHAR(6),
	PRIMARY KEY("id"),
	FOREIGN KEY("street_id") REFERENCES "street"("id") ON DELETE NO ACTION ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "person" (
	"id"	SERIAL,
	"name"	CHAR(50) NOT NULL,
	"surname"	CHAR(50) NOT NULL,
	"birth_date"	DATE NOT NULL,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "contact_type" (
	"id"	SERIAL,
	"name"	CHAR(50) NOT NULL UNIQUE,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "person_contact" (
	"id"	SERIAL,
	"person_id"	INTEGER NOT NULL,
	"contact_type_id"	INTEGER NOT NULL,
	"contact_value"	CHAR(50) NOT NULL,
	FOREIGN KEY("contact_type_id") REFERENCES "contact_type"("id") ON DELETE NO ACTION ON UPDATE CASCADE,
	PRIMARY KEY("id"),
	FOREIGN KEY("person_id") REFERENCES "person"("id") ON DELETE NO ACTION ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "customer" (
	"person_id"	INTEGER,
	"card_number"	INTEGER NOT NULL,
	"discount"	REAL NOT NULL,
	FOREIGN KEY("person_id") REFERENCES "person"("id") ON DELETE NO ACTION ON UPDATE CASCADE,
	PRIMARY KEY("person_id")
);
CREATE TABLE IF NOT EXISTS "product_category" (
	"id"	SERIAL,
	"name"	CHAR(50) NOT NULL UNIQUE,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "product_title" (
	"id"	SERIAL,
	"title"	CHAR(50) NOT NULL UNIQUE,
	"product_category_id"	INTEGER NOT NULL,
	PRIMARY KEY("id"),
	FOREIGN KEY("product_category_id") REFERENCES "product_category"("id") ON DELETE NO ACTION ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "manufacturer" (
	"id"	SERIAL,
	"name"	CHAR(50) NOT NULL UNIQUE,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "product" (
	"id"	SERIAL,
	"product_title_id"	INTEGER NOT NULL,
	"manufacturer_id"	INTEGER NOT NULL,
	"price"	REAL NOT NULL,
	"comment"	CHAR(60),
	PRIMARY KEY("id"),
	FOREIGN KEY("product_title_id") REFERENCES "product_title"("id") ON DELETE NO ACTION ON UPDATE CASCADE,
	FOREIGN KEY("manufacturer_id") REFERENCES "manufacturer"("id") ON DELETE NO ACTION ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "customer_order" (
	"id"	SERIAL,
	"operation_time"	DATE NOT NULL,
	"supermarket_id"	INTEGER NOT NULL,
	"customer_id"	INTEGER,
	FOREIGN KEY("supermarket_id") REFERENCES "supermarket"("id") ON DELETE NO ACTION ON UPDATE CASCADE,
	FOREIGN KEY("customer_id") REFERENCES "customer"("person_id") ON DELETE NO ACTION ON UPDATE CASCADE,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "order_details" (
	"id"	SERIAL,
	"customer_order_id"	INTEGER NOT NULL,
	"product_id"	INTEGER NOT NULL,
	"price"	REAL NOT NULL,
	"price_with_discount"	REAL NOT NULL,
	"product_amount"	INTEGER NOT NULL,
	FOREIGN KEY("product_id") REFERENCES "product"("id") ON DELETE NO ACTION ON UPDATE CASCADE,
	FOREIGN KEY("customer_order_id") REFERENCES "customer_order"("id") ON DELETE NO ACTION ON UPDATE CASCADE,
	PRIMARY KEY("id")
);
COMMIT;