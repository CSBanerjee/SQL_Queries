/* Input Table 
create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');
*/
with tbl1 as
(
select team_1 from icc_world_cup
union all 
select team_2 from icc_world_cup
),
tbl_2 as (
select team_1 as team_name,count(1) as no_of_matches_played from tbl1
group by team_1),
tbl_3 as (
select Winner,count(1) as no_of_wins from icc_world_cup
group by Winner
)
select a.team_name,
a.no_of_matches_played,
COALESCE(b.no_of_wins,0) as no_of_wins,
(a.no_of_matches_played-COALESCE(b.no_of_wins,0)) as no_of_losses,
COALESCE(b.no_of_wins,0)* a.no_of_matches_played as 'total_points'
from tbl_2 a
left join tbl_3 b
on a.team_name = b.Winner
order by COALESCE(b.no_of_wins,0) * a.no_of_matches_played desc;

