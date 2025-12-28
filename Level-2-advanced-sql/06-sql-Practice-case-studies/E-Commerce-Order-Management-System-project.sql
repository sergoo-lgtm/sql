-----------------------------------------------------------
-- Project: E-Commerce Order Management System
-----------------------------------------------------------

-----------------------------------------------------------
-- SECTION 1: TABLE CREATION
-----------------------------------------------------------

-- Categories Table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL,
    Description TEXT
);

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    Address VARCHAR(255),
    City VARCHAR(50),
    Region VARCHAR(50),
    Country VARCHAR(50),
    PostalCode VARCHAR(10)
);

-- Products Table
CREATE TABLE Products ( 
    ProductID INT PRIMARY KEY, 
    ProductName VARCHAR(255) NOT NULL, 
    Description TEXT, 
    CategoryID INT, 
    Price DECIMAL(10,2) NOT NULL, 
    StockQuantity INT DEFAULT 0,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    ShippingAddress VARCHAR(255),
    OrderStatus VARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Payments Table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(50),
    TransactionID VARCHAR(100),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Shipping Table
CREATE TABLE Shipping (
    ShippingID INT PRIMARY KEY,
    OrderID INT,
    ShippingDate DATE,
    TrackingNumber VARCHAR(100),
    Shipper VARCHAR(50),
    DeliveryDate DATE,
    ShippingCost DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-----------------------------------------------------------
-- SECTION 2: DATA INSERTION
-----------------------------------------------------------

INSERT INTO Categories VALUES
(1, 'Electronics', 'Electronic devices and accessories'),
(2, 'Computer Accessories', 'Accessories for computers');

INSERT INTO Customers VALUES
(1,'Alice','Smith','alice.smith@email.com','555-123-4567','123 Main St','Anytown','CA','USA','90210'),
(2,'Bob','Johnson','bob.johnson@email.com','555-987-6543','456 Oak Ave','Springfield','IL','USA','62704'),
(3,'Charlie','Brown','charlie.brown@email.com','555-555-1212','789 Pine Ln','Hill Valley','CA','USA','90302'),
(4,'Diana','Miller','diana.miller@email.com','555-111-2222','10 Downing St','London',NULL,'UK','SW1A 2AA'),
(5,'Eve','Davis','eve.davis@email.com','555-333-4444','5 Champs-Élysées','Paris',NULL,'France','75008');

INSERT INTO Products VALUES
(1,'Laptop','High-performance laptop',1,1200.00,10),
(2,'Smartphone','Latest smartphone',1,800.00,20),
(3,'Wireless Mouse','Wireless mouse',2,25.00,50),
(4,'Keyboard','Mechanical keyboard',2,75.00,30),
(5,'4K Monitor','27-inch monitor',1,400.00,15);

INSERT INTO Orders VALUES
(1,1,'2023-01-15','123 Main St, CA','Delivered'),
(2,2,'2023-02-20','456 Oak Ave, IL','Shipped'),
(3,1,'2023-03-10','123 Main St, CA','Delivered'),
(4,3,'2023-04-05','789 Pine Ln, CA','Pending'),
(5,4,'2023-05-01','10 Downing St, UK','Cancelled');

INSERT INTO OrderDetails VALUES
(1,1,1,1,1200.00),
(2,1,3,1,25.00),
(3,2,2,1,800.00),
(4,3,1,1,1200.00),
(5,4,4,2,75.00);

INSERT INTO Payments VALUES
(1,1,'2023-01-15',1225.00,'Credit Card','TXN12345'),
(2,2,'2023-02-20',800.00,'PayPal','TXN67890'),
(3,3,'2023-03-10',1200.00,'Credit Card','TXN24680'),
(4,4,'2023-04-05',150.00,'Credit Card','TXN13579'),
(5,5,'2023-05-01',0.00,'Credit Card','TXN86420');

INSERT INTO Shipping VALUES
(1,1,'2023-01-16','UPS12345','UPS','2023-01-18',10.00),
(2,2,'2023-02-21','FEDEX67890','FedEx',NULL,12.50),
(3,3,'2023-03-11','USPS24680','USPS','2023-03-13',7.50),
(4,4,'2023-04-06','DHL13579','DHL',NULL,15.00),
(5,5,'2023-05-02','DHL86420','DHL',NULL,15.00);

-----------------------------------------------------------
-- SECTION 3: JOIN QUERIES
-----------------------------------------------------------

-- Orders with Products
SELECT
    O.OrderID,
    O.OrderDate,
    C.FirstName,
    C.LastName,
    P.ProductName,
    OD.Quantity,
    OD.UnitPrice
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID;

-----------------------------------------------------------

-- Customers Without Orders
SELECT
    C.CustomerID,
    C.FirstName,
    C.LastName
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.OrderID IS NULL;

-----------------------------------------------------------

-- Products Never Ordered
SELECT
    P.ProductID,
    P.ProductName
FROM Products P
LEFT JOIN OrderDetails OD ON P.ProductID = OD.ProductID
WHERE OD.OrderID IS NULL;

-----------------------------------------------------------
-- SECTION 4: SET OPERATIONS & SUBQUERIES
-----------------------------------------------------------

-- Orders With and Without Payments
SELECT
    O.OrderID,
    O.OrderDate,
    P.PaymentID,
    P.PaymentDate,
    P.Amount
FROM Orders O
LEFT JOIN Payments P ON O.OrderID = P.OrderID;

-----------------------------------------------------------

-- Highest Order Amount Per Customer
SELECT
    O.OrderID,
    O.CustomerID,
    O.OrderDate,
    SUM(OD.Quantity * OD.UnitPrice) AS TotalOrderAmount
FROM Orders O
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY O.OrderID, O.CustomerID, O.OrderDate
HAVING TotalOrderAmount = (
    SELECT MAX(Total)
    FROM (
        SELECT SUM(OD2.Quantity * OD2.UnitPrice) AS Total
        FROM Orders O2
        JOIN OrderDetails OD2 ON O2.OrderID = OD2.OrderID
        WHERE O2.CustomerID = O.CustomerID
        GROUP BY O2.OrderID
    )
);

-----------------------------------------------------------
-- SECTION 5: AGGREGATIONS & WINDOW FUNCTIONS
-----------------------------------------------------------

-- Orders Count Per Customer
SELECT
    C.CustomerID,
    C.FirstName,
    C.LastName,
    COUNT(O.OrderID) AS NumberOfOrders
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
ORDER BY NumberOfOrders DESC;

-----------------------------------------------------------

-- Monthly Revenue
SELECT
    STRFTIME('%Y-%m', O.OrderDate) AS OrderMonth,
    SUM(OD.Quantity * OD.UnitPrice) AS TotalRevenue
FROM Orders O
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY OrderMonth
ORDER BY OrderMonth;

-----------------------------------------------------------

-- Top 5 Best Selling Products
SELECT
    ProductID,
    ProductName,
    TotalQuantitySold,
    ProductRank
FROM (
    SELECT
        P.ProductID,
        P.ProductName,
        SUM(OD.Quantity) AS TotalQuantitySold,
        RANK() OVER (ORDER BY SUM(OD.Quantity) DESC) AS ProductRank
    FROM Products P
    JOIN OrderDetails OD ON P.ProductID = OD.ProductID
    GROUP BY P.ProductID, P.ProductName
)
WHERE ProductRank <= 5
ORDER BY ProductRank;

-----------------------------------------------------------

-- Price Rank Per Category
SELECT
    CategoryID,
    ProductName,
    Price,
    DENSE_RANK() OVER (PARTITION BY CategoryID ORDER BY Price DESC) AS PriceRank
FROM Products;

-----------------------------------------------------------

-- Price Quartiles Per Category
SELECT
    CategoryID,
    ProductName,
    Price,
    NTILE(4) OVER (PARTITION BY CategoryID ORDER BY Price) AS PriceQuartile
FROM Products;

-----------------------------------------------------------
-- END OF PROJECT
-----------------------------------------------------------
