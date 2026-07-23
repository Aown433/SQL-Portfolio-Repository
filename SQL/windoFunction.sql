USE sakila;
SELECT 
    SUM(amount), customer_id
FROM
    payment
GROUP BY customer_id ; 

select
 customer_id , sum(amount) as total_payment ,
rank() over(
order by sum(amount) desc  
) as ranking 
from payment 
group by customer_id  ;
SELECT staff_id, customer_id, SUM(amount) AS total_payment , 
RANK() OVER(
partition by staff_id 
order by sum(amount) desc 
) as ranking 
from payment 
group by staff_id , customer_id ;
select customer_id , sum(amount) as total_payment  , 
row_number () over(
   order by sum(amount)
   ) as ranking 
from payment 
group by customer_id ;

describe rental ;
select rental_rate , title , 
rank() over(
 order by rental_rate desc
  ) as ranking 
from film ;
describe film ;
describe film_category;
SELECT f.title, f.length, c.name AS category,
dense_rank () over (
partition by c.name 
order by f.length desc 
) as ranking 
from film f 
inner join film_category fc 
on fc.film_id = f.film_id 
inner join category c
on fc.category_id  = c.category_id  ;
SELECT 
    customer_id
FROM
    payment
LIMIT 3; 