with order_items as ( 
    select * from {{ ref('stg_coffee_shop__order_items') }}
)
select * from order_items