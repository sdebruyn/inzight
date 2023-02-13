with date_dim as (
  {{ dbt_date.get_date_dimension('2015-01-01', '2030-01-01') }}
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
