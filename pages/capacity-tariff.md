# ⛰️ Capacity tariff

```mrt_capacity_tariff
select
    month_peak_value,
    pct_change as pct_change_pct1,
    month_name,
    month_name_short,
    month_peak_12month_avg,
    month_start_date
from mrt_capacity_tariff
```

The capacity tariff is based on the 12-month rolling average of your monthly peak consumption. The higher your peak consumption, the higher your capacity tariff.

<Chart data={mrt_capacity_tariff} x=month_start_date title="Month peak value evolution" yAxisTitle="kWh" xAxisTitle="month">
    <Bar y=month_peak_value />
    <Line y=month_peak_12month_avg name="Rolling average" />
</Chart>

```mrt_capacity_tariff_last_months
select
    *
from ${mrt_capacity_tariff}
order by month_start_date desc
limit 4
```

The current (<Value data={mrt_capacity_tariff_last_months} column=month_name_short/>) monthly peak is **<Value data={mrt_capacity_tariff_last_months} column=month_peak_value/> kWh**. The change over last month (<Value data={mrt_capacity_tariff_last_months} column=month_name_short row=1/>) is **<Value data={mrt_capacity_tariff_last_months} column=pct_change_pct1/>** as we then had <Value data={mrt_capacity_tariff_last_months} column=month_peak_value row=1/> kWh.

 The average monthly peak for the last 12 months is **<Value data={mrt_capacity_tariff_last_months} column=month_peak_12month_avg/> kWh**.

 Here are the monthly peaks for the last 4 months:

{#each mrt_capacity_tariff_last_months as month_row}

* {month_row.month_name}: {month_row.month_peak_value} kWh, <Value data={month_row} column=pct_change_pct1 />
{#if month_row.pct_change_pct1 > 0}
↗️ more
{:else}
↘️ less
{/if}
than the month before

{/each}
