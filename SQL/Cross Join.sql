-- CROSS JOIN
-- Suppose the company wants to experiment with team pairings 
-- to assess potential chemistry and productivity between 
-- its employees. They want to generate a list of all possible 
-- team pairings of employees from the Scranton and Stamford 
-- branches, without pairing an employee with themselves.

USE organization;
SELECT 
   A.first_name AS scranton_emp,
   B.first_name AS stanford_emp
FROM 
  employee A
CROSS JOIN 
  employee B
WHERE A.emp_id != B.emp_id AND
   A.branch_id=2 AND
   B.branch_id=3;
   
SELECT* FROM employee;
SELECT* FROM branch;
