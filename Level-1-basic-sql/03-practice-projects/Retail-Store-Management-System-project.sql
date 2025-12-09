-- Project: Retail Store Management System 🛒
-- Problem Set: Inventory, Customers, Orders, and Sales Analytics
-- Source: SQL Roadmap for Data Analysis (Level 1)

-----------------------------------------------------------
-- Task 1: Create Products Table
-- Challenge: Build the backbone of your retail store by creating the Products table with all necessary constraints.
CREATE TABLE Products (
    product_id int PRIMARY KEY,
    name varchar(50) NOT NULL,
    category varchar(50) CHECK (category IN ('Electronics', 'Clothing', 'Grocery', 'Furniture')),
    price REAL NOT NULL check(price > 0),
    stock_quantity INTEGER CHECK(stock_quantity >= 0)
);

-----------------------------------------------------------
-- Task 2: Create Customers Table
-- Challenge: Capture all essential customer details to keep your store running smoothly.
CREATE TABLE Customers (
    customer_id INTEGER PRIMARY KEY,
    name varchar(50) NOT NULL,
    email varchar(50) UNIQUE NOT NULL,
    phone varchar(50) UNIQUE NOT NULL,
    address varchar(50) DEFAULT 'Not Provided'
);

-----------------------------------------------------------
-- Task 3: Create Orders Table
-- Challenge: Track every purchase with the Orders table to analyze sales and customer behavior.
CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_date DATE DEFAULT CURRENT_DATE,
    total_amount REAL CHECK (total_amount > 0),
    Remarks_if_any varchar(50) DEFAULT 'No Remarks'
);

-----------------------------------------------------------
-- Task 4: Insert Sample Customers
-- Challenge: Populate your Customers table with 10 customers so your store has real data to analyze.
INSERT INTO Customers (customer_id, name, email, phone, address) 
VALUES
(1, 'John Doe', 'john.doe@email.com', '9876543210', '123 Main St'),
(2, 'Jane Smith', 'jane.smith@email.com', '9823456789', '45 Elm St'),
(3, 'Alice Brown', 'alice.b@email.com', '9988776655', '78 Pine Ave'),
(4, 'Bob Johnson', 'bob.j@email.com', '9765432109', '90 Oak Lane'),
(5, 'Charlie Lee', 'charlie.l@email.com', '9234567890', 'Not Provided'),
(6, 'David White', 'david.w@email.com', '9678991234', '12 Maple St'),
(7, 'Emily Clark', 'emily.c@email.com', '9345678901', 'Not Provided'),
(8, 'Frank Harris', 'frank.h@email.com', '9763214785', '56 Birch Road'),
(9, 'Grace Kelly', 'grace.k@email.com', '9456123870', '32 Cedar Ave'),
(10, 'Henry Adams', 'henry.a@email.com', '9312465789', '22 Walnut Lane');

-----------------------------------------------------------
-- Task 5: Insert Sample Products
-- Challenge: Fill your Products table with a variety of items to simulate a real store inventory.
INSERT INTO Products (product_id, name, category, price, stock_quantity) 
VALUES
(101, 'Apple iPhone 15', 'Electronics', 999.99, 10),
(102, 'Samsung Galaxy S23', 'Electronics', 899.99, 15),
(103, 'Leather Jacket', 'Clothing', 149.99, 25),
(104, 'HP Laptop', 'Electronics', 799.99, 8),
(105, 'Wooden Dining Table', 'Furniture', 499.99, 5),
(106, 'Nike Running Shoes', 'Clothing', 129.99, 20),
(107, 'LED TV 55"', 'Electronics', 699.99, 12),
(108, 'Rice 10kg', 'Grocery', 25.99, 50),
(109, 'Sofa Set (3+1+1)', 'Furniture', 999.99, 4),
(110, 'Organic Honey 500ml', 'Grocery', 15.99, 30);

