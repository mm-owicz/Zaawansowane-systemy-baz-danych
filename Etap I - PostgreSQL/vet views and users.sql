
-- VET

-- users
CREATE ROLE amazurczak WITH LOGIN PASSWORD '123';
CREATE ROLE jsierakowski WITH LOGIN PASSWORD '123';
CREATE ROLE switowska WITH LOGIN PASSWORD '123';
CREATE ROLE jmrotek WITH LOGIN PASSWORD '123';
CREATE ROLE ajanowicz WITH LOGIN PASSWORD '123';

GRANT USAGE ON SCHEMA public TO amazurczak;
GRANT USAGE ON SCHEMA public TO jsierakowski;
GRANT USAGE ON SCHEMA public TO switowska;
GRANT USAGE ON SCHEMA public TO jmrotek;
GRANT USAGE ON SCHEMA public TO ajanowicz;

-- amazurczak

CREATE OR REPLACE VIEW vet_amazurczak_visits AS
SELECT 
	v.visit_id,
	v.visit_date,
	v.reason,
	p.pet_name,
	CONCAT(po.first_name, ' ', po.last_name) as pet_owner
FROM visit v
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po ON p.owner_id = po.owner_id
WHERE v.vet_id = 5;

CREATE VIEW vet_amazurczak_treatments AS
SELECT 
	t.treatment_id,
	v.visit_date,
	p.pet_name,
	t.treatment_type,
	t.procedure,
	t.notes
FROM treatment t
INNER JOIN visit v ON t.visit_id = v.visit_id
INNER JOIN pet p ON p.pet_id = v.pet_id
WHERE v.vet_id = 5;

CREATE VIEW vet_amazurczak_lab_tests AS
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
WHERE v.vet_id = 5;

CREATE VIEW vet_amazurczak_diagnosis AS
SELECT 
	d.diagnosis_id,
	v.visit_date,
	p.pet_name,
	d.diagnosis_type,
	d.notes
FROM diagnosis d
INNER JOIN visit v ON d.visit_id = v.visit_id
INNER JOIN pet p ON v.pet_id = p.pet_id
WHERE v.vet_id = 5;

CREATE VIEW vet_amazurczak_medication_plans AS
SELECT 
	m.medicine_plan_id,
	p.pet_name,
	d.diagnosis_type,
	m.medicine_name,
	CONCAT(m.dosage, ' ', m.dosage_unit) as dosage,
	m.frequency,
	m.duration
FROM medicine_plan m
INNER JOIN diagnosis d ON m.diagnosis_id = d.diagnosis_id
INNER JOIN visit v ON d.visit_id = v.visit_id
INNER JOIN pet p ON p.pet_id = v.pet_id
WHERE v.vet_id = 5;

CREATE VIEW vet_amazurczak_prescriptions AS
SELECT 
	pr.prescription_id,
	p.pet_name,
	pr.prescription_date,
	pr.medicine_name,
	pr.medicine_amount
FROM prescription pr
JOIN visit v ON pr.visit_id = v.visit_id
INNER JOIN pet p ON p.pet_id = v.pet_id
WHERE v.vet_id = 5;

CREATE VIEW vet_amazurczak_pet_owners AS
SELECT 
	po.owner_id,
	CONCAT(po.first_name, ' ', po.last_name) as name,
	po.phone_number,
	po.email_address,
	p.pet_name
FROM pet_owner po
INNER JOIN pet p ON po.owner_id = p.owner_id
JOIN visit v ON p.pet_id = v.pet_id
WHERE v.vet_id = 5;

CREATE VIEW vet_amazurczak_pets AS
SELECT 
	p.pet_id,
	p.pet_name,
	s.species_name as species,
	p.date_of_birth,
	p.gender,
	m.weight as latest_weight,
	m.height as latest_height,
	CONCAT(po.first_name, ' ', po.last_name) as pet_owner
FROM pet p
INNER JOIN visit v ON p.pet_id = v.pet_id
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
WHERE v.vet_id = 5;

CREATE VIEW vet_amazurczak_vets AS
SELECT
	st.staff_id,
	CONCAT(st.first_name, ' ', st.last_name) as name,
	st.phone_number,
	pos.position_name as position,
	st.specialization
FROM staff st
INNER JOIN staff_position sp ON sp.staff_id = st.staff_id
INNER JOIN position pos ON sp.position_id = pos.position_id
WHERE st.staff_id = 5;

