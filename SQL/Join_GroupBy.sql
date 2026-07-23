USE sakila ; 
DESCRIBE payment  ; 
SELECT 
    SUM(amount) AS total_revene
FROM
    payment;
SHOW tables ;
DESCRIBE customer ;
SELECT 
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_payment,
    c.customer_id
FROM
    customer c
        JOIN
    payment p ON c.customer_id = p.customer_id
GROUP BY customer_id
ORDER BY sum(amount) desc
LIMIT 10;
describe film ;
describe inventory ; 
describe rental ;
SELECT 
    f.title, COUNT(r.rental_id)
FROM
    film f
        JOIN
    inventory i ON f.film_id = i.film_id
        JOIN
    rental r  ON i.inventory_id = r.inventory_id
GROUP BY  title
ORDER BY COUNT(r.rental_id) DESC
LIMIT 10;
describe rental;
show tables ; 
describe payment ; 
SELECT 
    DATE_FORMAT(payment_date, '%Y-%M') AS month_total,
    SUM(amount) AS Total_revenue
FROM
    payment
GROUP BY month_total
ORDER BY month_total;
SELECT 
    c.customer_id,
    COUNT(r.rental_id) AS Total_rental,
    c.first_name,
    c.last_name
FROM
    customer c
        JOIN
    rental r ON c.customer_id= r.customer_id
GROUP BY customer_id
ORDER BY Total_rental DESC
LIMIT 10; 
SELECT 
    f.title, SUM(p.amount) AS Total_revenu
FROM
    film f
        JOIN
    inventory i ON f.film_id = i.film_id
        JOIN
    rental r ON i.inventory_id = r.inventory_id
        JOIN
    payment p ON r.rental_id = p.rental_id
GROUP BY f.title
ORDER BY Total_revenu DESC
LIMIT 1;
describe film_category;
describe film;
describe payment ;
SELECT 
    *
FROM
    film_category;
describe category ;
select name 
from category ;

SELECT 
    n.name, SUM(p.amount) AS Total_revenu
FROM
    film f
        JOIN
    inventory i ON f.film_id = i.film_id
        JOIN
    rental r ON i.inventory_id = r.inventory_id
        JOIN
    payment p ON r.rental_id = p.rental_id
        JOIN
    film_category c ON f.film_id = c.film_id
        JOIN
    category n ON c.category_id = n.category_id
GROUP BY n.name
ORDER BY Total_revenu desc ;
describe payment ;
describe customer ;
describe city ;
describe country ;
describe address ; 

SELECT 
    c.city,
    SUM(p.amount) AS Total_revenu , r.first_name ,
    row_number() over(
          partition by c.city
         order by sum(p.amount)desc
          ) as ranking 
FROM
    payment p
        JOIN
    customer r ON p.customer_id = r.customer_id
        JOIN
    address a ON r.address_id = a.address_id
        JOIN
    city c ON a.city_id = c.city_id
group by c.city , r.first_name 
having ranking = 1;

with customer_top as(
SELECT 
    c.city,
    SUM(p.amount) AS Total_revenu , r.first_name ,
    row_number() over(
          partition by c.city
         order by sum(p.amount)desc
          ) as ranking
from
 payment p
        JOIN
    customer r ON p.customer_id = r.customer_id
        JOIN
    address a ON r.address_id = a.address_id
        JOIN
    city c ON a.city_id = c.city_id 
    group by c.city , r.first_name 
)
select city ,  first_name  , total_revenu 
from customer_top
where ranking = 1;

