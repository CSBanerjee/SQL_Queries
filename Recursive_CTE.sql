
with recursive r_cte as (
select min(period_start) dates,max(period_end) as max_date from sales
union all 
select date_add(dates,interval 1 day) as dates,max_date from r_cte
where dates < max_date
),
tbl_2 as 
(
select * from r_cte inner join sales on dates between period_start and period_end 
order by product_id,dates
)
select product_id,year(dates) as report_year,sum(average_daily_sales) as total_amount from tbl_2
group by product_id,year(dates)
order by product_id,year(dates)