CREATE OR REPLACE VIEW vet_amazurczak_measurements AS
SELECT DISTINCT
	m.measurement_id,
	p.pet_name,
	m.measurement_date,
	m.weight,
	m.height
FROM pet_measurement m
INNER JOIN pet p ON p.pet_id = m.pet_id
INNER JOIN visit v ON p.pet_id = v.pet_id
WHERE v.vet_id = 5;

CREATE OR REPLACE VIEW vet_amazurczak_positions AS
SELECT DISTINCT
	sp.staff_position_id,
	pos.position_name  as position,
	st.specialization,
	sp.from_date,
	sp.to_date
FROM staff st
INNER JOIN staff_position sp ON sp.staff_id = st.staff_id
INNER JOIN position pos ON sp.position_id = pos.position_id
WHERE st.staff_id = 5;

GRANT SELECT ON vet_amazurczak_visits TO amazurczak;
GRANT SELECT ON vet_amazurczak_treatments TO amazurczak;
GRANT SELECT ON vet_amazurczak_lab_tests TO amazurczak;
GRANT SELECT ON vet_amazurczak_diagnosis TO amazurczak;
GRANT SELECT ON vet_amazurczak_medication_plans TO amazurczak;
GRANT SELECT ON vet_amazurczak_prescriptions TO amazurczak;
GRANT SELECT ON vet_amazurczak_measurements TO amazurczak;
GRANT SELECT ON vet_amazurczak_pet_owners TO amazurczak;
GRANT SELECT ON vet_amazurczak_positions TO amazurczak;
GRANT SELECT ON vet_amazurczak_pets TO amazurczak;
GRANT SELECT ON vet_amazurczak_vets TO amazurczak;


-- jsierakowski

CREATE VIEW vet_jsierakowski_visits AS
SELECT 
v.visit_id,
v.visit_date,
v.reason,
p.pet_name,
CONCAT(po.first_name, ' ', po.last_name) as pet_owner
FROM visit v
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po ON p.owner_id = po.owner_id
WHERE vet_id = 6;

CREATE VIEW vet_jsierakowski_treatments AS
SELECT 
	t.treatment_id,
	v.visit_date,
	p.pet_name,
	t.treatment_type,
	t.procedure,
	t.notes
FROM treatment t
INNER JOIN visit v ON t.visit_id = v.visit_id
INNER JOIN pet p ON p.pet_id = v.pet_id
WHERE v.vet_id = 6;

CREATE VIEW vet_jsierakowski_lab_tests AS
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
WHERE v.vet_id = 6;

CREATE VIEW vet_jsierakowski_diagnosis AS
SELECT 
	d.diagnosis_id,
	v.visit_date,
	p.pet_name,
	d.diagnosis_type,
	d.notes
FROM diagnosis d
INNER JOIN visit v ON d.visit_id = v.visit_id
INNER JOIN pet p ON v.pet_id = p.pet_id
WHERE v.vet_id = 6;

CREATE VIEW vet_jsierakowski_medication_plans AS
SELECT 
	m.medicine_plan_id,
	p.pet_name,
	d.diagnosis_type,
	m.medicine_name,
	CONCAT(m.dosage, ' ', m.dosage_unit) as dosage,
	m.frequency,
	m.duration
FROM medicine_plan m
INNER JOIN diagnosis d ON m.diagnosis_id = d.diagnosis_id
INNER JOIN visit v ON d.visit_id = v.visit_id
INNER JOIN pet p ON p.pet_id = v.pet_id
WHERE v.vet_id = 6;

CREATE VIEW vet_jsierakowski_prescriptions AS
SELECT 
	pr.prescription_id,
	p.pet_name,
	pr.prescription_date,
	pr.medicine_name,
	pr.medicine_amount
FROM prescription pr
JOIN visit v ON pr.visit_id = v.visit_id
INNER JOIN pet p ON p.pet_id = v.pet_id
WHERE v.vet_id = 6;

CREATE VIEW vet_jsierakowski_pet_owners AS
SELECT 
	po.owner_id,
	CONCAT(po.first_name, ' ', po.last_name) as name,
	po.phone_number,
	po.email_address,
	p.pet_name
FROM pet_owner po
INNER JOIN pet p ON po.owner_id = p.owner_id
JOIN visit v ON p.pet_id = v.pet_id
WHERE v.vet_id = 6;

CREATE VIEW vet_jsierakowski_pets AS
SELECT 
	p.pet_id,
	p.pet_name,
	s.species_name as species,
	p.date_of_birth,
	p.gender,
	m.weight as latest_weight,
	m.height as latest_height,
	CONCAT(po.first_name, ' ', po.last_name) as pet_owner
