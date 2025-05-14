-- an initial query that retrieves all bookings along with the user details, property details, and payment details 

EXPLAIN ANALYZE
    SELECT *
        FROM `Booking`
        INNER JOIN `User`
        ON `Booking`.`user_id` = `User`.`user_id`
        INNER JOIN `Property`
        ON `Booking`.`property_id` = `Property`.`property_id`
        INNER JOIN `Payment`
        ON `Booking`.`booking_id` = `Payment`.`booking_id`;