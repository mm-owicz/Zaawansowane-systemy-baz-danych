
-- STAFF

-- users
CREATE ROLE jopolska WITH LOGIN PASSWORD '123';
CREATE ROLE pwojnar WITH LOGIN PASSWORD '123';
CREATE ROLE jbiskupska WITH LOGIN PASSWORD '123';
CREATE ROLE sdanielczyk WITH LOGIN PASSWORD '123';

GRANT USAGE ON SCHEMA public TO jopolska;
GRANT USAGE ON SCHEMA public TO pwojnar;
GRANT USAGE ON SCHEMA public TO jbiskupska;
GRANT USAGE ON SCHEMA public TO sdanielczyk;


-- jopolska i pwojnar

CREATE VIEW recept_visits AS
SELECT 
	v.visit_id,
	v.visit_date,
	v.reason,
	p.pet_name,
	CONCAT(po.first_name, ' ', po.last_name) as pet_owner
FROM visit v
INNER JOIN pet p ON p.pet_id = v.pet_id
INNER JOIN pet_owner po ON p.owner_id = po.owner_id;

CREATE VIEW recept_staff AS
SELECT
	st.staff_id,
	CONCAT(st.first_name, ' ', st.last_name) as name,
	st.phone_number,
	pos.position_name as position,
	st.specialization
FROM staff st
INNER JOIN staff_position sp ON sp.staff_id = st.staff_id
INNER JOIN position pos ON sp.position_id = pos.position_id
;

CREATE OR REPLACE VIEW recept_positions AS
SELECT DISTINCT
	sp.staff_position_id,
	CONCAT(st.first_name, ' ', st.last_name) as staff_name,
	pos.position_name as position,
	st.specialization,
	sp.from_date,
	sp.to_date
FROM staff st
INNER JOIN staff_position sp ON sp.staff_id = st.staff_id
INNER JOIN position pos ON sp.position_id = pos.position_id
;

CREATE VIEW recept_pet AS
SELECT 
	p.pet_id,
	p.pet_name,
	s.species_name as species,
	p.date_of_birth,
	p.gender,
	CONCAT(po.first_name, ' ', po.last_name) as pet_owner
FROM pet p
INNER JOIN species s on p.species_id = s.species_id
INNER JOIN pet_owner po on p.owner_id = po.owner_id
;

CREATE VIEW recept_pet_owner AS
SELECT 
	po.owner_id,
	CONCAT(po.first_name, ' ', po.last_name) as name,
	po.phone_number,
	po.email_address,
	p.pet_name
FROM pet_owner po
INNER JOIN pet p ON po.owner_id = p.owner_id
;

GRANT SELECT ON recept_visits TO jopolska;
GRANT SELECT ON recept_staff TO jopolska;
GRANT SELECT ON recept_positions TO jopolska;
GRANT SELECT ON recept_pet TO jopolska;
GRANT SELECT ON recept_pet_owner TO jopolska;

GRANT SELECT ON recept_visits TO pwojnar;
GRANT SELECT ON recept_staff TO pwojnar;
GRANT SELECT ON recept_positions TO pwojnar;
GRANT SELECT ON recept_pet TO pwojnar;
GRANT SELECT ON recept_pet_owner TO pwojnar;

-- jbiskupska

CREATE VIEW tech_tests AS
SELECT 
	lab_test_id,
	test_date,
	test_type
FROM lab_test;

CREATE VIEW tech_jbiskupska_staff AS
SELECT
	st.staff_id,
	CONCAT(st.first_name, ' ', st.last_name) as name,
	st.phone_number,
	pos.position_name as position,
	st.specialization
FROM staff st
INNER JOIN staff_position sp ON sp.staff_id = st.staff_id
INNER JOIN position pos ON sp.position_id = pos.position_id
WHERE st.staff_id=4;

CREATE OR REPLACE VIEW tech_jbiskupska_positions AS
SELECT DISTINCT
	sp.staff_position_id,
	CONCAT(st.first_name, ' ', st.last_name) as staff_name,
	pos.position_name as position,
	st.specialization,
	sp.from_date,
	sp.to_date
FROM staff st
INNER JOIN staff_position sp ON sp.staff_id = st.staff_id
INNER JOIN position pos ON sp.position_id = pos.position_id
WHERE st.staff_id=4;

GRANT SELECT ON tech_jbiskupska_staff TO jbiskupska;
GRANT SELECT ON tech_tests to jbiskupska;
GRANT SELECT ON tech_jbiskupska_positions to jbiskupska;

-- sdanielczyk

CREATE VIEW clean_sdanielczyk_staff AS
SELECT
	st.staff_id,
	CONCAT(st.first_name, ' ', st.last_name) as name,
	st.phone_number,
	pos.position_name as position,
	st.specialization
FROM staff st
INNER JOIN staff_position sp ON sp.staff_id = st.staff_id
INNER JOIN position pos ON sp.position_id = pos.position_id
WHERE st.staff_id=2;

CREATE OR REPLACE VIEW clean_sdanielczyk_positions AS
SELECT DISTINCT
	sp.staff_position_id,
	CONCAT(st.first_name, ' ', st.last_name) as staff_name,
	pos.position_name as position,
	st.specialization,
	sp.from_date,
	sp.to_date
FROM staff st
INNER JOIN staff_position sp ON sp.staff_id = st.staff_id
INNER JOIN position pos ON sp.position_id = pos.position_id
WHERE st.staff_id=2;

GRANT SELECT ON clean_sdanielczyk_staff TO sdanielczyk;
GRANT SELECT ON clean_sdanielczyk_positions to sdanielczyk;
