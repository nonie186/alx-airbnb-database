Step 1: Identify High-Usage Columns
| Table      | Column        | Reason                     |
| ---------- | ------------- | -------------------------- |
| `User`     | `email`       | `WHERE` clause, login/auth |
| `Booking`  | `user_id`     | `JOIN`, filtering by user  |
| `Booking`  | `property_id` | `JOIN`, aggregation        |
| `Property` | `location`    | Search/filter              |
| `Review`   | `property_id` | Aggregations, joins        |

Step 2: SQL to Create Indexes
-- Index on User email (frequently searched during login)
CREATE INDEX idx_user_email ON User(email);

-- Index on Booking.user_id (frequent joins and filters)
CREATE INDEX idx_booking_user_id ON Booking(user_id);

-- Index on Booking.property_id (join with Property)
CREATE INDEX idx_booking_property_id ON Booking(property_id);

--  Index on Property.location (used in search filters)
CREATE INDEX idx_property_location ON Property(location);

-- Index on Review.property_id (used in ratings aggregation)
CREATE INDEX idx_review_property_id ON Review(property_id);

Step 3: Measure Performance with EXPLAIN or ANALYZE
EXPLAIN ANALYZE
SELECT 
    u.user_id, u.first_name, COUNT(b.booking_id) AS total_bookings
FROM 
    User u
JOIN 
    Booking b ON u.user_id = b.user_id
GROUP BY 
    u.user_id;


