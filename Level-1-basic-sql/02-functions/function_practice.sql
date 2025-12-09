-- Problem Set: Aggregate Functions, Date & Time, Grouping, and Filtering
-- Source: SQL Roadmap for Data Analysis (Level 1)
-----------------------------------------------------------
-- Task 1: Employee Overview
-- Challenge: You are preparing an HR report. Output all columns from the employee table, but rename the columns for clarity in the report.
-- Hints: Use column aliases.
SELECT 
    employee_id AS Serial,
    employee_name AS Name,
    department AS Dept
FROM employee;

-----------------------------------------------------------
-- Task 2: Headcount Check
-- Challenge: The management wants to know the total number of employees in the company.
-- Hints: Use an aggregate function.
SELECT COUNT(*) AS Total_Employees
FROM employee;

-----------------------------------------------------------
-- Task 3: Pay Extremes
-- Challenge: Identify the highest and lowest hourly pay among employees. This is important for auditing salary ranges.
-- Hints: Use MAX and MIN aggregate functions.
SELECT MAX(Hourly_pay) AS Highest_Pay
FROM employee;

SELECT MIN(Hourly_pay) AS Lowest_Pay
FROM employee;

-----------------------------------------------------------
-- Task 4: Taxable Pay Formatting
-- Challenge: For the financial report, round the Taxable_Pay column to 2 decimal places for consistency in reporting.
-- Hints: Use the ROUND function.
SELECT ROUND(Taxable_Pay, 2) AS Taxable_Pay
FROM employee;

-----------------------------------------------------------
-- Task 5: Department-Specific Analysis
-- Challenge: You need quick insights per department:
-- a) Count employees in Sales
-- b) Find max Hourly_pay in Operations
-- c) Find min Hourly_pay in Operations
-- Hints: Use WHERE with department filtering and aggregate functions.
SELECT COUNT(*) AS Sales_Employees
FROM employee
WHERE department = 'Sales';

SELECT MAX(Hourly_pay) AS Operations_Max_Pay
FROM employee
WHERE department = 'Operations';

SELECT MIN(Hourly_pay) AS Operations_Min_Pay
FROM employee
WHERE department = 'Operations';

-----------------------------------------------------------
-- Task 6: Round Payout
-- Demonstrates: ROUND function
SELECT ROUND(Payout, 2) AS payout
FROM employee;

-----------------------------------------------------------
-- Task 7: Average payout across all employees
-- Demonstrates: AVG aggregate function
SELECT AVG(Payout) AS avg_payout
FROM employee;

-----------------------------------------------------------
-- Task 8: Total Payout for Product dept and Average Payout for Operations
-- Demonstrates: SUM and AVG with WHERE clause
SELECT SUM(Payout) AS product_total_pay
FROM employee
WHERE department = 'Product';

SELECT AVG(Payout) AS ops_avg_pay
FROM employee
WHERE department = 'Operations';

-----------------------------------------------------------
-- Task 9: Average payout per department
-- Demonstrates: GROUP BY with AVG
SELECT Department, AVG(Payout) AS avg_payout
FROM employee
GROUP BY Department;

-----------------------------------------------------------
-- Task 10: Average payout for departments with more than 3 employees
-- Demonstrates: GROUP BY with HAVING
SELECT Department, AVG(Payout) AS avg_payout
FROM employee
GROUP BY Department
HAVING COUNT(*) > 3;

-----------------------------------------------------------
-- Task 11: Departments with total payout > 40 and their average payout
-- Demonstrates: GROUP BY with HAVING and ORDER BY
SELECT Department, AVG(Payout) AS avg_payout
FROM employee
GROUP BY Department
HAVING SUM(Payout) > 40
ORDER BY Department;

-----------------------------------------------------------
-- Task 12: Current date and time with offset
-- Demonstrates: DATETIME function
SELECT DATETIME('now', '+5 hours', '+30 minutes');

-----------------------------------------------------------
-- Task 13: Current date and time separately
-- Demonstrates: CURRENT_DATE and CURRENT_TIME
SELECT CURRENT_DATE;
SELECT CURRENT_TIME;

-----------------------------------------------------------
-- Task 14: Date and time arithmetic
-- Demonstrates: Adding months/days and time intervals
SELECT DATE('2024-07-04', '+1 month');
SELECT TIME('20:34:21', '+30 minutes');

-----------------------------------------------------------
-- Task 15: Date formatting and strftime function
-- Demonstrates: STRFTIME for formatting dates
SELECT STRFTIME('%Y-%m-%d %H:%M:%S','2023-04-20 13:40:23','+10 days');
SELECT STRFTIME('%d','2024-03-04 23:34:20');

-----------------------------------------------------------
-- Task 16: Last day of month and date arithmetic
SELECT DATE('2024-06-23','start of month','+1 month','-1 day');
SELECT DATE('2024-03-22','+15 days');

-----------------------------------------------------------
-- Task 17: First purchase month of course 'Cpp'
SELECT MIN(STRFTIME('%m', Purchase_date)) AS Purchased_Month
FROM Purchases
WHERE Course_name = 'cpp';

-----------------------------------------------------------
-- Task 18: Date of highest purchase of all courses
SELECT 
    STRFTIME('%Y-%m-%d',purchase_date) AS Highest_Purchased_Date,
    COUNT(purchase_id) AS Purchased_Count
FROM purchases
GROUP BY Highest_Purchased_Date
ORDER BY Purchased_Count DESC
LIMIT 1;

-----------------------------------------------------------
-- Task 19: Difference in days between two dates
SELECT JULIANDAY('2024-12-25') - JULIANDAY('2023-09-24') AS Days_Difference;

-----------------------------------------------------------
-- Task 20: Month with highest number of purchases
SELECT 
    STRFTIME('%Y-%m',purchase_date) AS purchase_month,
    COUNT(*) AS purchase_count
FROM purchases
GROUP BY purchase_month
ORDER BY purchase_count DESC
LIMIT 1;

-----------------------------------------------------------
-- Task 21: Courses and their initial purchase date
SELECT Course_name AS Course, MIN(Purchase_date) AS First_purchase_date
FROM purchases
GROUP BY Course_name
ORDER BY First_purchase_date;

-----------------------------------------------------------
-- Task 22: Number of students in Commerce department
SELECT COUNT(Student_Id)
FROM student
WHERE department = 'Commerce';

-----------------------------------------------------------
-- Task 23: Min and Max marks in Science department
SELECT MIN(Marks) AS min_marks
FROM student
WHERE department = 'Science';

SELECT MAX(Marks) AS max_marks
FROM student
WHERE department = 'Science';

-----------------------------------------------------------
-- Task 24: Average age and total outstanding fee
SELECT AVG(age) AS avg_age
FROM student;

SELECT SUM(Fee_outstanding) AS Fee_outstanding
FROM student
WHERE department = 'Arts';

-----------------------------------------------------------
-- Task 25: Total outstanding fee per department
SELECT Department, SUM(Fee_outstanding) AS fee_outstanding
FROM student
GROUP BY Department;

-----------------------------------------------------------
-- Task 26: Average marks per department where avg outstanding fee < 500
SELECT Department, ROUND(AVG(Marks),2) AS avg_marks
FROM student
GROUP BY Department
HAVING AVG(Fee_outstanding) < 500;
