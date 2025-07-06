-- 🧾 Initial Complex Query
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_method
FROM 
    Booking b
JOIN 
    User u ON b.user_id = u.user_id
JOIN 
    Property p ON b.property_id = p.property_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id;

-- EXPLAIN ANALYZE results here (copy and comment output)
-- Total runtime: 850ms
-- Seq Scan on Booking...
-- Nested Loop...

-- ✅ Optimized Query
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,
    u.first_name || ' ' || u.last_name AS full_name,
    u.email,
    p.name AS property_name,
    p.location,
    pay.amount,
    pay.payment_method
FROM 
    Booking b
INNER JOIN 
    User u ON b.user_id = u.user_id
INNER JOIN 
    Property p ON b.property_id = p.property_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id;

-- EXPLAIN ANALYZE after optimization (optional)
-- Total runtime: 120ms
-- Index Scan on Booking...
-- Hash Join...
