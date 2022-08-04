/* Create database */

CREATE DATABASE collection;

/* Create item table */

CREATE TABLE item (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  author VARCHAR,
  source VARCHAR,
  label VARCHAR,
  publish_date DATE NOT NULL,
  archived BOOLEAN
)

/* Create Music album talbe with item as father */

CREATE TABLE music_album (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  on_spotify BOOLEAN NOT NULL
) INHERITS (item);

/* Create table genre */

CREATE TABLE genre (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR
)

/* Alter table item to create relationship with genre */

ALTER TABLE item
ADD genre_id INT;

ALTER TABLE item
ADD FOREIGN KEY (genre_id) REFERENCES genre(id);

