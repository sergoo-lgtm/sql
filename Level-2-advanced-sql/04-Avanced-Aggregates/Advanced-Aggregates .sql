-----------------------------------------------------------
-- Problem Set: CASE Statements, Conditional Aggregation, and Revenue Analysis
-- Source: SQL Roadmap for Data Analysis (Level 2)
-----------------------------------------------------------

-----------------------------------------------------------
-- Task 1: Student Grades Categorization
-- Challenge: Categorize students based on marks and count students in each grade.
-- Grades Logic:
-- Marks < 50  -> C
-- Marks 50-80 -> B
-- Marks > 80  -> A
SELECT 
    CASE 
        WHEN Marks < 50 THEN 'C'
        WHEN Marks BETWEEN 50 AND 80 THEN 'B'
        WHEN Marks > 80 THEN 'A'
        ELSE 'NA'
    END AS Grades,
    COUNT(*) AS Student_count
FROM student
GROUP BY 1;

-----------------------------------------------------------
-- Task 2: High Scoring Students per Department
-- Challenge: Count students scoring more than 80 marks across departments.
SELECT 
    department,
    COUNT(CASE WHEN Marks > 80 THEN 1 ELSE NULL END) AS Dept_HighScore_Count
FROM student
GROUP BY department;

-----------------------------------------------------------
-- Task 3: Sum of Fee Paid by Students Aged Above 20
-- Challenge: Find sum of fee paid by students aged above 20 across departments.
SELECT 
    Department,
    SUM(CASE WHEN Age > 20 THEN Fee ELSE 0 END) AS Sum_Senior_Fee
FROM student
GROUP BY 1;

-----------------------------------------------------------
-- Task 4: Percentage Contribution of Senior Students Fee
-- Challenge: Calculate percentage of fee paid by students aged above 20 per department.
SELECT 
    Department,
    (100 * SUM(CASE WHEN Age > 20 THEN Fee ELSE 0 END) / SUM(Fee)) AS Senior_Fee_Percentage
FROM student
GROUP BY 1;

-----------------------------------------------------------
-- Task 5: Create Orders Table
-- Challenge: Create Orders table for food delivery data.
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    item_name VARCHAR(255),
    cuisine VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(5,2),
    status VARCHAR(50)
);

-----------------------------------------------------------
-- Task 6: Insert Data into Orders Table
INSERT INTO Orders VALUES
(1,'Veggie Burger','American','Veg',9.99,'Sold'),
(3,'Margherita Pizza','Italian','Veg',14.99,'Sold'),
(4,'Pepperoni Pizza','Italian','Non veg',16.99,'Sold'),
(2,'Veggie Burger','American','Veg',9.99,'Sold'),
(6,'Pepperoni Pizza','Italian','Non veg',16.99,'Sold'),
(7,'Veggie Burger','American','Veg',9.99,'Sold'),
(9,'Green Curry','Thai','Veg',14.99,'Sold'),
(8,'Veggie Burger','American','Veg',9.99,'Sold'),
(12,'Mushroom Risotto','Italian','Veg',19.99,'Sold'),
(11,'Pepperoni Pizza','Italian','Non veg',16.99,'Sold'),
(13,'Pepperoni Pizza','Italian','Non veg',16.99,'Sold'),
(16,'Mushroom Risotto','Italian','Veg',19.99,'Sold'),
(17,'Pepperoni Pizza','Italian','Non veg',16.99,'Sold');

-----------------------------------------------------------
-- Task 7: Non-Veg Revenue by Cuisine
-- Challenge: Find total price of Non-Veg dishes across cuisines.
SELECT 
    cuisine,
    SUM(CASE WHEN category = 'Non veg' THEN price ELSE 0 END) AS Non_Veg_Price
FROM Orders
GROUP BY 1;

-----------------------------------------------------------
-- Task 8: Dish Count by Price Category
-- Challenge: Group dishes by price category and count them.
SELECT 
    CASE 
        WHEN price > 18 THEN 'High'
        WHEN price BETWEEN 10 AND 18 THEN 'Medium'
        WHEN price < 10 THEN 'Low'
        ELSE 'NA'
    END AS Pay_Category,
    COUNT(*) AS Dish_count
FROM Orders
GROUP BY 1;

-----------------------------------------------------------
-- Task 9: American Cuisine Revenue Percentage
-- Challenge: Find percentage of total revenue contributed by American cuisine.
SELECT 
    ROUND(
        (100 * SUM(CASE WHEN cuisine = 'American' THEN price ELSE 0 END)) / SUM(price),
        2
    ) AS American_Revenue
FROM Orders;

-----------------------------------------------------------