CREATE SCHEMA organization;
USE organization;

CREATE TABLE employee(
   emp_id INT PRIMARY KEY,
   first_name VARCHAR(40),
   last_name VARCHAR(40),
   birth_day DATE,
   sex VARCHAR(1),
   salary INT,
   super_id INT,
   branch_id INT
);
ALTER TABLE employee 
ADD FOREIGN KEY(super_id) REFERENCES employee(emp_id) ON DELETE SET NULL;
    
CREATE TABLE branch(
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT,
  mgr_start_date DATE,
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE employee
ADD FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL;
 
 CREATE TABLE client(
   client_id INT PRIMARY KEY,
   client_name VARCHAR(40),
   branch_id INT, 
   FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
   );

CREATE TABLE works_with(
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id,client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
 );
 
-- Corporate 
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL); 
INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');
UPDATE employee SET branch_id = 1 WHERE emp_id = 100;
INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Scranton
 INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);
 INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');
 UPDATE employee SET branch_id = 2 WHERE emp_id = 102;
 INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
 INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
 INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);
 
  -- Stamford 
  INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);
  INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');
  UPDATE employee SET branch_id = 3 WHERE emp_id = 106;
  INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
  INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);
  INSERT INTO employee VALUES(109, 'Oscar', 'Halpert', '1979-10-01', 'M', 69000, 106, 3);
  INSERT INTO employee VALUES(110, 'jack', 'Halpert', '1978-10-01', 'M', 69000, 106, 3);
   
   -- BRANCH SUPPLIER 
   INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
   INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
   INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
   INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
   INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils'); 
   INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
   INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');
   
   -- CLIENT 
   INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
   INSERT INTO client VALUES(401, 'Lackawana Country', 2);
   INSERT INTO client VALUES(402, 'FedEx', 3); 
   INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
   INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
   INSERT INTO client VALUES(405, 'Times Newspaper', 3);
   INSERT INTO client VALUES(406, 'FedEx', 2);
   
   -- WORKS_WITH 
   INSERT INTO works_with VALUES(105, 400, 55000);
   INSERT INTO works_with VALUES(102, 401, 267000); 
   INSERT INTO works_with VALUES(108, 402, 22500);
   INSERT INTO works_with VALUES(107, 403, 5000); 
   INSERT INTO works_with VALUES(108, 403, 12000); 
   INSERT INTO works_with VALUES(105, 404, 33000);
   INSERT INTO works_with VALUES(107, 405, 26000); 
   INSERT INTO works_with VALUES(102, 406, 15000); 
   INSERT INTO works_with VALUES(105, 406, 130000);
    
    
    #basic query 
    SELECT * FROM employee; 
    SELECT * FROM client;
    SELECT * FROM client ORDER BY branch_id ASC;
    # DESC 
    SELECT * FROM client ORDER BY client_name, branch_id ASC; 
    #DISTINCT
    SELECT DISTINCT sex FROM employee;
    SELECT DISTINCT super_id FROM employee;
    #COUNT DISTINCT
    SELECT COUNT(DISTINCT sex) FROM employee;
    
    SELECT * FROM employee ORDER BY last_name LIMIT 3;
    
    SELECT * FROM employee WHERE emp_id>103 AND sex='M';
	SELECT * FROM employee WHERE emp_id>103 AND NOT sex='M';
	SELECT * FROM employee WHERE emp_id>103 AND sex='M' AND birth_day>'1970-01-01';


    
    SELECT * FROM employee WHERE first_name='David' OR first_name='Kelly' OR first_name='Michael'; 
-- Optimized Alternative 
    SELECT * FROM employee WHERE first_name IN ('David', 'Kelly', 'Michael');

 SELECT * FROM employee WHERE first_name LIKE '%a%';
 SELECT * FROM employee WHERE first_name LIKE '_a%';
 SELECT * FROM employee WHERE first_name LIKE '__a%'; 
 SELECT * FROM employee WHERE first_name NOT LIKE '%a';
    
 -- the number of reporters who report to each manager 
SELECT super_id, COUNT(emp_id) AS cnt_emp, SUM(salary) FROM employee GROUP BY super_id;   
SELECT super_id, COUNT(emp_id) AS cnt_emp, MAX(salary) FROM employee GROUP BY super_id; 
SELECT SUM(salary) FROM employee;
SELECT sex, COUNT(sex), AVG(salary) FROM employee GROUP BY sex;


-- condition after group by 
SELECT super_id, COUNT(emp_id) AS cnt_emp, SUM(salary) AS sum_slr 
FROM employee 
WHERE salary>70000 
GROUP BY super_id ;

SELECT super_id, COUNT(emp_id) AS cnt_emp, SUM(salary) AS sum_slr 
FROM employee 
WHERE salary>70000 
GROUP BY super_id 
HAVING cnt_emp>1;

