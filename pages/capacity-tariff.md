# ⛰️ Capacity tariff

```mrt_capacity_tariff
select
    month_peak_value as month_peak_value_kwh3,
    pct_change as pct_change_pct1,
    month_name,
    month_name_short,
    month_peak_12month_avg as month_peak_12month_avg_kwh3,
    month_start_date,
    month_peak_timestamp as month_peak_timestamp_hm,
    month_peak_timestamp_end as month_peak_timestamp_end_hm,
    month_peak_timestamp as month_peak_timestamp_days,
    month_peak_is_holiday,
    month_peak_day_type
from mrt_capacity_tariff
```

The capacity tariff is based on the 12-month rolling average of your monthly peak consumption. The higher your peak consumption, the higher your capacity tariff.

<Chart data={mrt_capacity_tariff} x=month_start_date title="Month peak value evolution" yAxisTitle="peak" xAxisTitle="month">
    <Bar y=month_peak_value_kwh3 />
    <Line y=month_peak_12month_avg_kwh3 name="Rolling average" />
</Chart>

```mrt_capacity_tariff_last_months
select
    *
from ${mrt_capacity_tariff}
order by month_start_date desc
limit 6
```

The current (<Value data={mrt_capacity_tariff_last_months} column=month_name_short/>) monthly peak is **<Value data={mrt_capacity_tariff_last_months} column=month_peak_value_kwh3/>**.
This peak occured between <Value data={mrt_capacity_tariff_last_months} column=month_peak_timestamp_hm/> and <Value data={mrt_capacity_tariff_last_months} column=month_peak_timestamp_end_hm/> on <Value data={mrt_capacity_tariff_last_months} column=month_peak_timestamp_days />, a {mrt_capacity_tariff_last_months[0].month_peak_is_holiday ? "holiday" : mrt_capacity_tariff_last_months[0].month_peak_day_type}.

The change over last month (<Value data={mrt_capacity_tariff_last_months} column=month_name_short row=1/>) is **<Value data={mrt_capacity_tariff_last_months} column=pct_change_pct1/>** {mrt_capacity_tariff_last_months[0].pct_change_pct1 > 0 ? "🙁" : "😃"} as we then had <Value data={mrt_capacity_tariff_last_months} column=month_peak_value_kwh3 row=1/>.
This peak occured between <Value data={mrt_capacity_tariff_last_months} column=month_peak_timestamp_hm row=1/> and <Value data={mrt_capacity_tariff_last_months} column=month_peak_timestamp_end_hm row=1/> on <Value data={mrt_capacity_tariff_last_months} column=month_peak_timestamp_days row=1/>, a {mrt_capacity_tariff_last_months[1].month_peak_is_holiday ? "holiday" : mrt_capacity_tariff_last_months[1].month_peak_day_type}.

 The average monthly peak for the last 12 months is **<Value data={mrt_capacity_tariff_last_months} column=month_peak_12month_avg_kwh3/>**.

 Here are the monthly peaks for the last 6 months:

{#each mrt_capacity_tariff_last_months as month_row}

* {month_row.month_name}: <Value data={month_row} column=month_peak_value_kwh3 />, <Value data={month_row} column=pct_change_pct1 />
{#if month_row.pct_change_pct1 > 0}
↗️ more
{:else}
↘️ less
{/if}
than the month before

{/each}
