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