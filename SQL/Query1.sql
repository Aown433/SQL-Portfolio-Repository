use sakila ;
SELECT 
    rating, title
FROM
    film
WHERE
    rating = 'PG' ;
    SHOW TABLES;
    DESC CUSTOMER;
    DESC FILM;
SELECT 
    rating, title
FROM
    film ;
SELECT 
    first_name, last_name ,email
FROM
    customer ;
SELECT 
    rental_rate, title
FROM
    film
WHERE
    rental_rate = 4.99;
desc customer ;
SELECT 
    active, first_name
FROM
    customer
WHERE
    active = 1;
SELECT 
    length, title
FROM
    film
ORDER BY length DESC;
SELECT 
    replacement_cost, title
FROM
    film
ORDER BY replacement_cost DESC
LIMIT 5;
SELECT 
    rental_rate, title
FROM
    film
ORDER BY rental_rate
LIMIT 1;
SELECT DISTINCT
    rating
FROM
    FILM; 
SELECT DISTINCT
    rental_duration 
FROM
    film;
SELECT 
    rating, length, title
FROM
    film
WHERE
    length > 120 and rating = 'R'
ORDER BY length
LIMIT 10;