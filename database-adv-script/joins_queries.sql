# 1. INNER JOIN: Bookings with the Users Who Made Them
SELECT 
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM 
    Booking b
INNER JOIN 
    User u ON b.user_id = u.user_id;

# 2. LEFT JOIN: Properties with Their Reviews (Even if No Reviews)
SELECT 
    p.property_id,
    p.name AS property_name,
    p.description,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at AS review_date
FROM 
    Property p
LEFT JOIN 
    Review r ON p.property_id = r.property_id;

# 3. FULL OUTER JOIN: Users and Bookings (All Users and All Bookings, Matched or Not)
>SELECT 
    u.user_id,
    u.first_name,
    u.email,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.status
FROM 
    User u
FULL OUTER JOIN 
    Booking b ON u.user_id = b.user_id;


