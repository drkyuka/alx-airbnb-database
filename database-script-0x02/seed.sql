-- filepath: /Users/kyukaavongibrahim/sources/alx-airbnb-database/database-script-0x02/seed.sql
-- Sample data for Airbnb clone database
-- Created: May 10, 2025

-- Clear existing data (if any)
DELETE FROM `Message`;
DELETE FROM `Review`;
DELETE FROM `Payment`;
DELETE FROM `Booking`;
DELETE FROM `Property`;
DELETE FROM `User`;

-- Insert Users (10 users with different roles)
-- Using predefined UUIDs for referential integrity
INSERT INTO `User` (`user_id`, `first_name`, `last_name`, `email`, `password_hash`, `phone_number`, `role`, `created_at`) VALUES 
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'John', 'Smith', 'john.smith@example.com', '$2a$12$1FRG7JpUpmgDoiUTzQr9B.rVrYoVD4x6/3KP1vFE6p1Jc2IaV3u1W', '+1-202-555-0123', 'admin', '2024-01-01 08:00:00'),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Sarah', 'Johnson', 'sarah.j@example.com', '$2a$12$HEjG3Dty8ZbMF3zvpHFcPeCO3zbS8hZMWN4gg3N32d4lb.ARKstz6', '+1-202-555-0124', 'host', '2024-01-10 09:30:00'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Michael', 'Williams', 'mikew@example.com', '$2a$12$eUIBrfmH8X02Mn0fy1vt0OLFRoLdNz.UpX4iolE1U0sGu62x4q6Mi', '+1-202-555-0125', 'host', '2024-01-15 10:45:00'),
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Emily', 'Brown', 'emily_brown@example.com', '$2a$12$bwE1NWpJMRBQDpBQ4V.f5.JUleluRRKIeZ9i1BtiH9iBksvo9zEK2', '+1-202-555-0126', 'guest', '2024-01-20 11:15:00'),
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'David', 'Jones', 'djones@example.com', '$2a$12$Jj5mKOSWZbYnO2Jj1Z6zWe3wsrQj89FoOaWqNJHvUQP0EJKdJZUS2', '+1-202-555-0127', 'guest', '2024-02-01 12:30:00'),
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'Jessica', 'Garcia', 'jgarcia@example.com', '$2a$12$8.DIj3/S8D.h4hzFOCPQYenyAq7figx7EVn.J88KMR/XUg8WGrWVS', '+1-202-555-0128', 'guest', '2024-02-10 14:20:00'),
('a1eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'James', 'Miller', 'james.miller@example.com', '$2a$12$q5GbAXwVVC4XNgEf2Try7u6JvpqMF74es6zitNK6hfuV0jyLj4w0G', '+1-202-555-0129', 'host', '2024-02-15 16:10:00'),
('b1eebc99-9c0b-4ef8-bb6d-6bb9bd380a18', 'Emma', 'Davis', 'emma.davis@example.com', '$2a$12$7cmbP4UkaGHLEVQpjuKW9eF9yFUZGYEYS3mVIGiUHD5nKGArGLKFi', '+1-202-555-0130', 'guest', '2024-02-20 17:45:00'),
('c1eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 'Daniel', 'Rodriguez', 'drodriguez@example.com', '$2a$12$dnoSBdV7.sRY7oF1sj3sEuJkFa.txtgQFW7pCQl.b3wecAYUG5m8e', '+1-202-555-0131', 'guest', '2024-03-01 09:10:00'),
('d1eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', 'Olivia', 'Wilson', 'owilson@example.com', '$2a$12$wvSWTZ0kMXdtK7AwNJ0b6.J/s9VAC8I2JxfGkW2Br.StFU1QABg0e', '+1-202-555-0132', 'host', '2024-03-05 10:30:00');

-- Insert Properties (8 properties from different hosts)
INSERT INTO `Property` (`property_id`, `host_id`, `name`, `description`, `location`, `pricepernight`, `created_at`, `updated_at`) VALUES
('a2eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Beachfront Villa', 'Stunning villa with direct access to the beach and breathtaking ocean views. Features 4 bedrooms, a private pool, and a fully equipped kitchen.', 'Miami, Florida', 350.00, '2024-01-15 14:30:00', '2024-01-15 14:30:00'),
('b2eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Downtown Loft', 'Modern loft in the heart of the city with high ceilings, exposed brick walls, and contemporary furnishings. Walking distance to restaurants and attractions.', 'New York, New York', 225.00, '2024-01-20 16:45:00', '2024-02-10 11:20:00'),
('c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Mountain Cabin', 'Cozy cabin retreat surrounded by pine trees with mountain views. Features a fireplace, hot tub, and hiking trails nearby.', 'Aspen, Colorado', 180.00, '2024-02-01 10:15:00', '2024-02-15 09:30:00'),
('d2eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 'a1eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'Luxury Penthouse', 'Upscale penthouse with panoramic city views, featuring high-end furnishings, a private terrace, and access to building amenities.', 'Los Angeles, California', 450.00, '2024-02-10 12:30:00', '2024-03-01 14:15:00'),
('e2eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', 'a1eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'Countryside Cottage', 'Charming cottage with garden views in a peaceful rural setting. Perfect for a relaxing getaway with vintage decor and modern amenities.', 'Vermont', 135.00, '2024-02-20 15:45:00', '2024-03-05 16:20:00'),
('f2eebc99-9c0b-4ef8-bb6d-6bb9bd380a26', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'City Center Apartment', 'Contemporary apartment in a central location with easy access to public transportation, shops, and entertainment venues.', 'Chicago, Illinois', 175.00, '2024-03-01 11:10:00', '2024-03-10 10:05:00'),
('a3eebc99-9c0b-4ef8-bb6d-6bb9bd380a27', 'd1eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', 'Desert Retreat', 'Modern home with desert views, featuring a private pool, outdoor living space, and stunning sunset vistas.', 'Scottsdale, Arizona', 265.00, '2024-03-10 13:25:00', '2024-04-01 09:45:00'),
('b3eebc99-9c0b-4ef8-bb6d-6bb9bd380a28', 'd1eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', 'Lakeside Cabin', 'Rustic yet comfortable cabin on the lake shore with a private dock, canoes, and fishing equipment provided.', 'Lake Tahoe, Nevada', 195.00, '2024-03-20 14:50:00', '2024-04-05 13:30:00');

-- Insert Bookings (12 bookings with different statuses)
INSERT INTO `Booking` (`booking_id`, `property_id`, `user_id`, `start_date`, `end_date`, `status`, `created_at`) VALUES
('a4eebc99-9c0b-4ef8-bb6d-6bb9bd380a29', 'a2eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', '2024-06-10', '2024-06-15','confirmed', '2024-03-15 09:20:00'),
('b4eebc99-9c0b-4ef8-bb6d-6bb9bd380a30', 'b2eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'e0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', '2024-06-12', '2024-06-16', 'confirmed', '2024-03-20 10:35:00'),
('c4eebc99-9c0b-4ef8-bb6d-6bb9bd380a31', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 'f0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', '2024-06-20', '2024-06-25', 'confirmed', '2024-03-25 11:45:00'),
('d4eebc99-9c0b-4ef8-bb6d-6bb9bd380a32', 'd2eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380a18', '2024-07-01', '2024-07-08', 'pending', '2024-04-01 13:10:00'),
('e4eebc99-9c0b-4ef8-bb6d-6bb9bd380a33', 'e2eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', 'c1eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', '2024-07-05', '2024-07-10', 'confirmed', '2024-04-05 14:25:00'),
('f4eebc99-9c0b-4ef8-bb6d-6bb9bd380a34', 'f2eebc99-9c0b-4ef8-bb6d-6bb9bd380a26', 'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', '2024-07-15', '2024-07-20', 'confirmed', '2024-04-10 15:40:00'),
('a5eebc99-9c0b-4ef8-bb6d-6bb9bd380a35', 'a3eebc99-9c0b-4ef8-bb6d-6bb9bd380a27', 'e0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', '2024-07-20', '2024-07-27', 'canceled', '2024-04-15 16:55:00'),
('b5eebc99-9c0b-4ef8-bb6d-6bb9bd380a36', 'b3eebc99-9c0b-4ef8-bb6d-6bb9bd380a28', 'f0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', '2024-08-01', '2024-08-07', 'pending', '2024-04-20 18:05:00'),
('c5eebc99-9c0b-4ef8-bb6d-6bb9bd380a37', 'a2eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380a18', '2024-08-10', '2024-08-15', 'confirmed', '2024-04-25 09:15:00'),
('d5eebc99-9c0b-4ef8-bb6d-6bb9bd380a38', 'b2eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'c1eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', '2024-08-20', '2024-08-25', 'canceled', '2024-04-30 10:30:00'),
('e5eebc99-9c0b-4ef8-bb6d-6bb9bd380a39', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', '2024-09-01', '2024-09-05', 'pending', '2024-05-05 11:45:00'),
('f5eebc99-9c0b-4ef8-bb6d-6bb9bd380a40', 'd2eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 'e0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', '2024-09-10', '2024-09-15', 'confirmed', '2024-05-10 13:00:00');

-- Insert Payments (for confirmed bookings)
INSERT INTO `Payment` (`payment_id`, `booking_id`, `amount`, `payment_date`, `payment_method`) VALUES
('a6eebc99-9c0b-4ef8-bb6d-6bb9bd380a41', 'a4eebc99-9c0b-4ef8-bb6d-6bb9bd380a29', 1750.00, '2024-03-15 09:25:00', 'credit_card'),
('b6eebc99-9c0b-4ef8-bb6d-6bb9bd380a42', 'b4eebc99-9c0b-4ef8-bb6d-6bb9bd380a30', 900.00, '2024-03-20 10:40:00', 'paypal'),
('c6eebc99-9c0b-4ef8-bb6d-6bb9bd380a43', 'c4eebc99-9c0b-4ef8-bb6d-6bb9bd380a31', 900.00, '2024-03-25 11:50:00', 'credit_card'),
('d6eebc99-9c0b-4ef8-bb6d-6bb9bd380a44', 'e4eebc99-9c0b-4ef8-bb6d-6bb9bd380a33', 675.00, '2024-04-05 14:30:00', 'stripe'),
('e6eebc99-9c0b-4ef8-bb6d-6bb9bd380a45', 'f4eebc99-9c0b-4ef8-bb6d-6bb9bd380a34', 875.00, '2024-04-10 15:45:00', 'credit_card'),
('f6eebc99-9c0b-4ef8-bb6d-6bb9bd380a46', 'c5eebc99-9c0b-4ef8-bb6d-6bb9bd380a37', 1750.00, '2024-04-25 09:20:00', 'paypal'),
('a7eebc99-9c0b-4ef8-bb6d-6bb9bd380a47', 'f5eebc99-9c0b-4ef8-bb6d-6bb9bd380a40', 2250.00, '2024-05-10 13:05:00', 'stripe');

-- Insert Reviews (for completed stays)
INSERT INTO `Review` (`review_id`, `property_id`, `user_id`, `rating`, `comment`, `created_at`) VALUES
('a8eebc99-9c0b-4ef8-bb6d-6bb9bd380a48', 'a2eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 5, 'Absolutely stunning villa with incredible beach views! The host was very responsive and the amenities were top-notch. Would definitely stay again!', '2024-06-16 10:30:00'),
('b8eebc99-9c0b-4ef8-bb6d-6bb9bd380a49', 'b2eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'e0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 4, 'Great location in the heart of NYC. Stylish loft with all the necessities. Only minor issue was street noise at night, but that\'s expected in the city.', '2024-06-17 11:45:00'),
('c8eebc99-9c0b-4ef8-bb6d-6bb9bd380a50', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 'f0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 5, 'The perfect mountain getaway! Peaceful, clean, and cozy. We loved the fireplace and the nearby hiking trails were amazing.', '2024-06-26 09:15:00'),
('d8eebc99-9c0b-4ef8-bb6d-6bb9bd380a51', 'e2eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', 'c1eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 4, 'Charming cottage with beautiful garden views. Very comfortable and well-equipped. The host left detailed instructions for everything.', '2024-07-11 14:20:00'),
('e8eebc99-9c0b-4ef8-bb6d-6bb9bd380a52', 'f2eebc99-9c0b-4ef8-bb6d-6bb9bd380a26', 'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 3, 'Good apartment in a convenient location. Clean and functional, though a bit smaller than it appeared in photos. Still a good value.', '2024-07-21 16:30:00');

-- Insert Messages (communication between users)
INSERT INTO `Message` (`message_id`, `sender_id`, `recipient_id`, `message_body`, `sent_at`) VALUES
('a9eebc99-9c0b-4ef8-bb6d-6bb9bd380a53', 'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Hello! I\'m interested in your Beachfront Villa. Is early check-in possible on June 10?', '2024-03-14 15:20:00'),
('b9eebc99-9c0b-4ef8-bb6d-6bb9bd380a54', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Hi Emily! Yes, early check-in should be fine. What time were you thinking of arriving?', '2024-03-14 16:05:00'),
('c9eebc99-9c0b-4ef8-bb6d-6bb9bd380a55', 'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Great! We\'ll be arriving around 11am if that works.', '2024-03-14 16:30:00'),
('d9eebc99-9c0b-4ef8-bb6d-6bb9bd380a56', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', '11am works perfectly. I\'ll make a note of it. Looking forward to hosting you!', '2024-03-14 17:00:00'),
('e9eebc99-9c0b-4ef8-bb6d-6bb9bd380a57', 'e0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Hi Michael, does your Downtown Loft have parking included?', '2024-03-19 09:45:00'),
('f9eebc99-9c0b-4ef8-bb6d-6bb9bd380a58', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'e0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'Hello David, there\'s no private parking but there\'s a public garage two blocks away that offers day rates.', '2024-03-19 10:20:00'),
('a0febc99-9c0b-4ef8-bb6d-6bb9bd380a59', 'f0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Is there good cell service at the Mountain Cabin? We need to be able to work remotely during part of our stay.', '2024-03-24 13:10:00'),
('b0febc99-9c0b-4ef8-bb6d-6bb9bd380a60', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'f0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'Yes, there\'s reliable cell service and we also provide high-speed Wi-Fi. You should have no issues working remotely.', '2024-03-24 14:25:00'),
('c0febc99-9c0b-4ef8-bb6d-6bb9bd380a61', 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380a18', 'a1eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'I\'m interested in booking the Luxury Penthouse. Are pets allowed?', '2024-03-31 11:30:00'),
('d0febc99-9c0b-4ef8-bb6d-6bb9bd380a62', 'a1eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380a18', 'I\'m sorry, but we don\'t allow pets in the Luxury Penthouse due to building regulations.', '2024-03-31 12:15:00');