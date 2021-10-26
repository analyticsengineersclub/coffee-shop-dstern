{{ config(materialized="table")}}

with customer_orders as (

select customer_id
      ,min(created_at) as first_order_at
      ,count(distinct order_id) as number_of_orders
from {{ ref('stg_coffee_shop__orders')}} as orders
group by 1

)

select customer_orders.customer_id   
      ,customers.name
      ,customers.email
      ,customer_orders.first_order_at
      ,customer_orders.number_of_orders
from customer_orders
left join {{ ref('stg_coffee_shop__customers')}} as customers on customers.customer_id = customer_orders.customer_id
order by first_order_at 