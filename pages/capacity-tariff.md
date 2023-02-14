# ⛰️ Capacity tariff

```mrt_capacity_tariff
select
    month_peak_value as month_peak_value_kwh3,
    pct_change as pct_change_pct1,
    month_name,
    month_name_short,
    year,
    month_peak_12month_avg as month_peak_12month_avg_kwh3,
    month_start_date,
    month_peak_timestamp as month_peak_timestamp_hm,
    month_peak_timestamp_end as month_peak_timestamp_end_hm,
    month_peak_timestamp as month_peak_timestamp_days,
    month_peak_is_holiday,
    month_peak_day_type,
    month_peak_part_of_day
from mrt_capacity_tariff
```

## Overview

The capacity tariff is based on the 12-month rolling average of your monthly peak consumption. The higher your peak consumption, the higher your capacity tariff.

<Chart data={mrt_capacity_tariff} x=month_start_date>
    <Bar y=month_peak_value_kwh3 />
    <Line y=month_peak_12month_avg_kwh3 name="Rolling average" />
</Chart>

```mrt_capacity_tariff_last_months
select
    *
from ${mrt_capacity_tariff}
order by month_start_date desc
limit 12
```

## Current peak

The current
(<Value data={mrt_capacity_tariff_last_months} column=month_name_short/>)
monthly peak is
**<Value data={mrt_capacity_tariff_last_months} column=month_peak_value_kwh3/>**.
This peak occured during the <Value data={mrt_capacity_tariff_last_months} column=month_peak_part_of_day />,
between <Value data={mrt_capacity_tariff_last_months} column=month_peak_timestamp_hm/>
and <Value data={mrt_capacity_tariff_last_months} column=month_peak_timestamp_end_hm/>,
on <Value data={mrt_capacity_tariff_last_months} column=month_peak_timestamp_days />,
a
{mrt_capacity_tariff_last_months[0].month_peak_is_holiday ? "holiday" : mrt_capacity_tariff_last_months[0].month_peak_day_type}.

The change over last month
(<Value data={mrt_capacity_tariff_last_months} column=month_name_short row=1/>)
is
**<Value data={mrt_capacity_tariff_last_months} column=pct_change_pct1/>**
{mrt_capacity_tariff_last_months[0].pct_change_pct1 > 0 ? "🙁" : "😃"}
as we then had <Value data={mrt_capacity_tariff_last_months} column=month_peak_value_kwh3 row=1/>.
This previous peak occured during the <Value data={mrt_capacity_tariff_last_months} column=month_peak_part_of_day row=1 />,
between <Value data={mrt_capacity_tariff_last_months} column=month_peak_timestamp_hm row=1/>
and <Value data={mrt_capacity_tariff_last_months} column=month_peak_timestamp_end_hm row=1/>,
on <Value data={mrt_capacity_tariff_last_months} column=month_peak_timestamp_days row=1/>,
a
{mrt_capacity_tariff_last_months[1].month_peak_is_holiday ? "holiday" : mrt_capacity_tariff_last_months[1].month_peak_day_type}.

## Average peak

 The average monthly peak for the past 12 months is
 **<Value data={mrt_capacity_tariff_last_months} column=month_peak_12month_avg_kwh3/>**.

 💸 This is the actual value used to calculate your capacity tariff.

 ## History

 ```mrt_capacity_tariff_part_of_day
 select
    month_peak_part_of_day,
    count(*) as count
from ${mrt_capacity_tariff_last_months}
group by month_peak_part_of_day
order by count desc
 ```

In the past 12 months, most of the peaks occured during the **<Value data={mrt_capacity_tariff_part_of_day} column=month_peak_part_of_day />**.

<BarChart
    data={mrt_capacity_tariff_part_of_day}
    x=month_peak_part_of_day
    y=count
    swapXY=true
/>

Here are the monthly peaks for the past 12 months:

{#each mrt_capacity_tariff_last_months as month_row}

* **{month_row.month_name} {month_row.year}**: <Value data={month_row} column=month_peak_value_kwh3 /> on <Value data={month_row} column=month_peak_timestamp_days /> between <Value data={month_row} column=month_peak_timestamp_hm /> and <Value data={month_row} column=month_peak_timestamp_end_hm />
<br/>
<Value data={month_row} column=pct_change_pct1 />
{#if month_row.pct_change_pct1 > 0}
↗️ more
{:else}
↘️ less
{/if}
than the month before

{/each}
