CREATE OR REPLACE TABLE golden_account_month AS
WITH t AS (
 SELECT account_id, strftime(CAST(target_date AS DATE),'%Y-%m') month,
        COUNT(DISTINCT target_id) target_events, MAX(priority) priority,
        MODE(recommended_channel) recommended_channel
 FROM stg_targeting GROUP BY 1,2
), p AS (
 SELECT account_id, strftime(CAST(event_at AS TIMESTAMP),'%Y-%m') month,
        SUM(amount) recovery_amount, COUNT(DISTINCT payment_id) successful_payments
 FROM valid_recovery GROUP BY 1,2
)
SELECT t.*, a.borrower_id, a.loan_type, a.outstanding_amount, a.dpd, a.risk_segment, a.status, a.city, a.state,
       COALESCE(p.recovery_amount,0) recovery_amount, COALESCE(p.successful_payments,0) successful_payments
FROM t JOIN resolved_accounts a USING(account_id)
LEFT JOIN p USING(account_id,month);
