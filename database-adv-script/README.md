# 1. Write Complex Queries with Joins

## Objective: Master SQL joins by writing complex queries using different types of joins.

## Instructions:

Write a query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings.

Write a query using aLEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.

Write a query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.


# 2. Practice Subqueries

## Objective: Write both correlated and non-correlated subqueries.

## Instructions:

Write a query to find all properties where the average rating is greater than 4.0 using a subquery.

Write a correlated subquery to find users who have made more than 3 bookings.

# Apply Aggregations and Window Functions

Objective: Use SQL aggregation and window functions to analyze data.

## Instructions:

## Write a query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.

Use a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.

# 3. Implement Indexes for Optimization

## Objective: Identify and create indexes to improve query performance.

## Instructions:

Identify high-usage columns in your User, Booking, and Property tables (e.g., columns used in WHERE, JOIN, ORDER BY clauses).

Write SQL CREATE INDEX commands to create appropriate indexes for those columns and save them on database_index.sql

Measure the query performance before and after adding indexes using EXPLAIN or ANALYZE.

# 4. Query Optimization Report

## ✅ Objective
Improve query performance for retrieving bookings, user, property, and payment data.

## Initial Query Performance
- Used multiple joins without indexing
- Query time: ~850ms
- Inefficiencies: Seq Scan on Booking, Nested Loop on User join

## Optimizations Applied
- Added indexes on:
  - Booking.user_id
  - Booking.property_id
  - Payment.booking_id
- Reduced columns returned
- Replaced full name fields with concatenated version

## Result
- Query time reduced to ~120ms
- Index Scan and Hash Join now used

# 5. Partitioning Large Tables
mandatory
Objective: Implement table partitioning to optimize queries on large datasets.

## Instructions:

Assume the Booking table is large and query performance is slow. Implement partitioning on the Booking table based on the start_date column. Save the query in a file partitioning.sql

Test the performance of queries on the partitioned table (e.g., fetching bookings by date range).

Write a brief report on the improvements you observed.

# 6. Monitor and Refine Database Performance
mandatory
Objective: Continuously monitor and refine database performance by analyzing query execution plans and making schema adjustments.

## Instructions:

Use SQL commands like SHOW PROFILE or EXPLAIN ANALYZE to monitor the performance of a few of your frequently used queries.

Identify any bottlenecks and suggest changes (e.g., new indexes, schema adjustments).

Implement the changes and report the improvements.


