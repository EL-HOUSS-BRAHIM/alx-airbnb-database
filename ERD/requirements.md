# 🏠 Property Booking Platform – ERD Documentation

This project defines a relational database schema for a property booking platform, similar to Airbnb. The design focuses on identifying all core entities and modeling the relationships between them using industry-standard best practices.

## 📦 Entities and Attributes

### 1. **User**
- `user_id` (UUID, Primary Key)
- `first_name` (VARCHAR, Not Null)
- `last_name` (VARCHAR, Not Null)
- `email` (VARCHAR, Unique, Not Null)
- `password_hash` (VARCHAR, Not Null)
- `phone_number` (VARCHAR, Optional)
- `role` (ENUM: guest, host, admin, Not Null)
- `created_at` (TIMESTAMP, Defaults to current timestamp)

---

### 2. **Property**
- `property_id` (UUID, Primary Key)
- `host_id` (UUID, Foreign Key → User.user_id)
- `name` (VARCHAR, Not Null)
- `description` (TEXT, Not Null)
- `location` (VARCHAR, Not Null)
- `pricepernight` (DECIMAL, Not Null)
- `created_at` (TIMESTAMP)
- `updated_at` (TIMESTAMP)

---

### 3. **Booking**
- `booking_id` (UUID, Primary Key)
- `property_id` (UUID, Foreign Key → Property.property_id)
- `user_id` (UUID, Foreign Key → User.user_id)
- `start_date` (DATE, Not Null)
- `end_date` (DATE, Not Null)
- `total_price` (DECIMAL, Not Null)
- `status` (ENUM: pending, confirmed, canceled, Not Null)
- `created_at` (TIMESTAMP)

---

### 4. **Payment**
- `payment_id` (UUID, Primary Key)
- `booking_id` (UUID, Foreign Key → Booking.booking_id)
- `amount` (DECIMAL, Not Null)
- `payment_date` (TIMESTAMP)
- `payment_method` (ENUM: credit_card, paypal, stripe, Not Null)

---

### 5. **Review**
- `review_id` (UUID, Primary Key)
- `property_id` (UUID, Foreign Key → Property.property_id)
- `user_id` (UUID, Foreign Key → User.user_id)
- `rating` (INTEGER: 1-5)
- `comment` (TEXT, Not Null)
- `created_at` (TIMESTAMP)

---

### 6. **Message**
- `message_id` (UUID, Primary Key)
- `sender_id` (UUID, Foreign Key → User.user_id)
- `recipient_id` (UUID, Foreign Key → User.user_id)
- `message_body` (TEXT, Not Null)
- `sent_at` (TIMESTAMP)

---

## 🔗 Entity Relationships

- **User ↔ Booking**: One user can have many bookings (guest).
- **User ↔ Property**: One user (as host) can own multiple properties.
- **Property ↔ Booking**: One property can be booked many times.
- **Booking ↔ Payment**: Each booking can have one payment.
- **Property ↔ Review**: A property can receive many reviews from users.
- **User ↔ Review**: A user can write multiple reviews.
- **User ↔ Message**: Users can send and receive messages to/from each other.

---

## 🧠 Purpose

This schema supports a scalable and relational structure for managing users, bookings, payments, messaging, and reviews — laying the foundation for a robust property rental application.

## 📈 ER Diagram
![Image](https://github.com/user-attachments/assets/8a471a7f-15de-40fa-8c8d-13bfa0dff1a7)

---

## 🛠 Technologies

- PostgreSQL (preferred)
- UUIDs for primary keys
- ENUMs for constrained role/status types

---
