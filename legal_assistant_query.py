import mysql.connector

# Set your MySQL credentials
conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='990127Df#',
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
