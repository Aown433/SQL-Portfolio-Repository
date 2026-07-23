-- ============================================
-- POS DATABASE CREATION SCRIPT
-- 15 Tables + Relationships + Stored Procedures
-- ============================================

CREATE DATABASE IF NOT EXISTS pos_system;
USE pos_system;

-- 1. CITY TABLE
CREATE TABLE City (
    CityID INT PRIMARY KEY AUTO_INCREMENT,
    CityName VARCHAR(100) NOT NULL,
    State VARCHAR(50),
    News TEXT,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. STORE TABLE
CREATE TABLE Store (
    StoreID INT PRIMARY KEY AUTO_INCREMENT,
    StoreName VARCHAR(100) NOT NULL,
    CityID INT NOT NULL,
    Address VARCHAR(255),
    Phone VARCHAR(20),
    Manager VARCHAR(100),
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CityID) REFERENCES City(CityID)
);

-- 3. DEPARTMENT TABLE
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL,
    Description TEXT
);

-- 4. EMPLOYEE TABLE
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeName VARCHAR(100) NOT NULL,
    DepartmentID INT NOT NULL,
    StoreID INT NOT NULL,
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID)
);

-- 5. CATEGORY TABLE
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(100) NOT NULL,
    Description TEXT
);

-- 6. PRODUCT TABLE
CREATE TABLE Product (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT NOT NULL,
    Price DECIMAL(10, 2),
    Cost DECIMAL(10, 2),
    StockQty INT DEFAULT 0,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

-- 7. SUPPLIER TABLE
CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierName VARCHAR(100) NOT NULL,
    CityID INT NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(100),
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CityID) REFERENCES City(CityID)
);

-- 8. CUSTOMER TABLE
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(100),
    CityID INT NOT NULL,
    LoyaltyPoints INT DEFAULT 0,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CityID) REFERENCES City(CityID)
);

-- 9. INVENTORY TABLE
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT NOT NULL,
    StoreID INT NOT NULL,
    Quantity INT,
    LastRestockDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID),
    UNIQUE KEY unique_product_store (ProductID, StoreID)
);

-- 10. PAYMENT TABLE
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    PaymentMethod VARCHAR(50),
    Description TEXT
);

-- 11. TRANSACTION TABLE
CREATE TABLE Transaction (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    StoreID INT NOT NULL,
    CustomerID INT,
    EmployeeID INT NOT NULL,
    PaymentID INT NOT NULL,
    TransactionDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(12, 2),
    DiscountAmount DECIMAL(10, 2) DEFAULT 0,
    TaxAmount DECIMAL(10, 2) DEFAULT 0,
    NetAmount DECIMAL(12, 2),
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (PaymentID) REFERENCES Payment(PaymentID)
);

-- 12. TRANSACTION ITEM TABLE
CREATE TABLE TransactionItem (
    TransactionItemID INT PRIMARY KEY AUTO_INCREMENT,
    TransactionID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    LineTotal DECIMAL(12, 2),
    FOREIGN KEY (TransactionID) REFERENCES Transaction(TransactionID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- 13. RETURNS TABLE
CREATE TABLE Returns (
    ReturnID INT PRIMARY KEY AUTO_INCREMENT,
    TransactionID INT NOT NULL,
    ReturnDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Reason TEXT,
    RefundAmount DECIMAL(12, 2),
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (TransactionID) REFERENCES Transaction(TransactionID)
);

-- 14. SUPPLIER ORDER TABLE
CREATE TABLE SupplierOrder (
    SupplierOrderID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierID INT NOT NULL,
    StoreID INT NOT NULL,
    OrderDate DATE,
    DeliveryDate DATE,
    TotalCost DECIMAL(12, 2),
    Status VARCHAR(50),
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID)
);

-- 15. REPORTS TABLE (Summary Data)
CREATE TABLE Reports (
    ReportID INT PRIMARY KEY AUTO_INCREMENT,
    ReportType VARCHAR(50),
    ReportDate DATE,
    TotalSales DECIMAL(12, 2),
    TotalTransactions INT,
    AverageTransaction DECIMAL(12, 2),
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- STORED PROCEDURES FOR API
-- ============================================

-- SP: Get All Transactions with Details
DELIMITER //
CREATE PROCEDURE sp_GetAllTransactions()
BEGIN
    SELECT 
        t.TransactionID,
        st.StoreName,
        c.CustomerName,
        e.EmployeeName,
        p.PaymentMethod,
        t.TransactionDate,
        t.TotalAmount,
        t.DiscountAmount,
        t.TaxAmount,
        t.NetAmount
    FROM Transaction t
    JOIN Store st ON t.StoreID = st.StoreID
    LEFT JOIN Customer c ON t.CustomerID = c.CustomerID
    JOIN Employee e ON t.EmployeeID = e.EmployeeID
    JOIN Payment p ON t.PaymentID = p.PaymentID
    ORDER BY t.TransactionDate DESC;
END //
DELIMITER ;

-- SP: Get Sales by Store
DELIMITER //
CREATE PROCEDURE sp_GetSalesByStore()
BEGIN
    SELECT 
        s.StoreID,
        s.StoreName,
        COUNT(t.TransactionID) AS TotalTransactions,
        SUM(t.NetAmount) AS TotalSales,
        AVG(t.NetAmount) AS AvgSaleAmount
    FROM Store s
    LEFT JOIN Transaction t ON s.StoreID = t.StoreID
    GROUP BY s.StoreID, s.StoreName;
END //
DELIMITER ;

-- SP: Get Product Performance
DELIMITER //
CREATE PROCEDURE sp_GetProductPerformance()
BEGIN
    SELECT 
        p.ProductID,
        p.ProductName,
        c.CategoryName,
        SUM(ti.Quantity) AS TotalQuantitySold,
        SUM(ti.LineTotal) AS TotalRevenue,
        (SUM(ti.LineTotal) - SUM(ti.Quantity * p.Cost)) AS TotalProfit
    FROM Product p
    LEFT JOIN TransactionItem ti ON p.ProductID = ti.ProductID
    LEFT JOIN Category c ON p.CategoryID = c.CategoryID
    GROUP BY p.ProductID, p.ProductName, c.CategoryName
    ORDER BY TotalRevenue DESC;
END //
DELIMITER ;

-- SP: Get Customer Sales
DELIMITER //
CREATE PROCEDURE sp_GetCustomerSales()
BEGIN
    SELECT 
        c.CustomerID,
        c.CustomerName,
        COUNT(t.TransactionID) AS TotalPurchases,
        SUM(t.NetAmount) AS TotalSpent,
        c.LoyaltyPoints
    FROM Customer c
    LEFT JOIN Transaction t ON c.CustomerID = t.CustomerID
    GROUP BY c.CustomerID, c.CustomerName, c.LoyaltyPoints
    ORDER BY TotalSpent DESC;
END //
DELIMITER ;

COMMIT;
USE pos_system;
SHOW TABLES;

-- ============================================
-- TABLES READY FOR DATA INSERT
-- ============================================