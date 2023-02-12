{% set min_date_query %}
  select min(from_date) from {{ ref('stg_fluvius') }}
{% endset %}
{% set max_date_query %}
  select max(to_date) from {{ ref('stg_fluvius') }}
{% endset %}
{% set min_date_val = dbt_utils.get_single_value(min_date_query) %}
{% set max_date_val = dbt_utils.get_single_value(max_date_query) %}

with date_dim as (
  {{ dbt_date.get_date_dimension(min_date_val, max_date_val) }}
),

holidays as (
  select
    holiday_date,
    true as is_holiday
  from {{ ref('stg_be_holidays') }}
),

final as (
  select
    date_dim.*,
    case when date_dim.day_of_week_iso > 5 then 'weekend' else 'weekday' end as day_type,
    case when holidays.is_holiday = true then true else false end as is_holiday
  from date_dim
  left join holidays
  on date_dim.date_day = holidays.holiday_date
  order by date_dim.date_day asc
)

select * from final
