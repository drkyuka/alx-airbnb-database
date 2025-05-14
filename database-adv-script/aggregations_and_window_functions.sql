-- Query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.
SELECT User.user_id,
       User.first_name,
       User.last_name,
       COUNT(Booking.booking_id) AS NUMBER_OF_BOOKINGS
FROM `User`
INNER JOIN `Booking` 
ON User.user_id = Booking.user_id
GROUP BY User.user_id;

-- Use a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.
SELECT 
    P.property_id,
    P.name,
    P.location,
    COUNT(B.booking_id) AS NUMBER_OF_BOOKINGS,
    row_number() over (order by COUNT(B.booking_id) desc) as booking_row_number,
    rank() over (order by COUNT(B.booking_id) DESC) AS booking_rank
FROM `Property` P
INNER JOIN  `Booking` B 
ON P.property_id = B.property_id
GROUP BY P.property_id, P.name, P.location;
