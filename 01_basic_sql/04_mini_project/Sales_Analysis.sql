-- MySQL Mini Project: Sales Analysis

CREATE DATABASE IF NOT EXISTS mysql_practice;
USE mysql_practice;

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

-- Create customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    signup_date DATE
);

-- Create orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10, 2),
    CONSTRAINT fk_customer
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);

-- Insert customers
INSERT INTO customers VALUES
(1, 'Ganesh', 'Mumbai', '2024-01-05'),
(2, 'Sara', 'Lahore', '2024-01-10'),
(3, 'Shivam', 'Delhi', '2024-02-01'),
(4, 'Virat', 'Mumbai', '2024-02-15'),
(5, 'MS Dhoni', 'Ranchi', '2024-03-01'),
(6, 'Zain', 'Multan', '2024-03-10');

-- Insert orders
INSERT INTO orders VALUES
(101, 1, '2024-01-10', 250.00),
(102, 1, '2024-01-15', 100.00),
(103, 2, '2024-01-20', 500.00),
(104, 3, '2024-02-05', 300.00),
(105, 3, '2024-02-10', 150.00),
(106, 4, '2024-03-05', 700.00);

-- 1. Total number of customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- 2. Total number of orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- 3. Total sales
SELECT SUM(amount) AS total_sales
FROM orders;

-- 4. Average order amount
SELECT AVG(amount) AS average_order_amount
FROM orders;

-- 5. Monthly sales
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
       SUM(amount) AS monthly_sales
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- 6. Top customers by total spending
SELECT c.customer_name,
       SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

-- 7. Customers with no orders
SELECT c.customer_name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 8. City-wise sales
SELECT c.city,
       SUM(o.amount) AS total_sales
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_sales DESC;
