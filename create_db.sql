CREATE TABLE cities (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  country_id INTEGER,

  FOREIGN KEY(country_id) REFERENCES country(id)
);

CREATE TABLE countries (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  president_id INTEGER,

  FOREIGN KEY(president_id) REFERENCES president(id)
);

CREATE TABLE presidents (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

INSERT INTO
  presidents (id, name)
VALUES
  (1, "Barack Obama"), (2, "Vladimir Putin");

INSERT INTO
  cities (id, name, country_id)
VALUES
  (1, "San Francisco", 1),
  (2, "Tallahassee", 1),
  (3, "Moscow", 2),
  (4, "Tambov", 2);

INSERT INTO
  countries (id, name, president_id)
VALUES
  (1, "USA", 1),
  (2, "Russia", 2);
