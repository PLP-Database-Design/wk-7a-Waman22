use salesdb;




-- Question 1: Achieving 1NF
-- The ProductDetail table violates 1NF because the Products column contains multiple values.
-- To achieve 1NF, we split the Products column so each row represents a single product for an order.

-- Step 1: Create a new table in 1NF
CREATE TABLE If  not Exists ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    PRIMARY KEY (OrderID, Product) -- Composite key to ensure uniqueness
);

-- Step 2: Insert data into the 1NF table, splitting Products into individual rows
INSERT Ignore INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
    (101, 'Wamaanda Phaswana', 'Laptop'),
    (101, 'Wamaanda Phaswana', 'Mouse'),
    (102, 'Luke Skywaler', 'Tablet'),
    (102, 'Luke Skywaler', 'Keyboard'),
    (102, 'Luke Skywaler', 'Mouse'),
    (103, 'Tony Stark', 'Phone');

-- Question 2: Achieving 2NF

-- Step 1: Create a table for Orders to store OrderID and CustomerName
CREATE TABLE if not exists Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);


-- Step 2: Create a table for OrderDetails to store OrderID, Product, and Quantity
CREATE TABLE IF NOT EXISTS OrderDetails_2NF (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product), -- Composite key
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) -- Foreign key to link to Orders
);

-- Step 3: Insert data into the Orders table (unique OrderID and CustomerName pairs)
INSERT IGNORE INTO Orders (OrderID, CustomerName)
VALUES
    (101, 'Wamaanda Phaswana'),
    (102, 'Luke Skywalker'),
    (103, 'Tony Stark');

-- Step 4: Insert data into the OrderDetails_2NF table
INSERT IGNORE INTO OrderDetails_2NF (OrderID, Product, Quantity)
VALUES
    (101, 'Laptop', 2),
    (101, 'Mouse', 1),
    (102, 'Tablet', 3),
    (102, 'Keyboard', 1),
    (102, 'Mouse', 2),
    (103, 'Phone', 1);
