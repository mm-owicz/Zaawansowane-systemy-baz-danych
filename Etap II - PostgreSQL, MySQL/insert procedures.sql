-- VET PROCEDURES

-- pet measurement
CREATE OR REPLACE PROCEDURE insert_pet_measurement_vet(
    measurement_date DATE,
    weight NUMERIC,
    height NUMERIC,
	vpet_id INTEGER
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
curr_user TEXT;
BEGIN
	SELECT current_setting('role') into curr_user;
	IF not public.check_vet_pet_measurement(vpet_id, curr_user) THEN
		RAISE EXCEPTION 'Permission denied';
	END IF;

	IF measurement_date IS NULL THEN
        RAISE EXCEPTION 'Measurement date cannot be null.';
	END IF;

	IF height IS NULL THEN
        RAISE EXCEPTION 'Height cannot be null.';
	END IF;
    
	IF height::NUMERIC(5,2) != height THEN
        RAISE EXCEPTION 'Invalid height type.';
    END IF;

    IF weight IS NULL THEN
        RAISE EXCEPTION 'Weight cannot be null.';
	END IF;
    
	IF weight::NUMERIC(5,2) != weight THEN
        RAISE EXCEPTION 'Invalid weight type.';
    END IF;

    IF height <= 0 OR weight <= 0 THEN
        RAISE EXCEPTION 'Height and weight cannot be negative.';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pet p WHERE p.pet_id = vpet_id) THEN
        RAISE EXCEPTION 'Invalid pet_id: % .', vpet_id;
    END IF;

    INSERT INTO pet_measurement (measurement_date, weight, height, pet_id)
    VALUES (measurement_date, weight, height, vpet_id);
END;
$$;

