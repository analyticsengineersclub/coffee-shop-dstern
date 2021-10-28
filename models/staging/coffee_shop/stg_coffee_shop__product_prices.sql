with source as (
    
    select * from {{source('coffee_shop','product_prices')}}
    
),

renamed as (
    
    select
        id as product_price_id,
        product_id,

        -- timestamps
        created_at, 
        ended_at,

        price
    
    from source

)

select * from renamed