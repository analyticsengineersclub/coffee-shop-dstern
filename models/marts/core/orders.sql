with orders as ( 
    select * from {{ ref('stg_coffee_shop__orders') }}
)
select * from orders