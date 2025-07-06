-- Step 1: Create the parent Booking table (partitioned by start_date range)
CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL REFERENCES Property(property_id),
    user_id UUID NOT NULL REFERENCES User(user_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL NOT NULL,
    status TEXT CHECK (status IN ('pending', 'confirmed', 'canceled')) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (start_date);

-- Step 2: Create child partitions by year
CREATE TABLE Booking_2023 PARTITION OF Booking
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE Booking_2024 PARTITION OF Booking
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE Booking_2025 PARTITION OF Booking
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Step 3: Optional index on child tables
CREATE INDEX idx_booking_2023_user_id ON Booking_2023(user_id);
CREATE INDEX idx_booking_2024_user_id ON Booking_2024(user_id);
CREATE INDEX idx_booking_2025_user_id ON Booking_2025(user_id);

