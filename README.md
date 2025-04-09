# 🧠 Legal-Like SQL Query Execution Demo

This project demonstrates a practical example of **SQL Query Execution Order** using MySQL and Python. Inspired by visual guides, it shows how clauses like `FROM`, `JOIN`, `WHERE`, `GROUP BY`, `HAVING`, `ORDER BY`, and `LIMIT` are executed logically — even though they appear differently in SQL syntax.

---

## 📦 Contents

- `legal_query_example.sql` – SQL script to set up database, tables, sample data, and the query.
- `legal_assistant_query.py` – Python script to run the query and print formatted results.
- `README.md` – This guide.

---

## 🚀 Setup Instructions

### ✅ 1. Install MySQL on Ubuntu 20.04

```bash bash
sudo apt update
sudo apt install mysql-server -y
sudo systemctl start mysql
sudo systemctl enable mysql
sudo systemctl status mysql
```

### 🔐 Secure the Installation (Optional but Recommended):

```bash
sudo mysql_secure_installation
```

You'll be prompted to:

 - Set root password
 - Remove anonymous users
 - Disallow root login remotely
 - Remove test database
 - Reload privilege tables

### ✅ 2. Sample Query Based on the Diagram

### 👇 We will simulate:
   
   - Two tables: t1 and t2
   - A JOIN, WHERE, GROUP BY, HAVING, ORDER BY, LIMIT clause
   - Matching the order shown in your image

### 🧱 Create Tables and Insert Sample Data
  Login to MySQL:

```bash
sudo mysql -u root -p
```
Now run:
```mysql
CREATE DATABASE company_db;
USE company_db;

-- Table t1: Employees
CREATE TABLE employees (
    emp_id INT,
    name VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2)
);

-- Table t2: Departments
CREATE TABLE departments (
    dept_id INT,
    dept_name VARCHAR(50)
);

-- Insert data into t1
INSERT INTO employees VALUES
(1, 'Alice', 1, 80000),
(2, 'Bob', 2, 55000),
(3, 'Charlie', 1, 60000),
(4, 'Diana', 3, 75000),
(5, 'Eve', 2, 50000),
(6, 'Frank', 3, 85000);

-- Insert data into t2
INSERT INTO departments VALUES
(1, 'Engineering'),
(2, 'Marketing'),
(3, 'Sales');

```

###  🧪 Sample SQL Query Matching Execution Order

```mysql
SELECT d.dept_name, COUNT(e.emp_id) AS employee_count, AVG(e.salary) AS avg_salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE e.salary > 55000
GROUP BY d.dept_name
HAVING AVG(e.salary) > 70000
ORDER BY avg_salary DESC
LIMIT 2;

```
🧠 How This Matches the Execution Order in Your Image:
| Execution Step | SQL Clause                     | Description                     |
|----------------|--------------------------------|---------------------------------|
| 1️⃣ `FROM`      | `FROM employees`               | Start with base table           |
| 2️⃣ `JOIN`      | `JOIN departments`             | Join departments                |
| 3️⃣ `ON`        | `ON e.dept_id = d.dept_id`     | Join condition                  |
| 4️⃣ `WHERE`     | `e.salary > 55000`             | Filter before grouping          |
| 5️⃣ `GROUP BY`  | `GROUP BY dept_name`           | Group by department             |
| 6️⃣ `HAVING`    | `HAVING AVG(salary) > 70000`   | Post-group filtering            |
| 7️⃣ `SELECT`    | `SELECT dept_name, ...`        | Select columns                  |
| 8️⃣ `ORDER BY`  | `ORDER BY avg_salary DESC`     | Sort the result                 |
| 9️⃣ `LIMIT`     | `LIMIT 2`                      | Return top 2                    |
