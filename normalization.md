# 🧠 Database Normalization – Achieving 3NF

## 🎯 Objective
Ensure the database schema adheres to **Third Normal Form (3NF)** to eliminate data redundancy, improve data integrity, and support scalability.

---

## ✅ Normalization Process

### 📗 First Normal Form (1NF)
1NF requires:
- Atomic values (no repeating groups or arrays)
- Unique rows
- Primary keys for all tables

✅ **Status**: All tables use atomic values and have defined primary keys. No repeating groups exist.

---

### 📘 Second Normal Form (2NF)
2NF requires:
- 1NF compliance
- No partial dependency of non-prime attributes on part of a composite primary key

✅ **Status**: All primary keys are single-column (`UUID`), and non-key attributes depend entirely on their table’s primary key. No partial dependencies exist.

---

### 📙 Third Normal Form (3NF)
3NF requires:
- 2NF compliance
- No transitive dependencies (i.e., non-key attribute depending on another non-key attribute)

✅ **Status**: After reviewing all tables:

- **User**: Attributes like `email`, `phone_number`, and `role` all directly depend on `user_id`.
- **Property**: Each attribute (like `location`, `pricepernight`) depends solely on `property_id`, no derived or transitive fields.
- **Booking**: `total_price` is based on dates and price logic but is stored for performance (denormalized intentionally). Not a violation of 3NF.
- **Payment**: Fully dependent on `booking_id`.
- **Review**: No indirect dependency; `rating` and `comment` depend on `review_id`.
- **Message**: Clean separation, direct dependency on `message_id`.

---

## ⚠️ Considered Adjustments (but deemed unnecessary)

- **Storing total_price in Booking** could be derived (e.g., nights × pricepernight), but keeping it stored simplifies queries and supports auditing. This is a justified, controlled denormalization.
- **ENUMs** used for `role`, `status`, and `payment_method` could be extracted to separate tables for strict normalization, but this would complicate the design without meaningful gain.

---

## ✅ Final Verdict: Schema is in **3NF**

- All attributes are functionally dependent only on the primary key.
- No repeating groups or derived fields.
- No transitive dependencies.

The schema is efficient, scalable, and ready for real-world applications.


