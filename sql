CREATE DATABASE passage;

CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  email VARCHAR(300),
  username VARCHAR(20),
  password_digest VARCHAR(400)
);

CREATE TABLE followers (
  id SERIAL4 PRIMARY KEY,
  user_id INTEGER,
  follower_id INTEGER
);

CREATE TABLE locations (
  id SERIAL4 PRIMARY KEY,
  user_id INTEGER,
  name VARCHAR(200)
);

CREATE TABLE routes (
  id SERIAL4 PRIMARY KEY,
  location_id INTEGER,
  date_authored VARCHAR(50),
  title VARCHAR(200),
  description TEXT,
  votes INTEGER,
  author_id INTEGER,
  img VARCHAR(200)
);

CREATE TABLE steps (
  id SERIAL4 PRIMARY KEY,
  route_id INTEGER,
  description TEXT
);

CREATE TABLE images (
  id SERIAL4 PRIMARY KEY,
  img1 VARCHAR(300),
  step_id INTEGER
);

CREATE TABLE votes (
  id SERIAL4 PRIMARY KEY,
  user_id INTEGER,
  route_id INTEGER
);

INSERT INTO locations (name, user_id) values ('Sedlec Ossuary', 1);
INSERT INTO locations (name, user_id) values ('Okunoshima Island', 1);
