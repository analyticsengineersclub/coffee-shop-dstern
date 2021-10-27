{{ config(materialized="table")}}

with pageviews as ( 

    select * from {{ ref('stg_web_tracking__pageviews') }}

), users as ( 

    select * from {{ ref('users') }}

)

select  pageviews.pageview_id,
        pageviews.visitor_id,
        users.customer_id,
        pageviews.created_at, 
        pageviews.page,
        pageviews.device_type
from pageviews 
left join users on pageviews.visitor_id = users.visitor_id