/*
create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR')
*/

with tbl1 as
(
select name,floor, count(1) as most_visited_floor, rank() over (partition by name order by count(1) desc)  as rnk
from entries
group by name,floor
),
tbl2 as
(
select a.name,count(1) as total_visit, GROUP_CONCAT(distinct a.resources) as resorces_used from entries a 
group by a.name
),
tbl3 as
(
select a.name,b.total_visit,a.floor as most_visited_floor,b.resorces_used from tbl1 a
left join tbl2 b
on a.name = b.name
where a.rnk=1
)
select * from tbl3
