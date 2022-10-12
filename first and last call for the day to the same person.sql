with tbl1 as (
select Callerid,cast(Datecalled as date) date_called,min(Datecalled) as first_call,max(Datecalled) as last_call from phonelog
group by Callerid,cast(Datecalled as date)
),
tbl2 as (
select a.*,b.Recipientid as first_Recipientid,c.Recipientid as last_Recipientid from tbl1 a
left join phonelog b 
on a.Callerid = b.Callerid
and a.first_call = b.Datecalled
left join phonelog c
on a.Callerid = c.Callerid
and a.last_call = c.Datecalled)
select * from tbl2
where first_Recipientid = last_Recipientid;


