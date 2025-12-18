-----------------------------------------------------------
-- Problem Set: Set Operations
-- Source: SQL Roadmap for Data Analysis (Level 2)
-----------------------------------------------------------

-----------------------------------------------------------
-- Task 1: Create Employee Tables
-- Challenge: Create two tables: 'employee' for full-time and 'pt_employee' for part-time employees.
CREATE TABLE employee (
    emp_id VARCHAR(10) PRIMARY KEY,
    emp_name VARCHAR(255),
    department VARCHAR(50),
    mail_id VARCHAR(255)
);

CREATE TABLE pt_employee (
    emp_id VARCHAR(10) PRIMARY KEY,
    emp_name VARCHAR(255),
    department VARCHAR(50),
    mail_id VARCHAR(255)
);

-----------------------------------------------------------
-- Task 2: Insert Data into Employee Table
INSERT INTO employee (emp_id, emp_name, department, mail_id) VALUES
('FT1','John Smith','Sales','john.smith@company.com'),
('FT2','Sarah Johnson','Marketing','sarah.johnson@company.com'),
('FT3','Mark Davis','Finance','mark.davis@company.com'),
('FT4','Lisa Brown','Sales','lisa.brown@company.com'),
('FT5','Kevin Lee','IT','kevin.lee@company.com'),
('PT56','Tom Wilson','Marketing','tom.wilson@company.com'),
('PT57','Emily Parker','HR','emily.parker@company.com'),
('PT58','Mike Adams','IT','mike.adams@company.com'),
('PT59','Megan Kim','Finance','megan.kim@company.com'),
('FT10','Adam Scott','Sales','adam.scott@company.com'),
('FT11','Jessica Lee','Marketing','jessica.lee@company.com'),
('FT12','David Chen','IT','david.chen@company.com'),
('FT13','Julia Lee','Finance','julia.lee@company.com'),
('FT14','Daniel Brown','Sales','daniel.brown@company.com'),
('FT15','Olivia Taylor','Marketing','olivia.taylor@company.com');

-----------------------------------------------------------
-- Task 3: Insert Data into Part-Time Employee Table
INSERT INTO pt_employee (emp_id, emp_name, department, mail_id) VALUES
('PT49','Maxwell Johnson','Sales','maxwell.johnson@company.com'),
('PT40','Ashley Kim','Marketing','ashley.kim@company.com'),
('PT41','Jackie Nguyen','IT','jackie.nguyen@company.com'),
('PT42','Derek Smith','Finance','derek.smith@company.com'),
('PT43','Emily Wang','Sales','emily.wang@company.com'),
('PT44','Nate Thomas','Marketing','nate.thomas@company.com'),
('PT45','Sophia Lee','HR','sophia.lee@company.com'),
('PT56','Tom Wilson','Marketing','tom.wilson@company.com');

-----------------------------------------------------------
-- Task 4: Fruits Available in Supermarket
-- Challenge: Find the list of fruits available in both 'fruit' and 'inventory'.
SELECT f_name
FROM fruit
INTERSECT
SELECT inv_name
FROM inventory;

-----------------------------------------------------------
-- Task 5: Fruits Not in Inventory
-- Challenge: Output fruits from 'fruit' which are not present in 'inventory'.
SELECT f_name
FROM fruit
EXCEPT
SELECT inv_name
FROM inventory;

-----------------------------------------------------------
-- Task 6: Limit Employee Output
-- Challenge: Output first 5 rows of the 'employee' table.
SELECT *
FROM employee
LIMIT 5;

-----------------------------------------------------------
-- Task 7: Combine Employee Names (Full-Time + Part-Time)
-- Challenge: Output all employee names from both tables including duplicates.
SELECT emp_name
FROM employee
UNION ALL
SELECT emp_name
FROM pt_employee;

-----------------------------------------------------------
-- Task 8: Part-Time Employees Only
-- Challenge: Output all details of part-time employees who exist in both tables.
SELECT emp_id, emp_name
FROM employee
INTERSECT
SELECT emp_id, emp_name
FROM pt_employee;

-----------------------------------------------------------