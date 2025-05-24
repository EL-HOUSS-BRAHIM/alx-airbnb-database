-- Task 5: Table Partitioning Implementation

-- Create partitioned Booking table
CREATE TABLE "Booking_Partitioned" (
    booking_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID REFERENCES "Property"(property_id),
    user_id UUID REFERENCES "User"(user_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status booking_status NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (start_date);

-- Create partitions for different date ranges
CREATE TABLE booking_past PARTITION OF "Booking_Partitioned"
    FOR VALUES FROM (MINVALUE) TO ('2025-01-01');

CREATE TABLE booking_current_year PARTITION OF "Booking_Partitioned"
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

CREATE TABLE booking_next_year PARTITION OF "Booking_Partitioned"
    FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');

CREATE TABLE booking_future PARTITION OF "Booking_Partitioned"
    FOR VALUES FROM ('2027-01-01') TO (MAXVALUE);

-- Create indexes on partitions
CREATE INDEX idx_booking_past_dates ON booking_past(start_date, end_date);
CREATE INDEX idx_booking_current_dates ON booking_current_year(start_date, end_date);
CREATE INDEX idx_booking_next_dates ON booking_next_year(start_date, end_date);
CREATE INDEX idx_booking_future_dates ON booking_future(start_date, end_date);

-- Migration function
CREATE OR REPLACE FUNCTION migrate_bookings()
RETURNS void AS $$
BEGIN
    INSERT INTO "Booking_Partitioned"
    SELECT * FROM "Booking";
END;
$$ LANGUAGE plpgsql;

-- Sample queries to test partitioning
-- Query for current year bookings
EXPLAIN ANALYZE
SELECT *
FROM "Booking_Partitioned"
WHERE start_date BETWEEN '2025-01-01' AND '2025-12-31';

-- Query for specific date range across partitions
EXPLAIN ANALYZE
SELECT *
FROM "Booking_Partitioned"
WHERE start_date BETWEEN '2024-12-01' AND '2025-02-01';
