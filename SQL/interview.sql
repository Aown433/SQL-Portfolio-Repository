USE sakila ;
-- Top three customer by city 
describe city ;

describe address;
describe payment ; 
describe customer ;
WITH top_customer AS (
SELECT  c.first_name , SUM(p.amount ) as revenue , ci.city , 
ROW_NUMBER () OVER (
PARTITION BY ci.city 
ORDER BY SUM(p.amount) desc
)as ranking 
FROM payment p 
join customer c on p.customer_id = c.customer_id 
join address a on c.address_id = a.address_id
join city ci on a.city_id = ci.city_id 
group by  ci.city , c.first_name 
)
SELECT *
FROM top_customer 
WHERE ranking <= 3 ;

-- 
describe category ;
describe film_category;
describe inventory;
describe payment;
describe rental;
WITH revenue AS (
SELECT sum(p.amount) as total_revenue , 
c.name as category_name  , 
        ROUND(
            SUM(p.amount) * 100.0 / SUM(SUM(p.amount)) OVER (), 
        2) AS contribution
from payment p 
join rental r on p.rental_id = r.rental_id
join inventory i on r.inventory_id = i.inventory_id
join film_category fc on i.film_id = fc.film_id 
join category c on fc.category_id = c.category_id 
group by c.name 
)
SELECT *

FROM revenue  ;







