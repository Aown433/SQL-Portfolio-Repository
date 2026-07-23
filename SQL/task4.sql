USE sakila;
SELECT 
    c.first_name, c.last_name, f.title
FROM
    customer c
        INNER JOIN
    rental r ON c.customer_id = r.customer_id
        INNER JOIN
    inventory i ON r.inventory_id = i.inventory_id
        INNER JOIN
    film f ON f.film_id = i.film_id
LIMIT 10;
DESCRIBE rental;
DESCRIBE inventory ; 
DESCRIBE film ; 
SELECT 
    c.first_name, c.last_name, COUNT(*) AS total_rentals
FROM
    customer c
        INNER JOIN
    rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id , c.first_name , c.last_name
ORDER BY total_rentals DESC
LIMIT 5;
SELECT 
    f.title, COUNT(*) AS rental_total
FROM
    rental r
        INNER JOIN
    inventory i ON r.inventory_id = i.inventory_id
        INNER JOIN
    film f ON i.film_id = f.film_id
GROUP BY f.title , f.film_id
ORDER BY rental_total DESC
LIMIT 5;
SELECT 
    MAX(length)
FROM
    film ; 
SELECT 
    length, title
FROM
    film
WHERE
    length = (SELECT 
            MAX(length)
        FROM
            film);
SELECT 
    title, length
FROM
    film
WHERE
    length > (SELECT 
            AVG(length)
        FROM
            film);
describe customer ;
DESCRIBE payment ;

SELECT 
    customer_id, COUNT(*) AS total_rec
FROM
    payment
GROUP BY customer_id
HAVING COUNT(*) > (SELECT 
        AVG(total_rec)
    FROM
        (SELECT 
            customer_id, COUNT(*) AS total_rec
        FROM
            payment
        GROUP BY customer_id)t
        );


