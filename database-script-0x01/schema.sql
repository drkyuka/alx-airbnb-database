CREATE TABLE `User` (
  `user_id` CHAR(36) PRIMARY KEY COMMENT 'indexed',
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) UNIQUE NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `phone_number` varchar(255),
  `role` ENUM ('guest', 'host', 'admin') NOT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `Property` (
  `property_id` CHAR(36) PRIMARY KEY COMMENT 'indexed',
  `host_id` CHAR(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `location` varchar(255) NOT NULL,
  `pricepernight` decimal NOT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `Booking` (
  `booking_id` CHAR(36) PRIMARY KEY COMMENT 'indexed',
  `property_id` CHAR(36),
  `user_id` CHAR(36),
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` ENUM ('pending', 'confirmed', 'canceled') NOT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `Payment` (
  `payment_id` CHAR(36) PRIMARY KEY COMMENT 'indexed',
  `booking_id` CHAR(36),
  `amount` decimal NOT NULL,
  `payment_date` timestamp DEFAULT CURRENT_TIMESTAMP,
  `payment_method` ENUM ('credit_card', 'paypal', 'stripe') NOT NULL
);

CREATE TABLE `Review` (
  `review_id` CHAR(36) PRIMARY KEY COMMENT 'indexed',
  `property_id` CHAR(36),
  `user_id` CHAR(36),
  `rating` integer NOT NULL CHECK (rating >= 1 AND rating <= 5) COMMENT 'Rating must be between 1 and 5',
  `comment` text NOT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `Message` (
  `message_id` CHAR(36) PRIMARY KEY COMMENT 'indexed',
  `sender_id` CHAR(36),
  `recipient_id` CHAR(36),
  `message_body` text NOT NULL,
  `sent_at` timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX `User_index_1` ON `User` (`user_id`);

CREATE INDEX `Property_index_2` ON `Property` (`property_id`);

CREATE INDEX `Booking_index_3` ON `Booking` (`booking_id`);

CREATE INDEX `Payment_index_4` ON `Payment` (`payment_id`);

CREATE INDEX `Review_index_5` ON `Review` (`review_id`);

CREATE INDEX `Message_index_6` ON `Message` (`message_id`);

ALTER TABLE `Property` ADD FOREIGN KEY (`host_id`) REFERENCES `User` (`user_id`);

ALTER TABLE `Booking` ADD FOREIGN KEY (`property_id`) REFERENCES `Property` (`property_id`);

ALTER TABLE `Booking` ADD FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`);

ALTER TABLE `Payment` ADD FOREIGN KEY (`booking_id`) REFERENCES `Booking` (`booking_id`);

ALTER TABLE `Review` ADD FOREIGN KEY (`property_id`) REFERENCES `Property` (`property_id`);

ALTER TABLE `Review` ADD FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`);

ALTER TABLE `Message` ADD FOREIGN KEY (`sender_id`) REFERENCES `User` (`user_id`);

ALTER TABLE `Message` ADD FOREIGN KEY (`recipient_id`) REFERENCES `User` (`user_id`);
