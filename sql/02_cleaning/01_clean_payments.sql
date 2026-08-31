-- payment_id is the event primary key. Prefer the row with a non-null reference; only SUCCESS is recovery.
CREATE OR REPLACE TABLE clean_payments AS
WITH ranked AS (
 SELECT *, ROW_NUMBER() OVER (PARTITION BY payment_id ORDER BY CASE WHEN payment_reference IS NOT NULL THEN 0 ELSE 1 END) rn
 FROM stg_payments
)
SELECT * EXCLUDE(rn) FROM ranked WHERE rn=1;

CREATE OR REPLACE VIEW valid_recovery AS
SELECT * FROM clean_payments WHERE payment_status='SUCCESS';
