-----------------------------------------------------------
-- Problem Set: Window Functions - Ranking & Analytic Functions
-- Source: SQL Roadmap for Data Analysis (Level 2)
-----------------------------------------------------------

-----------------------------------------------------------
-- Task 1: Ranking Employees Within Departments
SELECT
    employee_id,
    department,
    salary,
    ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS row_num,
    RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank_num,
    DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dense_rank_num
FROM
    employees;

-----------------------------------------------------------
-- Task 2: Previous and Next Salary Within Department
SELECT
    employee_id,
    department,
    salary,
    LAG(salary, 1) OVER (PARTITION BY department ORDER BY employee_id) AS prev_salary,
    LEAD(salary, 1) OVER (PARTITION BY department ORDER BY employee_id) AS next_salary
FROM
    employees;

-----------------------------------------------------------
-- Task 3: NTILE Distribution and Running Maximum
SELECT
    employee_id,
    salary,
    NTILE(2) OVER (ORDER BY salary DESC) AS ntile_group,
    MAX(salary) OVER (ORDER BY employee_id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS running_max
FROM
    employees
ORDER BY
    employee_id;

-----------------------------------------------------------
-- Task 4: Cumulative Salary and Running Average per Department
SELECT
    employee_id,
    department,
    salary,
    SUM(salary) OVER (
        PARTITION BY department
        ORDER BY employee_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_salary,
    AVG(salary) OVER (
        PARTITION BY department
        ORDER BY employee_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_avg_salary
FROM employees;

-----------------------------------------------------------
-- Task 5: Compare Salary with Previous and Next Employee
SELECT
    employee_id,
    department,
    salary,
    salary - LAG(salary) OVER (PARTITION BY department ORDER BY salary ASC) AS diff_prev_salary,
    LEAD(salary) OVER (PARTITION BY department ORDER BY salary ASC) - salary AS diff_next_salary
FROM employees;

-----------------------------------------------------------
-- Task 6: First and Last Salary with Running Maximum
SELECT
    employee_id,
    department,
    salary,
    FIRST_VALUE(salary) OVER (PARTITION BY department ORDER BY employee_id) AS first_salary,
    LAST_VALUE(salary) OVER (
        PARTITION BY department
        ORDER BY employee_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS last_salary,
    MAX(salary) OVER (
        PARTITION BY department
        ORDER BY employee_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_max_salary
FROM employees;

-----------------------------------------------------------
-- Task 7: NTILE Groups and Department Rank
SELECT
    employee_id,
    department,
    salary,
    NTILE(3) OVER (ORDER BY salary DESC) AS salary_group,
    RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank_in_department,
    DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dense_rank_in_department
FROM employees;

-----------------------------------------------------------
-- Task 8: Moving Average of Salary (Current + 2 Previous)
SELECT
    employee_id,
    department,
    salary,
    AVG(salary) OVER (
        PARTITION BY department
        ORDER BY employee_id
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg_3
FROM employees;

-----------------------------------------------------------
-- Task 9: Cumulative Count and Sum of Salaries
SELECT
    employee_id,
    department,
    salary,
    COUNT(employee_id) OVER (
        PARTITION BY department
        ORDER BY employee_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_count,
    SUM(salary) OVER (
        PARTITION BY department
        ORDER BY employee_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_salary
FROM employees;

-----------------------------------------------------------
-- Task 10: Lead and Lag by 2 Rows
SELECT
    employee_id,
    department,
    salary,
    LAG(salary, 2) OVER (PARTITION BY department ORDER BY salary ASC) AS lag_2_salary,
    LEAD(salary, 2) OVER (PARTITION BY department ORDER BY salary ASC) AS lead_2_salary,
    salary - LAG(salary, 2) OVER (PARTITION BY department ORDER BY salary ASC) AS diff_lag_2,
    LEAD(salary, 2) OVER (PARTITION BY department ORDER BY salary ASC) - salary AS diff_lead_2
FROM employees;

-----------------------------------------------------------
-- Task 11: Running Max Salary Partitioned and Overall
SELECT
    employee_id,
    department,
    salary,
    MAX(salary) OVER (
        PARTITION BY department
        ORDER BY salary ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_max_department,
    MAX(salary) OVER (
        ORDER BY salary ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_max_overall
FROM employees;

-----------------------------------------------------------
-- Task 12: Dense Rank Overall and Within Department
SELECT
    employee_id,
    department,
    salary,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS overall_dense_rank,
    DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS department_dense_rank
FROM employees;

-----------------------------------------------------------
-- Task 13: NTILE Quartiles with Running Average by Salary Order
SELECT
    employee_id,
    salary,
    NTILE(4) OVER (ORDER BY salary ASC) AS quartile,
    AVG(salary) OVER (
        ORDER BY salary ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_avg_salary
FROM employees;

-----------------------------------------------------------
-- Task 14: Difference from Department Min and Max
SELECT
    employee_id,
    department,
    salary,
    salary - MIN(salary) OVER (PARTITION BY department) AS diff_from_min,
    MAX(salary) OVER (PARTITION BY department) - salary AS diff_from_max
FROM employees;

