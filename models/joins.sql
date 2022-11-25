with prod as (
    select
        ct.category_name, sp.company_name as suppliers, pr.product_name,
        pr.unit_price, pr.product_id
    from
        {{source('sources', 'products')}} pr
        left join {{source('sources', 'suppliers')}} sp
            on  pr.supplier_id = sp.supplier_id
        left join {{source('sources', 'categories')}} ct
            on  pr.category_id = ct.category_id
), orddetai as (
    select 
        pd.*, od.order_id, od.quantity, od.discount, od.total
    from    
        {{ref('orderdetails')}} od
        left join prod pd
            on  od.product_id = pd.product_id
), ordrs as (
    select  
        o.order_date, o.order_id, cs.company_name as customer, em.FullName as employee,
        em.age, em.lengthofservice
    from    
        {{source('sources', 'orders')}} o
        left join {{ref('customers')}} cs
            on  o.customer_id = cs.customer_id
        left join {{ref('employees')}} em 
            on  o.employee_id = em.employee_id
        left join {{source('sources', 'shippers')}} sh 
            on  o.ship_via = sh.shipper_id       
), finaljoin as (
    select 
        od.*, ord.order_date, ord.customer, ord.employee, ord.age, ord.lengthofservice
    from
        orddetai od
        inner join ordrs ord
            on  od.order_id = ord.order_id
)
select * from finaljoin