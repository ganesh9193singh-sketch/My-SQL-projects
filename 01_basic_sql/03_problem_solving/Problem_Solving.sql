
-- MySQL Problem Solving Project

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
(3, 'Sales'),
(4, 'Marketing');

-- Insert employees
INSERT INTO employees VALUES
(1, 'Ganesh', 'Singh', 60000, 1),
(2, 'Sara', 'Khan', 75000, 2),
(3, 'Shivam', 'Signh', 50000, 2),
(4, 'Virat', 'Kholi', 90000, 3),
(5, 'MS', 'Dhoni', 55000, 1),
(6, 'Zain', 'Raza', 40000, NULL);

-- Problem 1: Find highest salary
SELECT MAX(salary) AS highest_salary
FROM employees;

-- Problem 2: Find second highest salary
SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

-- Problem 3: Find top 3 highest paid employees
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 3;

-- Problem 4: Find employees earning more than average salary
SELECT first_name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

-- Problem 5: Find total salary by department
SELECT d.department_name,
       SUM(e.salary) AS total_salary
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
GROUP BY d.department_name;

-- Problem 6: Find department with highest average salary
SELECT d.department_name,
       AVG(e.salary) AS average_salary
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY average_salary DESC
LIMIT 1;

-- Problem 7: Find employees without department
SELECT first_name, last_name
FROM employees
WHERE department_id IS NULL;

-- Problem 8: Count employees in each department, including empty departments
SELECT d.department_name,
       COUNT(e.employee_id) AS employee_count
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_name;
