INSERT INTO customers
(customer_id, customer_name, city)
VALUES
(1, 'Ravi', 'Hyderabad'),
(2, 'Priya', 'Bangalore'),
(3, 'Arun', 'Chennai'),
(4, 'Sneha', 'Hyderabad');


INSERT INTO products
(product_id, product_name, category, price)
VALUES
(101, 'Laptop', 'Electronics', 60000),
(102, 'Mouse', 'Electronics', 1000),
(103, 'Keyboard', 'Electronics', 2000),
(104, 'Chair', 'Furniture', 5000);


INSERT INTO orders
(order_id, customer_id, product_id, quantity, order_date)
VALUES
(1001, 1, 101, 1, '2026-01-10'),
(1002, 2, 102, 2, '2026-01-15'),
(1003, 1, 103, 1, '2026-02-05'),
(1004, 3, 104, 2, '2026-02-10'),
(1005, 4, 101, 1, '2026-03-01'),
(1006, 2, 103, 3, '2026-03-15');