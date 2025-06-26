# Normalising the AirBnB Schema to Third Normal Form (3 NF)

## 0  Starting Point
The original schema contained six core entities:

* **User · Property · Booking · Payment · Review · Message**

Although largely tidy, a review uncovered a few derived attributes and “all-in-one” columns that could create update anomalies over time.

---

## 1  First Normal Form (1 NF)

| Requirement | Action taken |
|-------------|--------------|
| Each cell must hold **one value only** | • Verified all columns are scalar.<br>• Split `Property.location` (see 3 NF). |
| No repeating groups / arrays | None detected. |

---

## 2  Second Normal Form (2 NF)

Because every table already uses a **single-column surrogate primary key (`UUID`)**, there were *no* partial-dependency problems.  
No changes required.

---

## 3  Third Normal Form (3 NF)

| Issue found | Why it violates 3 NF | Remedy |
|-------------|----------------------|--------|
| `Booking.total_price` is **derivable** from `price_per_night × #nights` | A non-key column depends on other non-key columns → transitive dependency | **Removed** `total_price`.  Expose a view or computed column if you need quick access. |
| `Property.location` crams multilevel data (city / state / country) into one field | Encourages duplication & hard-to-query text searches | **New table `Location`** with `location_id` PK; `Property` now holds `location_id`. |
| ENUMs hard-coded in several tables (`role`, `status`, `payment_method`) | Fine for tiny lists, but not flexible, and cannot be FK-constrained | **Lookup tables** added (e.g., `Role`, `BookingStatus`, `PaymentMethod`).  Foreign keys ensure only valid values. |
| Potential duplicate reviews per guest & property | Not a 3 NF breach, but a consistency risk | Added **composite -‐ UNIQUE(property_id, user_id)** in `Review`. |

---

## 4  Revised Mini-Schema (DBML excerpt)

```dbml
Table User {
  user_id       UUID   [pk]
  first_name    VARCHAR [not null]
  last_name     VARCHAR [not null]
  email         VARCHAR [unique, not null]
  password_hash VARCHAR [not null]
  phone_number  VARCHAR
  role_id       SMALLINT [not null, ref: > Role.role_id]
  created_at    TIMESTAMP [default: `CURRENT_TIMESTAMP`]
}

Table Role {
  role_id SMALLINT [pk]
  role_name VARCHAR [unique, not null]  -- guest, host, admin
}

Table Location {
  location_id  UUID [pk]
  city         VARCHAR [not null]
  state_region VARCHAR
  country      VARCHAR [not null]
}

Table Property {
  property_id   UUID [pk]
  host_id       UUID  [ref: > User.user_id]
  location_id   UUID  [ref: > Location.location_id]
  name          VARCHAR [not null]
  description   TEXT    [not null]
  price_per_night DECIMAL [not null]
  created_at    TIMESTAMP [default: `CURRENT_TIMESTAMP`]
  updated_at    TIMESTAMP
}

Table BookingStatus {
  status_id SMALLINT [pk]
  status_name VARCHAR [unique, not null] -- pending / confirmed / canceled
}

Table Booking {
  booking_id   UUID [pk]
  property_id  UUID [ref: > Property.property_id]
  user_id      UUID [ref: > User.user_id]
  status_id    SMALLINT [ref: > BookingStatus.status_id]
  start_date   DATE [not null]
  end_date     DATE [not null]
  created_at   TIMESTAMP [default: `CURRENT_TIMESTAMP`]
  -- total_price removed: compute at runtime
}

Table PaymentMethod {
  method_id SMALLINT [pk]
  method_name VARCHAR [unique, not null] -- credit_card / paypal / stripe
}

Table Payment {
  payment_id    UUID [pk]
  booking_id    UUID [ref: > Booking.booking_id]
  amount        DECIMAL [not null]
  payment_date  TIMESTAMP [default: `CURRENT_TIMESTAMP`]
  method_id     SMALLINT [ref: > PaymentMethod.method_id]
}

Table Review {
  review_id  UUID [pk]
  property_id UUID [ref: > Property.property_id]
  user_id     UUID [ref: > User.user_id]
  rating      INTEGER [not null, note: '1-5']
  comment     TEXT [not null]
  created_at  TIMESTAMP [default: `CURRENT_TIMESTAMP`]

  indexes {
    (property_id, user_id) [unique]  -- prevent duplicate reviews
  }
}

Table Message {
  message_id   UUID [pk]
  sender_id    UUID [ref: > User.user_id]
  recipient_id UUID [ref: > User.user_id]
  message_body TEXT [not null]
  sent_at      TIMESTAMP [default: `CURRENT_TIMESTAMP`]
}
