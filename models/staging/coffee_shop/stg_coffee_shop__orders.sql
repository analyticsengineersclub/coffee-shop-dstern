with source as (
    
    select * from {{source('coffee_shop','orders')}}
    
),

renamed as (
    
    select
        id as order_id,
        customer_id,

        -- timestamps
        created_at, 

        total,
        address,
        state,
        zip
    
    from source

)

select * from renamed