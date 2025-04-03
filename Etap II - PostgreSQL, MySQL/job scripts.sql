-- STEP 1
DROP TABLE IF EXISTS job_log;
CREATE TABLE job_log (
    log_id SERIAL PRIMARY KEY,
    check_name TEXT,
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    errors_found INT
);

-- STEP 2
-- pet - species
WITH pet_check_species AS (
    SELECT COUNT(*) AS n_species
    FROM pet
    WHERE species_id IS NOT NULL AND species_id NOT IN (SELECT species_id FROM species)
)
INSERT INTO job_log (check_name, log_time, errors_found)
SELECT 'Pet - FK Species check', CURRENT_TIMESTAMP, n_species
FROM pet_check_species;

-- pet - owner
WITH pet_check_owner AS (
    SELECT COUNT(*) AS n_owner
    FROM pet
    WHERE owner_id IS NOT NULL AND owner_id NOT IN (SELECT owner_id FROM pet_owner)
)
INSERT INTO job_log (check_name, log_time, errors_found)
SELECT 'Pet - FK Owner check', CURRENT_TIMESTAMP, n_owner
FROM pet_check_owner;

-- pet measurement - pet
WITH pet_measurement_check_pet AS (
    SELECT COUNT(*) AS n_pet
    FROM pet_measurement
    WHERE pet_id IS NOT NULL AND pet_id NOT IN (SELECT pet_id FROM pet)
)
INSERT INTO job_log (check_name, log_time, errors_found)
SELECT 'Pet measurement - FK Pet check', CURRENT_TIMESTAMP, n_pet
FROM pet_measurement_check_pet;

-- staff position - position
WITH staff_position_check_position AS (
    SELECT COUNT(*) AS n_position
    FROM staff_position
    WHERE position_id IS NOT NULL AND position_id NOT IN (SELECT position_id FROM position)
)
INSERT INTO job_log (check_name, log_time, errors_found)
SELECT 'Staff position - FK Position check', CURRENT_TIMESTAMP, n_position
FROM staff_position_check_position;

-- Staff position - staff
WITH staff_position_check_staff AS (
    SELECT COUNT(*) AS n_staff
    FROM staff_position
    WHERE staff_id IS NOT NULL AND staff_id NOT IN (SELECT staff_id FROM staff)
)
INSERT INTO job_log (check_name, log_time, errors_found)
SELECT 'Staff position - FK Staff check', CURRENT_TIMESTAMP, n_staff
FROM staff_position_check_staff;

-- Visit - pet
WITH visit_check_pet AS (
    SELECT COUNT(*) AS n_pet
    FROM visit
    WHERE pet_id IS NOT NULL AND pet_id NOT IN (SELECT pet_id FROM pet)
)
INSERT INTO job_log (check_name, log_time, errors_found)
SELECT 'Visit - FK Pet check', CURRENT_TIMESTAMP, n_pet
FROM visit_check_pet;

-- Visit - vet
WITH visit_check_vet AS (
    SELECT COUNT(*) AS n_vet
    FROM visit
    WHERE vet_id IS NOT NULL AND vet_id NOT IN (SELECT staff_id FROM staff)
)
INSERT INTO job_log (check_name, log_time, errors_found)
SELECT 'Visit - FK Vet check', CURRENT_TIMESTAMP, n_vet
FROM visit_check_vet;

-- Lab test - visit
WITH lab_test_check_visit AS (
    SELECT COUNT(*) AS n_visit
    FROM lab_test
    WHERE visit_id IS NOT NULL AND visit_id NOT IN (SELECT visit_id FROM visit)
)
INSERT INTO job_log (check_name, log_time, errors_found)
SELECT 'Lab test - FK visit check', CURRENT_TIMESTAMP, n_visit
FROM lab_test_check_visit;

-- Treatment - visit
WITH treatment_check_visit AS (
    SELECT COUNT(*) AS n_visit
    FROM treatment
    WHERE visit_id IS NOT NULL AND visit_id NOT IN (SELECT visit_id FROM visit)
)
INSERT INTO job_log (check_name, log_time, errors_found)
SELECT 'Treatment - FK Visit check', CURRENT_TIMESTAMP, n_visit
FROM treatment_check_visit;

-- Prescription - visit
WITH prescription_check_visit AS (
    SELECT COUNT(*) AS n_visit
    FROM prescription
    WHERE visit_id IS NOT NULL AND visit_id NOT IN (SELECT visit_id FROM visit)
)
INSERT INTO job_log (check_name, log_time, errors_found)
SELECT 'Prescription - FK Visit check', CURRENT_TIMESTAMP, n_visit
FROM prescription_check_visit;

-- Diagnosis - visit
WITH diagnosis_check_visit AS (
    SELECT COUNT(*) AS n_visit
    FROM diagnosis
    WHERE visit_id IS NOT NULL AND visit_id NOT IN (SELECT visit_id FROM visit)
)
INSERT INTO job_log (check_name, log_time, errors_found)
SELECT 'Diagnosis - FK Visit check', CURRENT_TIMESTAMP, n_visit
FROM diagnosis_check_visit;

-- Medicine plan - diagnosis
WITH med_plan_check_diagnosis AS (
    SELECT COUNT(*) AS n_diagnosis
    FROM medicine_plan
    WHERE diagnosis_id IS NOT NULL AND diagnosis_id NOT IN (SELECT diagnosis_id FROM diagnosis)
)
INSERT INTO job_log (check_name, log_time, errors_found)
SELECT 'Medicine plan - FK Diagnosis check', CURRENT_TIMESTAMP, n_diagnosis
FROM med_plan_check_diagnosis;

-- STEP 3
COPY job_log TO 'C:\Users\Public\integrity_check_results.csv' DELIMITER ',' CSV HEADER;


