CREATE TABLE author
(
    id   BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100)
);

INSERT INTO author(name)
VALUES ('Пушкин'),
       ('Достоевский'),
       ('Толстой');

CREATE TABLE publisher
(
    id   BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO publisher(name)
VALUES ('Наука'),
       ('Москва');

CREATE TABLE book
(
    id           BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title        VARCHAR(50),
    year         INT,
    publisher_id BIGINT,
    CONSTRAINT fk_publisher FOREIGN KEY (publisher_id) REFERENCES publisher (id)
);

INSERT INTO book(title, year, publisher_id)
VALUES ('Борис Годунов', 1825, 1),
       ('Игрок', 1866, 2),
       ('Война и мир', 1869, 1);

CREATE TABLE book_author
(
    book_id   BIGINT,
    author_id BIGINT,
    CONSTRAINT fk_book FOREIGN KEY (book_id) REFERENCES book (id),
    CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES author (id)
);

INSERT INTO book_author(book_id, author_id)
VALUES (1, 1),
       (2, 2),
       (3, 3);

SELECT book.title     AS Название_книги,
       book.year      AS Год_публикации,
       publisher.name AS Название_издательства,
       author.name    AS Автор
FROM book
         JOIN
     publisher ON book.publisher_id = publisher.id
         JOIN
     book_author ON book.id = book_author.book_id
         JOIN
     author ON book_author.author_id = author.id;

ALTER TABLE book
    ADD COLUMN price DOUBLE PRECISION;

UPDATE book
SET price = 1200
WHERE id = 1;

UPDATE book
SET price = 1500
WHERE id = 2;

UPDATE book
SET price = 1400
WHERE id = 3;

INSERT INTO book(title, year, publisher_id, price)
VALUES ('Федя', 2025, 1, 4000);
INSERT INTO book_author(book_id, author_id)
VALUES (4, 1);

SELECT AVG(price) AS average_price,
       MIN(price) AS min_price,
       MAX(price) AS max_price
FROM book;

SELECT a.name, COUNT(b_a.book_id) AS total_book
FROM author a
         JOIN book_author b_a ON a.id = b_a.author_id
GROUP BY a.name
ORDER BY name;

SELECT a.name,
       COUNT(b.id)  AS total_book,
       AVG(b.price) AS average_price
FROM author a
         JOIN book_author b_a ON a.id = b_a.author_id
         JOIN book b ON b_a.book_id = b.id
GROUP BY a.name
ORDER BY name;

INSERT INTO author(name)
VALUES ('Юришин'),
       ('Шестаков'),
       ('Жиров');

SELECT a.name
FROM author a
         LEFT JOIN book_author b_a ON a.id = b_a.author_id
         LEFT JOIN book b ON b_a.book_id = b.id
WHERE book_id IS NULL
ORDER BY name;

SELECT a.name
FROM author a
         LEFT JOIN book_author b_a ON a.id = b_a.author_id
GROUP BY a.name
HAVING COUNT(b_a.book_id) = 0
ORDER BY name;