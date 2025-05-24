-- Task 4: Query Performance Optimization

-- Analyze initial query performance
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.first_name AS guest_first_name,
    u.last_name AS guest_last_name,
    u.email AS guest_email,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    h.first_name AS host_first_name,
    h.last_name AS host_last_name,
    h.email AS host_email,
    pay.payment_id,
    pay.amount,
    pay.payment_method,
    r.rating,
    r.comment
FROM "Booking" b
JOIN "User" u ON b.user_id = u.user_id
JOIN "Property" p ON b.property_id = p.property_id
JOIN "User" h ON p.host_id = h.user_id
LEFT JOIN "Payment" pay ON b.booking_id = pay.booking_id
LEFT JOIN "Review" r ON p.property_id = r.property_id AND r.user_id = b.user_id
WHERE b.status = 'confirmed'
AND b.start_date >= CURRENT_DATE
ORDER BY b.start_date;

-- Performance Analysis of Initial Query
/*
Expected performance issues in initial query:
1. Multiple table joins without proper indexing
2. Unnecessary columns in result set
3. No materialized views for frequently accessed data
4. Full table scans likely on large tables
*/

-- Optimized query (after analysis)
WITH BookingDetails AS (
    SELECT 
        b.booking_id,
        b.start_date,
        b.end_date,
        b.total_price,
        b.status,
        b.user_id AS guest_id,
        b.property_id,
        p.host_id,
        p.name AS property_name,
        p.location,
        p.pricepernight
    FROM "Booking" b
    JOIN "Property" p ON b.property_id = p.property_id
    WHERE b.status = 'confirmed'
    AND b.start_date >= CURRENT_DATE
),
PaymentInfo AS (
    SELECT 
        booking_id,
        payment_id,
        amount,
        payment_method
    FROM "Payment"
),
ReviewInfo AS (
    SELECT 
        property_id,
        user_id,
        rating,
        comment
    FROM "Review"
)
SELECT 
    bd.*,
    g.first_name AS guest_first_name,
    g.last_name AS guest_last_name,
    g.email AS guest_email,
    h.first_name AS host_first_name,
    h.last_name AS host_last_name,
    h.email AS host_email,
    pi.payment_id,
    pi.amount,
    pi.payment_method,
    ri.rating,
    ri.comment
FROM BookingDetails bd
JOIN "User" g ON bd.guest_id = g.user_id
JOIN "User" h ON bd.host_id = h.user_id
LEFT JOIN PaymentInfo pi ON bd.booking_id = pi.booking_id
LEFT JOIN ReviewInfo ri ON bd.property_id = ri.property_id AND ri.user_id = bd.guest_id
ORDER BY bd.start_date;

-- Analyze optimized query performance
EXPLAIN ANALYZE
WITH BookingDetails AS (
    SELECT 
        b.booking_id,
        b.start_date,
        b.end_date,
        b.total_price,
        b.status,
        b.user_id AS guest_id,
        b.property_id,
        p.host_id,
        p.name AS property_name,
        p.location,
        p.pricepernight
    FROM "Booking" b
    JOIN "Property" p ON b.property_id = p.property_id
    WHERE b.status = 'confirmed'
    AND b.start_date >= CURRENT_DATE
),
PaymentInfo AS (
    SELECT 
        booking_id,
        payment_id,
        amount,
        payment_method
    FROM "Payment"
),
ReviewInfo AS (
    SELECT 
        property_id,
        user_id,
        rating,
        comment
    FROM "Review"
)
SELECT 
    bd.*,
    g.first_name AS guest_first_name,
    g.last_name AS guest_last_name,
    g.email AS guest_email,
    h.first_name AS host_first_name,
    h.last_name AS host_last_name,
    h.email AS host_email,
    pi.payment_id,
    pi.amount,
    pi.payment_method,
    ri.rating,
    ri.comment
FROM BookingDetails bd
JOIN "User" g ON bd.guest_id = g.user_id
JOIN "User" h ON bd.host_id = h.user_id
LEFT JOIN PaymentInfo pi ON bd.booking_id = pi.booking_id
LEFT JOIN ReviewInfo ri ON bd.property_id = ri.property_id AND ri.user_id = bd.guest_id
ORDER BY bd.start_date;

-- Compare execution plans
/*
Expected improvements in optimized query:
1. CTEs break down complex query into manageable chunks
2. Reduced number of joins in main query
3. Better use of indexes with filtered CTEs
4. More efficient data access patterns
*/
