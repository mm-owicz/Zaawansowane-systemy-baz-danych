drop table staff_role_mapping;
CREATE TABLE staff_role_mapping (
	staff_id INTEGER PRIMARY KEY,
    role_name TEXT UNIQUE
);

INSERT INTO staff_role_mapping (staff_id, role_name) VALUES
    (1, 'jopolska'),
	(2, 'sdanielczyk'),
	(3, 'pwojnar'),
	(4, 'jbiskupska'),
	(5, 'amazurczak'),
	(6, 'jsierakowski'),
	(7, 'switowska'),
	(8, 'jmrotek'),
	(9, 'ajanowicz')
	;

grant select on table staff_role_mapping to jopolska;
grant select on table staff_role_mapping to sdanielczyk;
grant select on table staff_role_mapping to pwojnar;
grant select on table staff_role_mapping to jbiskupska;
grant select on table staff_role_mapping to amazurczak;
grant select on table staff_role_mapping to jsierakowski;
grant select on table staff_role_mapping to switowska;
grant select on table staff_role_mapping to jmrotek;
grant select on table staff_role_mapping to ajanowicz;
	
--------------------------------------

CREATE OR REPLACE FUNCTION check_vet_pet_measurement(vpet_id INTEGER, username TEXT)
RETURNS BOOLEAN AS $$
DECLARE
	current_vet_id INTEGER;
    visit_exists BOOLEAN;
BEGIN
    SELECT staff_id INTO current_vet_id
    FROM staff_role_mapping
    WHERE role_name = username;

    IF current_vet_id IS NULL THEN
        RAISE EXCEPTION 'Role % does not have an ID.', username;
    END IF;
	
    SELECT EXISTS (
        SELECT 1
        FROM visit
        WHERE visit.pet_id = vpet_id AND visit.vet_id = current_vet_id
    ) INTO visit_exists;

    RETURN visit_exists;
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER;

grant execute on function check_vet_pet_measurement(integer, text) to amazurczak;
grant execute on function check_vet_pet_measurement(integer, text) to jsierakowski;
grant execute on function check_vet_pet_measurement(integer, text) to switowska;
grant execute on function check_vet_pet_measurement(integer, text) to jmrotek;
grant execute on function check_vet_pet_measurement(integer, text) to ajanowicz;

-------------------------------

CREATE OR REPLACE FUNCTION check_vet_perm_with_visit(vvisit_id INTEGER, username TEXT)
RETURNS BOOLEAN AS $$
DECLARE
	current_vet_id INTEGER;
    visit_exists BOOLEAN;
BEGIN
    SELECT staff_id INTO current_vet_id
    FROM staff_role_mapping
    WHERE role_name = username;

    IF current_vet_id IS NULL THEN
        RAISE EXCEPTION 'Role % does not have an ID.', username;
    END IF;
	
    SELECT EXISTS (
        SELECT 1
        FROM visit
        WHERE visit.vet_id = current_vet_id AND visit.visit_id = vvisit_id
    ) INTO visit_exists;

    RETURN visit_exists;
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER;

grant execute on function check_vet_perm_with_visit(integer, text) to amazurczak;
grant execute on function check_vet_perm_with_visit(integer, text) to jsierakowski;
grant execute on function check_vet_perm_with_visit(integer, text) to switowska;
grant execute on function check_vet_perm_with_visit(integer, text) to jmrotek;
grant execute on function check_vet_perm_with_visit(integer, text) to ajanowicz;

----------------------------------------

CREATE OR REPLACE FUNCTION check_vet_medplan(vdiagnosis_id INTEGER, username TEXT)
RETURNS BOOLEAN AS $$
DECLARE
	current_vet_id INTEGER;
    visit_exists BOOLEAN;
BEGIN
    SELECT staff_id INTO current_vet_id
    FROM staff_role_mapping
    WHERE role_name = username;

    IF current_vet_id IS NULL THEN
        RAISE EXCEPTION 'Role % does not have an ID.', username;
    END IF;
	
    SELECT EXISTS (
        SELECT 1
        FROM diagnosis d
		INNER JOIN visit v ON d.visit_id = v.visit_id
		WHERE v.vet_id = current_vet_id
    ) INTO visit_exists;

    RETURN visit_exists;
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER;

grant execute on function check_vet_medplan(integer, text) to amazurczak;
grant execute on function check_vet_medplan(integer, text) to jsierakowski;
grant execute on function check_vet_medplan(integer, text) to switowska;
grant execute on function check_vet_medplan(integer, text) to jmrotek;
grant execute on function check_vet_medplan(integer, text) to ajanowicz;



