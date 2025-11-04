#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  \i /sql/01_schemas.sql
  \i /sql/02_bronze_tables.sql
  \i /sql/03_silver_tables.sql
  \i /sql/04_gold_views.sql
  \i /sql/05_seed_data.sql
EOSQL

echo "✅ Database initialized successfully!"