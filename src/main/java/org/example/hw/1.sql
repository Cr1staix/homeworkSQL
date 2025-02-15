CREATE TABLE IF NOT EXISTS author
(
    id   BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE CHECK (LENGTH(name) > 1)
    );

INSERT INTO author(name)
VALUES ('Пушкин'),
       ('Достоевский'),
       ('Толстой');

CREATE TABLE IF NOT EXISTS publisher
(
    id   BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE CHECK (LENGTH(name) > 1)
    );

INSERT INTO publisher(name)
VALUES ('Наука'),
       ('Москва');

CREATE TABLE IF NOT EXISTS book
(
    id           BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title        VARCHAR(50) NOT NULL CHECK (LENGTH(title) > 1),
    year         INT NOT NULL CHECK (year <= EXTRACT(YEAR FROM CURRENT_DATE)),
    price DOUBLE PRECISION NOT NULL CHECK (price > 0),
    publisher_id BIGINT NOT NULL,
    CONSTRAINT fk_publisher FOREIGN KEY (publisher_id)
    REFERENCES publisher (id)
    ON DELETE CASCADE
    );

INSERT INTO book(title, year, price,publisher_id)
VALUES ('Борис Годунов', 1825, 1400, 1),
       ('Игрок', 1866, 1500, 2),
       ('Война и мир', 1869, 1800, 1),
       ('Федя', 2025, 4000, 1);

CREATE TABLE IF NOT EXISTS book_author
(
    book_id   BIGINT,
    author_id BIGINT,
    PRIMARY KEY(book_id, author_id),

    CONSTRAINT fk_book FOREIGN KEY (book_id)
    REFERENCES book (id)
    ON DELETE CASCADE,

    CONSTRAINT fk_author FOREIGN KEY (author_id)
    REFERENCES author (id)
    ON DELETE CASCADE
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
    ADD COLUMN pages_amount INT;
UPDATE book
SET pages_amount = CASE
                       WHEN id = 1 THEN 500
                       WHEN id = 2 THEN 700
                       WHEN id = 3 THEN 1000
                       WHEN id = 4 THEN 2000
    END
WHERE id IN (1, 2, 3, 4);

SELECT b.title FROM book b
WHERE b.pages_amount > (SELECT AVG(pages_amount) FROM book);

ALTER TABLE book
    ADD COLUMN amount INT,
ADD COLUMN year_publication INT;

UPDATE book
SET amount = CASE
                 WHEN id = 1 THEN 7
                 WHEN id = 2 THEN 9
                 WHEN id = 3 THEN 15
                 WHEN id = 4 THEN 1
    END
WHERE id IN (1, 2, 3, 4);

UPDATE book
SET year_publication = CASE
                           WHEN id = 1 THEN 2020
                           WHEN id = 2 THEN 2016
                           WHEN id = 3 THEN 2025
                           WHEN id = 4 THEN 2008
    END
WHERE id IN (1, 2, 3, 4);

SELECT * FROM book
WHERE year_publication = (SELECT MAX(year_publication) FROM book);

SELECT * FROM book
WHERE year_publication IN (
    SELECT DISTINCT year_publication FROM book
    ORDER BY year_publication DESC
    LIMIT 2
    );

SELECT *
FROM   (SELECT title,SUM(amount*price) AS total
        FROM book
        GROUP BY title)
WHERE total > 10000
ORDER BY total;

SELECT title, SUM(amount * price) AS total
FROM book
GROUP BY title
HAVING SUM(amount * price) > 10000
ORDER BY total;

WITH book_total AS(
    SELECT title , SUM(amount * price) AS total
    FROM book
    GROUP BY title
)
SELECT *
FROM book_total
WHERE total > 10000
ORDER BY total;

SELECT
    CONCAT(book.title, ' ', book.year_publication, ' ', author.name) AS book_info,
    CASE
        WHEN book.year_publication >=  2020 THEN 'Свежие издания'
        WHEN book.year_publication BETWEEN 2010 AND 2019 THEN 'Всё ещё актуальны'
        ELSE 'Публиковались давно'
        END AS Статус
FROM book
         JOIN
     book_author ON book.id = book_author.book_id
         JOIN
     author ON book_author.author_id = author.id
ORDER BY book.year_publication DESC;