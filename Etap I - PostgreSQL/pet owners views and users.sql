-- PET OWNERS

-- users
CREATE ROLE apawliczak WITH LOGIN PASSWORD '123';
CREATE ROLE mlesner WITH LOGIN PASSWORD '123';
CREATE ROLE cwysocki WITH LOGIN PASSWORD '123';
CREATE ROLE mkortaba WITH LOGIN PASSWORD '123';
CREATE ROLE pgalus WITH LOGIN PASSWORD '123';

GRANT USAGE ON SCHEMA public TO apawliczak;
GRANT USAGE ON SCHEMA public TO mlesner;
GRANT USAGE ON SCHEMA public TO cwysocki;
GRANT USAGE ON SCHEMA public TO mkortaba;
GRANT USAGE ON SCHEMA public TO pgalus;


-- apawliczak

CREATE VIEW owner_apawliczak_pet_owners AS
SELECT 
	po.owner_id,
	CONCAT(po.first_name, ' ', po.last_name) as name,
	po.phone_number,
	po.email_address,
	p.pet_name
FROM pet_owner po
INNER JOIN pet p ON po.owner_id = p.owner_id
JOIN visit v ON p.pet_id = v.pet_id
WHERE po.owner_id = 1;

CREATE VIEW owner_apawliczak_pets AS
SELECT 
	p.pet_id,
	p.pet_name,
	s.species_name as species,
	p.date_of_birth,
	p.gender,
	m.weight as latest_weight,
	m.height as latest_height
FROM pet p
INNER JOIN species s on p.species_id = s.species_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
LEFT JOIN (
    SELECT m1.pet_id, m1.height, m1.weight
    FROM pet_measurement m1
    JOIN (
        SELECT pet_id, MAX(measurement_date) AS latest_date
        FROM pet_measurement
        GROUP BY pet_id
    ) m2 ON m1.pet_id = m2.pet_id AND m1.measurement_date = m2.latest_date
) m ON p.pet_id = m.pet_id
WHERE po.owner_id = 1;

CREATE OR REPLACE VIEW owner_apawliczak_measurements AS
SELECT DISTINCT
	m.measurement_id,
	p.pet_name,
	m.measurement_date,
	m.weight,
	m.height
FROM pet_measurement m
INNER JOIN pet p ON p.pet_id = m.pet_id
INNER JOIN pet_owner po ON p.owner_id = po.owner_id
WHERE po.owner_id = 1;

CREATE OR REPLACE VIEW owner_apawliczak_visits AS
SELECT 
	v.visit_id,
	v.visit_date,
	v.reason,
	p.pet_name,
	CONCAT(vet.first_name, ' ', vet.last_name) as vet
FROM visit v
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po ON p.owner_id = po.owner_id
INNER JOIN staff vet ON vet.staff_id = v.vet_id
WHERE po.owner_id = 1;

CREATE VIEW owner_apawliczak_vets AS
SELECT
	st.staff_id,
	CONCAT(st.first_name, ' ', st.last_name) as name,
	st.phone_number,
	st.specialization
FROM staff st
INNER JOIN visit v ON v.vet_id = st.staff_id
INNER JOIN pet p ON v.pet_id = p.pet_id
INNER JOIN pet_owner po ON p.owner_id = po.owner_id
WHERE po.owner_id = 1;

CREATE VIEW owner_apawliczak_diagnosis AS
SELECT 
	d.diagnosis_id,
	v.visit_date,
	p.pet_name,
	d.diagnosis_type,
	d.notes,
	CONCAT(st.first_name, ' ', st.last_name) as vet
FROM diagnosis d
INNER JOIN visit v ON d.visit_id = v.visit_id
INNER JOIN staff st ON st.staff_id = v.vet_id
INNER JOIN pet p ON v.pet_id = p.pet_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
WHERE po.owner_id = 1;

CREATE VIEW owner_apawliczak_lab_tests AS
SELECT 
	l.lab_test_id,
	p.pet_name,
	l.test_date,
	l.test_type,
	l.test_results,
	l.notes
FROM lab_test l
INNER JOIN visit v ON l.visit_id = v.visit_id
INNER JOIN pet p ON v.pet_id = p.pet_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
WHERE po.owner_id = 1;

