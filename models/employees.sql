--Employees

with calc_employees as (
select
    first_name + ' ' + last_name as FullName,
    cast(datediff(day, birth_date, getdate()) / 365.25 as int) as age,
    datediff(year, hire_date, getdate()) as lengthofservice,
    *
from {{source('sources', 'employees')}}
)

select * from calc_employees