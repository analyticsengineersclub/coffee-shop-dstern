with source as (
    
    select * from {{source('coffee_shop','products')}}
    
),

renamed as (
    
    select
        id as product_id,

        -- timestamps
        created_at, 

        name,
        category
    
    from source

)

select * from renamed