FROM pet p
INNER JOIN visit v ON p.pet_id = v.pet_id
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
WHERE v.vet_id = 6;

CREATE VIEW vet_jsierakowski_vets AS
SELECT
	st.staff_id,
	CONCAT(st.first_name, ' ', st.last_name) as name,
	st.phone_number,
	pos.position_name as position,
	st.specialization
FROM staff st
INNER JOIN staff_position sp ON sp.staff_id = st.staff_id
INNER JOIN position pos ON sp.position_id = pos.position_id
WHERE st.staff_id = 6;

CREATE OR REPLACE VIEW vet_jsierakowski_measurements AS
SELECT DISTINCT
	m.measurement_id,
	p.pet_name,
	m.measurement_date,
	m.weight,
	m.height
FROM pet_measurement m
INNER JOIN pet p ON p.pet_id = m.pet_id
INNER JOIN visit v ON p.pet_id = v.pet_id
WHERE v.vet_id = 6;

CREATE OR REPLACE VIEW vet_jsierakowski_positions AS
SELECT DISTINCT
	sp.staff_position_id,
	pos.position_name  as position,
	st.specialization,
	sp.from_date,
	sp.to_date
FROM staff st
INNER JOIN staff_position sp ON sp.staff_id = st.staff_id
INNER JOIN position pos ON sp.position_id = pos.position_id
WHERE st.staff_id = 6;

GRANT SELECT ON vet_jsierakowski_visits TO jsierakowski;
GRANT SELECT ON vet_jsierakowski_treatments TO jsierakowski;
GRANT SELECT ON vet_jsierakowski_lab_tests TO jsierakowski;
GRANT SELECT ON vet_jsierakowski_diagnosis TO jsierakowski;
GRANT SELECT ON vet_jsierakowski_medication_plans TO jsierakowski;
GRANT SELECT ON vet_jsierakowski_prescriptions TO jsierakowski;
GRANT SELECT ON vet_jsierakowski_measurements TO jsierakowski;
GRANT SELECT ON vet_jsierakowski_pet_owners TO jsierakowski;
GRANT SELECT ON vet_jsierakowski_positions TO jsierakowski;
GRANT SELECT ON vet_jsierakowski_pets TO jsierakowski;
GRANT SELECT ON vet_jsierakowski_vets TO jsierakowski;

-- switowska

CREATE VIEW vet_switowska_visits AS
SELECT 
v.visit_id,
v.visit_date,
v.reason,
p.pet_name,
CONCAT(po.first_name, ' ', po.last_name) as pet_owner
FROM visit v
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po ON p.owner_id = po.owner_id
WHERE vet_id = 7;

CREATE VIEW vet_switowska_treatments AS
SELECT 
	t.treatment_id,
	v.visit_date,
	p.pet_name,
	t.treatment_type,
	t.procedure,
	t.notes
FROM treatment t
INNER JOIN visit v ON t.visit_id = v.visit_id
INNER JOIN pet p ON p.pet_id = v.pet_id
WHERE v.vet_id = 7;

CREATE VIEW vet_switowska_lab_tests AS
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
WHERE v.vet_id = 7;

CREATE VIEW vet_switowska_diagnosis AS
SELECT 
	d.diagnosis_id,
	v.visit_date,
	p.pet_name,
	d.diagnosis_type,
	d.notes
FROM diagnosis d
INNER JOIN visit v ON d.visit_id = v.visit_id
INNER JOIN pet p ON v.pet_id = p.pet_id
WHERE v.vet_id = 7;

CREATE VIEW vet_switowska_medication_plans AS
SELECT 
	m.medicine_plan_id,
	p.pet_name,
	d.diagnosis_type,
	m.medicine_name,
	CONCAT(m.dosage, ' ', m.dosage_unit) as dosage,
	m.frequency,
	m.duration
FROM medicine_plan m
INNER JOIN diagnosis d ON m.diagnosis_id = d.diagnosis_id
INNER JOIN visit v ON d.visit_id = v.visit_id
INNER JOIN pet p ON p.pet_id = v.pet_id
WHERE v.vet_id = 7;

CREATE VIEW vet_switowska_prescriptions AS
SELECT 
	pr.prescription_id,
	p.pet_name,
	pr.prescription_date,
	pr.medicine_name,
	pr.medicine_amount
