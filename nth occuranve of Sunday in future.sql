#Write a query to provide the date for nth occuranve of Sunday in future from given date

set @today_date = '2022-09-03';
set @n = 3;
set @a = 6 - weekday(@today_date);

SELECT DATE_ADD(DATE_ADD(@today_date , INTERVAL @a DAY),INTERVAL @n-1 WEEK)