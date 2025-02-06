CREATE TABLE category(
                         id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                         name TEXT NOT NULL UNIQUE,
                         parent_id INT
);

INSERT INTO category(name)
VALUES('Кухонная техника');

INSERT INTO category(name, parent_id)
VALUES('Холодильники', 1),
      ('Духовки', 1);

INSERT INTO category(name)
VALUES ('Смартфоны');

INSERT INTO category(name, parent_id)
VALUES('Apple', 2),
      ('Samsung', 2);

INSERT INTO category(name)
VALUES ('Телевизоры');

INSERT INTO category(name, parent_id)
VALUES('Yandex TV', 3),
      ('LG', 3);

SELECT * FROM category;