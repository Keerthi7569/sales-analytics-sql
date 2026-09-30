-- FINAL CUSTOMER PERFORMANCE REPORT

WITH customer_sales AS (
    SELECT
        c.customer_id,
        c.customer_name,
        c.city,
        COUNT(o.order_id) AS total_orders,
        SUM(o.quantity) AS total_quantity,
        SUM(o.quantity * p.price) AS total_spent
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN products p
        ON o.product_id = p.product_id
    GROUP BY
        c.customer_id,
        c.customer_name,
        c.city
)
SELECT
    customer_id,
    customer_name,
    city,
    total_orders,
    total_quantity,
    total_spent,
    RANK() OVER (
        ORDER BY total_spent DESC
    ) AS customer_rank
FROM customer_sales
ORDER BY customer_rank;


-- EXECUTIVE SALES SUMMARY

SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    COUNT(DISTINCT o.product_id) AS products_sold,
    SUM(o.quantity) AS total_quantity_sold,
    SUM(o.quantity * p.price) AS total_revenue,
    ROUND(AVG(o.quantity * p.price), 2) AS average_order_value
FROM orders o
JOIN products p
    ON o.product_id = p.product_id;