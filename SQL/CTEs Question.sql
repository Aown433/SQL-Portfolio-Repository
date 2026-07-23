USE sakila ; 
describe payment ;
Select  sum( amount ), 
DATE_FORMAT(payment_date, '%Y-%M') AS month_total , 
sum(sum(amount)) over(order by DATE_FORMAT(payment_date, '%Y-%M'))as running_total
from payment  
group by DATE_FORMAT(payment_date, '%Y-%M') ;

-- Month-over-Month Revenue Growth %
WITH month_over_month as (
SELECT SUM(amount) as revenue ,DATE_FORMAT(payment_date, '%Y-%m') AS month, 
LAG(SUM(amount) )OVER ( order by DATE_FORMAT(payment_date, '%Y-%m'))as pervious_revenue 
from payment 
group by DATE_FORMAT(payment_date, '%Y-%m') 
)
select month , revenue , pervious_revenue ,
round(((revenue - pervious_revenue ) / revenue) *100 , 2)  as growth_month 
from month_over_month  ;

WITH month_category as (
SELECT 
sum(p.amount) as Total_revenue ,
DATE_FORMAT(p.payment_date , "%Y-%m") as Month,
c.name as Category_movies ,
ROW_NUMBER() OVER ( 
PARTITION BY DATE_FORMAT(p.payment_date , "%Y-%m")
ORDER BY SUM(p.amount) DESC) AS RANKING 
FROM payment p 
join 
rental r  on p.rental_id = r.rental_id
join inventory i
on r.inventory_id = i.inventory_id 
join film f 
on  i.film_id = f.film_id
join film_category fc
on  f.film_id = fc.film_id
join  category c
on fc.category_id = c.category_id 

GROUP BY c.name , DATE_FORMAT(p.payment_date , "%Y-%m")
)
SELECT Category_movies ,Total_revenue , RANKING  , Month
FROM month_category
where RANKING  = 1 ;
describe  inventory;