with tbl_1 as (
select exam_id,min(score) as min_score,max(score) as max_score from exams
group by exam_id),
tbl_2 as
(
select a.*,b.student_id as top,c.student_id as bottom from tbl_1 a
left join exams b on 
a.exam_id = b.exam_id
and 
a.max_score = b.score
left join exams c on
a.exam_id = c.exam_id
and 
a.min_score = c.score 
),
tbl_3 as
(
select a.*,b.min_score,b.max_score,(case when a.score>b.min_score and a.score<b.max_score then 'mid' else 'other'end) mid_point from exams a
left join tbl_2 b 
on a. exam_id = b.exam_id
)
select * from tbl_3
where mid_point = 'mid';
