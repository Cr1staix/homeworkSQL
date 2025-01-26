CREATE TABLE customer
(
    "id"          BIGINT GENERATED ALWAYS AS IDENTITY,
    "name"        VARCHAR(200),
    "city"        VARCHAR(50),
    "type"        VARCHAR(30),
    "count_order" INT
);

INSERT INTO customer(name, city, type, count_order)
VALUES ('Александр', 'Ленинград', 'Постоянный покупатель', 2),
       ('Иван', 'Ленинград', 'VIP покупатель', 6),
       ('Максим', 'Новосибирск', 'Постоянный покупатель', 3),
       ('Вася', 'Москва', 'Новый покупатель', 0);

UPDATE customer
SET name = 'Василий'
WHERE id = 4;

UPDATE customer
SET city = 'Санкт-Петербург'
WHERE city = 'Ленинград';

DELETE
FROM customer
WHERE id = 3;

SELECT *
FROM customer
ORDER by id;

SELECT *
FROM customer
WHERE city = 'Санкт-Петербург'
ORDER by name;