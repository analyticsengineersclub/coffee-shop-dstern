{{ config(materialized="table")}}

with order_items as ( 
    
    select * from {{ ref('order_items')}}

),   orders as (

    select * from {{ ref('orders')}}

),   products as ( 

    select * from {{ ref('products')}}

),   product_prices as (

    select * from {{ ref('product_prices')}}

)

select
    date_trunc(orders.created_at, week) as order_week_start,
    products.category,
    
    round(sum(product_prices.price / 100),2) as total_sales

from order_items

left join orders
    on order_items.order_id = orders.order_id

left join products
    on order_items.product_id = products.product_id

left join product_prices
  on order_items.product_id = product_prices.product_id
  and orders.created_at between product_prices.created_at and product_prices.ended_at

group by 1, 2
order by 1, 2