-- Task 1: Practice Subqueries

-- 1. Find all properties where the average rating is greater than 4.0
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.pricepernight,
    (
        SELECT AVG(rating)::DECIMAL(3,2)
        FROM "Review" r
        WHERE r.property_id = p.property_id
    ) as avg_rating
FROM "Property" p
WHERE (
    SELECT AVG(rating)
    FROM "Review" r
    WHERE r.property_id = p.property_id
) > 4.0;

-- 2. Find users who have made more than 3 bookings (correlated subquery)
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    (
        SELECT COUNT(*)
        FROM "Booking" b
        WHERE b.user_id = u.user_id
    ) as booking_count
FROM "User" u
WHERE (
    SELECT COUNT(*)
    FROM "Booking" b
    WHERE b.user_id = u.user_id
) > 3
ORDER BY u.created_at;
