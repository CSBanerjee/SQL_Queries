#find companies who have atleast 2 users who speaks English and German both the language
select company_id,count(num) num from (
select company_id,user_id,count(1) as num from  company_users
where language in ('English','German')
group by company_id,user_id
having count(1)=2
)a
where num =2
group by company_id
having num>=2