FROM prescription pr
JOIN visit v ON pr.visit_id = v.visit_id
INNER JOIN pet p ON p.pet_id = v.pet_id
WHERE v.vet_id = 7;

CREATE VIEW vet_switowska_pet_owners AS
SELECT 
	po.owner_id,
	CONCAT(po.first_name, ' ', po.last_name) as name,
	po.phone_number,
	po.email_address,
	p.pet_name
FROM pet_owner po
INNER JOIN pet p ON po.owner_id = p.owner_id
JOIN visit v ON p.pet_id = v.pet_id
WHERE v.vet_id = 7;

CREATE VIEW vet_switowska_pets AS
SELECT 
	p.pet_id,
	p.pet_name,
	s.species_name as species,
	p.date_of_birth,
	p.gender,
	m.weight as latest_weight,
	m.height as latest_height,
	CONCAT(po.first_name, ' ', po.last_name) as pet_owner
FROM pet p
INNER JOIN visit v ON p.pet_id = v.pet_id
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
WHERE v.vet_id = 7;

CREATE VIEW vet_switowska_vets AS
SELECT
	st.staff_id,
	CONCAT(st.first_name, ' ', st.last_name) as name,
	st.phone_number,
	pos.position_name as position,
	st.specialization
FROM staff st
INNER JOIN staff_position sp ON sp.staff_id = st.staff_id
INNER JOIN position pos ON sp.position_id = pos.position_id
WHERE st.staff_id = 7;


CREATE OR REPLACE VIEW vet_switowska_measurements AS
SELECT DISTINCT
	m.measurement_id,
	p.pet_name,
	m.measurement_date,
	m.weight,
	m.height
FROM pet_measurement m
INNER JOIN pet p ON p.pet_id = m.pet_id
INNER JOIN visit v ON p.pet_id = v.pet_id
WHERE v.vet_id = 7;

CREATE OR REPLACE VIEW vet_switowska_positions AS
SELECT DISTINCT
	sp.staff_position_id,
	pos.position_name as position,
	st.specialization,
	sp.from_date,
	sp.to_date
FROM staff st
INNER JOIN staff_position sp ON sp.staff_id = st.staff_id
INNER JOIN position pos ON sp.position_id = pos.position_id
WHERE st.staff_id = 7;

GRANT SELECT ON vet_switowska_visits TO switowska;
GRANT SELECT ON vet_switowska_treatments TO switowska;
GRANT SELECT ON vet_switowska_lab_tests TO switowska;
GRANT SELECT ON vet_switowska_diagnosis TO switowska;
GRANT SELECT ON vet_switowska_medication_plans TO switowska;
GRANT SELECT ON vet_switowska_prescriptions TO switowska;
GRANT SELECT ON vet_switowska_measurements TO switowska;
GRANT SELECT ON vet_switowska_pet_owners TO switowska;
GRANT SELECT ON vet_switowska_positions TO switowska;
GRANT SELECT ON vet_switowska_pets TO switowska;
GRANT SELECT ON vet_switowska_vets TO switowska;

-- jmrotek

CREATE VIEW vet_jmrotek_visits AS
SELECT 
v.visit_id,
v.visit_date,
v.reason,
p.pet_name,
CONCAT(po.first_name, ' ', po.last_name) as pet_owner
FROM visit v
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po ON p.owner_id = po.owner_id
WHERE vet_id = 8;

CREATE VIEW vet_jmrotek_treatments AS
SELECT 
	t.treatment_id,
	v.visit_date,
	p.pet_name,
	t.treatment_type,
	t.procedure,
	t.notes
FROM treatment t
INNER JOIN visit v ON t.visit_id = v.visit_id
INNER JOIN pet p ON p.pet_id = v.pet_id
WHERE v.vet_id = 8;

CREATE VIEW vet_jmrotek_lab_tests AS
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
WHERE v.vet_id = 8;

CREATE VIEW vet_jmrotek_diagnosis AS
SELECT 
	d.diagnosis_id,
	v.visit_date,
	p.pet_name,
	d.diagnosis_type,
	d.notes
FROM diagnosis d
INNER JOIN visit v ON d.visit_id = v.visit_id
INNER JOIN pet p ON v.pet_id = p.pet_id
WHERE v.vet_id = 8;

CREATE VIEW vet_jmrotek_medication_plans AS
SELECT 
	m.medicine_plan_id,
	p.pet_name,
	d.diagnosis_type,
	m.medicine_name,
	CONCAT(m.dosage, ' ', m.dosage_unit) as dosage,
	m.frequency,
	m.duration
