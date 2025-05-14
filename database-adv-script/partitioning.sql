-- backup and delete existing table 
CREATE TABLE Booking_backup AS SELECT * FROM Booking;

--DROP TABLE Booking CASCADE;

-- drop table Booking safely
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS Booking CASCADE;
DROP TABLE IF EXISTS Payment CASCADE;
SET FOREIGN_KEY_CHECKS=1;


-- show create table
SHOW CREATE TABLE Booking;
SHOW CREATE TABLE Booking_backup;


CREATE TABLE IF NOT EXISTS `Booking` (
  `booking_id` CHAR(36) COMMENT 'indexed',
  `property_id` CHAR(36),
  `user_id` CHAR(36),
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` ENUM ('pending', 'confirmed', 'canceled') NOT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`booking_id`, `start_date`)
)
PARTITION BY RANGE (YEAR(`start_date`)) (
  PARTITION p2023 VALUES LESS THAN (2024),
  PARTITION p2024 VALUES LESS THAN (2025),
  PARTITION p2025 VALUES LESS THAN (2026),
  PARTITION p2026 VALUES LESS THAN (2027),
  PARTITION pmax VALUES LESS THAN MAXVALUE
);

-- Create foreign keys for the partitioned table
ALTER TABLE `Payment` ADD FOREIGN KEY (`booking_id`) REFERENCES `Booking` (`booking_id`);
ALTER TABLE `Booking` ADD FOREIGN KEY (`property_id`) REFERENCES `Property` (`property_id`);
ALTER TABLE `Booking` ADD FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`);

-- Create indexes for the partitioned table
-- This is optional but can help with performance
CREATE INDEX `booking_id` on `Booking` (`booking_id`);
CREATE INDEX `booking_start_date` on `Booking` (`start_date`);

-- Query data from booking table
EXPLAIN ANALYZE
    SELECT *
    FROM `Booking`;

-- Query data from booking table backup
EXPLAIN ANALYZE
    SELECT *
    FROM `Booking_backup`;