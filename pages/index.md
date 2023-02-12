# in⚡️ight

A simple data project using [dbt](https://getdbt.com), [DuckDB](https://duckdb.org/) and [Evidence](https://evidence.dev) to analyse your electricity data from Belgian smart meters.

Navigate through the menu on the left to analyze your electricity data.

## Quick insights

```mrt_capacity_tariff_current
select
  month_peak_12month_avg,
  pct_change as pct_change_pct2,
from mrt_capacity_tariff
order by month_start_date desc
limit 1
```

<BigValue data={mrt_capacity_tariff_current} value=month_peak_12month_avg comparison=pct_change_pct2 downIsGood=true comparisonTitle="Evolution" title="Average monthly peak (kWh)" />