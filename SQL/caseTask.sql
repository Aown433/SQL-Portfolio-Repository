USE sakila ;
SELECT 
    AVG(DATEDIFF(return_date, rental_date))
FROM
    rental;
SELECT 
    MAX(DATEDIFF(return_date, rental_date))
FROM
    rental;
SELECT 
    MAX(amount)
FROM
    payment;
SELECT 
    amount,
    CASE
        WHEN amount < 3 THEN 'cheep'
        WHEN amount <= 7 THEN 'normal'
        ELSE 'Expensive'
    END AS catagary
FROM
    payment
LIMIT 10;
-- har customer ko catagory do 
SELECT 
  sum(amount),
    CASE
        WHEN SUM(amount) > 200 THEN 'VIP'
        WHEN SUM(amount) > 100 THEN 'Normal'
        ELSE 'new'
    END AS catagory
FROM
    payment
GROUP BY customer_id;

-- Rental catagory 
SELECT 
    rental_date,
    return_date,
    CASE
        WHEN DATEDIFF(return_date, rental_date) >= 3 THEN 'Short Rental '
        WHEN DATEDIFF(return_date, rental_date) >= 5 THEN 'Normal Rental '
        ELSE 'Long Rental '
    END AS catagory
FROM
    rental ; 
show tables ;
describe payment ;
SELECT 
    MONTH(payment_date),
    COUNT(*) AS total_payment,
    CASE
        WHEN COUNT(*) > 2500 THEN 'High Revenue'
        ELSE 'Low Revenue'
    END AS catagory
FROM
    payment
GROUP BY MONTH(payment_date);
describe staff_list ; 

SELECT 
    staff_id,
    SUM(amount) AS total,
    AVG(amount) AS averge,
    CASE
        WHEn SUM(amount) > avg (amount)THEN 'High Perfamance '
        ELSE 'Low Perfamancce'
    END AS catagory
FROM
    payment
GROUP BY staff_id;
SELECT 
    SUM(amount),
    MONTH(payment_date),
    CASE
        WHEN SUM(amount) > 5000 THEN 'good month'
        ELSE 'bad month '
    END AS catagory
FROM
    payment
GROUP BY MONTH(payment_date) ;