/* 
create table tickets
(
ticket_id varchar(10),
create_date date,
resolved_date date
);
delete from tickets;
insert into tickets values
(1,'2022-08-01','2022-08-03')
,(2,'2022-08-01','2022-08-12')
,(3,'2022-08-01','2022-08-16');
create table holidays
(
holiday_date date
,reason varchar(100)
);
delete from holidays;
insert into holidays values
('2022-08-11','Rakhi'),('2022-08-15','Independence day');
*/
with tbl_1 as 
(
select * from tickets
left join holidays on holiday_date between create_date and resolved_date
),
tbl_2 as 
(
select ticket_id,create_date,resolved_date,count(holiday_date) holiday_date from tbl_1 
group by ticket_id,create_date,resolved_date
),
tbl_3 as 
(
select *,datediff(resolved_date,create_date) - 
2*floor(datediff(resolved_date,create_date)/7) 
as business_days from tbl_2 -- one week has sat and sun total 2 days off.
),
tbl_4 as 
(
select ticket_id, create_date,resolved_date,( business_days - holiday_date) as business_days
from tbl_3
)
select * from tbl_4