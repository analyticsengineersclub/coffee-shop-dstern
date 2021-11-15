{{ config(materialized="table")}}

{% set product_categories = ["merch","coffee beans","brewing supplies"] %}

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
    date_trunc(orders.created_at, month) as order_month,

    {% for product_category in product_categories %}
    round(sum(case when products.category = '{{product_category}}' then product_prices.price end) / 100,2) as {{product_category|replace(" ","_")}}_amount,
    {% endfor %}
        
    round(sum(product_prices.price / 100),2) as total_sales,

from order_items

left join orders
    on order_items.order_id = orders.order_id

left join products
    on order_items.product_id = products.product_id

left join product_prices
  on order_items.product_id = product_prices.product_id
  and orders.created_at between product_prices.created_at and product_prices.ended_at

group by 1
order by 1