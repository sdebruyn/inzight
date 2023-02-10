with usage_data as (
    select
        from_timestamp,
        to_timestamp,
        tariff,
        usage,
        injection,
        validated
    from {{ ref('int_electricity') }}
),

final as (
    select *
    from usage_data
)

select *
from final