{{ config(materialized="view")}}

{{ config(materialized="view")}}

with pageviews as ( 

    select * from {{ ref('pageviews') }}

)

select session_id,
       min(created_at) as session_start_at,
       max(created_at) as session_ended_at,
       count(*) as count_pages_visited,
       date_diff(max(created_at),min(created_at), second) as session_duration_seconds,
       max(case when page = 'order-confirmation' then 1 else 0 end) = 1 as has_order_confirmation
from pageviews
group by 1
