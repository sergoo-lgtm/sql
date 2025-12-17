-- Problem Set: SQL Joins, Self Joins, Cross Joins, and Table Operations
-- Source: SQL Roadmap for Data Analysis (Level 2)
-----------------------------------------------------------
-- Task 1: Full Join Students and Courses
-- Challenge: Join 'student' and 'course' tables using 'Course_id' and output the joined table.
-- Hints: Use FULL JOIN.
SELECT *
FROM student AS s
FULL JOIN course AS c
ON s.Course_id = c.Course_id;

-----------------------------------------------------------
-- Task 2: Inner Join and Filter Course ENG201
-- Challenge: Join 'student' and 'course' tables and check if course with id ENG201 exists in the output.
-- Hints: Use INNER JOIN.
SELECT *
FROM student AS c
INNER JOIN course AS s
ON c.Course_id = s.Course_id;

-----------------------------------------------------------
-- Task 3: Inner and Left Join Students and Courses
-- Challenge: 
-- a) JOIN the tables 'student' and 'course' using 'Course_id'
-- b) LEFT JOIN the tables 'student' and 'course' using 'Course_id'
SELECT *
FROM student AS s
INNER JOIN course AS c
ON c.Course_id = s.Course_id;

SELECT *
FROM student AS s
LEFT JOIN course AS c
ON c.Course_id = s.Course_id;

-----------------------------------------------------------
-- Task 4: Inner and Right Join Students and Courses
-- Challenge: 
-- a) INNER JOIN the tables 'student' and 'course'
-- b) RIGHT JOIN the tables 'student' and 'course'
SELECT *
FROM student AS s
INNER JOIN course AS c
ON s.Course_id = c.Course_id;

SELECT *
FROM student AS s
RIGHT JOIN course AS c
ON s.Course_id = c.Course_id;

-----------------------------------------------------------
-- Task 5: Full Outer Join Students and Courses
-- Challenge: FULL OUTER JOIN the 'student' and 'course' tables using 'Course_id'
SELECT *
FROM student AS s
FULL OUTER JOIN course AS c
ON s.Course_id = c.Course_id;

-----------------------------------------------------------
-- Task 6: Self Join - Students in Same Department
-- Challenge: Find pairs of students in the same department.
SELECT s1.St_id, s1.St_Name, s1.Department,
       s2.St_id, s2.St_Name, s2.Department
FROM student AS s1
INNER JOIN student AS s2
ON s1.Department = s2.Department
AND s1.St_Name != s2.St_Name;

-----------------------------------------------------------
-- Task 7: Self Join - Students with Same Favorite Course
-- Challenge: Identify students who have chosen the same Course_id as their favorite.
SELECT s1.St_id, s1.St_Name, s1.Course_id
FROM student AS s1
INNER JOIN student AS s2
ON s1.Course_id = s2.Course_id
AND s1.St_id = s2.St_id
ORDER BY s1.Course_id;

-----------------------------------------------------------
-- Task 8: Cross Join Students and Courses
-- Challenge: Output all possible courses a student can opt for.
SELECT St_Name, Course_Name
FROM student
CROSS JOIN course;

-----------------------------------------------------------
-- Task 9: Inner Join Customers and Orders
-- Challenge: Display customer names with their order dates.
SELECT c.customer_name, o.order_date
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

-----------------------------------------------------------
-- Task 10: Left Join Customers and Orders
-- Challenge: Display all customers and their orders if available.
SELECT c.customer_name, o.product_name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

-----------------------------------------------------------
-- Task 11: Inner Join Products and Orders
-- Challenge: Find products and their order dates.
SELECT p.product_name, o.order_date
FROM products p
INNER JOIN orders o
ON p.product_name = o.product_name;

-----------------------------------------------------------
-- Task 12: Right Join Orders with Customers
-- Challenge: Get all orders and customer details if exist.
SELECT c.customer_name, o.*
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;

-----------------------------------------------------------
-- Task 13: Full Outer Join Products and Categories
-- Challenge: Combine all products with all categories; show NULL if no match.
SELECT p.product_name, c.category_name
FROM products p
FULL OUTER JOIN categories c
ON p.category_id = c.category_id;

-----------------------------------------------------------
-- Task 14: Right Join Products with Categories
-- Challenge: Show all categories with product details.
SELECT c.category_name, p.product_name, p.price
FROM products p
RIGHT JOIN categories c
ON p.category_id = c.category_id;

-----------------------------------------------------------
-- Task 15: Self Join Employees for Manager Names
-- Challenge: Display employees with their manager names.
SELECT e1.employee_name AS Employee, e2.employee_name AS Manager
FROM employees e1
LEFT JOIN employees e2
ON e1.manager_id = e2.employee_id;

-----------------------------------------------------------
-- Task 16: Cross Join Customers and Products
-- Challenge: Show every possible combination of customer_name and product_name.
SELECT c.customer_name, p.product_name
FROM customers c
CROSS JOIN products p;

-----------------------------------------------------------
-- Task 17: Multiple Joins - Product Report
-- Challenge: List product name, category, customer name, and order date.
SELECT p.product_name, cat.category_name, c.customer_name, o.order_date
FROM products p
JOIN categories cat ON p.category_id = cat.category_id
JOIN orders o ON p.product_name = o.product_name
JOIN customers c ON c.customer_id = o.customer_id;

-----------------------------------------------------------
-- Task 18: Total Spent by Customer
-- Challenge: Show total amount spent by each customer in descending order.
SELECT c.customer_name,
       SUM(p.price * o.quantity) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON o.product_name = p.product_name
GROUP BY c.customer_name
ORDER BY total_spent DESC;

-----------------------------------------------------------
-- Task 19: Create Customers and Orders Tables
-- Challenge: Create tables with primary key, unique key, and foreign key.
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    city VARCHAR(255),
    customer_email VARCHAR(255) UNIQUE
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-----------------------------------------------------------
-- Task 20: Delete Customer John Doe
-- Challenge: Delete John Doe and observe changes in Orders table.
DELETE FROM Customers
WHERE customer_name = 'John Doe';

SELECT * FROM Orders;

-----------------------------------------------------------
-- Task 21: Create Tables with ON DELETE/UPDATE SET NULL
-- Challenge: Create tables so that deleting or updating customer sets customer_id to NULL in Orders.
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    city VARCHAR(255)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NULL,
    order_date DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
    ON DELETE SET NULL
    ON UPDATE SET NULL
);

-- Delete John Doe to see effect
DELETE FROM Customers
WHERE customer_name = 'John Doe';

SELECT * FROM Orders;

-----------------------------------------------------------
-- Task 22: Union Arts and Science Tables
-- Challenge: Stack the 'Arts' table over 'Science' and output the result.
SELECT * FROM Arts
UNION
SELECT * FROM Science;

-----------------------------------------------------------