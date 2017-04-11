+++
date = "2017-04-10T19:42:23-07:00"
title = "profiling with performance schema of mysql"
draft = true

+++

MySQL has performance schema, which records performnce metrics. When
enabling, it causes some overhead depends on your workload. But it's an
userful tool with lots of metric.

The easiest metrics we can get out of it is how much time spending on
runing query. This metrics is great because it's the exact time MySQL
execute query without taking into account of network latency when we do
the benchmark from the app.

The table *events_statements_history* and
*events_statements_history_long* contains information about query
duration.

The time is in `pico seconds` which needs to be converted into `ms` 
like this:


```
SELECT  EVENT_ID, TRUNCATE(TIMER_WAIT/1000000000,6) as Duration_MS, SQL_TEXT
  FROM events_statements_history
  WHERE sql_text like "%pattern-for-query-we-want-to-profile%";
```

The table `events_statements_history_long` has slow query log. Only
analyze this table already give us lots of userful hindsight.

Another useful table is `table_io_waits_summary_by_index_usage` which
gives information of index usage
