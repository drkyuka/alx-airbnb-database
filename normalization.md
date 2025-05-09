## 1. Normalize Your Database Design
### Objective: Apply normalization principles to ensure the database is in the third normal form (3NF).

---

### Observations

- 1NF: All the tables are 1NF as each column is atomic. Each table has a primary key and no repeating groups
- 2NF: All non-key attributes are directly related to the primary key in all the tables and in 1NF

### Violations

- 3NF: All tables do not have a non-key attribute that is transitively dependent on the primary key except the Booking table. 
-   The attribute total_price can be implied as a calculated attribute based on the Property.pricepernight inferred from the foreign key Booking.property_id, start date and end date.
-   Storing the total_price attribute can create anomalies that may be in variance to the calculated booking amount on the property.

### Recommendations

To ensure the 3NF normalization of the Booking table, the attribute `total_price` can be removed from the table.

the revised `Booking` table is as follows:

Booking
- booking_id: Primary Key, UUID, Indexed
- property_id: Foreign Key, references Property(property_id)
- user_id: Foreign Key, references User(user_id)
- start_date: DATE, NOT NULL
- end_date: DATE, NOT NULL
- ~~ total_price: DECIMAL, NOT NULL ~~
- status: ENUM (pending, confirmed, canceled), NOT NULL
- created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP


