-- query using an `INNER JOIN` to retrieve all bookings and the respective users who made those bookings.

SELECT Booking.booking_id,
       User.first_name,
       User.last_name 
    FROM `Booking`
    INNER JOIN `User`
    ON `Booking`.`user_id` = `User`.`user_id`;

-- Query using a `LEFT JOIN` to retrieve all properties and their reviews, including properties that have no reviews
SELECT Property.name,
       Review.comment
    FROM `Property`
    LEFT JOIN `Review`
    ON `Property`.`property_id` = `Review`.`property_id`;


-- Query using a `FULL OUTER JOIN` to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user
-- mysql does not support FULL OUTER JOIN directly, but you can achieve it using a combination of LEFT JOIN and RIGHT JOIN with UNION
SELECT User.first_name,
       User.last_name,
       Booking.booking_id
    FROM `User`
    LEFT JOIN `Booking`
    ON `User`.`user_id` = `Booking`.`user_id`
    union
    SELECT User.first_name,
       User.last_name,
       Booking.booking_id
    FROM `User`
    RIGHT JOIN `Booking`
    ON `User`.`user_id` = `Booking`.`user_id`;