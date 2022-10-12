with tbl1 as (
select a.*,row_number() over (order by visit_date) as rn ,
 id - row_number() over (order by visit_date) as grp
from stadium a
where no_of_people>100
),
tbl2 as 
(
select grp,count(1) from tbl1
group by grp having count(1)>=3
)
select * from tbl1 where grp = (select grp from tbl2)