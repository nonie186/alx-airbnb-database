# SQL Schema Definition – AirBnB Database

## 🎯 Objective

Define SQL `CREATE TABLE` statements for each entity based on the provided AirBnB database specification. This includes:

- Appropriate data types
- Primary and foreign keys
- Constraints
- Indexes (where applicable)

---

## 👤 Table: User

```sql
CREATE TABLE users (
  user_id UUID PRIMARY KEY,
  first_name VARCHAR NOT NULL,
  last_name VARCHAR NOT NULL,
  email VARCHAR UNIQUE NOT NULL,
  password_hash VARCHAR NOT NULL,
  phone_number VARCHAR,
  role ENUM('guest','host','admin') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE properties (
  property_id UUID PRIMARY KEY,
  host_id UUID,
  name VARCHAR NOT NULL,
  description TEXT NOT NULL,
  location VARCHAR NOT NULL,
  pricepernight DECIMAL NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP,
  FOREIGN KEY (host_id) REFERENCES users(user_id)
);

CREATE TABLE bookings (
  booking_id UUID PRIMARY KEY,
  property_id UUID,
  user_id UUID,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  total_price DECIMAL NOT NULL,
  status ENUM('pending','confirmed','canceled') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(property_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE payments (
  payment_id UUID PRIMARY KEY,
  booking_id UUID,
  amount DECIMAL NOT NULL,
  payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  payment_method ENUM('credit_card','paypal','stripe') NOT NULL,
  FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

CREATE TABLE reviews (
  review_id UUID PRIMARY KEY,
  property_id UUID,
  user_id UUID,
  rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
  comment TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(property_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE messages (
  message_id UUID PRIMARY KEY,
  sender_id UUID,
  recipient_id UUID,
  message_body TEXT NOT NULL,
  sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (sender_id) REFERENCES users(user_id),
  FOREIGN KEY (recipient_id) REFERENCES users(user_id)
);

Below is the visual representation of our AirBnB database schema:

![3NF Diagram](./3NF.png)

