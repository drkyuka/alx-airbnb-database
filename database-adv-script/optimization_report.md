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
