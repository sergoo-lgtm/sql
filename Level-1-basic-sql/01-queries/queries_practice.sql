-- Problem Set: Select, Where, Between, Logical Operators
-- Source: SQL Roadmap for Data Analysis (Level 1)

-----------------------------------------------------------
-- Q1: Retrieve passengers whose names start with letters from A to D
-- Demonstrates: BETWEEN operator on text values
SELECT *
FROM Flights
WHERE Passenger_name BETWEEN 'A' AND 'D';

-----------------------------------------------------------
-- Q2: Retrieve passengers from New York
-- Demonstrates: Filtering using WHERE with equality
SELECT Passenger_name, Gender
FROM Flights
WHERE Origin = 'New York';

-----------------------------------------------------------
-- Q3: Retrieve flights where either origin or destination is Mumbai
-- Demonstrates: Logical OR operator
SELECT *
FROM Flights
WHERE Origin = 'Mumbai' OR Destination = 'Mumbai';

-----------------------------------------------------------
-- Q4: Retrieve passengers whose names end with 'a'
-- Demonstrates: Pattern matching with LIKE
SELECT *
FROM Flights
WHERE Passenger_name LIKE '%a';

-----------------------------------------------------------
-- Q5: Retrieve flights with destination ending in 'o' AND origin starting with 'M'
-- Demonstrates: Combining multiple conditions with AND and LIKE
SELECT *
FROM Flights
WHERE Destination LIKE '%o'
  AND Origin LIKE 'M%';

-----------------------------------------------------------
-- Q6: Retrieve passengers with blank or NULL Passenger_id
-- Demonstrates: Handling missing values
SELECT *
FROM Flights
WHERE Passenger_id = ' ' OR Passenger_id IS NULL
ORDER BY Passenger_name;

-----------------------------------------------------------
-- Q7: Retrieve orders between 12pm and 1pm
-- Demonstrates: Numeric BETWEEN for time filtering
SELECT *
FROM Orders
WHERE Order_time BETWEEN 12 AND 13;

-----------------------------------------------------------
-- Q8: Retrieve distinct customers with names ending in 'a'
-- Demonstrates: DISTINCT to remove duplicates and LIKE pattern
SELECT DISTINCT Customer_id
FROM Orders
WHERE Customer_name LIKE '%a';

-----------------------------------------------------------
-- Q9: Sort orders by apartment floor
-- Demonstrates: ORDER BY for sorting query results
SELECT *
FROM Orders
ORDER BY Apartment_floor;

-----------------------------------------------------------
-- Q10: Retrieve orders with missing order_time
-- Demonstrates: IS NULL for filtering missing values
SELECT Order_id
FROM Orders
WHERE Order_time IS NULL;