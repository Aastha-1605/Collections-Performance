"""Core rules used in the submission.
1) account_id is the analytical entity key.
2) event borrower_id is not trusted; derive borrower_id from accounts.
3) payment_id is deduplicated; SUCCESS only counts as recovery.
4) August 2026 is partial (through Aug 8) and excluded from trend inference.
5) monthly operational denominator = unique targeted-account outstanding exposure.
See notebooks/collections_forensic_analysis.ipynb for executable analysis.
"""
