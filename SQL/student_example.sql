CREATE SCHEMA student;
USE student;
DROP TABLE students;

USE student;
CREATE TABLE students ( 
std_id INT,
name VARCHAR(50) NOT NULL,
major VARCHAR(50) DEFAULT 'Undecided', 
PRIMARY KEY(std_id)
);
DESCRIBE students;
ALTER TABLE students ADD gpa DECIMAL;
ALTER TABLE students DROP COLUMN gpa;

INSERT INTO students VALUES(1, 'Jack', 'Biology');
INSERT INTO students VALUES(2, 'Kate', 'Society');
INSERT INTO students VALUES(3, 'Jeniffer', 'English');
INSERT INTO students VALUES(4, 'Jack', 'Biology');
INSERT INTO students VALUES(5, 'Mike','Comp sc.');
INSERT INTO students VALUES(6, 'Reza', DEFAULT );

# delete and update
DELETE FROM students WHERE std_id=6;
UPDATE students SET name='Sara' WHERE std_id=5;
DELETE FROM students WHERE std_id=6 AND name='Reza';
UPDATE students SET major='math', name='Reza' WHERE std_id=5;


# READ THE TABLE
SELECT std_id as id FROM students;
SELECT std_id, name FROM students;
SELECT * FROM students;
SELECT * FROM students WHERE std_id>3;
SELECT * FROM students WHERE std_id>=3 OR name='Jack';
SELECT * FROM students WHERE (std_id>=3 OR name='Jack') AND major='Biology';





