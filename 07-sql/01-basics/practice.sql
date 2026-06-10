-- Active: 1775851316389@@127.0.0.1@3306
CREATE DATABASE CompanyDB;

use CompanyDB;
Create table Departments
(dept_id INT PRIMARY KEY,
dept_name VARCHAR(30) NOT NULL);

select *  from Departments;
insert into Departments   
(dept_id,dept_name)
VALUES
(201,"It"),
(203,"Data Science"),
(202,"ai");

create table Employees(   -- new table cretion inside CompanyDB
emp_id INT PRIMARY KEY,
emp_name VARCHAR(30) NOT NULL,
salary DECIMAL(10,2) DEFAULT 25000,
age INT,
CONSTRAINT CHECK (age >= 18 ),
dept_id INT,
FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)  -- foreign key creation --
);

-- inserting values inside Employees Tables
INSERT INTO Employees
(emp_id,emp_name,salary,age,dept_id)
VALUES
(1,"Soumya",50000.8, 21,203),
(2,"Adi",DEFAULT,20,201),
(3,"Ritesh",DEFAULT,50,203);
select * from Employees;

INSERT INTO Employees
(emp_id,emp_name,salary,age,dept_id)
VALUES
(4,"OMEGA",DEFAULT, 21,202);

SHOW CREATE TABLE Employees;