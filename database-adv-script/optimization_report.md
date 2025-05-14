# Refactor complex queries to improve performance.

## Analyze the query’s performance using EXPLAIN and identify any inefficiencies.

Result of running the command
```
EXPLAIN ANALYZE
    SELECT *
        FROM `Booking`
        INNER JOIN `User`
        ON `Booking`.`user_id` = `User`.`user_id`
        INNER JOIN `Property`
        ON `Booking`.`property_id` = `Property`.`property_id`
        INNER JOIN `Payment`
        ON `Booking`.`booking_id` = `Payment`.`booking_id`;
```

gives the output

> -> Nested loop inner join  (cost=8.3 rows=7) (actual time=0.> 471..0.534 rows=7 loops=1)
>     -> Nested loop inner join  (cost=5.85 rows=7) (actual time=0.432..0.466 rows=7 loops=1)
>         -> Nested loop inner join  (cost=3.4 rows=7) (actual time=0.395..0.418 rows=7 loops=1)
>             -> Filter: (Payment.booking_id is not null)  (cost=0.95 rows=7) (actual time=0.265..0.27 rows=7 loops=1)
>                 -> Table scan on Payment  (cost=0.95 rows=7) (actual time=0.259..0.264 rows=7 loops=1)
>             -> Filter: ((Booking.property_id is not null) and (Booking.user_id is not null))  (cost=0.264 rows=1) (actual time=0.0181..0.0181 rows=1 loops=7)
>                 -> Single-row index lookup on Booking using PRIMARY (booking_id = Payment.booking_id)  (cost=0.264 rows=1) (actual time=0.0137..0.0138 rows=1 loops=7)
>         -> Single-row index lookup on Property using PRIMARY (property_id = Booking.property_id)  (cost=0.264 rows=1) (actual time=0.00673..0.00675 rows=1 loops=7)
>     -> Single-row index lookup on User using PRIMARY (user_id = Booking.user_id)  (cost=0.264 rows=1) (actual time=0.00806..0.00809 rows=1 loops=7)


## Analyze the query’s performance using EXPLAIN and identify any inefficiencies

### summary

| Step            | Operation                | Strategy          | Actual Time (per loop) | Efficiency         |
| --------------- | ------------------------ | ----------------- | ---------------------- | ------------------ |
| Payment         | Full Table Scan + Filter | Table scan        | 0.273–0.307 ms         | Good (small table) |
| Booking Lookup  | Index on `booking_id`    | Primary Key Index | \~0.013 ms             | Excellent          |
| Property Lookup | Index on `property_id`   | Primary Key Index | \~0.0034 ms            | Excellent          |
| User Lookup     | Index on `user_id`       | Primary Key Index | \~0.0024 ms            | Excellent          |

### comments
- while the query was fast, there are rooms for improvement

## Refactor the query to reduce execution time, such as reducing unnecessary joins or using indexing

### improvements
- instead of retrieving all fields from the booking, property, payment and user tables, only selected fields are defined
- replaced `LEFT JOIN` with `INNER JOIN` for filter null fields
- created index field on `Payment`.`booking_id` as foreign key to the `Booking` table to improve search performance
- rearrange inner join search from `Booking` -> `Property` -> `Payment` -> `User`

### Refactored SQL query
the new command is as follows:

```
-- optimise search on booking payments with indexing
CREATE INDEX `booking_payment` ON `Payment` (`booking_id`);

-- refactored sql query
EXPLAIN ANALYZE
    SELECT  B.booking_id,
            P.name,
            U.first_name,
            U.last_name,
            Y.amount,
            Y.payment_method
        FROM `Booking` B
        INNER JOIN `Property` P
        ON B.`property_id` = P.`property_id`
        INNER JOIN `Payment` Y
        ON B.`booking_id` = Y.`booking_id`
        INNER JOIN `User` U
        ON B.`user_id` = U.`user_id`;
```

which gave the output as follows:
> -> Nested loop inner join  (cost=8.3 rows=7) (actual time=0.23..0.302 rows=7 loops=1)
>     -> Nested loop inner join  (cost=5.85 rows=7) (actual time=0.192..0.252 rows=7 loops=1)
>         -> Nested loop inner join  (cost=3.4 rows=7) (actual time=0.172..0.208 rows=7 loops=1)
>             -> Filter: (Y.booking_id is not null)  (cost=0.95 rows=7) (actual time=0.114..0.129 rows=7 loops=1)
>                 -> Table scan on Y  (cost=0.95 rows=7) (actual time=0.103..0.117 rows=7 loops=1)
>             -> Filter: ((B.property_id is not null) and (B.user_id is not null))  (cost=0.264 rows=1) (actual time=0.00921..0.00929 rows=1 loops=7)
>                 -> Single-row index lookup on B using PRIMARY (booking_id = Y.booking_id)  (cost=0.264 rows=1) (actual time=0.00792..0.00795 rows=1 loops=7)
>         -> Single-row index lookup on P using PRIMARY (property_id = B.property_id)  (cost=0.264 rows=1) (actual time=0.00444..0.00448 rows=1 loops=7)
>     -> Single-row index lookup on U using PRIMARY (user_id = B.user_id)  (cost=0.264 rows=1) (actual time=0.00421..0.00424 rows=1 loops=7)

## observation
### 1. Performance improvement
- The most significant difference is the actual time taken. Command 2 completes in 0.302 ms, which is significantly faster than Command 1's 0.534 ms. This represents an improvement of approximately (0.534 - 0.302) / 0.534 * 100% = 43.45%.
### 2. Effect of indexing
- The actual time for "Table scan on Y" (where Y is an alias for Payment) has reduced from 0.259-0.264 ms in Command 1 to 0.103-0.117 ms in Command 2 due to the presence of the index which makes the scan more efficient.