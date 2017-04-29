CREATE TABLE expenses (
  id SERIAL PRIMARY KEY,
  amount NUMERIC(6,2) NOT NULL,
  memo TEXT NOT NULL,
  created_on DATE DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE expenses ADD CONSTRAINT positive_amount_only CHECK (amount >= 0.0);
