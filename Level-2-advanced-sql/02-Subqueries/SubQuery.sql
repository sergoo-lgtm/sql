-----------------------------------------------------------
-- Problem Set: Subqueries
-- Source: SQL Roadmap for Data Analysis (Level 2)
-----------------------------------------------------------

-----------------------------------------------------------
-- Task 1: Food Items with Low Rating
-- Output food name and type where rating is less than 3
SELECT
    f_name,
    f_type
FROM
    food
WHERE
    f_id IN (
        SELECT
            f_id
        FROM
            ratings
        WHERE
            f_rating < 3
    );

-----------------------------------------------------------
-- Task 2: Dishes Costing More Than Average
-- Find dishes with cost greater than the overall average cost
SELECT
    f_name,
    f_cost,
    f_type
FROM
    food
WHERE
    f_cost > (
        SELECT
            AVG(f_cost)
        FROM
            food
    );

-----------------------------------------------------------
-- Task 3: Cheaper Than Average Continental Food
-- Retrieve food items costing less than the average cost
-- of Continental food type
SELECT
    f_name
FROM
    food
WHERE
    f_cost < (
        SELECT
            AVG(f_cost)
        FROM
            food
        WHERE
            f_type = 'Continental'
    );

-----------------------------------------------------------
-- Task 4: Highly Rated Dishes
-- Output dish details where average rating is >= 4
SELECT
    f_name,
    f_cost,
    f_type
FROM
    food
WHERE
    f_id IN (
        SELECT
            f_id
        FROM
            ratings
        GROUP BY
            f_id
        HAVING
            AVG(f_rating) >= 4
    );

-----------------------------------------------------------
-- Task 5: Employees Younger Than Sales Average
-- Output employee names whose age is less than
-- the average age of Sales department
SELECT
    emp_name
FROM
    employee
WHERE
    emp_age < (
        SELECT
            AVG(emp_age)
        FROM
            employee
        WHERE
            emp_dept = 'Sales'
    );

-----------------------------------------------------------
-- Task 6: Highest Cost Dish
-- Find the food item(s) with the maximum cost
SELECT
    f_name,
    f_cost
FROM
    food
WHERE
    f_cost = (
        SELECT
            MAX(f_cost)
        FROM
            food
    );

-----------------------------------------------------------
-- Task 7: Employees Earning Above Department Average
-- Retrieve employees whose salary is higher than
-- the average salary of their own department
SELECT
    emp_name,
    emp_salary,
    emp_dept
FROM
    employee e
WHERE
    emp_salary > (
        SELECT
            AVG(emp_salary)
        FROM
            employee
        WHERE
            emp_dept = e.emp_dept
    );

-----------------------------------------------------------
-- Task 8: Food Items Never Rated
-- Retrieve food items that do not exist in ratings table
SELECT
    f_name
FROM
    food
WHERE
    f_id NOT IN (
        SELECT
            f_id
        FROM
            ratings
    );

-----------------------------------------------------------
-- Task 9: Top Rated Food Items
-- Retrieve food items whose average rating is the maximum
SELECT
    f_name
FROM
    food
WHERE
    f_id IN (
        SELECT
            f_id
        FROM
            ratings
        GROUP BY
            f_id
        HAVING
            AVG(f_rating) = (
                SELECT
                    MAX(avg_rating)
                FROM (
                    SELECT
                        AVG(f_rating) AS avg_rating
                    FROM
                        ratings
                    GROUP BY
                        f_id
                ) t
            )
    );

-----------------------------------------------------------
-- Task 10: Employees Working in Departments with More Than 3 Employees
SELECT
    emp_name,
    emp_dept
FROM
    employee
WHERE
    emp_dept IN (
        SELECT
            emp_dept
        FROM
            employee
        GROUP BY
            emp_dept
        HAVING
            COUNT(*) > 3
    );

-----------------------------------------------------------
-- Task 11: Food Items Costlier Than Any Continental Dish
SELECT
    f_name,
    f_cost
FROM
    food
WHERE
    f_cost > ANY (
        SELECT
            f_cost
        FROM
            food
        WHERE
            f_type = 'Continental'
    );

-----------------------------------------------------------
-- Task 12: Employee with Second Highest Salary
SELECT
    emp_name,
    emp_salary
FROM
    employee
WHERE
    emp_salary = (
        SELECT
            MAX(emp_salary)
        FROM
            employee
        WHERE
            emp_salary < (
                SELECT
                    MAX(emp_salary)
                FROM
                    employee
            )
    );

-----------------------------------------------------------
-- Task 13: Food Items Rated by More Than One Customer
SELECT
    f_name
FROM
    food
WHERE
    f_id IN (
        SELECT
            f_id
        FROM
            ratings
        GROUP BY
            f_id
        HAVING
            COUNT(*) > 1
    );

-----------------------------------------------------------
-- Task 14: Employees Older Than Company Average
SELECT
    emp_name,
    emp_age
FROM
    employee
WHERE
    emp_age > (
        SELECT
            AVG(emp_age)
        FROM
            employee
    );

-----------------------------------------------------------
-- Task 15: Departments with Highest Average Salary
SELECT
    emp_dept
FROM
    employee
GROUP BY
    emp_dept
HAVING
    AVG(emp_salary) = (
        SELECT
            MAX(avg_sal)
        FROM (
            SELECT
                AVG(emp_salary) AS avg_sal
            FROM
                employee
            GROUP BY
                emp_dept
        ) d
    );