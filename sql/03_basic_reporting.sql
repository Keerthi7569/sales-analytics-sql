-- 1. Order-level revenue
SELECT
    o.order_id,
    p.product_name,
    o.quantity,
    p.price,
    o.quantity * p.price AS sales_amount
FROM orders o
JOIN products p
    ON o.product_id = p.product_id;


-- 2. Total revenue
SELECT
    SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id;


-- 3. Revenue by product
SELECT
    p.product_name,
    SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;


-- 4. Revenue by customer
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