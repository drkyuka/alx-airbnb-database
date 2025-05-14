-- sample queries

-- Query using a `LEFT JOIN` to retrieve all properties and their reviews, including properties that have no reviews
SET SESSION profiling = 1;
SELECT Property.name,
       Review.comment
    FROM `Property`
    LEFT JOIN `Review`
    ON `Property`.`property_id` = `Review`.`property_id` 
    ORDER BY Property.name
    LIMIT 100;

-- Query using a WHERE and AND clauses to retrieve all properties and their reviews, including properties that have no reviews
-- SET SESSION profiling = 2;
SELECT Property.name,
       Review.comment
    FROM `Property`, `Review`
    WHERE `Property`.`property_id` = `Review`.`property_id`
    AND Review.comment IS NOT NULL
    ORDER BY Property.name
    LIMIT 100;

-- Write a query to retrieve all users who are hosts to properties, including their first and last names and the property names
-- SET SESSION profiling = 3;
SELECT User.first_name,
       User.last_name,
       `Property`.name
    FROM `User`
    INNER JOIN `Property`
    ON `User`.`user_id` = `Property`.`host_id`
    WHERE User.role = 'host';

-- -- Write a query to retrieve all users who are hosts to properties, including their first and last names and the property names using WHERE and AND clauses
-- SET SESSION profiling = 4;
SELECT User.first_name,
       User.last_name,
       `Property`.name
    FROM `User`, `Property`
    WHERE `User`.`user_id` = `Property`.`host_id`
    AND User.role = 'host';

-- Write a query to retrieve all properties that have confirmed booked dates, including the property name and the booking start and end dates
-- SET SESSION profiling = 5;
SELECT Property.name,
       Booking.start_date,
       Booking.end_date
    FROM `Property`
    INNER JOIN `Booking`
    ON `Property`.`property_id` = `Booking`.`property_id`
    WHERE Booking.status = 'confirmed';

-- write a query to retrieve all payments made in the past 12 months
-- SET SESSION profiling = 6;
SELECT Payment.payment_id,
       Payment.amount,
       Payment.payment_date
    FROM `Payment`
    WHERE Payment.payment_date >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH);

-- write a query to show profiles to monitor the performance of the database
SHOW PROFILE
    FOR QUERY 1;

SHOW PROFILES;

-- Query to show summary of events
SELECT *
    FROM performance_schema.events_statements_current;

-- Query to show execution time for the first query
SELECT *
    FROM information_schema.PROFILING
    WHERE QUERY_ID = 1;

-- Query to show execution time for query 2
SELECT *
    FROM information_schema.PROFILING
    WHERE QUERY_ID = 2;

-- Query to show execution time for query 3
SELECT *
    FROM information_schema.PROFILING
    WHERE QUERY_ID = 3;

-- Query to show execution time for query 4
SELECT *
    FROM information_schema.PROFILING
    WHERE QUERY_ID = 4;

-- Query to show execution time for query 5
SELECT *
    FROM information_schema.PROFILING
    WHERE QUERY_ID = 5;

-- Query to show execution time for query 6
SELECT *
    FROM information_schema.PROFILING
    WHERE QUERY_ID = 6;