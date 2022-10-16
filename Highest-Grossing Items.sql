with tbl_1 as (
SELECT category,
product,sum(spend) as total_spend
FROM product_spend
where extract('year' from transaction_date)='2022'
group by category, product
),
tbl_2 as 
(
select a.*, ROW_NUMBER() over(PARTITION BY category
order by total_spend desc) rnk
from tbl_1 a
)
SELECT category,product,total_spend from tbl_2
where rnk<=2
;