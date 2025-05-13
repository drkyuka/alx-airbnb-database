-- Query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.
select User.user_id,
       User.first_name,
       User.last_name,
       COUNT(Booking.booking_id) AS total_bookings
from `User`
inner join `Booking` 
on User.user_id = Booking.user_id
group by User.user_id;

-- Use a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.
select 
    P.property_id,
    P.name,
    P.location,
    COUNT(B.booking_id) AS total_bookings,
    row_number() over (order by COUNT(B.booking_id) desc) as booking_row_number,
    rank() over (order by COUNT(B.booking_id) DESC) AS booking_rank
from `Property` P
inner join `Booking` B ON P.property_id = B.property_id
group by P.property_id, P.name, P.location;
