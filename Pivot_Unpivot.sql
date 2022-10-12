select * from emp_compensation;
#pivot
select emp_id,
SUM(case when salary_component_type = 'salary' then val else NULL end) as 'Salary',
SUM(case when salary_component_type = 'bonus' then val else NULL end) as 'Bonus',
SUM(case when salary_component_type = 'hike_percent' then val else NULL end) as 'Hike_Percent'
FROM emp_compensation
GROUP BY emp_id;

#unpivot
SELECT emp_id, 'salary' as salary_component_type,salary as val from 
(select emp_id,
SUM(case when salary_component_type = 'salary' then val else NULL end) as 'Salary',
SUM(case when salary_component_type = 'bonus' then val else NULL end) as 'Bonus',
SUM(case when salary_component_type = 'hike_percent' then val else NULL end) as 'Hike_Percent'
FROM emp_compensation
GROUP BY emp_id) a
union all
SELECT emp_id, 'bonus' as salary_component_type,bonus as val from 
(select emp_id,
SUM(case when salary_component_type = 'salary' then val else NULL end) as 'Salary',
SUM(case when salary_component_type = 'bonus' then val else NULL end) as 'Bonus',
SUM(case when salary_component_type = 'hike_percent' then val else NULL end) as 'Hike_Percent'
FROM emp_compensation
GROUP BY emp_id) a
union all
SELECT emp_id, 'hike_percent' as salary_component_type,hike_percent as val from 
(select emp_id,
SUM(case when salary_component_type = 'salary' then val else NULL end) as 'Salary',
SUM(case when salary_component_type = 'bonus' then val else NULL end) as 'Bonus',
SUM(case when salary_component_type = 'hike_percent' then val else NULL end) as 'Hike_Percent'
FROM emp_compensation
GROUP BY emp_id) a