CREATE VIEW owner_apawliczak_treatments AS
SELECT 
	t.treatment_id,
	v.visit_date,
	p.pet_name,
	t.treatment_type,
	t.procedure,
	t.notes,
	CONCAT(st.first_name, ' ', st.last_name) as vet
FROM treatment t
INNER JOIN visit v ON t.visit_id = v.visit_id
INNER JOIN staff st ON st.staff_id = v.vet_id
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
WHERE po.owner_id = 1;

CREATE VIEW owner_apawliczak_prescriptions AS
SELECT 
	pr.prescription_id,
	p.pet_name,
	pr.prescription_date,
	pr.medicine_name,
	pr.medicine_amount,
	CONCAT(st.first_name, ' ', st.last_name) as vet
FROM prescription pr
JOIN visit v ON pr.visit_id = v.visit_id
INNER JOIN staff st ON st.staff_id = v.vet_id
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
WHERE po.owner_id = 1;

CREATE VIEW owner_apawliczak_medication_plans AS
SELECT 
	m.medicine_plan_id,
	p.pet_name,
	d.diagnosis_type,
	m.medicine_name,
	CONCAT(m.dosage, ' ', m.dosage_unit) as dosage,
	m.frequency,
	m.duration,
	CONCAT(st.first_name, ' ', st.last_name) as vet
FROM medicine_plan m
INNER JOIN diagnosis d ON m.diagnosis_id = d.diagnosis_id
INNER JOIN visit v ON d.visit_id = v.visit_id
INNER JOIN staff st ON st.staff_id = v.vet_id
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
WHERE po.owner_id = 1;

GRANT SELECT ON owner_apawliczak_pet_owners TO apawliczak;
GRANT SELECT ON owner_apawliczak_pets TO apawliczak;
GRANT SELECT ON owner_apawliczak_measurements TO apawliczak;
GRANT SELECT ON owner_apawliczak_visits TO apawliczak;
GRANT SELECT ON owner_apawliczak_vets TO apawliczak;
GRANT SELECT ON owner_apawliczak_diagnosis TO apawliczak;
GRANT SELECT ON owner_apawliczak_lab_tests TO apawliczak;
GRANT SELECT ON owner_apawliczak_treatments TO apawliczak;
GRANT SELECT ON owner_apawliczak_prescriptions TO apawliczak;
GRANT SELECT ON owner_apawliczak_medication_plans TO apawliczak;

-- mlesner 

CREATE VIEW owner_mlesner_pet_owners AS
SELECT 
	po.owner_id,
	CONCAT(po.first_name, ' ', po.last_name) as name,
	po.phone_number,
	po.email_address,
	p.pet_name
FROM pet_owner po
INNER JOIN pet p ON po.owner_id = p.owner_id
JOIN visit v ON p.pet_id = v.pet_id
WHERE po.owner_id = 2;

CREATE VIEW owner_mlesner_pets AS
SELECT 
	p.pet_id,
	p.pet_name,
	s.species_name as species,
	p.date_of_birth,
	p.gender,
	m.weight as latest_weight,
	m.height as latest_height
FROM pet p
INNER JOIN species s on p.species_id = s.species_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
LEFT JOIN (
    SELECT m1.pet_id, m1.height, m1.weight
    FROM pet_measurement m1
    JOIN (
        SELECT pet_id, MAX(measurement_date) AS latest_date
        FROM pet_measurement
        GROUP BY pet_id
    ) m2 ON m1.pet_id = m2.pet_id AND m1.measurement_date = m2.latest_date
) m ON p.pet_id = m.pet_id
WHERE po.owner_id = 2;

CREATE OR REPLACE VIEW owner_mlesner_measurements AS
SELECT DISTINCT
	m.measurement_id,
	p.pet_name,
	m.measurement_date,
	m.weight,
	m.height
FROM pet_measurement m
INNER JOIN pet p ON p.pet_id = m.pet_id
INNER JOIN pet_owner po ON p.owner_id = po.owner_id
WHERE po.owner_id = 2;

CREATE OR REPLACE VIEW owner_mlesner_visits AS
SELECT 
	v.visit_id,
	v.visit_date,
	v.reason,
	p.pet_name,
	CONCAT(vet.first_name, ' ', vet.last_name) as vet
