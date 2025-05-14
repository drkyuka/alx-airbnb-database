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


## Implement the changes and report the improvements.

