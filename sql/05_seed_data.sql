-- BRONZE
CREATE TABLE IF NOT EXISTS bronze.raw_events (
  id SERIAL PRIMARY KEY,
  source_file TEXT,
  raw_record JSONB NOT NULL,
  ingestion_ts TIMESTAMPTZ DEFAULT now()
);

-- SILVER (normalizado simplificado)
CREATE TABLE IF NOT EXISTS silver.patients (
  patient_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  normalized_name TEXT,
  gender TEXT,
  blood_type TEXT
);

CREATE TABLE IF NOT EXISTS silver.doctors (
  doctor_id SERIAL PRIMARY KEY,
  name TEXT UNIQUE
);

CREATE TABLE IF NOT EXISTS silver.hospitals (
  hospital_id SERIAL PRIMARY KEY,
  name TEXT UNIQUE
);

CREATE TABLE IF NOT EXISTS silver.admissions (
  admission_id SERIAL PRIMARY KEY,
  patient_id INT REFERENCES silver.patients(patient_id),
  doctor_id INT REFERENCES silver.doctors(doctor_id),
  hospital_id INT REFERENCES silver.hospitals(hospital_id),
  insurer TEXT,
  admission_date DATE,
  discharge_date DATE,
  admission_type TEXT,
  room_number TEXT,
  medical_condition TEXT,
  age_at_admission INT,
  billing_amount NUMERIC(12,2)
);

-- GOLD: Recomend create materialized views on demand. (TBD)
