show databases;
use sakila;
show tables;
select * from departments;
show DATABASES;
use joins_lab;

CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL UNIQUE
);
INSERT INTO Departments VALUES
(101,'HR'),
(102,'IT'),
(103,'Finance'),
(104,'Marketing'),
(105,'Operations');

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    age INT CHECK(age >= 18),
    hire_date DATE,
    dept_id INT,

    FOREIGN KEY (dept_id)
    REFERENCES Departments(dept_id)
);
INSERT INTO Employees VALUES
(1,'Soumya',55000,21,'2024-01-15',102),
(2,'Adi',40000,22,'2023-08-10',101),
(3,'Ritesh',65000,28,'2022-03-20',102),
(4,'Omega',75000,25,'2021-11-05',103),
(5,'Rahul',35000,23,'2024-02-18',104),
(6,'Aman',82000,30,'2020-06-12',103),
(7,'Neha',47000,26,'2023-05-01',105),
(8,'Priya',68000,29,'2021-09-15',102),
(9,'Karan',39000,24,'2024-04-22',104),
(10,'Ankit',90000,32,'2019-12-01',103),
(11,'Sanjay',48000,27,'2023-01-15',101),
(12,'Rohit',52000,29,'2022-06-10',102);

CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL UNIQUE,
    budget DECIMAL(12,2) CHECK(budget > 0)
);
INSERT INTO Projects VALUES
(201,'E-Commerce Platform',500000),
(202,'AI Chatbot',350000),
(203,'HR Management System',200000),
(204,'Marketing Dashboard',250000),
(205,'Inventory Tracker',300000);

CREATE TABLE Employee_Project (
    emp_id INT,
    project_id INT,
    hours_worked INT DEFAULT 0,

    PRIMARY KEY (emp_id, project_id),

    FOREIGN KEY (emp_id)
    REFERENCES Employees(emp_id),

    FOREIGN KEY (project_id)
    REFERENCES Projects(project_id)
);  

INSERT INTO Employee_Project VALUES
(1,201,120),
(1,202,80),
(2,203,60),
(3,201,150),
(3,205,100),
(4,202,200),
(5,204,90),
(6,201,250),
(6,205,180),
(7,204,110),
(8,202,140),
(8,205,95),
(9,204,70),
(10,201,300),
(10,202,220),
(11,203,80),
(12,201,90);
use joins_lab;
show tables;

select * from departments;
select * from employee_project;
select * from employees;
select * from projects;


-- Q1. Employee + Department Report     -->  approach : -- self join should be there for values extract from different table 
-- Show:
-- Employee Name
-- Department Name
-- Salary
SELECT emp.emp_name, dept.dept_name, emp.salary 
FROM employees as emp 
JOIN Departments as dept
ON emp.dept_id = dept.dept_id;



-- Q2. Employees Working on Projects                   -- self join should be there for values extract from different table 
-- Show:
-- Employee Name
-- Project Name
-- Hours Worked
-- Department Name

SELECT emp.emp_name, proj.project_name, emp_proj.hours_worked, dept.dept_name
FROM projects as proj
JOIN employee_project as emp_proj
ON emp_proj.project_id = proj.project_id

JOIN employees as emp 
ON emp.emp_id = emp_proj.emp_id

JOIN Departments as dept 
ON dept.dept_id = dept.dept_id 



-- Q3. Department-wise Employee Count       --->  aopproach -- group by 
-- Show:
-- Department Name
-- Total Employees
-- Department Id ALSO
--IN THAT CASE HOW BUT THE GROUP BY CLAUSE TAKE 3 COLUMN WHICH IS NOT IN NORMAL CASE --( I THINK THAT ON;Y USE IN CASE OF JOIN)
SELECT dept.dept_name, count(emp.emp_name),dept.dept_id   
FROM departments as dept
RIGHT JOIN employees as emp   -- only join also works
ON dept.dept_id = emp.dept_id
GROUP BY dept_name ; 



select * from departments;
select * from employee_project;
select * from employees;
select * from projects;

