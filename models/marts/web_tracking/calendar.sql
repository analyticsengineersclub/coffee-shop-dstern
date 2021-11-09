{{ config(materialized="view")}}

select *
from unnest(generate_date_array('2020-01-01', current_date, interval 1 day)) as calendar_date
order by 1