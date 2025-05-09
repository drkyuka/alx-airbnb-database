# Task 1: Craft a detailed Entity-Relationship Diagram (ERD) to visualize the database design, ensuring clear relationships and properly defined entities.

## Visualize the ERD for a airbnb clone
<img src="/alx-airbnb-database/ERD/entity_graph.png" alt="ERD Picture">

## Modelling Entity specification with DBML
```dbml
// Use DBML to define your database structure
// Docs: https://dbml.dbdiagram.io/docs
// Visuals: https://dbdiagram.io/d

// enumerate user role
enum userRole {
  guest
  host
  admin
}

// create user table
Table User {
  user_id uuid [primary key, note: 'indexed']
  first_name varchar [not null]
  last_name  varchar [not null]
  email  varchar [not null, unique]
  password_hash  varchar [not null]
  phone_number  varchar [null]
  role  userRole [not null]
  created_at timestamp [default: `now()`]

  indexes {user_id}
}

// create property table
Table Property {
  property_id uuid [primary key, note: 'indexed']
  host_id uuid [not null, ref: > User.user_id]
  name varchar [not null]
  description text [not null]
  location  varchar [not null]
  pricepernight decimal [not null]
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  indexes {property_id}
}

// create booking table
Table Booking {
  booking_id uuid [primary key, note: 'indexed']
  property_id uuid [ref: > Property.property_id]
  user_id uuid [ref: > User.user_id]
  start_date date [not null]
  end_date date [not null]
  total_price decimal [not null]
  status enum [note: 'pending, confirmed, canceled', not null]
  created_at timestamp [default: `now()`]

  indexes {booking_id}
}

// enumerate payment method options
enum paymentOption {
  credit_card
  paypal
  stripe
}

// create payment table
Table Payment {
  payment_id uuid [primary key, note: 'indexed']
  booking_id uuid [ref: > Booking.booking_id]
  amount decimal [not null]
  payment_date timestamp [default: `now()`]
  payment_method paymentOption [not null]

  indexes {payment_id}
}

// create review table
Table Review {
  review_id uuid [primary key, note: 'indexed']
  property_id uuid [ref: > Property.property_id]
  user_id uuid [ref: > User.user_id]
  rating integer [not null, note: 'CHECK: rating >= 1 AND rating <= 5']
  comment text [not null]
  created_at timestamp [default: `now()`]

  indexes {review_id}
  note "check constraint does not exist in dbml"
}

// create message table
table Message {
  message_id uuid [primary key, note: 'indexed']
  sender_id uuid [ref: > User.user_id]
  recipient_id uuid [ref: > User.user_id]
  message_body text [not null]
  sent_at timestamp [default: `now()`]

  indexes {message_id}
}
```