FROM visit v
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po ON p.owner_id = po.owner_id
INNER JOIN staff vet ON vet.staff_id = v.vet_id
WHERE po.owner_id = 2;

CREATE VIEW owner_mlesner_vets AS
SELECT
	st.staff_id,
	CONCAT(st.first_name, ' ', st.last_name) as name,
	st.phone_number,
	st.specialization
FROM staff st
INNER JOIN visit v ON v.vet_id = st.staff_id
INNER JOIN pet p ON v.pet_id = p.pet_id
INNER JOIN pet_owner po ON p.owner_id = po.owner_id
WHERE po.owner_id = 2;

CREATE VIEW owner_mlesner_diagnosis AS
SELECT 
	d.diagnosis_id,
	v.visit_date,
	p.pet_name,
	d.diagnosis_type,
	d.notes,
	CONCAT(st.first_name, ' ', st.last_name) as vet
FROM diagnosis d
INNER JOIN visit v ON d.visit_id = v.visit_id
INNER JOIN staff st ON st.staff_id = v.vet_id
INNER JOIN pet p ON v.pet_id = p.pet_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
WHERE po.owner_id = 2;

CREATE VIEW owner_mlesner_lab_tests AS
SELECT 
	l.lab_test_id,
	p.pet_name,
	l.test_date,
	l.test_type,
	l.test_results,
	l.notes
FROM lab_test l
INNER JOIN visit v ON l.visit_id = v.visit_id
INNER JOIN pet p ON v.pet_id = p.pet_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
WHERE po.owner_id = 2;

CREATE VIEW owner_mlesner_treatments AS
SELECT 
	t.treatment_id,
	v.visit_date,
	p.pet_name,
	t.treatment_type,
	t.procedure,
	t.notes,
	CONCAT(st.first_name, ' ', st.last_name) as vet
FROM treatment t
INNER JOIN visit v ON t.visit_id = v.visit_id
INNER JOIN staff st ON st.staff_id = v.vet_id
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
WHERE po.owner_id = 2;

CREATE VIEW owner_mlesner_prescriptions AS
SELECT 
	pr.prescription_id,
	p.pet_name,
	pr.prescription_date,
	pr.medicine_name,
	pr.medicine_amount,
	CONCAT(st.first_name, ' ', st.last_name) as vet
FROM prescription pr
JOIN visit v ON pr.visit_id = v.visit_id
INNER JOIN staff st ON st.staff_id = v.vet_id
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
WHERE po.owner_id = 2;

CREATE VIEW owner_mlesner_medication_plans AS
SELECT 
	m.medicine_plan_id,
	p.pet_name,
	d.diagnosis_type,
	m.medicine_name,
	CONCAT(m.dosage, ' ', m.dosage_unit) as dosage,
	m.frequency,
	m.duration,
	CONCAT(st.first_name, ' ', st.last_name) as vet
FROM medicine_plan m
INNER JOIN diagnosis d ON m.diagnosis_id = d.diagnosis_id
INNER JOIN visit v ON d.visit_id = v.visit_id
INNER JOIN staff st ON st.staff_id = v.vet_id
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
WHERE po.owner_id = 2;

GRANT SELECT ON owner_mlesner_pet_owners TO mlesner;
GRANT SELECT ON owner_mlesner_pets TO mlesner;
GRANT SELECT ON owner_mlesner_measurements TO mlesner;
GRANT SELECT ON owner_mlesner_visits TO mlesner;
GRANT SELECT ON owner_mlesner_vets TO mlesner;
GRANT SELECT ON owner_mlesner_diagnosis TO mlesner;
GRANT SELECT ON owner_mlesner_lab_tests TO mlesner;
GRANT SELECT ON owner_mlesner_treatments TO mlesner;
GRANT SELECT ON owner_mlesner_prescriptions TO mlesner;
GRANT SELECT ON owner_mlesner_medication_plans TO mlesner;

-- cwysocki 

CREATE VIEW owner_cwysocki_pet_owners AS
SELECT 
	po.owner_id,
	CONCAT(po.first_name, ' ', po.last_name) as name,
	po.phone_number,
	po.email_address,
	p.pet_name
FROM pet_owner po
INNER JOIN pet p ON po.owner_id = p.owner_id
JOIN visit v ON p.pet_id = v.pet_id
WHERE po.owner_id = 3;

