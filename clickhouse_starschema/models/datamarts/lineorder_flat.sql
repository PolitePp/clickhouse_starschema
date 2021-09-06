{{
    config (
      materialized='table',
      engine='MergeTree()',
      order_by=['LO_ORDERDATE', 'LO_ORDERKEY'],
      partition_by='toYear(LO_ORDERDATE)'
    )
}}

SELECT
    MD5(coalesce(cast(LO_CUSTKEY as String), '') || '-'
                 || coalesce(cast(C_CUSTKEY as String), '') || '-'
                 || coalesce(cast(S_SUPPKEY as String), '')) as hash_pk
    ,{{ dbt_utils.star(source('dbgen', 'lineorder')) }}
    ,{{ dbt_utils.star(source('dbgen', 'customer')) }}
    ,{{ dbt_utils.star(source('dbgen', 'supplier')) }}
    ,{{ dbt_utils.star(source('dbgen', 'part')) }}

FROM {{ source('dbgen', 'lineorder') }} AS l
INNER JOIN {{ source('dbgen', 'customer') }} AS c ON c.C_CUSTKEY = l.LO_CUSTKEY
INNER JOIN {{ source('dbgen', 'supplier') }} AS s ON s.S_SUPPKEY = l.LO_SUPPKEY
INNER JOIN {{ source('dbgen', 'part') }} AS p ON p.P_PARTKEY = l.LO_PARTKEY