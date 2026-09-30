-- 1. Find the average product price
SELECT
    AVG(price) AS average_price
FROM products;


-- 2. Find products priced above the average price
SELECT
    product_name,
    price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
)
ORDER BY price DESC;