with tbl1 as (
select *,left(seat,1) as row_id,cast(substr(seat,2,2) as SIGNED) as seat_id from movie),
tbl2 as
(
select *,max(occupancy) over (partition by row_id order by seat_id rows between 
current row and 3 following) as is_4_following,
count(occupancy) over (partition by row_id order by seat_id rows between 
current row and 3 following) as cnt_is_4_empty from tbl1
),
tbl3 as
(
select * from tbl2
where is_4_following = 0
and cnt_is_4_empty = 4)
select * from tbl2 a
inner join tbl3 b
on a.row_id = b.row_id
and a.seat_id between b.seat_id and b.seat_id+3
