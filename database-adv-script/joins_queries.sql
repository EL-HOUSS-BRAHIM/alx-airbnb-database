-- Task 0: Complex Queries with Joins

-- 1. INNER JOIN to retrieve all bookings and their users
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.first_name,
    u.last_name,
    u.email
FROM "Booking" b
INNER JOIN "User" u ON b.user_id = u.user_id
ORDER BY b.start_date DESC;

-- 2. LEFT JOIN to retrieve all properties and their reviews
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.pricepernight,
    COALESCE(r.rating, 0) as rating,
    r.comment,
    r.created_at as review_date
FROM "Property" p
LEFT JOIN "Review" r ON p.property_id = r.property_id
ORDER BY p.created_at DESC;

-- 3. FULL OUTER JOIN to retrieve all users and bookings
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status
FROM "User" u
FULL OUTER JOIN "Booking" b ON u.user_id = b.user_id
ORDER BY u.created_at DESC, b.created_at DESC;
