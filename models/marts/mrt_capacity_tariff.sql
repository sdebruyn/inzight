with usage_data as (
    select
        from_timestamp,
        usage
    from {{ ref('int_electricity') }}
),

components as (
    select
        month(from_timestamp) as month,
        year(from_timestamp) as year,
        from_timestamp,
        usage * 4 as quarter_power
    from usage_data
),

month_peaks as (
    select
        max(quarter_power) as month_peak,
        month,
        year
    from components
    group by month, year
),

final as (
    select
        components.month as month,
        components.year as year,
        components.from_timestamp as month_peak_moment,
        month_peaks.month_peak as month_peak_value,
        avg(month_peaks.month_peak) over (rows between 11 preceding and current row) as month_peak_12month_avg
    from components
    join month_peaks
    on components.month = month_peaks.month
    and components.year = month_peaks.year
    and components.quarter_power = month_peaks.month_peak
)

select *
from final