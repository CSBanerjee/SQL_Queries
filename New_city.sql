select ops_year,count(distinct city_id) as new_city from (
select city_id, min(year(business_date)) as ops_year from business_city
group by city_id
) a
group by ops_year