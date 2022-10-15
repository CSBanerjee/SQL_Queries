select aa.employee_id,aa.salary,(case when salary> 2*thrshold then 
'Overpaid' when salary <thrshold/2 then 'Underpaid' else null end) as 
status from 
(SELECT a.*, avg(salary) over (partition by title order by title )
 as thrshold FROM employee_pay a) aa
 where (case when salary> 2*thrshold then 
'Overpaid' when salary <thrshold/2 then 'Underpaid' else null end) is not null
 
 