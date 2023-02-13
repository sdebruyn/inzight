with usage_data as (
    select
        from_timestamp,
        to_timestamp,
        usage
    from {{ ref('fct_electricity') }}
),

components as (
    select
        month(u.from_timestamp) as month,
        year(u.from_timestamp) as year,
        u.from_timestamp,
        u.to_timestamp,
        u.usage * 4 as quarter_power,
        dd.*
    from usage_data u
    left join {{ ref('dim_dates') }} dd
    on u.from_timestamp::date = dd.date_day
),

month_peaks as (
    select
        max(quarter_power) as month_peak,
        month,
        year
    from components
    group by month, year
),

with_avg as (
    select
        d.month as month,
        d.year as year,
        d.month_name as month_name,
        d.month_name_short as month_name_short,
        d.month_start_date as month_start_date,
        d.from_timestamp as month_peak_timestamp,
        d.to_timestamp as month_peak_timestamp_end,
        d.from_timestamp::date as month_peak_date,
        d.day_of_week_name as month_peak_day_of_week_name,
        d.day_of_month as month_peak_day_of_month,
        d.day_type as month_peak_day_type,
        d.is_holiday as month_peak_is_holiday,
        p.month_peak as month_peak_value,
        avg(p.month_peak) over (rows between 11 preceding and current row) as month_peak_12month_avg,
    from components d
    join month_peaks p
    on d.month = p.month
    and d.year = p.year
    and d.quarter_power = p.month_peak
),

final as (
    select
        *,
        (month_peak_value - lag(month_peak_value) over (order by month_start_date)) / lag(month_peak_value) over (order by month_start_date) as pct_change
    from with_avg
)

select *
from final