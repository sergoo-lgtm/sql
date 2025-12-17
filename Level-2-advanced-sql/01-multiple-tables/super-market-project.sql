-- Problem Set: super market project
-- Source: SQL Roadmap for Data Analysis (Level 2)
-----------------------------------------------------------

-- Task 1: Create Customer Table
CREATE TABLE Customer (
    Customer_id INT PRIMARY KEY,
    Customer_Name VARCHAR(255),
    Customer_Age INT
);

-- Task 2: Create Purchase Table
CREATE TABLE Purchase (
    Purchase_id INT PRIMARY KEY,
    Customer_id INT,
    Purchase_amt INT,
    Last_purchase_month VARCHAR(50),
    FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id)
);

-----------------------------------------------------------
-- Task 3: Insert Data into Customer Table
INSERT INTO Customer (Customer_id, Customer_Name, Customer_Age) VALUES
(1, 'John', 15),
(2, 'Sara', 16),
(3, 'Adam', 17),
(4, 'Emily', 15),
(5, 'Tom', 16),
(6, 'Amy', 17),
(7, 'Mark', 15),
(8, 'Olivia', 16),
(9, 'David', 17),
(10, 'Emma', 15);

-- (Optional) Insert some example data into Purchase table
INSERT INTO Purchase (Purchase_id, Customer_id, Purchase_amt, Last_purchase_month) VALUES
(101, 1, 250, 'January'),
(102, 2, 400, 'February'),
(103, 3, 150, 'March'),
(104, 4, 300, 'January'),
(105, 5, 450, 'February');

-----------------------------------------------------------
-- Task 4: Limit Customer Output
-- Challenge: Output the 'Customer' table, limited to 3 rows.
SELECT *
FROM Customer
LIMIT 3;

-----------------------------------------------------------
-- Task 5: Inner Join Customer and Purchase
-- Challenge: Join 'Customer' and 'Purchase' using Customer_id.
SELECT *
FROM Customer AS C
INNER JOIN Purchase AS P
ON C.Customer_id = P.Customer_id;

-----------------------------------------------------------
-- Task 6: Left Join Customer and Purchase
-- Challenge: Output all customers including those without purchases.
SELECT *
FROM Customer AS C
LEFT JOIN Purchase AS P
ON C.Customer_id = P.Customer_id;

-----------------------------------------------------------
-- Task 7: Cross Join Customer and Item
-- Challenge: List all possible items each customer could buy.
SELECT Customer_Name, Item_Name
FROM Customer
CROSS JOIN Item;

-----------------------------------------------------------
-- Task 8: Union Items and Item_adn
-- Challenge: Combine all items from two tables.
SELECT * FROM Item
UNION
SELECT * FROM Item_adn;

-----------------------------------------------------------
-- Task 9: Top 3 Customers by Purchase Amount
-- Challenge: Output a join table of 'Customer' and 'Purchase' for the top 3 highest purchase amounts.
WITH top_purchase AS (
    SELECT Purchase_id, Customer_id, Purchase_amt
    FROM Purchase
    ORDER BY Purchase_amt DESC
    LIMIT 3
)
SELECT *
FROM Customer
JOIN top_purchase
ON Customer.Customer_id = top_purchase.Customer_id;
-----------------------------------------------------------