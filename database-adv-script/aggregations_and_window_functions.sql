-- Task 2: Aggregations and Window Functions

-- 1. Total number of bookings by user
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) as total_bookings,
    SUM(b.total_price) as total_spent
FROM "User" u
LEFT JOIN "Booking" b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;

-- 2. Rank properties based on number of bookings using window functions
WITH PropertyBookings AS (
    SELECT 
        p.property_id,
        p.name,
        p.location,
        COUNT(b.booking_id) as booking_count,
        AVG(r.rating)::DECIMAL(3,2) as avg_rating
    FROM "Property" p
    LEFT JOIN "Booking" b ON p.property_id = b.property_id
    LEFT JOIN "Review" r ON p.property_id = r.property_id
    GROUP BY p.property_id, p.name, p.location
)
SELECT 
    property_id,
    name,
    location,
    booking_count,
    avg_rating,
    RANK() OVER (ORDER BY booking_count DESC) as booking_rank,
    DENSE_RANK() OVER (ORDER BY avg_rating DESC) as rating_rank
FROM PropertyBookings
ORDER BY booking_count DESC, avg_rating DESC;
