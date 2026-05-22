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