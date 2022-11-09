with tbl_1 as (
select a.*, row_number() over(order by visit_date) as Id_1,
id - row_number() over(order by visit_date) as grp
 from stadium a
where no_of_people>100
)
select * from tbl_1
where grp=2