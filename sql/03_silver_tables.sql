-- SILVER --
-- ========== Core Entities ==========
CREATE TABLE IF NOT EXISTS silver.patients (
  patient_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  normalized_name TEXT,
  gender TEXT,
  blood_type TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS silver.doctors (
  doctor_id SERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL,
  normalized_name TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS silver.hospitals (
  hospital_id SERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL,
  normalized_name TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS silver.insurance_providers (
  insurer_id SERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS silver.medical_conditions (
  condition_id SERIAL PRIMARY KEY,
  condition_name TEXT UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS silver.medications (
  medication_id SERIAL PRIMARY KEY,
  medication_name TEXT UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS silver.tests (
  test_id SERIAL PRIMARY KEY,
  result TEXT CHECK (result IN('Normal', 'Abnormal', 'Inconclusive'))
);

-- ========== Relationships / fatcs ==========

CREATE TABLE IF NOT EXISTS silver.admissions (
  admission_id SERIAL PRIMARY KEY,
  patient_id INT REFERENCES silver.patients(patient_id),
  doctor_id INT REFERENCES silver.doctors(doctor_id),
  hospital_id INT REFERENCES silver.hospitals(hospital_id),
  insurer_id INT REFERENCES silver.insurance_providers(insurer_id),
  condition_id INT REFERENCES silver.medical_condition(condition_id),
  medication_id INT REFERENCES silver.medications(medication_id),
  test_id INT REFERENCES silver.tests(test_id),
  age_at_admission INT,
  admission_date DATE,
  discharge_date DATE,
  admission_type TEXT CHECK (admission_type IN ('Urgent', 'Emergency', 'Elective')),
  room_number TEXT,
  billing_amount NUMERIC(12,2),
  created_at TIMESTAMPTZ DEFAULT now()
);
