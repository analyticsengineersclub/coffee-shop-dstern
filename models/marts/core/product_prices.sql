with product_prices as ( 
    select * from {{ ref('stg_coffee_shop__product_prices') }}
)
select * from product_prices