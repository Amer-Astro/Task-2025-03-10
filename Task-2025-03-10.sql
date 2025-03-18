--1. Create a new database named "CompanyDB." 
CREATE DATABASE CompanyDB;
GO
--2. Create a schema named "Sales" within the "CompanyDB" database. 
CREATE SCHEMA Sales;
GO
--3. Create a table named "employees" with columns:  
CREATE TABLE Sales.employees (
	employee_id INT PRIMARY KEY IDENTITY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	salary DECIMAL(8,2)
);
--4. Alter the "employees" table to add a new column named "hire_date" with the data type DATE. 
ALTER TABLE Sales.employees
ADD hire_date DATE

--ADDING DATA FROM MOCKAROO DONE

--1. Select all columns from the "employees" table. 
SELECT *
FROM sales.employees;
--2. Retrieve only the "first_name" and "last_name" columns from the "employees" table. 
SELECT first_name, last_name
FROM sales.employees;
--3. Retrieve "full name" as a one column from "first_name" and "last_name" columns from the "employees" table. 
SELECT first_name +' '+ last_name AS 'full name'
FROM sales.employees;
--4. Show the average salary of all employees. (Use AVG() function) 
SELECT AVG(salary) AS 'Average Salary'
FROM sales.employees;
--5. Select employees whose salary is greater than 50000.
SELECT *
FROM sales.employees
WHERE salary > 50000;
--6. Retrieve employees hired in the year 2020.
SELECT *
FROM sales.employees
WHERE hire_date between '2020-01-01' and '2020-12-31';
--7. List employees whose last names start with 'S'.
SELECT *
FROM sales.employees
WHERE last_name LIKE 'S%';
--8. Display the top 10 highest-paid employees.
SELECT TOP 10 *
FROM sales.employees ORDER BY salary DESC;
--9. Find employees with salaries between 40000 and 60000.
SELECT *
FROM sales.employees
WHERE salary between 40000 and 60000;
--10. Show employees with names containing the substring 'man'.
SELECT *
FROM sales.employees
WHERE last_name LIKE '%man%' OR first_name LIKE '%man%';
--11. Display employees with a NULL value in the "hire_date" column.
SELECT *
FROM sales.employees
WHERE hire_date is NULL;
--12. Select employees with a salary in the set (40000, 45000, 50000).
SELECT *
FROM sales.employees
WHERE salary IN (40000, 45000, 50000);
--13. Retrieve employees hired between '2020-01-01' and '2021-01-01'.
SELECT *
FROM sales.employees
WHERE hire_date between '2020-01-01' and '2021-01-01';
--14. List employees with salaries in descending order.
SELECT *
FROM sales.employees ORDER BY salary DESC;
--15. Show the first 5 employees ordered by "last_name" in ascending order.
SELECT TOP 5 *
FROM sales.employees 
ORDER BY last_name;
--16. Display employees with a salary greater than 55000 and hired in 2020.
SELECT *
FROM sales.employees
WHERE salary > 55000 AND hire_date between '2020-01-01' and '2020-12-31';
--17. Select employees whose first name is 'John' or 'Jane'.
SELECT *
FROM sales.employees
WHERE first_name IN ('John','Jane');
--18. List employees with a salary ≤ 55000 and a hire date after '2022-01-01'
SELECT *
FROM sales.employees
WHERE salary <= 55000 AND hire_date > '2022-01-01';
--19. Retrieve employees with a salary greater than the average salary.
SELECT *
FROM sales.employees
WHERE salary > (SELECT AVG(Salary) FROM sales.employees);
--20. Display the 3rd to 7th highest-paid employees. (Use OFFSET and FETCH)
SELECT *
FROM sales.employees
ORDER BY salary DESC
OFFSET 3 ROWS 
FETCH NEXT 7 ROWS ONLY;
--21. List employees hired after '2021-01-01' in alphabetical order.
SELECT *
FROM sales.employees
WHERE hire_date > '2021-01-01'
ORDER BY first_name
--22. Retrieve employees with a salary > 50000 and last name not starting with 'A'.
SELECT *
FROM sales.employees
WHERE salary > 50000 AND last_name NOT LIKE 'A%'
ORDER BY last_name
--23. Display employees with a salary that is not NULL.
SELECT *
FROM sales.employees
WHERE salary IS NOT NULL
--24. Show employees with names containing 'e' or 'i' and a salary > 45000.
SELECT *
FROM sales.employees
WHERE salary > 45000 AND (first_name LIKE '%e%' OR last_name LIKE '%o%');
--25. Create a new table named "departments" with columns: 
CREATE TABLE Sales.departments (
	department_id INT PRIMARY KEY IDENTITY,
	department_name VARCHAR(50),
	manager_id INT REFERENCES Sales.employees(employee_id)
);
--26. Assign each employee to a department by creating a "department_id" column in "employees" and making it a foreign key referencing "departments".department_id.
ALTER TABLE Sales.employees
ADD department_id INT NULL;

ALTER TABLE Sales.employees
ADD CONSTRAINT FK_Employees_Departments
FOREIGN KEY (department_id) REFERENCES Sales.departments(department_id);
--27. Retrieve all employees with their department names (Use INNER JOIN).
SELECT e.employee_id, e.first_name, e.salary, d.department_name
FROM Sales.employees e
INNER JOIN Sales.departments d ON d.department_id = e.department_id;
--28. Retrieve employees who don’t belong to any department (Use LEFT JOIN and check for NULL).
SELECT e.employee_id, e.first_name, e.salary, e.department_id
FROM Sales.employees e
LEFT JOIN Sales.departments d ON e.department_id = d.department_id
WHERE d.department_id IS NULL;
--29. Show all departments and their employee count (Use JOIN and GROUP BY).
SELECT d.department_name, COUNT(e.employee_id) AS employee_count
FROM Sales.departments d
LEFT JOIN Sales.employees e ON d.department_id = e.department_id
GROUP BY d.department_name;
--30. Retrieve the highest-paid employee in each department (Use JOIN and MAX(salary)).
SELECT e.employee_id, e.first_name, e.salary, d.department_name
FROM Sales.employees e
INNER JOIN Sales.departments d ON e.department_id = d.department_id
WHERE e.salary = (
    SELECT MAX(salary)
    FROM Sales.employees
    WHERE department_id = e.department_id
);
