
-- MySQL Data Cleaning Project

CREATE DATABASE IF NOT EXISTS mysql_practice;
USE mysql_practice;

DROP TABLE IF EXISTS customers_clean;
DROP TABLE IF EXISTS customers_dirty;

-- Create messy customer table
CREATE TABLE customers_dirty (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    city VARCHAR(50),
    signup_date VARCHAR(20)
);

-- Insert messy data
INSERT INTO customers_dirty VALUES
(1, 'Ganesh Singh   ', 'Ganesh@GMAIL.COM', NULL, '  Karachi ', '2024-01-05'),
(2, 'Sara Khan', 'SARA@GMAIL.COM', '03001234567', 'Lahore', '2024-01-10'),
(3, 'Shivam Singh', 'Shivam@gmail.com', '03001111111', 'Karachi', '2024-01-05'),
(4, ' Virat', 'Virat@.com', '03002222222', '', '2024-02-01'),
(5, 'MS Dhoni', 'MSdhoni@gmail.com', '', NULL, '2024-02-10'),
(6, 'Fatima', 'fatima@gmail.com', '03003333333', 'Islamabad', '2024-02-15');

-- Check raw data
SELECT *
FROM customers_dirty;

-- Create cleaned table
CREATE TABLE customers_clean AS
SELECT
    customer_id,
    TRIM(customer_name) AS customer_name,
    LOWER(TRIM(email)) AS email,
    NULLIF(TRIM(phone), '') AS phone,
    NULLIF(TRIM(city), '') AS city,
    STR_TO_DATE(signup_date, '%Y-%m-%d') AS signup_date
FROM customers_dirty;

-- Check cleaned data before removing duplicates
SELECT *
FROM customers_clean;

-- Find duplicate emails
SELECT email, COUNT(*) AS duplicate_count
FROM customers_clean
GROUP BY email
HAVING COUNT(*) > 1;

-- Remove duplicate emails, keeping the lowest customer_id
DELETE c1
FROM customers_clean c1
JOIN customers_clean c2
ON c1.email = c2.email
AND c1.customer_id > c2.customer_id;

-- Replace missing phone numbers
UPDATE customers_clean
SET phone = 'Unknown'
WHERE phone IS NULL;

-- Replace missing city values
UPDATE customers_clean
SET city = 'Not Provided'
WHERE city IS NULL OR city = '';

-- Remove invalid emails
DELETE FROM customers_clean
WHERE email IS NULL
   OR email NOT LIKE '%@%.%';

-- Final cleaned data
SELECT *
FROM customers_clean
ORDER BY customer_id;
