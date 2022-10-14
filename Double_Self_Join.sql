#Double Self Join
with tbl_1 as (
select distinct e.emp_id,e.emp_name,e.manager_id,m.emp_name as manager_name,m.manager_id as sm_id from emp_1 e
left join emp_1 m
on e.manager_id = m.emp_id
),
tbl_2 as
(
select a.*,s.emp_name as sm_name from tbl_1 a
left join emp_1 s
on a.sm_id = s.emp_id
)
select * from tbl_2