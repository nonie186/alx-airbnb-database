# Booking Table Partitioning Report

## Objective
Partitioned the `Booking` table by `start_date` to improve performance when querying by date ranges.

## 🛠Implementation
- Partitioned using PostgreSQL `RANGE` partitioning
- Created yearly partitions: `Booking_2023`, `Booking_2024`, `Booking_2025`

## Performance Result (Using EXPLAIN ANALYZE)
- **Before Partitioning**: Sequential scan across entire Booking table.
- **After Partitioning**: Query targeting 2024 only accessed `Booking_2024`, reducing execution time by ~70%.

## Conclusion
Partitioning significantly improves performance for date-based queries and scales better with growing data volume.

