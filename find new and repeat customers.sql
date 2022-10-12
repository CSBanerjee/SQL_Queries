/*
create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);
select * from customer_orders;
insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)
;
*/

with tbl1 as (
select customer_id,min(order_date) as first_date  from customer_orders
group by customer_id
),
tbl2 as
(
select a.*,b.first_date,(case when order_date = first_date then "New_C" else "Return_C" end) cust_type from customer_orders a
left join tbl1 b on
a.customer_id =b.customer_id
)
select order_date,coalesce(sum(case when cust_type ="New_C" THEN 1 END),0) AS new_c, 
coalesce(SUM(case when cust_type ="Return_C" THEN 1 END),0) AS Return_C from tbl2
GROUP BY order_date
;