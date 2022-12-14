#Fill Missing Client Data
WITH tbl1 AS(
SELECT *, SUM(CASE WHEN category IS NOT NULL THEN 1 ELSE 0 END) 
OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS temp FROM brands),
tbl2 AS(
SELECT category, temp FROM tbl1
WHERE category IS NOT NULL)
SELECT c2.category, c1.brand_name FROM tbl1 c1 JOIN tbl2 c2
ON c1.temp = c2.temp;

#Option 2
with tbl_1 as (
select a.*,count(category) over (order by brand_name) as rnk from brands a
),
tbl_2 as 
(
select a.*, first_value(category) over(partition by rnk order by rnk) as brand_name_1 from tbl_1 a
)
select * from tbl_2