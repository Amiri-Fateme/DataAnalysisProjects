-- PIVOT UNPIVOT
USE student;
CREATE TABLE sales_table(
   Product VARCHAR(10),
   Year INT,
   Sales INT
);
INSERT INTO sales_table (Product, Year, Sales)
VALUES
('A', 2021, 100),
('A', 2022, 150), 
('B', 2021, 200), 
('B', 2022, 210);
 
 SELECT*FROM sales_table
 
 -- MySQL does not have built-in PIVOT and UNPIVOT operations like some other database 
 -- systems (e.g., SQL Server, Oracle), so we need to simulate these operations using SQL queries. 
 -- PIVOT 
SELECT Product, 
MAX(CASE WHEN Year=2021 THEN Sales ELSE NULL END) AS '2021', 
MAX(CASE WHEN Year=2022 THEN Sales ELSE NULL END) AS '2022' 
FROM sales_table 
GROUP BY Product;

 -- UNPIVOT 
SELECT Product, '2021' AS Year, `2021` AS Sales FROM (SELECT Product, MAX(CASE WHEN Year = 2021 THEN Sales ELSE NULL END) AS '2021' FROM sales_table GROUP BY Product) AS SubQuery1 
UNION ALL 
SELECT Product, '2022' AS Year, `2022` AS Sales FROM (SELECT Product, MAX(CASE WHEN Year = 2022 THEN Sales ELSE NULL END) AS '2022' FROM sales_table GROUP BY Product) AS SubQuery2;


 -- leetcode https://leetcode.com/studyplan/top-sql-50/ 
 -- sqlzoo https://sqlzoo.net/wiki/SQL_Tutorial 
 -- Strata https://platform.stratascratch.com/coding?code_type=3