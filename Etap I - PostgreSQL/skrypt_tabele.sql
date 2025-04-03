BEGIN;
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

CREATE TABLE IF NOT EXISTS species
(
	species_id serial NOT NULL,
	species_name varchar(100),
	PRIMARY KEY (species_id)
);

CREATE TABLE IF NOT EXISTS pet
(
    pet_id serial NOT NULL,
    pet_name varchar(100) NOT NULL,
    date_of_birth date,
    gender "char" NOT NULL,
    PRIMARY KEY (pet_id)
);

CREATE TABLE IF NOT EXISTS pet_measurement
(
	measurement_id serial NOT NULL,
	measurement_date date NOT NULL,
	weight decimal(5,2) NOT NULL,
	height decimal(5,2) NOT NULL,
	PRIMARY KEY (measurement_id)
);

CREATE TABLE IF NOT EXISTS pet_owner
(
    owner_id serial NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    phone_number text NOT NULL,
    email_address character varying(100),
    PRIMARY KEY (owner_id)
);

CREATE TABLE IF NOT EXISTS visit
(
    visit_id serial NOT NULL,
    visit_date timestamp without time zone NOT NULL,
    reason text NOT NULL,
    PRIMARY KEY (visit_id)
);

CREATE TABLE IF NOT EXISTS lab_test
(
    lab_test_id serial NOT NULL,
    test_date timestamp without time zone NOT NULL,
    test_type character varying(300) NOT NULL,
    test_results text NOT NULL,
    notes text,
    PRIMARY KEY (lab_test_id)
);

CREATE TABLE IF NOT EXISTS diagnosis
(
    diagnosis_id serial NOT NULL,
    diagnosis_type text NOT NULL,
    notes text,
    PRIMARY KEY (diagnosis_id)
);

CREATE TABLE IF NOT EXISTS treatment
(
    treatment_id serial NOT NULL,
    treatment_type character varying(300) NOT NULL,
    procedure text NOT NULL,
    notes text,
    PRIMARY KEY (treatment_id)
);

CREATE TABLE IF NOT EXISTS medicine_plan
(
    medicine_plan_id serial NOT NULL,
    medicine_name character varying(100) NOT NULL,
    dosage decimal(5, 2) NOT NULL,
    dosage_unit character varying(10) NOT NULL,
    frequency text NOT NULL,
    duration text NOT NULL,
    PRIMARY KEY (medicine_plan_id)
);

CREATE TABLE IF NOT EXISTS prescription
(
    prescription_id serial NOT NULL,
    prescription_date date NOT NULL,
    medicine_name character varying(100) NOT NULL,
    medicine_amount integer NOT NULL,
    PRIMARY KEY (prescription_id)
);

CREATE TABLE IF NOT EXISTS position
(
	position_id serial NOT NULL,
	position_name text NOT NULL,
	PRIMARY KEY (position_id)
);

CREATE TABLE IF NOT EXISTS staff_position
(
	staff_position_id serial NOT NULL,
	from_date date NOT NULL,
	to_date date,
	PRIMARY KEY (staff_position_id)
);

CREATE TABLE IF NOT EXISTS staff
(
    staff_id serial NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    phone_number text NOT NULL,
	specialization text,
    PRIMARY KEY (staff_id)
);

ALTER TABLE IF EXISTS pet
	ADD COLUMN species_id integer,
    ADD CONSTRAINT fk_species
	FOREIGN KEY (species_id) REFERENCES species(species_id)
    ON UPDATE CASCADE
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS pet
	ADD COLUMN owner_id integer,
    ADD CONSTRAINT fk_owner 
	FOREIGN KEY (owner_id) REFERENCES pet_owner(owner_id)
    ON UPDATE CASCADE
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS pet_measurement
	ADD COLUMN pet_id integer,
    ADD CONSTRAINT fk_pet
	FOREIGN KEY (pet_id) REFERENCES pet(pet_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS visit
	ADD COLUMN vet_id integer,
    ADD CONSTRAINT fk_veterinarian 
	FOREIGN KEY (vet_id) REFERENCES staff (staff_id)
    ON UPDATE CASCADE
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS visit
	ADD COLUMN pet_id integer,
    ADD CONSTRAINT fk_pet
	FOREIGN KEY (pet_id) REFERENCES pet (pet_id)
    ON UPDATE CASCADE
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS lab_test
	ADD COLUMN visit_id integer,
    ADD CONSTRAINT fk_visit
	FOREIGN KEY (visit_id) REFERENCES visit (visit_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS diagnosis
	ADD COLUMN visit_id integer,
    ADD CONSTRAINT fk_visit
	FOREIGN KEY (visit_id) REFERENCES visit (visit_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

	
ALTER TABLE IF EXISTS treatment
	ADD COLUMN visit_id integer,
    ADD CONSTRAINT fk_visit
	FOREIGN KEY (visit_id) REFERENCES visit (visit_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS medicine_plan
	ADD COLUMN diagnosis_id integer,
    ADD CONSTRAINT fk_diagnosis
	FOREIGN KEY (diagnosis_id) REFERENCES diagnosis (diagnosis_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS prescription
	ADD COLUMN visit_id integer,
    ADD CONSTRAINT fk_visit
	FOREIGN KEY (visit_id) REFERENCES visit (visit_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS staff_position
	ADD COLUMN staff_id integer,
	ADD CONSTRAINT fk_staff
	FOREIGN KEY (staff_id) REFERENCES staff (staff_id)
	ON UPDATE CASCADE
	ON DELETE CASCADE;

ALTER TABLE IF EXISTS staff_position
	ADD COLUMN position_id integer,
	ADD CONSTRAINT fk_position
	FOREIGN KEY (position_id) REFERENCES position (position_id)
	ON UPDATE CASCADE
	ON DELETE CASCADE;

END;