-- Aggregation Functions 
-- COUNT, SUM, MAX, MIN, AVG 
SELECT SUM(salary) FROM employee; 
SELECT MAX(salary) FROM employee; 
SELECT AVG(salary) FROM employee;

-- DATE and TIME funtions, among a list of >50 functions: 
-- NOW(), CURDATE(), DATE_ADD(), DATE_SUB(), DATEDIFF() ---> Session lenght, SEC_TO_TIME(), -- TIME_TO_SEC(), DAYOFYEAR(), DAYOFMONTH(), DAYOFWEEK(), WEEKDAY() ---> Mon 0, Tue 1, ...,
 -- TIME_FORMAT() 
SELECT CURDATE(); 
SELECT NOW(); 
SELECT DATE(birth_day) FROM employee; SELECT DATE_ADD(birth_day, INTERVAL 2 DAY) FROM employee; 
SELECT DATE_SUB(birth_day, INTERVAL 1 DAY) FROM employee;
SELECT DAYOFYEAR(birth_day) FROM employee;
SELECT DAYOFMONTH(birth_day) FROM employee;
SELECT DATEDIFF(NOW(), birth_day) FROM employee;
SELECT DAYOFWEEK(birth_day) FROM employee; 
SELECT DATE_FORMAT(birth_day, "%M-%D") FROM employee;


-- STRING FUNCTIONS 
-- CONCAT, LOWER, UPPER, TRIM 
SELECT CONCAT( 'MR/MRS',first_name) FROM employee;
SELECT *, CONCAT(first_name, ' ', last_name) AS full_name FROM employee; 
SELECT UPPER(first_name) AS "upper name" FROM employee; 
SELECT TRIM(LEADING 'a' FROM 'aaaaaaaHELLO REZAaaaaa') AS beg_triming;
SELECT TRIM(TRAILING 'a' FROM 'aaaaaaaHELLO REZAaaaaa') AS end_triming;
SELECT TRIM(BOTH 'a' FROM 'aaaaaaaHELLO REZAaaaaa') AS both_triming;

-- -------------------------------------------------
 -- CASE statement | Conditional Experssion (IF, ELSE, WHEN) 
 -- salary<60000 poor / salary < 75000 average / salary > 75000 rich 
SELECT emp_id, first_name, last_name, salary,
 CASE 
WHEN salary>75000 THEN 'rich' 
WHEN salary<=75000 AND salary>60000 THEN 'average' 
ELSE 'poor' END AS salary_category FROM employee;

SELECT emp_id, first_name, last_name, salary,
IF(salary>70000, 'rich', IF(salary>60000, 'average', 'poor')) AS salary_cat 
FROM employee;

--------------------------------------
-- JOIN(JOIN, LEFT JOIN, RIGHT JOIN,INNER JION, OUTER JOIN)
SELECT emp.emp_id, emp.first_name,wk.client_id
FROM employee AS emp
JOIN works_with AS wk
ON emp.emp_id=wk.emp_id;

SELECT emp.emp_id, emp.first_name,wk.client_id
FROM employee AS emp
LEFT JOIN works_with AS wk
ON emp.emp_id=wk.emp_id;

SELECT emp.emp_id, emp.first_name,wk.client_id
FROM employee AS emp
RIGHT JOIN works_with AS wk
ON emp.emp_id=wk.emp_id;

SELECT emp.emp_id, emp.first_name, COUNT(wk.client_id), SUM(total_sales)
FROM employee AS emp
LEFT JOIN works_with AS wk
ON emp.emp_id=wk.emp_id
GROUP BY emp.emp_id, emp.first_name;

SELECT emp.emp_id, emp.first_name, COUNT(wk.client_id), SUM(total_sales)
FROM employee AS emp
INNER JOIN works_with AS wk
ON emp.emp_id=wk.emp_id
GROUP BY emp.emp_id, emp.first_name;

-------------------
#UNION
SELECT first_name FROM employee
UNION
SELECT last_name FROM employee;

SELECT salary FROM employee
UNION
SELECT emp_id FROM employee;

----------------------
#NESTED QUERIES/ SUB QUERY
SELECT emp.emp_id, emp.first_name, emp.last_name
FROM employee AS emp
WHERE emp_id IN
(SELECT wk.emp_id
FROM works_with AS wk
WHERE wk.total_sales>50000)

SELECT 
    b.branch_name,
    SUM(w.total_sales) AS total_branch_sales
FROM 
    branch b
JOIN 
    employee e ON b.branch_id = e.branch_id
JOIN 
    works_with w ON e.emp_id = w.emp_id
GROUP BY 
    b.branch_name
ORDER BY 
    total_branch_sales DESC;

   
	# Functions (COUNT | COUNT DISTINCT | DISTINCT | AVG | MIN | MAX | .....)
     # GROUP BY + HAVING 
     # JOIN 
     # UNION 
     # Stored Procedure 
     # Trigger 
     # Condition with CASE WHEN 
     # WILDCARD + Regex ---- > LIKE
   
 

