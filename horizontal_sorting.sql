with tbl_1 as (
select a.*,
case when sender<receiver then sender else receiver end as p1,
case when sender>receiver then sender else receiver end as p2
from subscriber a),
tbl_2 as
(
select p1,p2,sum(sms_no) from tbl_1
group by  p1,p2
)
select * from tbl_2;