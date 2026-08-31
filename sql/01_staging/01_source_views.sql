-- DuckDB-compatible staging views. Run from repository root.
CREATE OR REPLACE VIEW stg_accounts AS SELECT * FROM read_csv_auto('data/raw/accounts.csv', header=true);
CREATE OR REPLACE VIEW stg_payments AS SELECT * FROM read_csv_auto('data/raw/payments.csv', header=true);
CREATE OR REPLACE VIEW stg_calls AS SELECT * FROM read_csv_auto('data/raw/calls.csv', header=true);
CREATE OR REPLACE VIEW stg_targeting AS SELECT * FROM read_csv_auto('data/raw/daily_targeting.csv', header=true);
CREATE OR REPLACE VIEW stg_borrowers AS SELECT * FROM read_csv_auto('data/raw/borrowers.csv', header=true);
CREATE OR REPLACE VIEW stg_campaigns AS SELECT * FROM read_csv_auto('data/raw/campaigns.csv', header=true);
