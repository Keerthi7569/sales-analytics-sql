-- 1. Monthly revenue
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', o.order_date) AS month,
        SUM(o.quantity * p.price) AS monthly_revenue
    FROM orders o
    JOIN products p
        ON o.product_id = p.product_id
    GROUP BY DATE_TRUNC('month', o.order_date)
)
SELECT
    month,
    monthly_revenue
FROM monthly_sales
ORDER BY month;


-- 2. Previous month's revenue
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', o.order_date) AS month,
        SUM(o.quantity * p.price) AS monthly_revenue
    FROM orders o
    JOIN products p
        ON o.product_id = p.product_id
    GROUP BY DATE_TRUNC('month', o.order_date)
)
SELECT
    month,
    monthly_revenue,
    LAG(monthly_revenue) OVER (
        ORDER BY month
    ) AS previous_month_revenue
FROM monthly_sales
ORDER BY month;


-- 3. Month-over-month growth percentage
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', o.order_date) AS month,
        SUM(o.quantity * p.price) AS monthly_revenue
    FROM orders o
    JOIN products p
        ON o.product_id = p.product_id
    GROUP BY DATE_TRUNC('month', o.order_date)
)
SELECT
    month,
    monthly_revenue,
    LAG(monthly_revenue) OVER (
        ORDER BY month
    ) AS previous_month_revenue,
    ROUND(
        (
            (
                monthly_revenue
                - LAG(monthly_revenue) OVER (
                    ORDER BY month
                )
            )
            /
            NULLIF(
                LAG(monthly_revenue) OVER (
                    ORDER BY month
                ),
                0
            )
        ) * 100,
        2
    ) AS growth_percentage
FROM monthly_sales
ORDER BY month;