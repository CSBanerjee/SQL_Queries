with tbl1 as
(
select *,lag(status,1,status) over (order by event_time asc) as prev_status
from event_status),
tbl2 as
(
select a.*, sum(case when status='on' and prev_status='off' then 1 else 0 end)
over (order by event_time) as group_key from tbl1 a
)
select min(event_time) as log_in_time,max(event_time) as log_out_time,
count(1)-1 as total_time from tbl2
group by group_key