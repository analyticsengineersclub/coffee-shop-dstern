with source as (
    
    select * from {{source('coffee_shop','customers')}}
    
),

renamed as (
    
    select
        id as customer_id,
        email,
        name
    
    from source

)

select * from renamed