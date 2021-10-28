{{ config(materialized="view")}}

with pageviews as ( 

    select * from {{ ref('stg_web_tracking__pageviews') }}

),  users as ( 

    select visitor_id,
           customer_id
    from pageviews
    where customer_id is not null
    group by 1,2

)

select * from users