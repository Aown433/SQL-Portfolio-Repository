use sakila ;
SELECT 
    rating, title
FROM
    film
WHERE
    rating IN ('G' , 'PG', 'PG-13');
-- QUESTION 2 
SELECT 
    title, rental_duration
FROM
    film
WHERE
    rental_duration IN (3 , 5, 7) ; 
    -- QUESTION 3 
SELECT 
    title, rental_duration
FROM
    film
WHERE
    rental_duration BETWEEN 2.99 AND 4.99 ;
    -- QUESTION 4 
SELECT 
    title, length
FROM
    film
WHERE
    length BETWEEN 90 AND 120;
    -- question 5 
SELECT 
    title
FROM
    film
WHERE
    title LIKE 'A%'; 
SELECT 
    title
FROM
    film
WHERE
    title LIKE '%LOVE%';
SELECT 
    title
FROM
    film
WHERE
    title LIKE '%S';
-- QUESTION 8
SELECT 
    address2 
FROM
    address
WHERE
    address2 IS NULL;
-- QUESTION 10
SELECT 
    rating ,title
FROM
    film
WHERE
    rating NOT IN ('R' , 'NC-17');
-- question 10
SELECT 
    rating, title, length
FROM
    film
WHERE
    rating IN ('PG' , 'G')
        AND length BETWEEN 60 AND 90
        AND title LIKE '%THE%';
