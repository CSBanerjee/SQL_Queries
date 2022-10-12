#Write a sql query to get the list of all students who scored above the average marks in each subject
with tbl_1 as (
select a.*,avg(marks) over (partition by subject) as avg_marks from students_test_table a
),
tbl_2 as
(select a.*, case when marks>avg_marks then 'a' else 'b' end as fltr from tbl_1 a)
select * from tbl_2
where fltr='a';

#Write a sql query to get the percentage of students who score more than 90 in any subject among the total student
select 
(select count(distinct studentid) as more_than_90 from students_test_table where marks>90)
/ (select count(distinct studentid) from students_test_table) as percent_of_total
;
#Write a sql query to get the second highest and second lowest marks for each subject
with tbl_1 as 
(
select subject,marks,dense_rank() over (partition by subject order by marks desc) as rnk from students_test_table a
),
tbl_2 as 
(
select subject,marks,dense_rank() over (partition by subject order by marks asc) as rnk from students_test_table a
),
tbl_3 as
(
select a.subject,a.marks as second_highest,b.marks as second_lowest from tbl_1 a
left join tbl_2 b 
on a.subject = b.subject
where a.rnk = 2
and b.rnk = 2
)
select * from tbl_3;

# For each student and test, identify if their marks increased or decreased from previous test

select a.*, case when marks>previous_marks then 'inc' else 'dec' end as status from (
select *,lag(marks,1) over (partition by studentid order by testdate,subject) as previous_marks 
from students_test_table) a;

