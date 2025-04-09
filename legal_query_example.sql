-- Create and use database
CREATE DATABASE IF NOT EXISTS company_db;
USE company_db;

-- Drop tables if they exist
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- Create employees table
CREATE TABLE employees (
    emp_id INT,
    name VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2)
);

-- Create departments table
CREATE TABLE departments (
    dept_id INT,
    dept_name VARCHAR(50)
);

-- Insert sample employees
INSERT INTO employees (emp_id, name, dept_id, salary) VALUES
(1, 'Alice', 1, 80000),
(2, 'Bob', 2, 55000),
(3, 'Charlie', 1, 60000),
(4, 'Diana', 3, 75000),
(5, 'Eve', 2, 50000),
(6, 'Frank', 3, 85000);

-- Insert sample departments
INSERT INTO departments (dept_id, dept_name) VALUES
(1, 'Engineering'),
(2, 'Marketing'),
(3, 'Sales');

-- Query matching the SQL execution order diagram
SELECT d.dept_name, COUNT(e.emp_id) AS employee_count, AVG(e.salary) AS avg_salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE e.salary > 55000
GROUP BY d.dept_name
HAVING AVG(e.salary) > 70000
ORDER BY avg_salary DESC
LIMIT 2;
