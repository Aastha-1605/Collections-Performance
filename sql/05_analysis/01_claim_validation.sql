-- Validate the reported Feb->Mar improvement using deduped successful payments.
WITH m AS (
 SELECT strftime(CAST(event_at AS TIMESTAMP),'%Y-%m') month, SUM(amount) recovery
 FROM valid_recovery GROUP BY 1
)
SELECT mar.recovery/feb.recovery-1 AS feb_to_mar_change
FROM m feb CROSS JOIN m mar
WHERE feb.month='2026-02' AND mar.month='2026-03';
