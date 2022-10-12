with tbl_1 as (
select company,avg(salary) avg_salary from (
select a.*,
row_number() over (partition by company order by salary) as rn,
count(1) over (partition by company) as cnt
 from employee a
order by company,salary) a
where rn between cnt*1.0/2 and cnt*1.0/2+1
group by company)
select a.*,b.avg_salary from employee a
inner join tbl_1 b on 
a.company = b.company