-----------------------------------------------------------
-- Task 6: Insert Sample Orders
-- Challenge: Record initial purchases in your Orders table to analyze sales and trends.
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, Remarks_if_any) 
VALUES
(1001, 1, '2024-01-15', 999.99, 'No Remarks'),
(1002, 2, '2024-01-16', 299.98, 'Delivered'),
(1003, 3, '2024-01-17', 129.99, 'Payment Pending'),
(1004, 4, '2024-01-18', 899.99, 'No Remarks'),
(1005, 5, '2024-01-19', 799.99, 'Cancelled'),
(1006, 6, '2024-01-20', 499.99, 'Delivered'),
(1007, 7, '2024-01-21', 129.99, 'No Remarks'),
(1008, 8, '2024-01-22', 699.99, 'Refund Issued'),
(1009, 9, '2024-01-23', 25.99, 'No Remarks'),
(1010, 10, '2024-01-24', 15.99, 'Delivered');
-----------------------------------------------------------
-- Task 7: Show first 3 customers, products, and orders
-- Challenge: Preview your retail store database by retrieving the first 3 records from each table.
SELECT * FROM Customers
LIMIT 3;

SELECT * FROM Products
LIMIT 3;

SELECT * FROM Orders
LIMIT 3;

-----------------------------------------------------------
-- Task 8: Fetch all distinct product categories
-- Challenge: Identify all unique categories in your store's inventory.
SELECT DISTINCT category   
FROM Products;

-----------------------------------------------------------
-- Task 9: Orders above 900
-- Challenge: Spotlight the big spenders by retrieving orders greater than ₹900.
SELECT *
FROM Orders
WHERE total_amount > 900;

-----------------------------------------------------------
-- Task 10: Top 2 most expensive products
-- Challenge: Find the premium items in your store.
SELECT *
FROM Products
ORDER BY price DESC
LIMIT 2;

-----------------------------------------------------------
-- Task 11: Customers with missing addresses
-- Challenge: Detect customers who haven’t provided their address.
SELECT *
FROM Customers
WHERE address = 'Not Provided';

-----------------------------------------------------------
-- Task 12: Increase Electronics prices by 10%
-- Challenge: Adjust prices to reflect market trends.
UPDATE Products
SET price = price * 1.10
WHERE category = 'Electronics';

SELECT name, price, stock_quantity
FROM Products
WHERE category = 'Electronics'
LIMIT 1;

-----------------------------------------------------------
-- Task 13: Add discount column to Orders
-- Challenge: Prepare for sales promotions by adding a discount column.
ALTER TABLE Orders 
ADD discount FLOAT DEFAULT 0;

SELECT order_id, total_amount, discount
FROM Orders
LIMIT 1;

-----------------------------------------------------------
-- Task 14: Update stock quantity for products with 10 units
-- Challenge: Simulate sold-out items by reducing stock to 0.
UPDATE Products
SET stock_quantity = 0
WHERE stock_quantity = 10;

SELECT *
FROM Products
WHERE stock_quantity = 0;

-----------------------------------------------------------
-- Task 15: Add new_address column to Customers
-- Challenge: Track updated customer addresses.
ALTER TABLE Customers 
ADD new_address VARCHAR(50) DEFAULT 'Unknown';

SELECT name, address, new_address
FROM Customers
LIMIT 1;

-----------------------------------------------------------
-- Task 16: Apply 5% discount to big orders
-- Challenge: Reward high-spending customers automatically.
UPDATE Orders
SET discount = total_amount * 0.05
WHERE total_amount > 900;

SELECT order_id, total_amount, discount
FROM Orders
WHERE discount > 0;

-----------------------------------------------------------
-- Task 17: Remove out-of-stock products
-- Challenge: Clean your inventory of items no longer available.
DELETE FROM Products
WHERE stock_quantity = 0;

SELECT product_id, name, stock_quantity
FROM Products;

-----------------------------------------------------------
-- Task 18: Delete old orders before 2024-01-20
-- Challenge: Maintain current order records by removing outdated transactions.
DELETE FROM Orders
WHERE order_date < '2024-01-20';

