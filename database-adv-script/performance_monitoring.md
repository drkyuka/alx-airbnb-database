# 6. Monitor and Refine Database Performance

## Objective: Continuously monitor and refine database performance by analyzing query execution plans and making schema adjustments.

## Instructions:

## Use SQL commands like SHOW PROFILE or EXPLAIN ANALYZE to monitor the performance of a few of your frequently used queries.
I ran the following commands
```
SET SESSION profiling = 1;
SELECT Payment.payment_id,
       Payment.amount,
       Payment.payment_date
    FROM `Payment`
    WHERE Payment.payment_date >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH);
```

To profile the queries, i ran the command
```
SHOW PROFILES;
```

To examine the details of the query, I ran the command:
```
-- Query to show execution time for query 6
SELECT *
    FROM information_schema.PROFILING
    WHERE QUERY_ID = 6;
```

| QUERY | SEQ | STATE                      | DURATION (s) | CPU\_USER (s) | CPU\_SYSTEM (s) |
| ----- | --- | -------------------------- | ------------ | ------------- | --------------- |
| 6     | 2   | starting                   | 0.003321     | 0.002559      | 0.000000        |
| 6     | 3   | Executing hook on transac  | 0.000048     | 0.000036      | 0.000000        |
| 6     | 4   | starting                   | 0.000152     | 0.000152      | 0.000000        |
| 6     | 5   | checking permissions       | 0.000088     | 0.000087      | 0.000000        |
| 6     | 6   | Opening tables             | 0.006240     | 0.006264      | 0.000000        |
| 6     | 7   | init                       | 0.000047     | 0.000024      | 0.000000        |
| 6     | 8   | System lock                | 0.000090     | 0.000087      | 0.000000        |
| 6     | 9   | optimizing                 | 0.000071     | 0.000071      | 0.000000        |
| 6     | 10  | statistics                 | 0.000126     | 0.000128      | 0.000000        |
| 6     | 11  | preparing                  | 0.000180     | 0.000206      | 0.000000        |
| 6     | 12  | executing                  | 0.000394     | 0.000396      | 0.000000        |
| 6     | 13  | end                        | 0.000026     | 0.000023      | 0.000000        |
| 6     | 14  | query end                  | 0.000019     | 0.000019      | 0.000000        |
| 6     | 15  | waiting for handler commit | 0.000086     | 0.000088      | 0.000000        |
| 6     | 16  | closing tables             | 0.000044     | 0.000044      | 0.000000        |
| 6     | 17  | freeing items              | 0.000238     | 0.000239      | 0.000000        |
| 6     | 18  | cleaning up                | 0.000206     | 0.000206      | 0.000000        |

## Identify any bottlenecks and suggest changes (e.g., new indexes, schema adjustments).
### Summary of the states

| Seq | State                      | Duration (s) | CPU User (s) | Notes                                                         |
| --- | -------------------------- | ------------ | ------------ | ------------------------------------------------------------- |
| 2   | starting                   | 0.003321     | 0.002559     | Longer-than-average init state                                |
| 3   | Executing hook on transac  | 0.000048     | 0.000036     | Negligible                                                    |
| 4   | starting                   | 0.000152     | 0.000152     | Fast                                                          |
| 5   | checking permissions       | 0.000088     | 0.000087     | Fast                                                          |
| 6   | Opening tables             | 0.006240     | 0.006264     | ⚠️ Highest duration — possible I/O or metadata access issue   |
| 7   | init                       | 0.000047     | 0.000024     | Fast                                                          |
| 8   | System lock                | 0.000090     | 0.000087     | Acceptable                                                    |
| 9   | optimizing                 | 0.000071     | 0.000071     | Acceptable                                                    |
| 10  | statistics                 | 0.000126     | 0.000128     | Slightly high — may suggest indexing optimization needed      |
| 11  | preparing                  | 0.000180     | 0.000206     | Acceptable                                                    |
| 12  | executing                  | 0.000394     | 0.000396     | ⚠️ Slightly high for this phase                               |
| 13  | end                        | 0.000026     | 0.000023     | Fast                                                          |
| 14  | query end                  | 0.000019     | 0.000019     | Fast                                                          |
| 15  | waiting for handler commit | 0.000086     | 0.000088     | Minor delay                                                   |
| 16  | closing tables             | 0.000044     | 0.000044     | Negligible                                                    |
| 17  | freeing items              | 0.000238     | 0.000239     | ⚠️ Higher than normal — cleanup cost                          |
| 18  | cleaning up                | 0.000206     | 0.000206     | ⚠️ Higher than expected — could suggest resource usage issues |

### key bottlenecks
in summary, the key bottlenecks are summarized as follows:
| STATE                       | DURATION (s)      | Remarks                                                                             |
| --------------------------- | ----------------- | ----------------------------------------------------------------------------------- |
| Opening tables              | 0.006240          | Highest time spent, indicates possible I/O bottleneck or lack of table/index cache. |
| starting                    | 0.003321          | Initial overhead; not critical but could be due to cold cache.                      |
| executing                   | 0.000394          | Actual row retrieval; reasonable.                                                   |
| freeing items & cleaning up | \~0.0004 combined | Minor impact, normal cleanup.                                                       |


## Implement the changes and report the improvements.

### Query improvement
- To improve filtering and reduce time of `opening tables` and `executing`, it is important to index.
- To improve caching and execution plan stability, use a fixed date as '2024-05-21' in the query to avoid function execution for every row.

### Revised query
the revised query is as follows:

```
CREATE INDEX idx_payment_date ON Payment(payment_date);
ANALYZE TABLE Payment;
SELECT P.payment_id,
       P.amount,
       P.payment_date
    FROM `Payment` P 
    WHERE P.payment_date >= '2024-05-14';
```

### Result
the changes made notably improved the performance of the query between 10-40% as shown in the table below.

| Metric / State        | Previous Execution (Query 6) | Latest Execution (Query 4) | Δ (Difference)              |
| --------------------- | ---------------------------- | -------------------------- | --------------------------- |
| Total Duration        | 0.013875 sec                 | 0.005741 sec               | ⬇️ Faster by 0.008134 sec   |
| Opening tables        | 0.006240                     | 0.001725                   | ⬇️ Significant reduction    |
| Starting (initial)    | 0.003321                     | 0.001337                   | ⬇️ Reduced startup overhead |
| Executing             | 0.000394                     | 0.000103                   | ⬇️ More efficient execution |
| Cleaning up           | 0.000206                     | 0.000188                   | ⬇️ Slight improvement       |
| Freeing items         | 0.000238                     | 0.000159                   | ⬇️ Reduced cleanup          |
| CPU Time (User) Total | \~0.0129                     | \~0.0052                   | ⬇️ Nearly 60% less CPU      |
