-- UDF
CREATE OR REPLACE FUNCTION calc_pet_age(date_of_birth DATE)
RETURNS INTEGER AS $$
DECLARE
    pet_age INTEGER;
BEGIN
	IF date_of_birth IS NULL THEN
        RETURN NULL; 
    END IF;
	
    SELECT DATE_PART('year', AGE(date_of_birth)) INTO pet_age;
    RETURN pet_age;
END;
$$ LANGUAGE plpgsql;

SELECT pet_name, calc_pet_age(date_of_birth) AS age
FROM pet;
