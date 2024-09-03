-- SELF JOIN
-- The organization wants to find pairs of employees who work
 -- in the same branch and have the same salary, but are not 
 -- the same person. This could be useful for HR purposes,
 -- for example, to ensure there's no pay discrepancy for
 -- people doing similar roles.
USE organization;
SELECT 
   A.emp_id AS emp1_id,
   B.emp_id AS emp2_id,
   A.first_name AS emp1_name,
   B.first_name AS emp2_name,
   A.branch_id AS branch_id,
   A.salary AS salary
FROM 
  employee A
JOIN 
  employee B
   ON 
     (A.emp_id != B.emp_id) 
   AND
     (A.branch_id=B.branch_id)
   AND
     (A.salary=B.salary)
ORDER BY A.branch_id, A.salary

SELECT * FROM employee;
SELECT * FROM branch;
