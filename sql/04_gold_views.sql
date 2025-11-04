-- GOLD Layer: Aggregated / Analytics Views

CREATE MATERIALIZED VIEW IF NOT EXISTS gold.admission_summary AS
SELECT
  h.name AS hospital,
  d.name AS doctor,
  mc.condition_name AS condition,
  COUNT(a.admission_id) AS total_admissions,
  ROUND(AVG(a.billing_amount), 2) AS avg_billing,
  ROUND(AVG(a.age_at_admission), 1) AS avg_age
FROM silver.admissions a
JOIN silver.hospitals h ON a.hospital_id = h.hospital_id
JOIN silver.doctors d ON a.doctor_id = d.doctor_id
JOIN silver.medical_conditions mc ON a.condition_id = mc.condition_id
GROUP BY h.name, d.name, mc.condition_name;

-- Index to speed up queries
CREATE INDEX IF NOT EXISTS idx_gold_summary_hospital
  ON gold.admission_summary (hospital);