FROM medicine_plan m
INNER JOIN diagnosis d ON m.diagnosis_id = d.diagnosis_id
INNER JOIN visit v ON d.visit_id = v.visit_id
INNER JOIN pet p ON p.pet_id = v.pet_id
WHERE v.vet_id = 8;

CREATE VIEW vet_jmrotek_prescriptions AS
SELECT 
	pr.prescription_id,
	p.pet_name,
	pr.prescription_date,
	pr.medicine_name,
	pr.medicine_amount
FROM prescription pr
JOIN visit v ON pr.visit_id = v.visit_id
INNER JOIN pet p ON p.pet_id = v.pet_id
WHERE v.vet_id = 8;

CREATE VIEW vet_jmrotek_pet_owners AS
SELECT 
	po.owner_id,
	CONCAT(po.first_name, ' ', po.last_name) as name,
	po.phone_number,
	po.email_address,
	p.pet_name
FROM pet_owner po
INNER JOIN pet p ON po.owner_id = p.owner_id
JOIN visit v ON p.pet_id = v.pet_id
WHERE v.vet_id = 8;

CREATE VIEW vet_jmrotek_pets AS
SELECT 
	p.pet_id,
	p.pet_name,
	s.species_name as species,
	p.date_of_birth,
	p.gender,
	m.weight as latest_weight,
	m.height as latest_height,
	CONCAT(po.first_name, ' ', po.last_name) as pet_owner
FROM pet p
INNER JOIN visit v ON p.pet_id = v.pet_id
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
WHERE v.vet_id = 8;

CREATE VIEW vet_jmrotek_vets AS
SELECT
	st.staff_id,
	CONCAT(st.first_name, ' ', st.last_name) as name,
	st.phone_number,
	pos.position_name as position,
	st.specialization
FROM staff st
INNER JOIN staff_position sp ON sp.staff_id = st.staff_id
INNER JOIN position pos ON sp.position_id = pos.position_id
WHERE st.staff_id = 8;

CREATE OR REPLACE VIEW vet_jmrotek_measurements AS
SELECT DISTINCT
	m.measurement_id,
	p.pet_name,
	m.measurement_date,
	m.weight,
	m.height
FROM pet_measurement m
INNER JOIN pet p ON p.pet_id = m.pet_id
INNER JOIN visit v ON p.pet_id = v.pet_id
WHERE v.vet_id = 8;

CREATE OR REPLACE VIEW vet_jmrotek_positions AS
SELECT DISTINCT
	sp.staff_position_id,
	pos.position_name as position,
	st.specialization,
	sp.from_date,
	sp.to_date
FROM staff st
INNER JOIN staff_position sp ON sp.staff_id = st.staff_id
INNER JOIN position pos ON sp.position_id = pos.position_id
WHERE st.staff_id = 8;

GRANT SELECT ON vet_jmrotek_visits TO jmrotek;
GRANT SELECT ON vet_jmrotek_treatments TO jmrotek;
GRANT SELECT ON vet_jmrotek_lab_tests TO jmrotek;
GRANT SELECT ON vet_jmrotek_diagnosis TO jmrotek;
GRANT SELECT ON vet_jmrotek_medication_plans TO jmrotek;
GRANT SELECT ON vet_jmrotek_prescriptions TO jmrotek;
GRANT SELECT ON vet_jmrotek_measurements TO jmrotek;
GRANT SELECT ON vet_jmrotek_pet_owners TO jmrotek;
GRANT SELECT ON vet_jmrotek_positions TO jmrotek;
GRANT SELECT ON vet_jmrotek_pets TO jmrotek;
GRANT SELECT ON vet_jmrotek_vets TO jmrotek;


-- ajanowicz

CREATE VIEW vet_ajanowicz_visits AS
SELECT 
v.visit_id,
v.visit_date,
v.reason,
p.pet_name,
CONCAT(po.first_name, ' ', po.last_name) as pet_owner
FROM visit v
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po ON p.owner_id = po.owner_id
WHERE vet_id = 9;

CREATE VIEW vet_ajanowicz_treatments AS
SELECT 
	t.treatment_id,
	v.visit_date,
	p.pet_name,
	t.treatment_type,
	t.procedure,
	t.notes
FROM treatment t
INNER JOIN visit v ON t.visit_id = v.visit_id
INNER JOIN pet p ON p.pet_id = v.pet_id
WHERE v.vet_id = 9;

CREATE VIEW vet_ajanowicz_lab_tests AS
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
WHERE v.vet_id = 9;

