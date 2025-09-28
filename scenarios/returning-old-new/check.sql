\timing on
DROP TABLE IF EXISTS returning_demo;
CREATE TABLE returning_demo (
    id          serial PRIMARY KEY,
    account     text NOT NULL,
    balance     numeric(12,2) NOT NULL
);

INSERT INTO returning_demo (account, balance)
SELECT 'acct-' || gs::text, 1000 + (random() * 500)::numeric(12,2)
FROM generate_series(1, 10) AS gs;

\echo 'Running UPDATE with RETURNING OLD/NEW (PostgreSQL 18 feature)'
BEGIN;
UPDATE returning_demo
SET balance = balance - 50
WHERE id <= 3
RETURNING OLD.balance AS before_balance,
          NEW.balance AS after_balance,
          OLD.id;
ROLLBACK;
