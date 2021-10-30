{{ config(materialized="view")}}

with pageviews_sessionized as ( 

select pageview_id,
       visitor_id,
       created_at,
       case when date_diff(created_at, lag(created_at,1) over visitor_views, second) is null  or
                 date_diff(created_at, lag(created_at,1) over visitor_views, second) >= 60*30 
            then 1 
            else 0 end as is_new_session
from {{ ref('stg_web_tracking__pageviews') }}
window visitor_views as (partition by visitor_id order by created_at asc)
order by visitor_id, created_at

)

select pageview_id
      ,sum(is_new_session) over (order by visitor_id,created_at asc) as session_id
from pageviews_sessionized