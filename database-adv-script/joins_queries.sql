-- query using an `INNER JOIN` to retrieve all bookings and the respective users who made those bookings.

select Booking.booking_id,
       Booking.start_date,
       Booking.end_date,
       Booking.status,
       User.user_id,
       User.first_name,
       User.last_name 
    from `Booking`
    inner JOIN `User`
    on `Booking`.`user_id` = `User`.`user_id`;

-- Query using a `LEFT JOIN` to retrieve all properties and their reviews, including properties that have no reviews
select Property.property_id,
       Property.name,
       Property.location,
       Property.pricepernight,
       Review.review_id,
       Review.rating,
       Review.comment 
    from `Property`
    left JOIN `Review`
    on `Property`.`property_id` = `Review`.`property_id`;


-- Query using a `FULL OUTER JOIN` to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user
-- mysql does not support FULL OUTER JOIN directly, but you can achieve it using a combination of LEFT JOIN and RIGHT JOIN with UNION
select User.user_id,
       User.first_name,
       User.last_name,
       Booking.booking_id,
       Booking.start_date,
       Booking.end_date 
    from `User`
    left JOIN `Booking`
    on `User`.`user_id` = `Booking`.`user_id`
    UNION
    select User.user_id,
       User.first_name,
       User.last_name,
       Booking.booking_id,
       Booking.start_date,
       Booking.end_date 
    from `User`
    right JOIN `Booking`
    on `User`.`user_id` = `Booking`.`user_id`;