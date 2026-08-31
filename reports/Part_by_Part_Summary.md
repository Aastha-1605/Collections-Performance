# Part-by-Part Assignment Summary

| Assignment part | What was done | Conclusion |
|---|---|---|
| Golden Dataset | Built a targeted account-month analytical layer; canonicalized payment/call/message event keys; resolved borrower attributes through account master | `account_id` is trustworthy enough to anchor analysis; event borrower IDs are not |
| Data Forensics | Audited duplicates, identity conflicts, timestamps, payment references, time zones, denominator completeness and partial months | Material data-quality problems exist, but payment duplicates do not explain the Feb-Mar 11% increase |
| Statistical Investigation | Standardized March to February DPD x risk x loan mix; bootstrapped uncertainty; checked Jan-Jul trend and major biases | March improvement survives mix adjustment, but there is no sustained Jan-Jul improvement |
| 11% Claim | Compared raw recovery, cleaned recovery and targeted-exposure recovery rate | The 11% arithmetic is correct for Feb-Mar; saying operations are structurally improving is not supported |
| Counterfactual | Tested whether supplied files contain an identifiable mid-period targeting switch; designed randomized holdout / matched DiD fallback | No defensible causal switch estimate can be claimed from the supplied files alone |
| ₹10 Cr Investment | Compared targeting, telephony, agents, AI voice, digital and field evidence; calculated one-year break-even hurdle | Better borrower targeting is the best candidate, but release investment only after controlled lift clears ~0.43 pp |
| Production Analytics | Designed raw → staging → clean → golden → feature → metrics → dashboard with monitoring/backfills | Ready for an engineering team to operationalize |
