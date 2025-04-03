CREATE OR REPLACE PROCEDURE add_staff_with_position(
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    phone_number TEXT,
    specialization TEXT,
	nposition_name TEXT,
	from_date DATE,
	to_date DATE
)
LANGUAGE plpgsql
AS $$
DECLARE
    nstaff_id INTEGER;
    nposition_id INTEGER;
BEGIN
    BEGIN
		IF nposition_name IS NULL OR nposition_name = '' THEN
        	RAISE EXCEPTION 'Position name cannot be null or empty.';
   		END IF;
	
        SELECT pos.position_id INTO nposition_id
        	FROM position pos
        WHERE pos.position_name = nposition_name;

        IF nposition_id IS NULL THEN
            INSERT INTO position (position_name)
            VALUES (nposition_name)
            RETURNING position_id INTO nposition_id;
        END IF;

		IF first_name IS NULL OR first_name = '' OR last_name IS NULL OR last_name = '' THEN
        	RAISE EXCEPTION 'Staff name cannot be null or empty.';
   		END IF;
		IF phone_number IS NULL OR phone_number = '' THEN
        	RAISE EXCEPTION 'Phone number cannot be null or empty.';
   		END IF;

        INSERT INTO staff (first_name, last_name, phone_number, specialization)
        VALUES (first_name, last_name, phone_number, specialization)
        RETURNING staff_id INTO nstaff_id;

		IF from_date IS NULL OR from_date = '' THEN
        	RAISE EXCEPTION 'Employment date cannot be null or empty.';
   		END IF;
        INSERT INTO staff_position (from_date, to_date, position_id, staff_id)
        VALUES (from_date, to_date, nposition_id, nstaff_id);

    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'ERROR: %', SQLERRM;
    END;
END;
$$;