CREATE VIEW owner_cwysocki_pets AS
SELECT 
	p.pet_id,
	p.pet_name,
	s.species_name as species,
	p.date_of_birth,
	p.gender,
	m.weight as latest_weight,
	m.height as latest_height
FROM pet p
INNER JOIN species s on p.species_id = s.species_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
LEFT JOIN (
    SELECT m1.pet_id, m1.height, m1.weight
    FROM pet_measurement m1
    JOIN (
        SELECT pet_id, MAX(measurement_date) AS latest_date
        FROM pet_measurement
        GROUP BY pet_id
    ) m2 ON m1.pet_id = m2.pet_id AND m1.measurement_date = m2.latest_date
) m ON p.pet_id = m.pet_id
WHERE po.owner_id = 3;

CREATE OR REPLACE VIEW owner_cwysocki_measurements AS
SELECT DISTINCT
	m.measurement_id,
	p.pet_name,
	m.measurement_date,
	m.weight,
	m.height
FROM pet_measurement m
INNER JOIN pet p ON p.pet_id = m.pet_id
INNER JOIN pet_owner po ON p.owner_id = po.owner_id
WHERE po.owner_id = 3;

CREATE OR REPLACE VIEW owner_cwysocki_visits AS
SELECT 
	v.visit_id,
	v.visit_date,
	v.reason,
	p.pet_name,
	CONCAT(vet.first_name, ' ', vet.last_name) as vet
FROM visit v
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po ON p.owner_id = po.owner_id
INNER JOIN staff vet ON vet.staff_id = v.vet_id
WHERE po.owner_id = 3;

CREATE VIEW owner_cwysocki_vets AS
SELECT
	st.staff_id,
	CONCAT(st.first_name, ' ', st.last_name) as name,
	st.phone_number,
	st.specialization
FROM staff st
INNER JOIN visit v ON v.vet_id = st.staff_id
INNER JOIN pet p ON v.pet_id = p.pet_id
INNER JOIN pet_owner po ON p.owner_id = po.owner_id
WHERE po.owner_id = 3;

CREATE VIEW owner_cwysocki_diagnosis AS
SELECT 
	d.diagnosis_id,
	v.visit_date,
	p.pet_name,
	d.diagnosis_type,
	d.notes,
	CONCAT(st.first_name, ' ', st.last_name) as vet
FROM diagnosis d
INNER JOIN visit v ON d.visit_id = v.visit_id
INNER JOIN staff st ON st.staff_id = v.vet_id
INNER JOIN pet p ON v.pet_id = p.pet_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
WHERE po.owner_id = 3;

CREATE VIEW owner_cwysocki_lab_tests AS
SELECT 
	l.lab_test_id,
	p.pet_name,
	l.test_date,
	l.test_type,
	l.test_results,
	l.notes
FROM lab_test l
INNER JOIN visit v ON l.visit_id = v.visit_id
INNER JOIN pet p ON v.pet_id = p.pet_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
WHERE po.owner_id = 3;

CREATE VIEW owner_cwysocki_treatments AS
SELECT 
	t.treatment_id,
	v.visit_date,
	p.pet_name,
	t.treatment_type,
	t.procedure,
	t.notes,
	CONCAT(st.first_name, ' ', st.last_name) as vet
FROM treatment t
INNER JOIN visit v ON t.visit_id = v.visit_id
INNER JOIN staff st ON st.staff_id = v.vet_id
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
WHERE po.owner_id = 3;

CREATE VIEW owner_cwysocki_prescriptions AS
SELECT 
	pr.prescription_id,
	p.pet_name,
	pr.prescription_date,
	pr.medicine_name,
	pr.medicine_amount,
	CONCAT(st.first_name, ' ', st.last_name) as vet
FROM prescription pr
JOIN visit v ON pr.visit_id = v.visit_id
INNER JOIN staff st ON st.staff_id = v.vet_id
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
WHERE po.owner_id = 3;

CREATE VIEW owner_cwysocki_medication_plans AS
SELECT 
	m.medicine_plan_id,
	p.pet_name,
	d.diagnosis_type,
	m.medicine_name,
	CONCAT(m.dosage, ' ', m.dosage_unit) as dosage,
	m.frequency,
	m.duration,
	CONCAT(st.first_name, ' ', st.last_name) as vet
