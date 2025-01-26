CREATE TABLE product
(
    "id"    BIGINT GENERATED ALWAYS AS IDENTITY,
    "name"  VARCHAR(200),
    "price" DOUBLE PRECISION,
    "type"  VARCHAR(30)
);