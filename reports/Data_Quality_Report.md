# Data Quality Report

## Executive conclusion
The raw layer cannot be used directly for borrower-level or recovery reporting. The largest issue is identity inconsistency: event-level `borrower_id` conflicts with the account master in ~98% of core event rows. The analytical pipeline therefore treats `account_id` as the stable entity key and re-derives borrower identity through `accounts`.

| Issue | Detection | Treatment | Business impact |
|---|---|---|---|
| Duplicate payments | Exact-row and `payment_id` uniqueness checks | One canonical row per `payment_id`, preferring non-null transaction reference | Raw recovery is inflated; cleaned totals are used for all KPIs |
| Duplicate calls | Exact-row and `call_id` uniqueness checks | One canonical row per `call_id` | Prevents contact-rate denominator inflation |
| Duplicate WhatsApp events | Event-PK check | One row per `whatsapp_event_id` | Prevents channel activity inflation |
| Borrower ID contradiction | Compare event `borrower_id` with `accounts.borrower_id` for same account | Ignore event borrower identity; resolve through account master | Prevents invalid geography/borrower segmentation |
| Payment-reference reuse | Check reference across account/amount/status | Do not globally dedupe by `payment_reference` | Prevents deletion of legitimate distinct payment events |
| Timestamp contradictions | Pairwise chronology checks | Preserve source values, flag issue, avoid invalid history-based inference | Reduces false lifecycle/late-arrival conclusions |
| Mixed time zones | Inspect row/source timezone | Normalize call-hour analysis to Asia/Kolkata | Avoids wrong time-of-day conclusions |
| Partial August | Date completeness audit | Exclude Aug 1-8 from trend inference | Prevents artificial -75% MoM decline |
| Missing cost data | Schema audit | Do not fabricate cost-per-rupee KPI; use explicit investment scenarios | Keeps ROI assumptions visible |
| No clean strategy-switch flag | Targeting/campaign audit | Do not fabricate causal effect; propose randomized holdout | Avoids unsupported counterfactual claims |

## Quantified duplicate findings
- `payments.csv`: 486 exact duplicate rows; 500 duplicated payment IDs.
- `calls.csv`: 1,271 exact duplicate rows.
- `whatsapp_events.csv`: 600 exact duplicate rows.
- `borrowers.csv`: 600 exact duplicate rows.

## Timestamp findings
- 15,354 borrower rows have `updated_at < created_at`.
- 30,191 account-status-history rows have `recorded_at < event_at`.

## Reconciliation principle
Every cleaning step is designed to be idempotent and keyed by a documented business/event key. The repository retains raw files, cleaned/golden outputs and reconciliation tables so leadership can see how reported rupee totals change from raw to trusted analytics.
