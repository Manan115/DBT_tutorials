{{config(
    materialized = 'view'
)}}

Select 
    *
FROM
   {{source('source', 'fact_sales') }}