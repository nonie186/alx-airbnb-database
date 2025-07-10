## 1. **Total Number of Bookings by Each User**

```sql
SELECT 
    b.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM 
    Booking b
JOIN 
    User u ON b.user_id = u.user_id
GROUP BY 
    b.user_id, u.first_name, u.last_name;
```

> 🎯 This query returns each user and how many bookings they’ve made.


## 2. **Rank Properties by Total Bookings (Using RANK)**

```sql
SELECT 
    p.property_id,
    p.name AS property_name,
    COUNT(b.booking_id) AS booking_count,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.name;
```

> This query ranks each property by how many bookings it has, from most to least.



### Optional: Use `ROW_NUMBER()` instead of `RANK()` if you want strict ranking

Just change the ranking line like this:

```sql
ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
```

## Run These in MySQL Workbench or CLI

You can test both queries in:

* **MySQL Workbench**
* or terminal using: `mysql -u root -p` → then `USE your_database;`


