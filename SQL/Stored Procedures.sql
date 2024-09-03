-- STORED PROCEDURES = FUNCTION
-- Suppose the HR department wants to quickly know the total number of employees 
-- and the average salary in a given branch.
-- Rather than executing multiple queries or doing the calculations manually, 
-- a stored procedure can be created to simplify this task.
DELIMITER //
CREATE PROCEDURE GetBranchStats( IN branch_name_input VARCHAR(50), 
OUT total_emps INT, OUT avg_salary DECIMAL(10,2))
BEGIN
	-- get total employees in the given branch name
        SELECT COUNT(emp_id) INTO total_emps
        FROM employee e
        JOIN branch b
        ON e.branch_id=b.branch_id
        WHERE b.branch_name=branch_name_input;
        
	-- get average salary in the given branch name
		SELECT AVG(salary) INTO avg_salary
        FROM employee e
        JOIN branch b
        ON e.branch_id=b.branch_id
        WHERE b.branch_name= branch_name_input;
END //
DELIMITER ;

-- how to call stored procedures:
CALL GetBranchStats ('Stamford', @total, @avg_sal);

SELECT @total, @avg_sal;

DROP PROCEDURE IF EXISTS GetBranchStats;
 