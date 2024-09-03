-- NULL VALUE HANDELING(IF THEN RULE,COALESCE)
USE student;
CREATE TABLE null_value_sample(
ids INT PRIMARY KEY,
 name VARCHAR(50),
 age INT
 );

INSERT INTO null_value_sample (ids,name,age)
VALUES
(1,'Ali', NULL),
(2,NULL,25),
(3,'Reza',NULL),
(4, NULL,NULL);

SELECT * FROM null_value_sample;

-- method 1 : IF THEN RULE
SELECT ids,
     IF (name IS NULL,'no name', name) AS name,
     IF (age IS NULL,0, age) AS age
FROM null_value_sample;
-----------------------------------------------------
-- method 2 : COALESCE
SELECT ids,
    COALESCE(name,'no name') AS name,
    COALESCE(age,0) AS age
FROM null_value_sample;


