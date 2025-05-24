-- User Table Indexes
CREATE INDEX IF NOT EXISTS idx_user_email ON "User"(email);
CREATE INDEX IF NOT EXISTS idx_user_role ON "User"(role);
CREATE INDEX IF NOT EXISTS idx_user_created_at ON "User"(created_at);

-- Booking Table Indexes
CREATE INDEX IF NOT EXISTS idx_booking_dates ON "Booking"(start_date, end_date);
CREATE INDEX IF NOT EXISTS idx_booking_status ON "Booking"(status);
CREATE INDEX IF NOT EXISTS idx_booking_property ON "Booking"(property_id);
CREATE INDEX IF NOT EXISTS idx_booking_user ON "Booking"(user_id);

-- Property Table Indexes
CREATE INDEX IF NOT EXISTS idx_property_location ON "Property"(location);
CREATE INDEX IF NOT EXISTS idx_property_host ON "Property"(host_id);
CREATE INDEX IF NOT EXISTS idx_property_created ON "Property"(created_at);

-- Performance Measurement: Before Creating Indexes
-- Run this first to see performance without indexes
EXPLAIN ANALYZE
SELECT u.email, b.start_date, b.end_date, p.name
FROM "User" u
JOIN "Booking" b ON u.user_id = b.user_id
JOIN "Property" p ON b.property_id = p.property_id
WHERE u.role = 'guest'
AND b.status = 'confirmed'
AND p.location = 'Portland';

-- After creating indexes, run the same query to compare performance
EXPLAIN ANALYZE
SELECT u.email, b.start_date, b.end_date, p.name
FROM "User" u
JOIN "Booking" b ON u.user_id = b.user_id
JOIN "Property" p ON b.property_id = p.property_id
WHERE u.role = 'guest'
AND b.status = 'confirmed'
AND p.location = 'Portland';

-- Additional performance test queries
-- Test email lookup performance
EXPLAIN ANALYZE
SELECT * FROM "User" WHERE email = 'test@example.com';

-- Test date range query performance
EXPLAIN ANALYZE
SELECT * FROM "Booking" 
WHERE start_date >= '2025-01-01' 
AND end_date <= '2025-12-31';

-- Test property search by location
EXPLAIN ANALYZE
SELECT * FROM "Property" 
WHERE location = 'Portland'
ORDER BY created_at DESC;

-- Monitor index usage
SELECT 
    schemaname, 
    tablename, 
    indexname, 
    idx_scan, 
    idx_tup_read, 
    idx_tup_fetch 
FROM pg_stat_user_indexes 
WHERE 
    schemaname = 'public' 
    AND (
        tablename = 'User' 
        OR tablename = 'Booking' 
        OR tablename = 'Property'
    );
