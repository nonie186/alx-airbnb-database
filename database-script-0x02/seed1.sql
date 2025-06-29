-- =======================================
-- 🧑 USERS
-- =======================================
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
  ('u1-0000-0000-0000-000000000001', 'Alice', 'Walker', 'alice@airbnb.com', 'hash_pw1', '0712345678', 'host', CURRENT_TIMESTAMP),
  ('u2-0000-0000-0000-000000000002', 'Brian', 'Mokoena', 'brian@guest.com', 'hash_pw2', '0723456789', 'guest', CURRENT_TIMESTAMP),
  ('u3-0000-0000-0000-000000000003', 'Carla', 'Ndlovu', 'carla@admin.com', 'hash_pw3', '0734567890', 'admin', CURRENT_TIMESTAMP),
  ('u4-0000-0000-0000-000000000004', 'David', 'Smith', 'david@guest.com', 'hash_pw4', NULL, 'guest', CURRENT_TIMESTAMP);

-- =======================================
-- 🏠 PROPERTIES
-- =======================================
INSERT INTO properties (property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
VALUES
  ('p1-0000-0000-0000-000000000001', 'u1-0000-0000-0000-000000000001', 'City Studio', 'Modern studio in Johannesburg CBD', 'Johannesburg', 900.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('p2-0000-0000-0000-000000000002', 'u1-0000-0000-0000-000000000001', 'Garden Loft', 'Spacious loft in Cape Town', 'Cape Town', 1500.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- =======================================
-- 📅 BOOKINGS
-- =======================================
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
  ('b1-0000-0000-0000-000000000001', 'p1-0000-0000-0000-000000000001', 'u2-0000-0000-0000-000000000002', '2025-07-01', '2025-07-05', 3600.00, 'confirmed', CURRENT_TIMESTAMP),
  ('b2-0000-0000-0000-000000000002', 'p2-0000-0000-0000-000000000002', 'u4-0000-0000-0000-000000000004', '2025-08-10', '2025-08-12', 3000.00, 'pending', CURRENT_TIMESTAMP);

-- =======================================
-- 💳 PAYMENTS
-- =======================================
INSERT INTO payments (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
  ('pay1-0000-0000-0000-000000000001', 'b1-0000-0000-0000-000000000001', 3600.00, CURRENT_TIMESTAMP, 'credit_card'),
  ('pay2-0000-0000-0000-000000000002', 'b2-0000-0000-0000-000000000002', 3000.00, CURRENT_TIMESTAMP, 'paypal');

-- =======================================
-- 🌟 REVIEWS
-- =======================================
INSERT INTO reviews (review_id, property_id, user_id, rating, comment, created_at)
VALUES
  ('r1-0000-0000-0000-000000000001', 'p1-0000-0000-0000-000000000001', 'u2-0000-0000-0000-000000000002', 5, 'Great location, very clean!', CURRENT_TIMESTAMP),
  ('r2-0000-0000-0000-000000000002', 'p2-0000-0000-0000-000000000002', 'u4-0000-0000-0000-000000000004', 4, 'Spacious and private, but no WiFi.', CURRENT_TIMESTAMP);

-- =======================================
-- 💬 MESSAGES
-- =======================================
INSERT INTO messages (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
  ('m1-0000-0000-0000-000000000001', 'u2-0000-0000-0000-000000000002', 'u1-0000-0000-0000-000000000001', 'Hi, is the studio available on the 1st?', CURRENT_TIMESTAMP),
  ('m2-0000-0000-0000-000000000002', 'u1-0000-0000-0000-000000000001', 'u2-0000-0000-0000-000000000002', 'Yes, feel free to book via the platform.', CURRENT_TIMESTAMP);

