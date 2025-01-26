CREATE TABLE orders(
    "id" BIGINT GENERATED ALWAYS AS IDENTITY,
    "customer_id" BIGINT,
    "product_id"  BIGINT,
    "type"        VARCHAR(30)
);