with tbl_1 as 
(
SELECT  measurement_id,
measurement_value,
cast(measurement_time as DATE) as measurement_day,
ROW_NUMBER() over (partition by CAST(measurement_time AS DATE) 
      ORDER BY measurement_time) as rnk,
measurement_time
FROM measurements),
tbl_2 as 
(
select a.*, case when rnk%2=0 then 'even' else 'odd' end as odd_even
from tbl_1 a
),
tbl_3 as 
(
select odd_even,measurement_day,sum(measurement_value) as total
from tbl_2 
group by odd_even,measurement_day
order by measurement_day
),tbl_4 as 
(
select measurement_day,
case when odd_even = 'odd' then total end as odd_sum  ,
case when odd_even = 'even' then total end as even_sum  
from tbl_3)
select measurement_day,sum(odd_sum) odd_sum,
sum(even_sum) as even_sum from tbl_4
group by measurement_day