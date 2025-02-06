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