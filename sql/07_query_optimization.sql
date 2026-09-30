-- 1. Analyze query execution plan
EXPLAIN
SELECT *
FROM orders
WHERE customer_id = 2;


-- 2. Analyze actual query performance
EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 2;


-- 3. Create index on customer_id
CREATE INDEX IF NOT EXISTS idx_orders_customer_id
ON orders(customer_id);


-- 4. Analyze query after indexing
EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 2;


-- 5. Reporting query execution plan
EXPLAIN ANALYZE
SELECT
    c.customer_name,
    SUM(o.quantity * p.price) AS total_spent
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN products p
    ON o.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;


-- 6. Index on product_id for join performance
CREATE INDEX IF NOT EXISTS idx_orders_product_id
ON orders(product_id);