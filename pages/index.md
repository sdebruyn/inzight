# in⚡️ight

A simple data project using [dbt](https://getdbt.com), [DuckDB](https://duckdb.org/) and [Evidence](https://evidence.dev) to analyse your electricity data from Belgian smart meters.

Navigate through the menu on the left to analyze your electricity data.

## Quick in⚡️ights

```mrt_capacity_tariff_current
select
  month_peak_12month_avg as month_peak_12month_avg_kwh3,
  pct_change as pct_change_pct2,
from mrt_capacity_tariff
order by month_start_date desc
limit 1
```

<BigValue data={mrt_capacity_tariff_current} value=month_peak_12month_avg_kwh3 comparison=pct_change_pct2 downIsGood=true comparisonTitle="current peak vs. last month" title="Average monthly peak" />