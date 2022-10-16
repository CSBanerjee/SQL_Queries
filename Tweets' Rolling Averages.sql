with tbl_1 as 
(
SELECT a.*,dense_rank() over(PARTITION BY user_id
ORDER BY tweet_date) as rnk FROM tweets a
),
tbl_2 as 
(
select user_id,tweet_date,count(distinct tweet_id) total_tweet from tbl_1
group by user_id,tweet_date),
tbl_3 as 
(select 
a.*, round(avg(total_tweet) over (PARTITION BY user_id order 
by user_id,tweet_date rows between 2 preceding and current row),2
)
FROM tbl_2 a
)
select * from tbl_3