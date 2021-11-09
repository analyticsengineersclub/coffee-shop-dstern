with source as (
    
    select * from {{source('web_tracking','pageviews')}}
    
),

renamed as (
    
    select
        id as pageview_id,
        visitor_id,
        customer_id,

        -- timestamps
        timestamp as created_at, 

        page,
        device_type
    
    from source

)

select * from renamed