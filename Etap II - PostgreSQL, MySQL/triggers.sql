-- Trigger - płeć z dużej litery

CREATE OR REPLACE FUNCTION correct_pet_gender_case()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.gender = 'f' THEN
        NEW.gender := 'F';
    ELSIF NEW.gender = 'm' THEN
        NEW.gender := 'M';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_correct_pet_gender_case
BEFORE INSERT ON pet
FOR EACH ROW
EXECUTE FUNCTION correct_pet_gender_case();

-- Trigger - duplikaty w nazwie pozycji

CREATE OR REPLACE FUNCTION check_duplicate_position_names()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM position WHERE position_name = NEW.position_name) THEN
        RAISE EXCEPTION 'Position name % already exists', NEW.position_name;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_prevent_duplicate_position_names
BEFORE INSERT ON position
FOR EACH ROW
EXECUTE FUNCTION check_duplicate_position_names();


-- Trigger - unikalność dat wizyt (dla zwierząt i osobno dla weterynarzy)

CREATE OR REPLACE FUNCTION check_unique_visit_date()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS ( -- vets
        SELECT 1 FROM visit
        WHERE vet_id = NEW.vet_id AND visit_date = NEW.visit_date
    ) THEN
        RAISE EXCEPTION 'A visit for this vet on this date and time already exists';
    END IF;

	IF EXISTS ( -- pets
        SELECT 1 FROM visit
        WHERE pet_id = NEW.pet_id AND visit_date = NEW.visit_date
    ) THEN
        RAISE EXCEPTION 'A visit for this pet on this date and time already exists';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_unique_visit_date
BEFORE INSERT ON visit
FOR EACH ROW
EXECUTE FUNCTION check_unique_visit_date();



