-- Sample Users
INSERT INTO "User" (first_name, last_name, email, password_hash, phone_number, role)
VALUES 
('Alice', 'Smith', 'alice@example.com', 'hashedpassword1', '1234567890', 'guest'),
('Bob', 'Johnson', 'bob@example.com', 'hashedpassword2', '2345678901', 'host'),
('Admin', 'User', 'admin@example.com', 'hashedadmin', NULL, 'admin');

-- Sample Properties
INSERT INTO "Property" (host_id, name, description, location, pricepernight)
SELECT user_id, 'Cozy Cottage', 'A cozy place to relax', 'Portland', 120.00
FROM "User" WHERE email = 'bob@example.com';

-- Sample Booking
INSERT INTO "Booking" (property_id, user_id, start_date, end_date, total_price, status)
SELECT p.property_id, u.user_id, '2025-06-01', '2025-06-05', 480.00, 'confirmed'
FROM "Property" p, "User" u
WHERE p.name = 'Cozy Cottage' AND u.email = 'alice@example.com';

-- Sample Payment
INSERT INTO "Payment" (booking_id, amount, payment_method)
SELECT b.booking_id, 480.00, 'credit_card'
FROM "Booking" b;

-- Sample Review
INSERT INTO "Review" (property_id, user_id, rating, comment)
SELECT p.property_id, u.user_id, 5, 'Fantastic stay!'
FROM "Property" p, "User" u
WHERE p.name = 'Cozy Cottage' AND u.email = 'alice@example.com';

-- Sample Message
INSERT INTO "Message" (sender_id, recipient_id, message_body)
SELECT s.user_id, r.user_id, 'Hey! I had a question about the booking.'
FROM "User" s, "User" r
WHERE s.email = 'alice@example.com' AND r.email = 'bob@example.com';

