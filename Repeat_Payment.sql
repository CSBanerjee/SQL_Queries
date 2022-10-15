#Using the transactions table, identify any payments made at the same merchant with the same credit card for the same amount within 10 minutes of each other. Count such repeated payments.



with tbl_1 as (
SELECT transaction_id,merchant_id,credit_card_id,
amount,lag(amount,1) over (partition by merchant_id,
credit_card_id,amount
order by merchant_id) as previous_transaction,transaction_timestamp,
lag(transaction_timestamp,1) over (partition by merchant_id,
credit_card_id,amount
order by merchant_id) as previous_timestamp
FROM transactions),
tbl_2 as (
select a.*, EXTRACT(EPOCH from
(transaction_timestamp - previous_timestamp))/60 time_diff
from tbl_1 a
where previous_timestamp is not null
)
select count((merchant_id)) from tbl_2 where time_diff<=10
