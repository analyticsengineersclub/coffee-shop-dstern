{{ config(materialized="table")}}

with customer_orders as (

select customer_id
      ,min(created_at) as first_order_at
      ,count(distinct id) as number_of_orders
from `analytics-engineers-club.coffee_shop.orders` as orders
group by 1

)

select customer_orders.customer_id   
      ,customers.name
      ,customers.email
      ,customer_orders.first_order_at
      ,customer_orders.number_of_orders
from customer_orders
left join `analytics-engineers-club.coffee_shop.customers` as customers on customers.id = customer_orders.customer_id
order by first_order_at 