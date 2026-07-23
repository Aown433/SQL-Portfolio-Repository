USE sakila ; 
SELECT 
    first_name, LOWER(first_name)
FROM
    customer ; 
SELECT 
    first_name, LENGTH(first_name)
FROM
    customer;
SELECT 
    first_name, LENGTH(first_name) AS total_char
FROM
    customer
ORDER BY total_char DESC
LIMIT 5;
-- concat function in sql 
SELECT 
    LENGTH(first_name, ' ', last_name),
    CONCAT(first_name, ' ', last_name) AS full_name
FROM
    customer
LIMIT 10; 