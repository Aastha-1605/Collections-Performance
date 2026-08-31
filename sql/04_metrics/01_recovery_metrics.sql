-- Independent recovery definitions.
SELECT month,
 SUM(recovery_amount) AS recovery_amount,
 SUM(outstanding_amount) AS targeted_exposure,
 SUM(recovery_amount)/NULLIF(SUM(outstanding_amount),0) AS targeted_recovery_rate,
 COUNT(DISTINCT account_id) AS targeted_accounts,
 SUM(recovery_amount)/NULLIF(COUNT(DISTINCT account_id),0) AS recovery_per_account
FROM golden_account_month
GROUP BY month ORDER BY month;
