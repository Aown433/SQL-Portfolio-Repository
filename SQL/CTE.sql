USE  sakila ;
WITH total_payment AS (
SELECT customer_id , SUM(amount) as total 
from payment 
group by customer_id
) 
SELECT  *
 FROM total_payment  
 where total > 180 ; 
WITH customer_rank AS (
SELECT  SUM(amount) as total_payment ,customer_id , 
RANK() OVER(
  order by sum(amount) desc
)  as ranking
from payment 
group by  customer_id 
 )
select *
from customer_rank 
where   ranking <= 5 ; 
describe staff ;
describe payment ;
WITH final AS (
SELECT customer_id , staff_id , sum(amount) as total_payment  ,
rank() OVER(
PARTITION BY staff_id 
order by sum(amount) desc  
) as  ranking 
from payment
group by staff_id ,  customer_id
 )
select * from final 
where ranking <= 3 ; 
describe payment ;
describe customer ;
WITH customer_total AS (
SELECT customer_id , sum(amount) as payment_total 
from payment 
group by customer_id ) ,
customer_category AS (
SELECT payment_total , customer_id  , 
CASE 
WHEN payment_total > 200 then  "VIP" 
ELSE "REGURAL" 
END AS category 
FROM customer_total 
)
SELECT * 
FROM customer_category
