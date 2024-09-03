-- TRIGGERs
-- Triggers are special routines that are automatically executed(or 'fired')
-- events that can activate a tigger inclue INSERT, UPDATE, AND DELETE.

-- There are two timing-based classifications for triggers:
-- BEFORE: Trigger is invoked before the event. 
-- AFTER: Trigger is invoked after the event. 

-- Every time an employee's salary is updated in the employee table, 
-- we want to maintain a log of this change. The log should contain 
-- the employee ID, old salary, new salary, and the timestamp of the change. 

-- Solution: 
-- First, create a table called salary_audit to store the logs. 
-- Then, create a trigger that will be fired before an employee's salary is updated.

CREATE TABLE salary_audit(
  audit_id INT AUTO_INCREMENT PRIMARY KEY,
  emp_id INT,
  old_salary INT, 
  new_salary INT,
  changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  );

SELECT * FROM salary_audit;
DROP TABLE salary_audit;

-- trigger
DELIMITER $$
CREATE TRIGGER before_employee_update
BEFORE UPDATE ON employee
FOR EACH ROW 
BEGIN
  IF OLD.salary != NEW.salary THEN
    INSERT INTO salary_audit (emp_id, old_salary, new_salary)
    VALUES(OLD.emp_id, OLD.salary, NEW.salary);
  END IF;
END $$
DELIMITER ;

DROP TRIGGER before_employee_update

INSERT INTO employee(emp_id, first_name, last_name, birth_day, sex, salary, super_id, branch_id)
VALUES(112, 'Jin', 'Martinez', '1979-10-01', 'M', 69000, 106, 3);
SELECT * FROM employee;
UPDATE employee SET salary = 73000
WHERE emp_id= 111;

UPDATE employee SET salary = 50000
WHERE emp_id = 112;

UPDATE employee SET salary = 80000
WHERE emp_id> 110;

SELECT* FROM salary_audit;

