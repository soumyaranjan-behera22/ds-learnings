create DATABASE ds_db;

select database()

use ds_db;

select DATABASE()

create table students(
    id int primary key,
    name VARCHAR(30),
    age int not null,
    marks int default 30
    -- constraint (age_check) CHECK(age>18)
);
select * from students;
INSERT INTO students VALUES
    (239,"soumya",15,214);
select name from students

SELECT * from students 
limit 3;

show databases;
use ds_db;

show tables;
select DATABASE();

select * from students;

CREATE TABLE course (
    student_id INT REFERENCES student(id), -- Shorthand
    course_id VARCHAR(30) NOT NULL
);
INSERT INTO course VALUES
(243,"dac211"),
(241,"dac212"),
(242,"dac213");





show DATABASES;

-- PROBLEM OF 1ST PART OF SQL --
create  database if not EXISTS School;
use  School;
CREATE TABLE Teacher
(id  INT PRIMARY KEY,
name  INT NOT NULL,
subject   VARCHAR(20) DEFAULT "CSE", 
salary  INT  DEFAULT 25000 );

DESC teacher;     -- show the table structure schema -- 

INSERT INTO teacher
(id,name,subject,salary)
VALUES
(23,"ajay","math","50000");

ALTER TABLE teacher  --- made a mistake that i give the int to name instead of varchar
MODIFY COLUMN name VARCHAR(30) NOT NULL;

select * from teacher
ORDER BY id DESC;

-- inserting rest of values 
INSERT INTO teacher
(id,name,subject,salary)
VALUES
(47,"bharat","english","60000"),
(18,"chetan","chemistry","45000"),
(9,"divya","physics","75000");

-- 1 select teacher whose salary more than 55k 
SELECT name FROM teacher
WHERE salary > 55000;

-- 2 rename the salary column table to ctc
ALTER TABLE teacher 
CHANGE COLUMN salary ctc INT DEFAULT 25000;     -- in this caee i made a mistake that i use rename instead of change 
---- RENAME  is for table only


-- 3 update salary column of all teacher by giving them increment 25%
-- firstly set the SQL safe updates as 0 
SET SQL_SAFE_UPDATES = 0;
UPDATE teacher
SET ctc = ctc+(ctc*0.25) ;

-- mad mistake that undo the changes and seting the salary individually manually 
UPDATE teacher 
SET ctc = CASE id
    WHEN 47 THEN 50000
    WHEN 23 THEN 60000
    WHEN 18 THEN 45000
    WHEN 9  THEN 75000
END
WHERE id IN (47, 23, 18, 9);



ALTER TABLE teacher 
ADD COLUMN city VARCHAR(30) DEFAULT "Gurgaon";

-- 4 delete the column for teacher table
ALTER TABLE teacher
DROP COLUMN ctc;


--  PROBLEM OF 1ST PART OF SQL 2ND QUESTION --

SHOW DATABASES;

select * from student;
CREATE TABLE Student
(roll INT PRIMARY KEY,
name VARCHAR(30) NOT NULL,
city VARCHAR(30),
mark INT);

INSERT INTO Student
(roll, name,city,mark)
VALUES
(110,"adam","delhi",76),
(108,"bob", "mumbai", 65),
(124,"casey", "pune", 94),
(112,"duke", "pune", 80);

--1 select all students who scored 75+
select name , mark FROM Student
WHERE mark>=75;

--2 find names of all cities where students are from
Select city , count(roll) from Student  -- one solution
GROUP BY city;

select DISTINCT city from Student ; -- other way


-- 3 maximun marks of students from each city

select city, max(mark) FROM Student
GROUP BY city;

select avg(mark) from Student;

-- 4 add new column grade , assign grade such that:
    -- marks>80 , grade = 0
    -- marks 70-80, grade = A
    -- marks 60-70 , grade = B

ALTER TABLE Student
ADD COLUMN grade VARCHAR(2);

UPDATE Student
SET grade = "0"
WHERE mark > 90;
UPDATE Student
SET grade = "A"
WHERE mark BETWEEN 80 AND 89;
UPDATE Student
SET grade = "B"
WHERE mark BETWEEN 70 AND 79;
UPDATE Student
SET grade = "C"
WHERE mark < 70;

-- ASIIGNMENT 1ST PART
use companyDB;
CREATE TABLE Employee (  -- i use employee because emplotees already exists
    EmpID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);
INSERT INTO Employee (EmpID, FirstName, LastName, Department, Salary, HireDate)
VALUES 
(101, 'Alice', 'Johnson', 'IT', 6500.00, '2020-03-15'),
(102, 'Mark', 'Rivera', 'HR', 4800.00, '2019-07-22'),
(103, 'Sophia', 'Lee', 'Finance', 7200.00, '2021-01-10'),
(104, 'Daniel', 'Kim', 'IT', 5800.00, '2018-11-05'),
(105, 'Emma', 'Brown', 'Marketing', 5300.00, '2022-04-18'),
(106, 'Liam', 'Patel', 'Finance', 6900.00, '2020-09-29'),
(107, 'Olivia', 'Garcia', 'HR', 4600.00, '2017-06-30'),
(108, 'Noah', 'Thompson', 'IT', 7500.00, '2023-02-12'),
(109, 'Ava', 'Martinez', 'Marketing', 5100.00, '2019-12-02'),
(110, 'Ethan', 'Davis', 'Finance', 8000.00, '2016-05-14');



-- Q1. Write a query to display every employee and all their data.

select * from Employee;

-- Q2. List only the FirstName, LastName, and Salary of every employee.

select FirstName, LastName, Salary from Employee;


-- Q3. Show all employees who work in the 'IT' department.

SELECT FirstName, LastName, Department from Employee
WHERE Department = "IT";


-- Q4. Retrieve employees with a salary greater than 6000.

select  * FROM Employee 
WHERE Salary > 6000;


-- Q5. List all employees ordered by HireDate from newest to oldest.

select * from employee 
ORDER BY HireDate DESC;


-- Q6. Show a list of all unique departments present in the table.

select DISTINCT Department from Employee;



-- Q7. Find employees whose first name starts with ‘A’.

SELECT * from Employee
WHERE FirstName LIKE "A%" ;


-- Q8. Show employees whose salaries are between 4000 and 7000.

SELECT * FROM Employee
WHERE Salary BETWEEN 4000 AND 7000;


-- Q9. Find the average salary of all employees.

SELECT avg(Salary) from Employee;


-- Q10. List each department along with the number of employees, but only include departments with more than 3 employees.
SELECT Department, COUNT(EmpID) from Employee
GROUP BY Department
HAVING COUNT(EmpID)>=3;
