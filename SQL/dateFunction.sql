USE sakila;
SELECT CURDATE();
SELECT NOW() ; 
SELECT CURRENT_TIMESTAMP();
SELECT DATE_ADD('2026-07-13', INTERVAL 10 DAY); 
SELECT 
    DATEDIFF(rental_date, return_date)
FROM
    rental;
SELECT 
    rental_date, YEAR(rental_date) AS year_
FROM
    rental
LIMIT 10;
SELECT 
    rental_date,
    MONTH(rental_date) AS month_,
    COUNT(rental_date) 
FROM
    rental
GROUP BY rental_date
ORDER BY rental_date DESC
LIMIT 5;
SELECT 
    payment_id, payment_date, YEAR(payment_date) AS payment_year
FROM
     payment ; 
SELECT 
    payment_id, payment_date, YEAR(payment_date) AS year_count
FROM
    payment
WHERE
    YEAR(payment_date) = 2005;
SELECT 
    MONTH(payment_date) AS month_total,
    COUNT(*) AS total_payment
FROM
    payment
GROUP BY month_total ; 
SELECT 
    MONTH(payment_date) AS month_check, payment_id
FROM
    payment
HAVING month_check = 6;
SELECT 
    MONTH(payment_date) AS month_ch, COUNT(*) AS total
FROM
    payment
GROUP BY month_ch;

SELECT 
    MONTH(payment_date) AS total, payment_date
FROM
    payment;
SELECT 
    DAY(payment_date) AS total, payment_date
FROM
    payment ; 
SELECT 
    DAY(payment_date) AS total, payment_date
FROM
    payment
HAVING total  = 15;
SELECT
    payment_date,
    YEAR(payment_date) AS year_,
    MONTH(payment_date) AS month_,
    DAY(payment_date) AS day_
FROM payment
LIMIT 10;


