-- Basic MySQL Queries

CREATE DATABASE IF NOT EXISTS mysql_practice;
USE mysql_practice;

DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- Create departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

-- Create employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT,
    CONSTRAINT fk_department
    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);

-- Insert departments
INSERT INTO departments VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Sales');

-- Insert employees
INSERT INTO employees VALUES
(1, 'Ganesh', 'Singh', 'Ganesh@gmail.com', 60000, 1),
(2, 'Sara', 'Khan', 'sara@gmail.com', 75000, 2),
(3, 'Shivam', 'Singh', 'Shivam@gmail.com', 50000, 2),
(4, 'Virat', 'kholi', 'virat@gmail.com', 90000, 3),
(5, 'MS', 'Dhoni', 'MSdhoni@gmail.com', 55000, 1);

-- 1. Select all employees
SELECT *
FROM employees;

-- 2. Select specific columns
SELECT employee_id, first_name, last_name, salary
FROM employees;

-- 3. Filter employees with salary greater than 50000
SELECT *
FROM employees
WHERE salary > 50000;

-- 4. Sort employees by salary highest to lowest
SELECT first_name, salary
FROM employees
ORDER BY salary DESC;

-- 5. Count total employees
SELECT COUNT(*) AS total_employees
FROM employees;

-- 6. Find average salary
SELECT AVG(salary) AS average_salary
FROM employees;

-- 7. Count employees by department
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id;

-- 8. Show departments having more than 1 employee
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 1;

-- 9. Join employees with departments
SELECT e.employee_id,
       e.first_name,
       e.salary,
       d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;
