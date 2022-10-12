#write a SQL to build a team with a combination of seniors and juniors within a given salary budget of 70000

with tbl1 as (
select a.*,sum(salary) over (order by emp_id) as running_total from candidates a
where experience = 'Senior'
),
tbl2 as
(
select a.*, (case when running_total<70000 then 'yes' else 'no' end) as flag from tbl1 a
),
tbl3 as
(
select a.*,sum(salary) over (order by emp_id) as running_total from candidates a
where experience = 'Junior'
 
),
tbl4 as
(
select * from tbl3
where running_total <= (select max(running_total) from tbl2 where flag = 'yes')
),
tbl_final as
(
select emp_id,experience,salary from tbl2 where flag = 'yes'
union
select emp_id,experience,salary from tbl4

)
select * from tbl_final
order by emp_id