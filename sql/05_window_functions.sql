-- 1. Rank customers by total spending
SELECT
    c.customer_name,
    SUM(o.quantity * p.price) AS total_spent,
    RANK() OVER (
        ORDER BY SUM(o.quantity * p.price) DESC
    ) AS customer_rank
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN products p
    ON o.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY customer_rank;


-- 2. Assign row numbers to customers by spending
SELECT
    c.customer_name,
    SUM(o.quantity * p.price) AS total_spent,
    ROW_NUMBER() OVER (
        ORDER BY SUM(o.quantity * p.price) DESC
    ) AS row_number
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN products p
    ON o.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY row_number;


-- 3. Number each customer's orders
SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    o.quantity * p.price AS order_revenue,
    ROW_NUMBER() OVER (
        PARTITION BY c.customer_id
        ORDER BY o.order_date
    ) AS customer_order_number
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN products p
    ON o.product_id = p.product_id
ORDER BY c.customer_name, o.order_date;


-- 4. Calculate cumulative revenue
SELECT
    o.order_date,
    o.quantity * p.price AS order_revenue,
    SUM(o.quantity * p.price) OVER (
        ORDER BY o.order_date
    ) AS running_revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
ORDER BY o.order_date;


-- 5. Compare each customer's order with their previous order
SELECT
    c.customer_name,
    o.order_date,
    o.quantity * p.price AS order_revenue,
    LAG(o.quantity * p.price) OVER (
        PARTITION BY c.customer_id
        ORDER BY o.order_date
    ) AS previous_order_revenue
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN products p
    ON o.product_id = p.product_id
ORDER BY c.customer_name, o.order_date;