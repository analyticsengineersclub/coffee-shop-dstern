{{ config(materialized="table")}}

with orders as (

    select * from {{ ref('orders')}}

),   calendar as ( 

    select distinct date(date_trunc(calendar_date,week)) as calendar_week
    from  {{ ref('calendar')}}
    

),   customer_totals_by_week as ( 

    select
        customer_id,
        date(date_trunc(created_at, week)) as order_week,
        sum(total) as revenue

    from orders
    group by 1, 2
    order by 1, 2

), customer_acquistion as ( 

    select customer_id,
           min(order_week) as first_order_week
    from customer_totals_by_week
    group by 1

), customer_weeks as ( 

    select customer_acquistion.customer_id,
           calendar.calendar_week
        
    from customer_acquistion
    cross join  calendar
    where customer_acquistion.first_order_week <= calendar.calendar_week 
    order by calendar.calendar_week

)

    select customer_weeks.customer_id,  
           customer_weeks.calendar_week,
           rank() over by_customer as customer_week,
           coalesce(customer_totals_by_week.revenue,0) as revenue,
           sum(customer_totals_by_week.revenue)  over by_customer as cumulative_revenue
    from customer_weeks
    left join customer_totals_by_week 
        on customer_totals_by_week.customer_id = customer_weeks.customer_id
        and customer_totals_by_week.order_week = customer_weeks.calendar_week
    window by_customer as (partition by customer_weeks.customer_id order by customer_weeks.calendar_week)
    order by 1,2