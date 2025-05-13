-- Query to find all properties where the average rating is greater than 4.0 using a subquery
select Property.property_id,
       Property.name,
       Property.location,
       Property.pricepernight,
       AvgReview.avg_rating
    from `Property`
    inner JOIN (
        select property_id, AVG(rating) as avg_rating
        from `Review`
        group by property_id
        having avg_rating > 4.0
    ) as AvgReview
    on Property.property_id = AvgReview.property_id;


-- Create a correlated subquery to find users who have made more than 3 bookings
select 
    U.user_id,
    U.first_name,
    U.last_name,
    (SELECT COUNT(*) FROM `Booking` B WHERE B.user_id = U.user_id) AS total_booking
from `User` U
where (SELECT COUNT(*) FROM `Booking` B WHERE B.user_id = U.user_id) > 3;
