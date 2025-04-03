-- INDEXES

CREATE INDEX idx_diagnosis_visit_id
ON diagnosis(visit_id);

CREATE INDEX idx_diagnosis_id
ON diagnosis(diagnosis_id);

CREATE INDEX idx_med_plan_diagnosis_id
ON medicine_plan(diagnosis_id);

CREATE INDEX idx_staff_position_staff_id
ON staff_position(staff_id);

CREATE INDEX idx_staff_position_id
ON staff_position(position_id);

CREATE INDEX idx_position_id
ON position(position_id);

CREATE INDEX idx_staff_id
ON staff(staff_id);

CREATE INDEX idx_measurements_pet_id_date
ON pet_measurement(pet_id, measurement_date);

CREATE INDEX idx_pet_owner_id
ON pet_owner(owner_id);

CREATE INDEX idx_pet_id
ON pet(pet_id);

CREATE INDEX idx_pet_pet_owner_id
ON pet(owner_id);

CREATE INDEX idx_visit_id
ON visit(visit_id);

CREATE INDEX idx_visit_pet_date_id
ON visit(pet_id, visit_date);


drop index if exists idx_visit_pet_date_id, idx_visit_id, idx_pet_pet_owner_id,
	idx_pet_id, idx_pet_owner_id, idx_measurements_pet_id_date,
	idx_staff_id, idx_position_id, idx_staff_position_id, idx_staff_position_staff_id,
	idx_med_plan_diagnosis_id, idx_diagnosis_id,idx_diagnosis_visit_id ;