FROM medicine_plan m
INNER JOIN diagnosis d ON m.diagnosis_id = d.diagnosis_id
INNER JOIN visit v ON d.visit_id = v.visit_id
INNER JOIN staff st ON st.staff_id = v.vet_id
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
WHERE po.owner_id = 3;

GRANT SELECT ON owner_cwysocki_pet_owners TO cwysocki;
GRANT SELECT ON owner_cwysocki_pets TO cwysocki;
GRANT SELECT ON owner_cwysocki_measurements TO cwysocki;
GRANT SELECT ON owner_cwysocki_visits TO cwysocki;
GRANT SELECT ON owner_cwysocki_vets TO cwysocki;
GRANT SELECT ON owner_cwysocki_diagnosis TO cwysocki;
GRANT SELECT ON owner_cwysocki_lab_tests TO cwysocki;
GRANT SELECT ON owner_cwysocki_treatments TO cwysocki;
GRANT SELECT ON owner_cwysocki_prescriptions TO cwysocki;
GRANT SELECT ON owner_cwysocki_medication_plans TO cwysocki;

-- mkortaba 

CREATE VIEW owner_mkortaba_pet_owners AS
SELECT 
	po.owner_id,
	CONCAT(po.first_name, ' ', po.last_name) as name,
	po.phone_number,
	po.email_address,
	p.pet_name
FROM pet_owner po
INNER JOIN pet p ON po.owner_id = p.owner_id
JOIN visit v ON p.pet_id = v.pet_id
WHERE po.owner_id = 4;

CREATE VIEW owner_mkortaba_pets AS
SELECT 
	p.pet_id,
	p.pet_name,
	s.species_name as species,
	p.date_of_birth,
	p.gender,
	m.weight as latest_weight,
	m.height as latest_height
FROM pet p
INNER JOIN species s on p.species_id = s.species_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
LEFT JOIN (
    SELECT m1.pet_id, m1.height, m1.weight
    FROM pet_measurement m1
    JOIN (
        SELECT pet_id, MAX(measurement_date) AS latest_date
        FROM pet_measurement
        GROUP BY pet_id
    ) m2 ON m1.pet_id = m2.pet_id AND m1.measurement_date = m2.latest_date
) m ON p.pet_id = m.pet_id
WHERE po.owner_id = 4;

CREATE OR REPLACE VIEW owner_mkortaba_measurements AS
SELECT DISTINCT
	m.measurement_id,
	p.pet_name,
	m.measurement_date,
	m.weight,
	m.height
FROM pet_measurement m
INNER JOIN pet p ON p.pet_id = m.pet_id
INNER JOIN pet_owner po ON p.owner_id = po.owner_id
WHERE po.owner_id = 4;

CREATE OR REPLACE VIEW owner_mkortaba_visits AS
SELECT 
	v.visit_id,
	v.visit_date,
	v.reason,
	p.pet_name,
	CONCAT(vet.first_name, ' ', vet.last_name) as vet
FROM visit v
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po ON p.owner_id = po.owner_id
INNER JOIN staff vet ON vet.staff_id = v.vet_id
WHERE po.owner_id = 4;

CREATE VIEW owner_mkortaba_vets AS
SELECT
	st.staff_id,
	CONCAT(st.first_name, ' ', st.last_name) as name,
	st.phone_number,
	st.specialization
FROM staff st
INNER JOIN visit v ON v.vet_id = st.staff_id
INNER JOIN pet p ON v.pet_id = p.pet_id
INNER JOIN pet_owner po ON p.owner_id = po.owner_id
WHERE po.owner_id = 4;

CREATE VIEW owner_mkortaba_diagnosis AS
SELECT 
	d.diagnosis_id,
	v.visit_date,
	p.pet_name,
	d.diagnosis_type,
	d.notes,
	CONCAT(st.first_name, ' ', st.last_name) as vet
FROM diagnosis d
INNER JOIN visit v ON d.visit_id = v.visit_id
INNER JOIN staff st ON st.staff_id = v.vet_id
INNER JOIN pet p ON v.pet_id = p.pet_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
WHERE po.owner_id = 4;

