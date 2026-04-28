with dedup_query as (
select *,ROW_NUMBER() over (partition by id order by updateDate desc) as deduplication_id from {{ source('source', 'items') }}
)
select id,name,category,updateDate from dedup_query
where 
deduplication_id = 1