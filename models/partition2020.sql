select
    *
from
    {{ref('joins')}}
where
    datepart(year, order_date) = 2020