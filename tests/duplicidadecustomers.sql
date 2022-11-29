select
    count(1) as qtd, company_name, contact_name
from
    {{ref('customers')}}
    --{{source('sources', 'customers')}}
group by
    company_name, contact_name
having
    count(1) > 1