1. Non-Correlated Subquery
SELECT 
    property_id, 
    name, 
    description, 
    location, 
    pricepernight
FROM 
    Property
WHERE 
    property_id IN (
        SELECT 
            property_id
        FROM 
            Review
        GROUP BY 
            property_id
        HAVING 
            AVG(rating) > 4.0
    );
## Explanation:
The subquery gets all property_ids whose average rating is above 4.0.
The outer query retrieves full details of those properties.

2. Correlated Subquery
SELECT 
    user_id, 
    first_name, 
    last_name, 
    email
FROM 
    User u
WHERE 
    (
        SELECT COUNT(*)
        FROM Booking b
        WHERE b.user_id = u.user_id
    ) > 3;
## Explanation:
The subquery is correlated because it depends on each row of the outer User table (b.user_id = u.user_id).

It counts bookings per user, and filters for those with more than 3.
