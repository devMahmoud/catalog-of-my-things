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

/* Create genre table */

CREATE TABLE genre (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR
)

/* Create author table */

CREATE TABLE author (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  first_name VARCHAR,
  last_name VARCHAR
)

/* Alter table item to create relationship  */

ALTER TABLE item
ADD genre_id INT;

ALTER TABLE item
ADD author_id INT;

ALTER TABLE item
ADD FOREIGN KEY (genre_id) REFERENCES genre(id);

ALTER TABLE item
ADD FOREIGN KEY (author_id) REFERENCES author(id);

