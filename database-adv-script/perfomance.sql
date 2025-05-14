-- an initial query that retrieves all bookings along with the user details, property details, and payment details 

-- delete booking pament index if it exists
-- DROP INDEX `booking_payment` ON `Payment`;

EXPLAIN ANALYZE
    SELECT *
        FROM `Booking`
        LEFT JOIN `User`
        ON `Booking`.`user_id` = `User`.`user_id`
        INNER JOIN `Property`
        ON `Booking`.`property_id` = `Property`.`property_id`
        INNER JOIN `Payment`
        ON `Booking`.`booking_id` = `Payment`.`booking_id`;


-- using `WHERE` and `AND` clauses instead of `JOIN` to filter data
EXPLAIN ANALYZE
    SELECT *
    FROM `Booking`, `User`, `Property`, `Payment`
    WHERE `Booking`.`booking_id` = `Payment`.`booking_id`
    AND `Booking`.`property_id` = `Property`.`property_id`
    AND `Booking`.`user_id` = `User`.`user_id`;

-- Refresh the database to ensure the latest data is used
FLUSH TABLES;

-- refactored query to reduce execution time, such as reducing unnecessary joins or using indexing

-- optimise search on booking payments with indexing
CREATE INDEX `booking_payment` ON `Payment` (`booking_id`);
CREATE INDEX `booking_property` ON `Booking` (`property_id`);

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


-- using `WHERE` and `AND` clauses instead of `JOIN` to filter data
EXPLAIN ANALYZE
    SELECT B.booking_id,
            P.name,
            U.first_name,
            U.last_name,
            Y.amount,
            Y.payment_method
    FROM `Booking` B, `User` U, `Property` P, `Payment` Y
    WHERE B.`booking_id` = Y.`booking_id`
    AND B.`property_id` = P.`property_id`
    AND B.`user_id` = U.`user_id`;