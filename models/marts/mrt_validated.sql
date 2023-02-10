with usage_data as (
    select
        usage,
        injection,
        validated
    from {{ ref('int_electricity') }}
),

final as (
    select
        sum(usage) as usage,
        sum(injection) as injection
    from usage_data
    where validated = false
)

select *
from final