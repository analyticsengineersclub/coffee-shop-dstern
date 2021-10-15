{{ config(materialized="view")}}

select
   date_trunc(first_order_at, month) as first_order_month
  ,count(*) as count_customers
  ,sum(case when number_of_orders > 1 then 1 else 0 end) as count_repeat_customers
from {{ ref('customers')}}
group by 1
order by 1