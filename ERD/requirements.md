### 🏆 Task 0 📋 Entities and Attributes

#### 👤 User: Craft a detailed Entity-Relationship Diagram (ERD) to visualize the database design, ensuring clear relationships and properly defined entities.

## 🖼️ Visualize the ERD for a airbnb clone
<img src="/alx-airbnb-database/ERD/entity_graph.png" alt="ERD Picture">

---

## 📊 Database Specification
### 📋 Entities and Attributes

#### User
- user_id: Primary Key, UUID, Indexed
- first_name: VARCHAR, NOT NULL
- last_name: VARCHAR, NOT NULL
- email: VARCHAR, UNIQUE, NOT NULL
- password_hash: VARCHAR, NOT NULL
- phone_number: VARCHAR, NULL
- role: ENUM (guest, host, admin), NOT NULL
- created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

#### 🏠 Property
- property_id: Primary Key, UUID, Indexed
- host_id: Foreign Key, references User(user_id)
- name: VARCHAR, NOT NULL
- description: TEXT, NOT NULL
- location: VARCHAR, NOT NULL
- pricepernight: DECIMAL, NOT NULL
- created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
- updated_at: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP

#### 📅 Booking
- booking_id: Primary Key, UUID, Indexed
- property_id: Foreign Key, references Property(property_id)
- user_id: Foreign Key, references User(user_id)
- start_date: DATE, NOT NULL
- end_date: DATE, NOT NULL
- total_price: DECIMAL, NOT NULL
- status: ENUM (pending, confirmed, canceled), NOT NULL
- created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

#### 💰 Payment
- payment_id: Primary Key, UUID, Indexed
- booking_id: Foreign Key, references Booking(booking_id)
- amount: DECIMAL, NOT NULL
- payment_date: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
- payment_method: ENUM (credit_card, paypal, stripe), NOT NULL

#### ⭐ Review
- review_id: Primary Key, UUID, Indexed
- property_id: Foreign Key, references Property(property_id)
- user_id: Foreign Key, references User(user_id)
- rating: INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL
- comment: TEXT, NOT NULL
- created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

#### 💬 Message
- message_id: Primary Key, UUID, Indexed
- sender_id: Foreign Key, references User(user_id)
- recipient_id: Foreign Key, references User(user_id)
- message_body: TEXT, NOT NULL
- sent_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

---

### 🔒 Constraints

#### 👤 User Table
- Unique constraint on email.
- Non-null constraints on required fields.

#### 🏠 Property Table
- Foreign key constraint on host_id.
- Non-null constraints on essential attributes.

#### 📅 Booking Table
- Foreign key constraints on property_id and user_id.
- status must be one of pending, confirmed, or canceled.

#### Payment Table
- Foreign key constraint on booking_id, ensuring payment is linked to valid bookings.

#### Review Table
- Constraints on rating values (1-5).
- Foreign key constraints on property_id and user_id.

#### Message Table
- Foreign key constraints on sender_id and recipient_id.

### Indexing
- Primary Keys: Indexed automatically.
- Additional Indexes:
-   email in the User table.
-   property_id in the Property and Booking tables.
-   booking_id in the Booking and Payment tables.

---

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