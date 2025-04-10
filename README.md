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

```bash
 bash
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

## ✅ Expected Output
With the sample data:

Engineering and Sales meet the WHERE and HAVING conditions

The top 2 departments with the highest average salaries are returned

| Top departments by average salary (filtered): | 
| --------------------------------------------- |                

| Department: Sales                             | Employees: 2 | Avg Salary: $80,000.00 |

| Department: Engineering                       | Employees: 2 | Avg Salary: $70,000.00 |

## ✅ Part 1: Export .sql File (Schema + Data + Query)

Here’s the complete .sql script file (use touch to create the file) then you can run in MySQL :

```bash
touch legal_query_example.sql
```

```mysql
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
```

## 📥 Save this as legal_query_example.sql
To execute it:
```bash
sudo mysql -u root -p < legal_query_example.sql
```
## ✅ Part 2: Python App to Execute the Query (via MySQL Connector)

1. Install MySQL Connector
```bash
pip install mysql-connector-python
```
2. Python Script (legal_assistant_query.py)
```python
import mysql.connector

# Set your MySQL credentials
conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='your_mysql_password',
    database='company_db'
)

cursor = conn.cursor()

query = """
SELECT d.dept_name, COUNT(e.emp_id) AS employee_count, AVG(e.salary) AS avg_salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE e.salary > 55000
GROUP BY d.dept_name
HAVING AVG(e.salary) > 70000
ORDER BY avg_salary DESC
LIMIT 2;
"""

cursor.execute(query)
results = cursor.fetchall()

print("Top departments by average salary (filtered):")
print("---------------------------------------------")
for row in results:
    print(f"Department: {row[0]} | Employees: {row[1]} | Avg Salary: ${row[2]:,.2f}")

cursor.close()
conn.close()
```

## 🛠️ Next Steps (Optional)
🔐 Add a frontend (Streamlit or Flask)

📊 Visualize data with charts

🧠 Integrate with LLMs for document-based querying

## To visualize SQL data with charts, you can use several tools depending on whether you want a local script, a web app, or a dashboard. Here's a quick guide:

## 📊 1. Using Python (Matplotlib / Seaborn / Plotly)
Step-by-Step:
## ✅ a. Install required libraries
```bash
pip install mysql-connector-python matplotlib seaborn pandas
```
## ✅ b. Sample code to connect and plot
```python
import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Connect to MySQL
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="your_mysql_password",
    database="sales_db"
)

# Query data
query = "SELECT Category, SUM(Amount) AS TotalSales FROM sales_data GROUP BY Category;"
df = pd.read_sql(query, conn)
conn.close()

# Plot
plt.figure(figsize=(10,6))
sns.barplot(data=df, x="Category", y="TotalSales")
plt.title("Total Sales by Category")
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()

```


## 📄 License
MIT – free to use, share, and adapt.
