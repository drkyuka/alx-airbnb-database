-- SQL CREATE INDEX commands to create appropriate indexes for those columns

CREATE INDEX `User_full_name` ON `User` (`first_name`, `last_name`);
CREATE INDEX `Property_name` ON `Property` (`name`);

-- Measure the query performance before and after adding indexes
EXPLAIN 
    SELECT *
    FROM `Booking`
    INNER JOIN `User`
    ON `Booking`.`user_id` = `User`.`user_id`;

EXPLAIN
    SELECT *
    FROM `Property`
    LEFT JOIN `Review`
    ON `Property`.`property_id` = `Review`.`property_id`;