-- Forensic checks (DuckDB-compatible)
-- 1) Exact duplicate payment rows
SELECT SUM(n - 1) AS duplicate_rows
FROM (
  SELECT payment_id, account_id, borrower_id, event_at, payment_reference, amount,
         payment_status, payment_method, provider_id, COUNT(*) AS n
  FROM stg_payments
  GROUP BY ALL
) x
WHERE n > 1;

-- 2) Borrower/account disagreement: event borrower_id is unsafe for segmentation
SELECT AVG(CASE WHEN p.borrower_id <> a.borrower_id THEN 1.0 ELSE 0.0 END) AS mismatch_rate
FROM stg_payments p JOIN stg_accounts a USING(account_id);

-- 3) Denominator audit
SELECT strftime(CAST(target_date AS DATE),'%Y-%m') month,
       COUNT(DISTINCT account_id) eligible_accounts
FROM stg_targeting
GROUP BY 1 ORDER BY 1;
