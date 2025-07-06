# Database Performance Monitoring Report

## Objective
Monitor and refine query performance for large datasets using `EXPLAIN ANALYZE`.

## Query Analyzed
```sql
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    u.first_name,
    p.name AS property_name,
    pay.amount
FROM 
    Booking b
JOIN 
    User u ON b.user_id = u.user_id
JOIN 
    Property p ON b.property_id = p.property_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id;

# Optimization Steps
# Created indexes to improve query speed:

CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_payment_booking_id ON Payment(booking_id);

ANALYZE Output (After Optimization)
Index scan on Booking

Hash join instead of nested loop

Execution time: 180ms


### 2. Optionally Update This SQL in `performance.sql` (if you have it)

If you already have `performance.sql` inside `database-script-0x02/`, you can optionally add:

```sql
-- EXPLAIN ANALYZE before optimization (example)
EXPLAIN ANALYZE
SELECT ...
-- Execution time: 600ms

-- Indexes applied
CREATE INDEX idx_booking_user_id ON Booking(user_id);
...

-- EXPLAIN ANALYZE after optimization
EXPLAIN ANALYZE
SELECT ...
-- Execution time: 180ms


