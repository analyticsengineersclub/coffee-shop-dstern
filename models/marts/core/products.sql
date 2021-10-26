with products as ( 
    select * from {{ ref('stg_coffee_shop__products') }}
)
select * from products