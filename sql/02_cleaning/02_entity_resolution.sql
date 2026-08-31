-- Event borrower_id is not trusted. account_id is stable and borrower identity is re-derived from accounts.
CREATE OR REPLACE VIEW resolved_accounts AS
SELECT a.*, b.city, b.state
FROM stg_accounts a
LEFT JOIN (
  SELECT * EXCLUDE(rn) FROM (
    SELECT *, ROW_NUMBER() OVER(PARTITION BY borrower_id ORDER BY TRY_CAST(updated_at AS TIMESTAMP) DESC) rn
    FROM stg_borrowers
  ) WHERE rn=1
) b USING (borrower_id);
