{{ config(materialized="table")}}

with pageviews as ( 

    select * from {{ ref('stg_web_tracking__pageviews') }}

), users as ( 

    select * from {{ ref('users') }}

)

select  pageviews.pageview_id,
        case when users.customer_id is not null 
            then first_value(pageviews.visitor_id) 
                over (partition by users.customer_id order by pageviews.created_at asc)
            else pageviews.visitor_id 
            end as visitor_id,
        users.customer_id,
        pageviews.created_at, 
        pageviews.page,
        pageviews.device_type
from pageviews 
left join users on pageviews.visitor_id = users.visitor_id