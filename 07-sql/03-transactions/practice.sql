show DATABASES;

create DATABASE BankDB;
use BankDB;
show tables;
create table Accounts
(account_id INT PRIMARY KEY,
holder_name VARCHAR(30) NOT NULL,
balance INT
);

insert INTO Accounts
(account_id,holder_name,balance)
VALUES
(101,"Soumya",50000),
(102,"Ritesh",30000);

SELECT * from Accounts;
--Task:

-- Transfer ₹10,000 from Soumya to Rahul.
-- Use a transaction.
-- Make changes permanent using COMMIT.
SELECT @@autocommit;  
SET autocommit = 0;   
START TRANSACTION;           -- for doing transaction operations select columns all at ones till the commit message and press (Ctrl + Enter)
UPDATE Accounts SET balance=balance-5000 WHERE account_id =101;
UPDATE Accounts SET balance=balance+5000 WHERE account_id = 102;
ROLLBACK;



-- Q2: Bank Transfer Failure (ROLLBACK)

-- Using the same Accounts table:

-- Task:

-- Deduct ₹20,000 from Soumya.
-- Accidentally add ₹25,000 to Rahul.
-- Realize the mistake.
-- Undo all changes.

START TRANSACTION;           -- for doing transaction operations select columns all at ones till the commit message and press (Ctrl + Enter)
UPDATE Accounts SET balance=balance+25000 WHERE account_id =101;
UPDATE Accounts SET balance=balance-5000 WHERE account_id = 102;
-- Realize the mistake. THAT  Accidentally add ₹25,000 to RITESH.
ROLLBACK;

-- Q3: Employee Salary Update

-- Table:
-- Employees
-- Task:
-- Increase all IT department salaries by 10%.
-- Check results.
-- If satisfied, save changes.
-- Otherwise undo them.


CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    age INT,
    dept_name VARCHAR(50)
);

INSERT INTO Employees VALUES
(101,'Soumya',50000,21,'IT'),
(102,'Rahul',45000,24,'HR'),
(103,'Aman',60000,28,'IT'),
(104,'Priya',55000,26,'Finance'),
(105,'Neha',70000,30,'IT'),
(106,'Ritesh',40000,23,'Marketing'),
(107,'Karan',52000,27,'HR'),
(108,'Sneha',65000,29,'IT');

SELECT * FROM Employees;

-- Increase all IT department salaries by 10%.
-- Check results.
-- If satisfied, save changes.
-- Otherwise undo them.

START TRANSACTION;           -- for doing transaction operations select columns all at ones till the commit message and press (Ctrl + Enter)
UPDATE  Employees SET salary=salary+(salary*0.10) WHERE emp_id =101;
COMMIT; -- if it satisfied
ROLLBACK; -- otherwise rollback/undo


-- Q4: SAVEPOINT Practice

-- Table:
-- Products
-- Columns:
-- product_id
-- product_name
-- price
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);
INSERT INTO Products VALUES
(101, 'Laptop', 50000.00),
(102, 'Mobile', 25000.00),
(103, 'Keyboard', 1500.00),
(104, 'Mouse', 800.00),
(105, 'Monitor', 12000.00);


SELECT * FROM Products;
-- Task:

-- Start transaction.
-- Increase all prices by 5%.
-- Create SAVEPOINT price_update.
-- Increase all prices by another 10%.
-- Rollback only the second increase.
-- Commit first increase.

START TRANSACTION;   -- for doing transaction operations select columns all at ones till the commit message and press (Ctrl + Enter)
UPDATE Products SET price = price + (price*0.05);
SAVEPOINT price_update;
UPDATE Products SET price = price + (price*0.1);
ROLLBACK TO price_update;
COMMIT;



-- Q5: Order Management System (Industry Style)
-- Tables:
-- Customers
-- Orders
-- Products
-- Scenario: Customer buys a product.
-- Steps:
-- Create order record.
-- Reduce product stock.
-- Update customer purchase count.
-- If any step fails: Undo everything
-- If all succeed: Save everything