CREATE VIEW vet_ajanowicz_diagnosis AS
SELECT 
	d.diagnosis_id,
	v.visit_date,
	p.pet_name,
	d.diagnosis_type,
	d.notes
FROM diagnosis d
INNER JOIN visit v ON d.visit_id = v.visit_id
INNER JOIN pet p ON v.pet_id = p.pet_id
WHERE v.vet_id = 9;

CREATE VIEW vet_ajanowicz_medication_plans AS
SELECT 
	m.medicine_plan_id,
	p.pet_name,
	d.diagnosis_type,
	m.medicine_name,
	CONCAT(m.dosage, ' ', m.dosage_unit) as dosage,
	m.frequency,
	m.duration
FROM medicine_plan m
INNER JOIN diagnosis d ON m.diagnosis_id = d.diagnosis_id
INNER JOIN visit v ON d.visit_id = v.visit_id
INNER JOIN pet p ON p.pet_id = v.pet_id
WHERE v.vet_id = 9;

CREATE VIEW vet_ajanowicz_prescriptions AS
SELECT 
	pr.prescription_id,
	p.pet_name,
	pr.prescription_date,
	pr.medicine_name,
	pr.medicine_amount
FROM prescription pr
JOIN visit v ON pr.visit_id = v.visit_id
INNER JOIN pet p ON p.pet_id = v.pet_id
WHERE v.vet_id = 9;

CREATE VIEW vet_ajanowicz_pet_owners AS
SELECT 
	po.owner_id,
	CONCAT(po.first_name, ' ', po.last_name) as name,
	po.phone_number,
	po.email_address,
	p.pet_name
FROM pet_owner po
INNER JOIN pet p ON po.owner_id = p.owner_id
JOIN visit v ON p.pet_id = v.pet_id
WHERE v.vet_id = 9;

CREATE VIEW vet_ajanowicz_pets AS
SELECT DISTINCT
	p.pet_id,
	p.pet_name,
	s.species_name as species,
	p.date_of_birth,
	p.gender,
	m.weight as latest_weight,
	m.height as latest_height,
	CONCAT(po.first_name, ' ', po.last_name) as pet_owner
FROM pet p
INNER JOIN visit v ON p.pet_id = v.pet_id
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
WHERE v.vet_id = 9;

CREATE VIEW vet_ajanowicz_vets AS
SELECT
	st.staff_id,
	CONCAT(st.first_name, ' ', st.last_name) as name,
	st.phone_number,
	pos.position_name as position,
	st.specialization
FROM staff st
INNER JOIN staff_position sp ON sp.staff_id = st.staff_id
INNER JOIN position pos ON sp.position_id = pos.position_id
WHERE st.staff_id = 9;

CREATE OR REPLACE VIEW vet_ajanowicz_measurements AS
SELECT DISTINCT
	m.measurement_id,
	p.pet_name,
	m.measurement_date,
	m.weight,
	m.height
FROM pet_measurement m
INNER JOIN pet p ON p.pet_id = m.pet_id
INNER JOIN visit v ON p.pet_id = v.pet_id
WHERE v.vet_id = 9;

CREATE OR REPLACE VIEW vet_ajanowicz_positions AS
SELECT DISTINCT
	sp.staff_position_id,
	pos.position_name as position,
	st.specialization,
	sp.from_date,
	sp.to_date
FROM staff st
INNER JOIN staff_position sp ON sp.staff_id = st.staff_id
INNER JOIN position pos ON sp.position_id = pos.position_id
WHERE st.staff_id = 9;

GRANT SELECT ON vet_ajanowicz_visits TO ajanowicz;
GRANT SELECT ON vet_ajanowicz_treatments TO ajanowicz;
GRANT SELECT ON vet_ajanowicz_lab_tests TO ajanowicz;
GRANT SELECT ON vet_ajanowicz_diagnosis TO ajanowicz;
GRANT SELECT ON vet_ajanowicz_medication_plans TO ajanowicz;
GRANT SELECT ON vet_ajanowicz_prescriptions TO ajanowicz;
GRANT SELECT ON vet_ajanowicz_measurements TO ajanowicz;
GRANT SELECT ON vet_ajanowicz_pet_owners TO ajanowicz;
GRANT SELECT ON vet_ajanowicz_positions TO ajanowicz;
GRANT SELECT ON vet_ajanowicz_pets TO ajanowicz;
GRANT SELECT ON vet_ajanowicz_vets TO ajanowicz;


