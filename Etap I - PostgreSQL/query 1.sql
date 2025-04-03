-- Query 1

SELECT
    pet.pet_name,
    latest_treatment.treatment_type,
    latest_treatment.visit_date
FROM
    pet
LEFT JOIN (
    SELECT
        visit.pet_id,
        t.treatment_type,
        visit.visit_date,
        ROW_NUMBER() OVER (PARTITION BY visit.pet_id ORDER BY visit.visit_date DESC) AS rn
    FROM
        visit
    JOIN treatment t ON visit.visit_id = t.visit_id
) AS latest_treatment ON pet.pet_id = latest_treatment.pet_id AND latest_treatment.rn = 1
WHERE latest_treatment.treatment_type is not null
ORDER BY
    latest_treatment.visit_date;
