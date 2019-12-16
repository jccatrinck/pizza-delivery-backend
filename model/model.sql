CREATE DATABASE "pizza_delivery";

CREATE TABLE "customer" (
  "customer_id" SERIAL PRIMARY KEY,
  "name" VARCHAR (50) UNIQUE NOT NULL,
  "address" VARCHAR (255) NOT NULL,
  "created" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TYPE "product_size" AS ENUM ('Small', 'Medium', 'Large');

CREATE TABLE "product" (
  "product_id" SERIAL PRIMARY KEY,
  "name" VARCHAR (50) NOT NULL,
  "size" "product_size" NOT NULL,
  "price" NUMERIC(12,2) NOT NULL,
  "description" VARCHAR (150) NOT NULL,
  "created" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE ("name", "size")
);

CREATE TYPE "order_status" AS ENUM ('New', 'Preparing', 'Delivering', 'Delivered');

CREATE TABLE "order" (
  "order_id" SERIAL PRIMARY KEY,
  "customer_id" INTEGER NOT NULL,
  "status" "order_status"  NOT NULL,
  "created" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "order_customer_id_fk" FOREIGN KEY ("customer_id")
    REFERENCES "customer" ("customer_id") MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE "order_product" (
  "order_id" INTEGER NOT NULL,
  "product_id" INTEGER NOT NULL,
  "amount" INTEGER,
  "created" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("order_id", "product_id"),
  CONSTRAINT "order_id_fk" FOREIGN KEY ("order_id")
    REFERENCES "order" ("order_id") MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT "product_id_fk" FOREIGN KEY ("product_id")
    REFERENCES "product" ("product_id") MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE RESTRICT
);