SELECT order_id, customer_id, order_date, total_amount
FROM Orders;

-----------------------------------------------------------
-- Task 19: Delete customers with no orders
-- Challenge: Keep only active customers in your database.
DELETE FROM Customers
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM Orders);

SELECT customer_id, name
FROM Customers;

-----------------------------------------------------------
-- Task 20: Delete orders below 150
-- Challenge: Filter out low-value transactions.
DELETE FROM Orders
WHERE total_amount < 150;

SELECT order_id, customer_id, total_amount
FROM Orders;

-----------------------------------------------------------
-- Task 21: Calculate total revenue
-- Challenge: Measure the total earnings of your store.
SELECT SUM(total_amount) AS total_revenue
FROM Orders;

-----------------------------------------------------------
-- Task 22: Average spending per customer
-- Challenge: Analyze customer behavior for insights.
SELECT AVG(total_amount) AS avg_spending_per_customer
FROM Orders;

-----------------------------------------------------------
-- Task 23: Orders per month
-- Challenge: Track monthly sales trends.
SELECT STRFTIME('%Y-%m', order_date) AS order_month, COUNT(*) AS total_orders
FROM Orders
GROUP BY order_month;

-----------------------------------------------------------
-- Task 24: Highest-priced product
-- Challenge: Identify the most expensive item in your store.
SELECT name, price
FROM Products
ORDER BY price DESC
LIMIT 1;

-----------------------------------------------------------
-- Task 25: Replace Unknown addresses with NULL
-- Challenge: Standardize customer address records.
UPDATE Customers
SET new_address = NULL
WHERE new_address = 'Unknown';

SELECT customer_id, name, new_address
FROM Customers
LIMIT 3;

-----------------------------------------------------------
-- Task 26: Set specific address for Henry Adams
-- Challenge: Fix missing address for an important customer.
UPDATE Customers
SET new_address = '23 Walnut Lane'
WHERE customer_id = 10 AND name = 'Henry Adams' AND new_address IS NULL;

SELECT *
FROM Customers
WHERE customer_id = 10;

-----------------------------------------------------------
-- Task 27: Set Remarks_if_any to NULL where it's 'No Remarks'
-- Challenge: Clean unnecessary remarks from orders.
UPDATE Orders
SET Remarks_if_any = NULL
WHERE Remarks_if_any = 'No Remarks';

SELECT order_id, Remarks_if_any
FROM Orders
WHERE Remarks_if_any IS NULL;

-----------------------------------------------------------
-- Task 28: Orders in January 2024
-- Challenge: Focus on early-year transactions for trend analysis.
SELECT order_id, customer_id, order_date
FROM Orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-01-30';

-----------------------------------------------------------
-- Task 29: Most recent order date
-- Challenge: Quickly identify the last transaction date.
SELECT MAX(order_date) AS most_recent_order
FROM Orders;

-----------------------------------------------------------
-- Task 30: Orders count per day (2024-01-15 to 2024-01-17)
-- Challenge: Track daily order frequency.
SELECT order_date, COUNT(*) AS order_count
FROM Orders
WHERE order_date BETWEEN '2024-01-15' AND '2024-01-17'
GROUP BY order_date
ORDER BY order_date;

-----------------------------------------------------------
-- Task 31: Days between earliest and latest order
-- Challenge: Determine the range of your store's operations.
SELECT JULIANDAY(MAX(order_date)) - JULIANDAY(MIN(order_date)) AS days_between
FROM Orders;

-----------------------------------------------------------
-- Task 32: Orders in the 5 days before 2024-01-24
-- Challenge: Retrieve recent transactions leading up to a key date.
SELECT order_id, customer_id, order_date, total_amount
FROM Orders
WHERE order_date BETWEEN DATE('2024-01-24', '-5 days') AND '2024-01-23'
ORDER BY order_date;
