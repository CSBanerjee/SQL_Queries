with tbl1 as (
select call_number from call_details
where call_type = 'OUT'
union select call_number from call_details
where call_type = 'INC'
),
tbl2 as 
(
select * from call_details where call_number in (select call_number from tbl1)
),
tbl3 as
(
select call_number,call_type,sum(call_duration) call_duration from tbl2
group by call_number,call_type
),
tbl4 as
(
select a.call_number,a.call_duration as out_time,b.call_duration as in_time from 
(select * from tbl3 where call_type = 'INC') a
inner join (select * from tbl3 where call_type = 'OUT') b
on a.call_number = b.call_number
)
select call_number from tbl4 where out_time > in_time