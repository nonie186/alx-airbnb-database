1. Total Number of Bookings Per User (Using COUNT + GROUP BY)

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM 
    User u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.first_name, u.last_name
ORDER BY 
    total_bookings DESC;

## What this does:
Uses COUNT() to get the total number of bookings per user.

Uses LEFT JOIN to also show users with 0 bookings.

Sorted by most active users first.

# 2. Rank Properties by Total Bookings (Using RANK() or ROW_NUMBER())
SELECT 
    property_id,
    total_bookings,
    RANK() OVER (ORDER BY total_bookings DESC) AS rank
FROM (
    SELECT 
        p.property_id,
        COUNT(b.booking_id) AS total_bookings
    FROM 
        Property p
    LEFT JOIN 
        Booking b ON p.property_id = b.property_id
    GROUP BY 
        p.property_id
) AS booking_counts;

## What this does:
Aggregates the total bookings per property inside a subquery.

Applies the RANK() window function to rank them from most to least booked.

ROW_NUMBER() could be used instead of RANK() if you want no ties.

