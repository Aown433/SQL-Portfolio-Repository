USE sakila ; 
WITH customer_segmamention AS (
SELECT 
c.customer_id , sum(p.amount) as Total_revenue  , c.first_name , c.last_name  ,
CASE
WHEN SUM(P.amount) > 150 then "VIP"
WHEN SUM(P.amount) > 100 then "Regural"
else "New"  
END AS ranking
from customer c 
join payment p on c.customer_id = p.customer_id  
group by c.first_name , c.last_name , c.customer_id
)
SELECT *
from customer_segmamention ;

-- Pareto Analysis (80/20 Rule)
WITH take_1 AS (
SELECT c.customer_id , c.first_name , c.last_name , SUM(p.amount) as Revenue , 
Sum(Sum(p.amount)) over() as total_revenue , 
ROUND(
	SUM(p.amount) * 100.0 / SUM(SUM(p.amount)) OVER (), 
	2) AS contribution

from customer c 
join payment p on c.customer_id = p.customer_id  
group by c.customer_id , c.first_name , c.last_name 

)
SELECT *
from take_1 
order by contribution desc;

WITH take_2 AS (
SELECT c.customer_id , c.first_name , c.last_name , SUM(p.amount) as Revenue 
from customer c 
join payment p on c.customer_id = p.customer_id  
group by   c.customer_id,
        c.first_name,
        c.last_name

)
SELECT  first_name ,last_name , Revenue ,
Sum(Revenue) over(
order by Revenue  desc 
) as running_total , 
sum(Revenue) over () as total_revenue ,
ROUND(
	Sum(Revenue) over(
order by Revenue  desc 
)  / sum(Revenue) over ()  * 100 ,
	2) AS contribution

from take_2 
ORDER BY Revenue DESC; 



