-- Query 2


SELECT
	staff.first_name AS vet_first_name,
    staff.last_name AS vet_last_name,
    visit.visit_date,
    pet.pet_name,
	COALESCE(treatment_count.treatments_done, 0) AS treatments_done,
    COALESCE(diagnosis_count.diagnoses_given, 0) AS diagnoses_given
FROM
    visit
JOIN pet ON visit.pet_id = pet.pet_id
JOIN staff ON visit.vet_id = staff.staff_id
LEFT JOIN (
	SELECT treatment.visit_id, COUNT(*) as treatments_done
	FROM treatment
	GROUP BY treatment.visit_id
) AS treatment_count ON visit.visit_id = treatment_count.visit_id
LEFT JOIN (
	SELECT diagnosis.visit_id, COUNT(*) as diagnoses_given
	FROM diagnosis
	GROUP BY diagnosis.visit_id
) AS diagnosis_count ON visit.visit_id = diagnosis_count.visit_id
WHERE
    visit.visit_id IN (
        SELECT v2.visit_id
        FROM visit v2
        WHERE v2.vet_id = visit.vet_id
		AND v2.visit_date = (
            SELECT MAX(v3.visit_date)
            FROM visit v3
            WHERE v3.vet_id = v2.vet_id
        GROUP BY v2.vet_id
    ))
ORDER BY
    staff.last_name, staff.first_name, visit.visit_date;


