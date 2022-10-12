with tbl1 as (
select dep_name,emp_name,salary,row_number() over (partition by dep_name order by salary) as rnk
,count(1) over  (partition by dep_name) as rnk_1
 from emp
)
select * from tbl1
where rnk=3 or (rnk_1<3 and rnk=rnk_1)