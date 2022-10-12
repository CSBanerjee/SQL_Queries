select * from players_location;

select
max(case when city='Bangalore' then name end) as Bangalore,
max(case when city='Mumbai' then name end) as Mumbai,
max(case when city='Delhi' then name end) as Delhi from (
select *, row_number() over (partition by city order by name asc) as player_groups
from players_location) a
group by player_groups