CREATE VIEW owner_mkortaba_lab_tests AS
SELECT 
	l.lab_test_id,
	p.pet_name,
	l.test_date,
	l.test_type,
	l.test_results,
	l.notes
FROM lab_test l
INNER JOIN visit v ON l.visit_id = v.visit_id
INNER JOIN pet p ON v.pet_id = p.pet_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
WHERE po.owner_id = 4;

CREATE VIEW owner_mkortaba_treatments AS
SELECT 
	t.treatment_id,
	v.visit_date,
	p.pet_name,
	t.treatment_type,
	t.procedure,
	t.notes,
	CONCAT(st.first_name, ' ', st.last_name) as vet
FROM treatment t
INNER JOIN visit v ON t.visit_id = v.visit_id
INNER JOIN staff st ON st.staff_id = v.vet_id
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
WHERE po.owner_id = 4;

CREATE VIEW owner_mkortaba_prescriptions AS
SELECT 
	pr.prescription_id,
	p.pet_name,
	pr.prescription_date,
	pr.medicine_name,
	pr.medicine_amount,
	CONCAT(st.first_name, ' ', st.last_name) as vet
FROM prescription pr
JOIN visit v ON pr.visit_id = v.visit_id
INNER JOIN staff st ON st.staff_id = v.vet_id
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
WHERE po.owner_id = 4;

CREATE VIEW owner_mkortaba_medication_plans AS
SELECT 
	m.medicine_plan_id,
	p.pet_name,
	d.diagnosis_type,
	m.medicine_name,
	CONCAT(m.dosage, ' ', m.dosage_unit) as dosage,
	m.frequency,
	m.duration,
	CONCAT(st.first_name, ' ', st.last_name) as vet
FROM medicine_plan m
INNER JOIN diagnosis d ON m.diagnosis_id = d.diagnosis_id
INNER JOIN visit v ON d.visit_id = v.visit_id
INNER JOIN staff st ON st.staff_id = v.vet_id
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
WHERE po.owner_id = 4;

GRANT SELECT ON owner_mkortaba_pet_owners TO mkortaba;
GRANT SELECT ON owner_mkortaba_pets TO mkortaba;
GRANT SELECT ON owner_mkortaba_measurements TO mkortaba;
GRANT SELECT ON owner_mkortaba_visits TO mkortaba;
GRANT SELECT ON owner_mkortaba_vets TO mkortaba;
GRANT SELECT ON owner_mkortaba_diagnosis TO mkortaba;
GRANT SELECT ON owner_mkortaba_lab_tests TO mkortaba;
GRANT SELECT ON owner_mkortaba_treatments TO mkortaba;
GRANT SELECT ON owner_mkortaba_prescriptions TO mkortaba;
GRANT SELECT ON owner_mkortaba_medication_plans TO mkortaba;

-- pgalus 

CREATE VIEW owner_pgalus_pet_owners AS
SELECT 
	po.owner_id,
	CONCAT(po.first_name, ' ', po.last_name) as name,
	po.phone_number,
	po.email_address,
	p.pet_name
FROM pet_owner po
INNER JOIN pet p ON po.owner_id = p.owner_id
JOIN visit v ON p.pet_id = v.pet_id
WHERE po.owner_id = 5;

CREATE VIEW owner_pgalus_pets AS
SELECT 
	p.pet_id,
	p.pet_name,
	s.species_name as species,
	p.date_of_birth,
	p.gender,
	m.weight as latest_weight,
	m.height as latest_height
FROM pet p
INNER JOIN species s on p.species_id = s.species_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
LEFT JOIN (
    SELECT m1.pet_id, m1.height, m1.weight
    FROM pet_measurement m1
    JOIN (
        SELECT pet_id, MAX(measurement_date) AS latest_date
        FROM pet_measurement
        GROUP BY pet_id
    ) m2 ON m1.pet_id = m2.pet_id AND m1.measurement_date = m2.latest_date
) m ON p.pet_id = m.pet_id
WHERE po.owner_id = 5;

CREATE OR REPLACE VIEW owner_pgalus_measurements AS
SELECT DISTINCT
	m.measurement_id,
	p.pet_name,
	m.measurement_date,
	m.weight,
	m.height
