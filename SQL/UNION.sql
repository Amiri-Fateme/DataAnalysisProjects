-- UNION اجتماع
SELECT 
    client_name AS Name
FROM client
UNION
SELECT 
   CONCAT(first_name,' ', last_name) AS Name
FROM employee
