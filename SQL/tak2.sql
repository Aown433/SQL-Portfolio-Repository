USE sakila ;
SHOW TABLES ;
DESCRIBE customer;
describe payment; 

SELECT 
    c.customer_id, c.first_name, c.last_name, p.amount
FROM
    customer c
        INNER JOIN
    payment p
WHERE
    c.customer_id = p.customer_id;
-- select from two tables
SELECT 
    c.first_name, c.last_name, SUM(p.amount) AS total_amount
FROM
    customer c
        INNER JOIN
    payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id , c.first_name , c.last_name
ORDER BY total_amount DESC
LIMIT 10;
SELECT 
    c.first_name, c.last_name, COUNT(p.amount) AS total_order
FROM
    customer c
        INNER JOIN
    payment p ON c.customer_id = p.customer_id
GROUP BY first_name , last_name , c.customer_id
ORDER BY total_order DESC
LIMIT 10;
SELECT 
    c.first_name, c.last_name, SUM(p.amount) AS total_order
FROM
    customer c
        INNER JOIN
    payment p ON c.customer_id = p.customer_id
GROUP BY first_name , last_name , c.customer_id
ORDER BY total_order DESC
LIMIT 10;

SELECT 
    c.first_name, c.last_name, COUNT(p.amount) AS total_spend
FROM
    customer c
        INNER JOIN
    payment p ON c.customer_id = p.customer_id
GROUP BY c.first_name , c.last_name 
HAVING total_spend > 40
ORDER BY total_spend DESC
LIMIT 5;
   