FROM pet_measurement m
INNER JOIN pet p ON p.pet_id = m.pet_id
INNER JOIN pet_owner po ON p.owner_id = po.owner_id
WHERE po.owner_id = 5;

CREATE OR REPLACE VIEW owner_pgalus_visits AS
SELECT 
	v.visit_id,
	v.visit_date,
	v.reason,
	p.pet_name,
	CONCAT(vet.first_name, ' ', vet.last_name) as vet
FROM visit v
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po ON p.owner_id = po.owner_id
INNER JOIN staff vet ON vet.staff_id = v.vet_id
WHERE po.owner_id = 5;

CREATE VIEW owner_pgalus_vets AS
SELECT
	st.staff_id,
	CONCAT(st.first_name, ' ', st.last_name) as name,
	st.phone_number,
	st.specialization
FROM staff st
INNER JOIN visit v ON v.vet_id = st.staff_id
INNER JOIN pet p ON v.pet_id = p.pet_id
INNER JOIN pet_owner po ON p.owner_id = po.owner_id
WHERE po.owner_id = 5;

CREATE VIEW owner_pgalus_diagnosis AS
SELECT 
	d.diagnosis_id,
	v.visit_date,
	p.pet_name,
	d.diagnosis_type,
	d.notes,
	CONCAT(st.first_name, ' ', st.last_name) as vet
FROM diagnosis d
INNER JOIN visit v ON d.visit_id = v.visit_id
INNER JOIN staff st ON st.staff_id = v.vet_id
INNER JOIN pet p ON v.pet_id = p.pet_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
WHERE po.owner_id = 5;

CREATE VIEW owner_pgalus_lab_tests AS
SELECT 
	l.lab_test_id,
	p.pet_name,
	l.test_date,
	l.test_type,
	l.test_results,
	l.notes
FROM lab_test l
INNER JOIN visit v ON l.visit_id = v.visit_id
INNER JOIN pet p ON v.pet_id = p.pet_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
WHERE po.owner_id = 5;

CREATE VIEW owner_pgalus_treatments AS
SELECT 
	t.treatment_id,
	v.visit_date,
	p.pet_name,
	t.treatment_type,
	t.procedure,
	t.notes,
	CONCAT(st.first_name, ' ', st.last_name) as vet
FROM treatment t
INNER JOIN visit v ON t.visit_id = v.visit_id
INNER JOIN staff st ON st.staff_id = v.vet_id
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
WHERE po.owner_id = 5;

CREATE VIEW owner_pgalus_prescriptions AS
SELECT 
	pr.prescription_id,
	p.pet_name,
	pr.prescription_date,
	pr.medicine_name,
	pr.medicine_amount,
	CONCAT(st.first_name, ' ', st.last_name) as vet
FROM prescription pr
JOIN visit v ON pr.visit_id = v.visit_id
INNER JOIN staff st ON st.staff_id = v.vet_id
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
WHERE po.owner_id = 5;

CREATE VIEW owner_pgalus_medication_plans AS
SELECT 
	m.medicine_plan_id,
	p.pet_name,
	d.diagnosis_type,
	m.medicine_name,
	CONCAT(m.dosage, ' ', m.dosage_unit) as dosage,
	m.frequency,
	m.duration,
	CONCAT(st.first_name, ' ', st.last_name) as vet
FROM medicine_plan m
INNER JOIN diagnosis d ON m.diagnosis_id = d.diagnosis_id
INNER JOIN visit v ON d.visit_id = v.visit_id
INNER JOIN staff st ON st.staff_id = v.vet_id
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
WHERE po.owner_id = 5;


GRANT SELECT ON owner_pgalus_pet_owners TO pgalus;
GRANT SELECT ON owner_pgalus_pets TO pgalus;
GRANT SELECT ON owner_pgalus_measurements TO pgalus;
GRANT SELECT ON owner_pgalus_visits TO pgalus;
GRANT SELECT ON owner_pgalus_vets TO pgalus;
GRANT SELECT ON owner_pgalus_diagnosis TO pgalus;
GRANT SELECT ON owner_pgalus_lab_tests TO pgalus;
GRANT SELECT ON owner_pgalus_treatments TO pgalus;
GRANT SELECT ON owner_pgalus_prescriptions TO pgalus;
GRANT SELECT ON owner_pgalus_medication_plans TO pgalus;