-- lab test
CREATE OR REPLACE PROCEDURE insert_lab_test_vet(
    test_date TIMESTAMP WITHOUT TIME ZONE,
	test_type VARCHAR(300),
	test_results TEXT,
	notes TEXT,
	vvisit_id INTEGER
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
curr_user TEXT;
BEGIN
	SELECT current_setting('role') into curr_user;
	IF not public.check_vet_perm_with_visit(vvisit_id, curr_user) THEN
		RAISE EXCEPTION 'Permission denied';
	END IF;

	IF test_date IS NULL THEN
        RAISE EXCEPTION 'Test date cannot be null.';
    END IF;

	IF test_type IS NULL OR test_type = '' THEN
        RAISE EXCEPTION 'Test type cannot be null or empty.';
    END IF;

	IF test_results IS NULL OR test_results = '' THEN
        RAISE EXCEPTION 'Test results cannot be null or empty.';
    END IF;

	IF NOT EXISTS (SELECT 1 FROM visit v WHERE v.visit_id = vvisit_id) THEN
        RAISE EXCEPTION 'Invalid visit_id: % .', vvisit_id;
    END IF;

	
    INSERT INTO lab_test (test_date, test_type, test_results, notes, visit_id)
    VALUES (test_date, test_type, test_results, notes, vvisit_id);
END;
$$;

-- treatment
CREATE OR REPLACE PROCEDURE insert_treatment_vet(
    treatment_type VARCHAR(300),
	procedure TEXT,
	notes TEXT,
	vvisit_id INTEGER
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
curr_user TEXT;
BEGIN
	SELECT current_setting('role') into curr_user;
	IF not public.check_vet_perm_with_visit(vvisit_id, curr_user) THEN
		RAISE EXCEPTION 'Permission denied';
	END IF;

    IF treatment_type IS NULL OR treatment_type = '' THEN
        RAISE EXCEPTION 'Treatment type cannot be null or empty.';
    END IF;

	IF procedure IS NULL OR procedure = '' THEN
        RAISE EXCEPTION 'Procedure cannot be null or empty.';
    END IF;

	IF NOT EXISTS (SELECT 1 FROM visit v WHERE v.visit_id = vvisit_id) THEN
        RAISE EXCEPTION 'Invalid visit_id: % .', vvisit_id;
    END IF;

	
    INSERT INTO treatment (treatment_type, procedure, notes, visit_id)
    VALUES (treatment_type, procedure, notes, vvisit_id);

    RAISE NOTICE 'Treatment inserted successfully.';
END;
$$;

-- diagnosis
CREATE OR REPLACE PROCEDURE insert_diagnosis_vet(
	diagnosis_type TEXT,
	notes TEXT,
	vvisit_id INTEGER
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
curr_user TEXT;
BEGIN
	SELECT current_setting('role') into curr_user;
	
    IF not public.check_vet_perm_with_visit(vvisit_id, curr_user) THEN
		RAISE EXCEPTION 'Permission denied';
	END IF;

	IF diagnosis_type IS NULL OR diagnosis_type = '' THEN
        RAISE EXCEPTION 'Diagnosis type cannot be null or empty.';
    END IF;

	IF NOT EXISTS (SELECT 1 FROM visit v WHERE v.visit_id = vvisit_id) THEN
        RAISE EXCEPTION 'Invalid visit_id: % .', vvisit_id;
    END IF;

    INSERT INTO diagnosis (diagnosis_type, notes, visit_id)
    VALUES (diagnosis_type, notes, vvisit_id);
END;
$$;

-- medicine plan
CREATE OR REPLACE PROCEDURE insert_medicine_plan_vet(
	medicine_name VARCHAR(100),
	dosage NUMERIC,
	dosage_unit VARCHAR(10),
	frequency TEXT,
	duration TEXT,
	vdiagnosis_id INTEGER
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
curr_user TEXT;
BEGIN
	SELECT current_setting('role') into curr_user;
	IF not public.check_vet_medplan(vdiagnosis_id, curr_user) THEN
		RAISE EXCEPTION 'Permission denied';
	END IF;

	IF medicine_name IS NULL OR medicine_name = '' THEN
        RAISE EXCEPTION 'Medicine name cannot be null or empty.';
    END IF;

	IF dosage IS NULL THEN
        RAISE EXCEPTION 'Dosage cannot be null.';
	END IF;
    
	IF dosage::NUMERIC(5,2) != dosage THEN
        RAISE EXCEPTION 'Invalid dosage type.';
    END IF;

	IF dosage <= 0 THEN
		RAISE EXCEPTION 'Dosage cannot be negative or 0.';
	END IF;

	IF dosage_unit IS NULL OR dosage_unit = '' THEN
        RAISE EXCEPTION 'Dosage unit cannot be null or empty.';
    END IF;

	IF frequency IS NULL OR frequency = '' THEN
        RAISE EXCEPTION 'Frequency cannot be null or empty.';
    END IF;

	IF duration IS NULL OR duration = '' THEN
        RAISE EXCEPTION 'Duration cannot be null or empty.';
    END IF;

	IF NOT EXISTS (SELECT 1 FROM diagnosis d WHERE d.diagnosis_id = vdiagnosis_id) THEN
        RAISE EXCEPTION 'Invalid diagnosis_id: % .', vdiagnosis_id;
    END IF;

	
    INSERT INTO medicine_plan (medicine_name, dosage, dosage_unit, frequency, duration, diagnosis_id)
    VALUES (medicine_name, dosage, dosage_unit, frequency, duration, vdiagnosis_id);
END;
$$;

-- prescription
CREATE OR REPLACE PROCEDURE insert_prescription_vet(
	prescription_date DATE,
	medicine_name VARCHAR(100),
	medicine_amount INTEGER,
	vvisit_id INTEGER
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
curr_user TEXT;
BEGIN
	SELECT current_setting('role') into curr_user;
	IF not public.check_vet_perm_with_visit(vvisit_id, curr_user) THEN
		RAISE EXCEPTION 'Permission denied';
	END IF;

	IF prescription_date IS NULL THEN
        RAISE EXCEPTION 'Prescription date cannot be null.';
    END IF;

	IF medicine_name IS NULL OR medicine_name = '' THEN
        RAISE EXCEPTION 'Medicine name cannot be null or empty.';
    END IF;

	IF medicine_amount IS NULL THEN
        RAISE EXCEPTION 'Medicine amount cannot be null.';
	END IF;

	IF medicine_amount <= 0 THEN
		RAISE EXCEPTION 'Medicine amount cannot be negative or 0.';
	END IF;

	IF NOT EXISTS (SELECT 1 FROM visit v WHERE v.visit_id = vvisit_id) THEN
        RAISE EXCEPTION 'Invalid visit_id: % .', vvisit_id;
    END IF;

	
    INSERT INTO prescription (prescription_date, medicine_name, medicine_amount, visit_id)
    VALUES (prescription_date, medicine_name, medicine_amount, vvisit_id);
END;
$$;

------------------------------------------

-- STAFF (receptionist) PROCEDURES

-- visit 
CREATE OR REPLACE PROCEDURE insert_visit_recept(
    visit_date TIMESTAMP WITHOUT TIME ZONE,
	reason TEXT,
	vvet_id INTEGER,
	vpet_id INTEGER
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
	IF visit_date IS NULL THEN
        RAISE EXCEPTION 'Visit date cannot be null.';
    END IF;

	IF reason IS NULL OR reason = '' THEN
        RAISE EXCEPTION 'Reason cannot be null or empty.';
    END IF;

	IF NOT EXISTS (SELECT 1 FROM staff s WHERE s.staff_id = vvet_id) THEN
        RAISE EXCEPTION 'Invalid vet_id: % .', vvet_id;
    END IF;

	IF NOT EXISTS (SELECT 1 FROM pet p WHERE p.pet_id = vpet_id) THEN
        RAISE EXCEPTION 'Invalid pet_id: % .', vpet_id;
    END IF;
    INSERT INTO visit (visit_date, reason, vet_id, pet_id)
    VALUES (visit_date, reason, vvet_id, vpet_id);
END;
$$;

GRANT ALL ON PROCEDURE insert_visit_recept to jopolska;


-- staff 
CREATE OR REPLACE PROCEDURE insert_staff_recept(
    first_name VARCHAR(100),
	last_name VARCHAR(100),
	phone_number TEXT,
	specialization TEXT,
	vposition_id INTEGER,
	employment_date date
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    new_id INTEGER;
BEGIN
	IF first_name IS NULL OR first_name = '' THEN
        RAISE EXCEPTION 'First name cannot be null or empty.';
    END IF;

	IF last_name IS NULL OR last_name = '' THEN
        RAISE EXCEPTION 'Last name cannot be null or empty.';
    END IF;

	IF phone_number IS NULL OR phone_number = '' THEN
        RAISE EXCEPTION 'Phone number cannot be null or empty.';
    END IF;

	IF employment_date IS NULL THEN
        RAISE EXCEPTION 'Employment date cannot be null.';
    END IF;

	IF NOT EXISTS (SELECT 1 FROM position p WHERE p.position_id = vposition_id) THEN
        RAISE EXCEPTION 'Invalid position_id: % .', vposition_id;
    END IF;
	
    INSERT INTO staff (first_name, last_name, phone_number, specialization)
    VALUES (first_name, last_name, phone_number, specialization)
	RETURNING staff_id INTO new_id;

	INSERT INTO staff_position
	(from_date, to_date, staff_id, position_id)
	VALUES
	(employment_date, null, new_id, vposition_id);
END;
$$;

-- staff position
CREATE OR REPLACE PROCEDURE insert_staff_position(
    from_date DATE,
	to_date DATE,
	vstaff_id INTEGER,
	vposition_id INTEGER
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
	IF from_date IS NULL THEN
        RAISE EXCEPTION 'From date cannot be null.';
    END IF;

	IF NOT EXISTS (SELECT 1 FROM staff s WHERE s.staff_id = vstaff_id) THEN
        RAISE EXCEPTION 'Invalid staff_id: % .', vstaff_id;
    END IF;

	IF NOT EXISTS (SELECT 1 FROM position p WHERE p.position_id = vposition_id) THEN
        RAISE EXCEPTION 'Invalid position_id: % .', vposition_id;
    END IF;
	
    INSERT INTO staff_position (from_date, to_date, staff_id, position_id)
    VALUES (from_date, to_date, vstaff_id, vposition_id);
END;
$$;


-- pet owner
CREATE OR REPLACE PROCEDURE insert_pet_owner(
    first_name VARCHAR(100),
	last_name VARCHAR(100),
	phone_number TEXT,
	email_address VARCHAR(100)
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
	IF first_name IS NULL OR first_name = '' THEN
        RAISE EXCEPTION 'First name cannot be null or empty.';
    END IF;

	IF last_name IS NULL OR last_name = '' THEN
        RAISE EXCEPTION 'Last name cannot be null or empty.';
    END IF;

	IF phone_number IS NULL OR phone_number = '' THEN
        RAISE EXCEPTION 'Phone number cannot be null or empty.';
    END IF;
	
    INSERT INTO pet_owner (first_name, last_name, phone_number, email_address)
    VALUES (first_name, last_name, phone_number, email_address);
END;
$$;

-- pet

CREATE OR REPLACE PROCEDURE insert_pet(
    pet_name VARCHAR(100),
	date_of_birth DATE,
	gender CHAR,
	vspecies_id INTEGER,
	vowner_id INTEGER
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
	IF pet_name IS NULL OR pet_name = '' THEN
        RAISE EXCEPTION 'Pet name cannot be null or empty.';
    END IF;

	IF gender IS NULL OR gender = '' THEN
        RAISE EXCEPTION 'Gender cannot be null or empty.';
    END IF;

	IF gender NOT IN ('F', 'M') THEN
        RAISE EXCEPTION 'Invalid gender: % . Must be either ''F'' or ''M''.', gender;
    END IF;

	IF NOT EXISTS (SELECT 1 FROM species WHERE species_id = vspecies_id) THEN
        RAISE EXCEPTION 'Invalid species_id: %.', vspecies_id;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pet_owner WHERE owner_id = vowner_id) THEN
        RAISE EXCEPTION 'Invalid owner_id: % .', vowner_id;
    END IF;
	
    INSERT INTO pet (pet_name, date_of_birth, gender, species_id, owner_id)
    VALUES (pet_name, date_of_birth, gender, vspecies_id, vowner_id);
END;
$$;



