with tbl_1 as (
SELECT 
transaction_id,product_id,spend, extract(year from transaction_date) yr
FROM user_transactions),
tbl_2 as 
(
select product_id,yr,sum(spend) curr_year_spend from tbl_1
group by product_id,yr
order by yr
),
tbl_3 as 
(
select a.*,LAG(curr_year_spend, 1) OVER (
      PARTITION BY product_id
      ORDER BY product_id, yr) AS prev_year_spend from tbl_2 a
)
select a.yr as year,a.product_id,a.curr_year_spend,a.prev_year_spend,
round((a.curr_year_spend-a.prev_year_spend)*100/a.prev_year_spend,2) as yoy_rate
from tbl_3 a