-- VIEWs(CREATE VIEW view_name AS QUERY )
-- The management wants a simplified view to see employee details
-- from the Scranton branch without exposing their salaries
-- and supervisor IDs. They want to see just the employee's ID, 
-- first name, last name, and the branch name.
CREATE VIEW scranton_emp AS
SELECT 
       e.emp_id,
       e.first_name,
       e.last_name,
       b.branch_name
FROM 
   employee AS e
JOIN 
   branch AS b
ON (e.branch_id=b.branch_id)
WHERE 
   b.branch_name='scranton';
SELECT * FROM scranton_emp;

-- Suppose after a while, the management decides they also want to 
-- include the birth date of the employees from the Scranton branch
 -- in the view.

CREATE OR REPLACE VIEW scanton_emp AS
SELECT 
       e.emp_id,
       e.first_name,
       e.last_name,
       e.birth_day,
       b.branch_name
FROM 
   employee AS e
JOIN 
   branch AS b
ON (e.branch_id = b.branch_id)
WHERE 
   b.branch_name='scranton';
SELECT * FROM scranton_emp;

DROP VIEW IF EXISTS scranton_emp;