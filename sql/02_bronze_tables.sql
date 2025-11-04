-- BRONZE
CREATE TABLE IF NOT EXISTS bronze.raw_events (
  id SERIAL PRIMARY KEY,
  source_file TEXT,
  raw_record JSONB NOT NULL,
  ingestion_ts TIMESTAMPTZ DEFAULT now()
);
