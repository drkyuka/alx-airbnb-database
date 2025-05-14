# 5. Partitioning Large Tables

## Objective: Implement table partitioning to optimize queries on large datasets.

## Instructions:

<p>
    Assume the Booking table is large and query performance is slow. Implement partitioning on the Booking table based on the start_date column. Save the query in a file partitioning.sql
</p>

## Test the performance of queries on the partitioned table (e.g., fetching bookings by date range).

### 1. Query non-partitioned table
I ran the query of the `Booking_backup` table as follows:
```
EXPLAIN ANALYZE
    SELECT *
    FROM `Booking_backup`;
```
it provided the output as follows:
> -> Table scan on Booking_backup  (cost=1.45 rows=12) (actual time=0.615..0.678 rows=12 loops=1)

### 2. Query a partitioned table
I ran the query of the `Booking` table as follows:
```
EXPLAIN ANALYZE
    SELECT *
    FROM `Booking`;
```
it provided the output as follows:
> -> Table scan on Booking  (cost=2.45 rows=12) (actual time=0.867..0.986 rows=12 loops=1)

## Write a brief report on the improvements you observed

### 1. Performance 
- the average cost of querying the partitioned table `Booking` is 2.45 compared to the non-partitioned backup `Booking_backup` at 1.45 which represents `68.9%` increase in cost compared to the non-partitioned table.
- the actual time taken for the partitioned table `Booking` is `0.119ms` compared to the non-partitioned backup `Booking_backup` which took `0.063ms` which is a `88.9%` more than the non-partitioned table querying the 12 rows in the table.

### 2. Foreign key constraints
- foreign key constraints could not be added to the `Booking` table after it was partitioned as this is a limitation on the MySQL engine.
- PostgreSQL supports limited functionality on foreign key constraints on partitioned tables.
- the workaround for the MySQL engine is to decouple the foreign key constraints and handle referential integrity at the application level or business logic level