-- Q4. Project-wise Employee Count
-- Show:
-- Project Name
-- Number of Employees Assigned

SELECT proj.project_name, count(emp.emp_name) 
FROM Projects as proj

JOIN employee_project as emp_proj
ON proj.project_id = emp_proj.project_id


JOIN Employees as emp
ON  emp.emp_id= emp_proj.emp_id

GROUP BY project_name



-- Q5. Employees Working on Multiple Projects ( more than 1 )
-- Show: 
-- Employee Name
-- Number of Projects
-- FOR Having duplication use  count(DISTINCT proj.project_name)

SELECT emp.emp_name, count( proj.project_name)
FROM employee_project as emp_proj
JOIN Projects as proj
ON emp_proj.project_id = proj.project_id

JOIN Employees as emp 
ON emp.emp_id = emp_proj.emp_id

GROUP BY emp_name
HAVING count(proj.project_name) > 1

-- for cheking of each persdon having same name with project name 
SELECT emp.emp_name, proj.project_name
FROM employee_project as emp_proj
JOIN Projects as proj
ON emp_proj.project_id = proj.project_id

JOIN Employees as emp 
ON emp.emp_id = emp_proj.emp_id


-- Q6. Department-wise Salary Report
-- Show:
-- Department Name
-- Total Salary
-- Average Salary
-- Highest Salary
-- Lowest Salary


SELECT dept_name, max(salary), sum(salary), avg(salary), min(salary)
from departments as dept
join employees emp 
ON dept.dept_id = emp.dept_id
GROUP BY dept_name



-- Q7. Project Utilization Report (sort by highest total hours)
-- Show:
-- Project Name
-- Total Employees
-- Total Hours Worked
-- Average Hours Worked

SELECT  proj.project_name, count(emp.emp_name ), SUM(emp_proj.hours_worked), avg(emp_proj.hours_worked)
FROM projects proj
JOIN employee_project emp_proj
ON proj.project_id = emp_proj.project_id
JOIN employees emp
ON emp_proj.emp_id = emp.emp_id
GROUP BY project_name
ORDER BY AVG(salary) DESC;
use joins_lab;
select * from departments;
select * from employee_project;
select * from employees;
select * from projects;

-- Q8. Employees Not Assigned to Any Project
-- Show:
-- Employee ID
-- Employee Name
-- Department Name
INSERT INTO Employees
VALUES
(13,'TestUser',50000,25,'2024-01-01',101);

SELECT emp.emp_id, emp.emp_name, dept.dept_name 
FROM employees emp
JOIN departments dept
ON emp.dept_id = dept.dept_id
LEFT JOIN employee_project emp_proj
ON emp_proj.emp_id = emp.emp_id
-- JOIN projects proj
-- ON proj.project_id = emp_proj.project_id
WHERE emp_proj.project_id IS NULL


-- Q9. Highest Budget Project with Assigned Employees
-- Show:
-- Project Name
-- Budget
-- Employee Name
-- Hours Worked
-- Only for the highest-budget project.

SELECT proj.project_name, proj.budget, emp_proj.hours_worked
from projects proj
join employee_project emp_proj
ON emp_proj.project_id = proj.project_id
LEFT JOIN employees emp    -- even if only join works 
ON emp.emp_id = emp_proj.emp_id 
ORDER BY proj.budget DESC 
limit 1; 



-- Q10. Management Dashboard Query (Industry Style)
-- Show:
-- Department Name
-- Employee Count
-- Average Salary
-- Projects Involved
-- Total Hours Worked
-- Only departments having more than 2 employees
-- Highest total hours worked

select d.dept_name, count(e.emp_id), avg(e.salary), sum(hours_worked)
FROM departments d
join employees e
on e.dept_id = d.dept_id 

JOIN employee_project ep
ON ep.emp_id = e.emp_id

JOIN projects p
ON p.project_id = ep.project_id
GROUP BY dept_name
HAVING count(d.dept_id) >2


