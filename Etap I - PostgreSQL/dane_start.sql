
INSERT INTO species (species_name)
VALUES ('Pies'), ('Kot'), ('Żółw'), ('Kaczka'), ('Papuga'), ('Chomik');

INSERT INTO pet_owner 
(first_name, last_name, phone_number, email_address)
VALUES
('Alicja', 'Pawliczak', '555-897-321', 'alicja.paw@wp.pl'),
('Mariusz', 'Lesner', '+48 342-123-432', 'marles@gmail.com'),
('Cezary', 'Wysocki', '555-234-476', 'wysocki.cezary@gmail.com'),
('Milena', 'Kortaba', '555-676-726', 'kortaba.mil@onet.pl'),
('Patryk', 'Galus', '333-462-624', 'patr.gal.poczta@wp.pl')
;

INSERT INTO pet
(pet_name, date_of_birth, gender, species_id, owner_id)
VALUES
('Napoleon', '2018-11-05', 'M', 1, 4),
('Kłatka', '2019-01-15', 'M', 4, 5),
('Laweta', '2017-03-20', 'F', 2, 2),
('Lea', '2016-06-25', 'F', 3, 1),
('Dakota',  '2019-03-07', 'F', 1, 3),
('Lili', '2018-06-22', 'F', 1, 2)
;

INSERT INTO pet_measurement (measurement_date, weight, height, pet_id)
VALUES
('2019-04-20', 39.7, 70.2, 1),
('2022-11-13', 3.6, 34.7, 2),
('2019-11-24', 9.75, 32.4, 3),
('2020-07-23', 0.46, 10.4, 4),
('2021-07-26', 32.3, 75.2, 5),
('2023-04-16', 64.6, 83.5, 6);

INSERT INTO position
(position_name)
VALUES
('Recepcjonist/ka'), 
('Weterynarz'), 
('Sprzątacz'),
('Technik sprzętowy');

INSERT INTO staff
(first_name, last_name, phone_number, specialization)
VALUES
('Janina', 'Opolska', '723-213-112', null),
('Sebastian ', 'Danielczyk', '836-213-132', null),
('Paweł', 'Wojnar', '663-252-112', null),
('Jadwiga', 'Biskupska', '562-433-862', 'Sprzęt USG/RTG'),
('Anita', 'Mazurczak', '535-623-716', 'Choroby psów i kotów'),
('Jakub', 'Sierakowski', '522-251-121', 'Choroby psów i kotów'),
('Sylwia', 'Witowska', '363-224-242', 'Chirurgia weterynaryjna'),
('Julianna', 'Mrotek', '787-878-261', 'Choroby gadów i płazów'),
('Artur', 'Janowicz', '716-233-112', 'Choroby drobiu i ptactwa');
;

INSERT INTO staff_position
(from_date, to_date, staff_id, position_id)
VALUES
('2019-02-01', null, 1, 1),
('2019-02-01', null, 2, 3),
('2020-04-01', null, 3, 1),
('2020-06-01', null, 4, 4),
('2019-02-01', null, 5, 2),
('2020-03-01', null, 6, 2),
('2020-05-01', null, 7, 2),
('2020-05-01', null, 8, 2),
('2019-01-02', null, 9, 2);

INSERT INTO visit
(visit_date, reason, pet_id, vet_id)
VALUES
('2019-04-20 09:00:00', 'Szczepienie psa', 1, 6),
('2019-07-11 12:00:00', 'Nagłe osłabienie', 2, 9),
('2019-11-24 15:00:00', 'Zmęczenie i dziwne zachowanie', 3, 5),  -- laweta
('2020-07-23 14:00:00', 'Rutynowa kontrola', 4, 8),  -- lea
('2020-12-12 17:00:00', 'Igły jeża wbite w psa', 5, 5),
('2021-07-20 09:00:00', 'Potrącenie przez samochód', 6, 7),
('2021-07-22 11:00:00', 'Rutynowa kontrola', 3, 5), -- laweta
('2021-07-26 09:00:00', 'Niepokojące zachowanie po operacji', 6, 6),
('2022-11-13 13:00:00', 'Podejrzenie urazu oka', 2, 9),
('2023-04-16 12:00:00', 'Podejrzenie ciąży psa', 5, 6);

INSERT INTO treatment
(treatment_type, procedure, notes, visit_id)
VALUES
('Szczepienie na wściekliznę', 'Podano psu szczepionkę', null, 1),
('Podanie tableki', 'Podano psu tabletkę na kleszcze zakupioną podczas wizyty', null, 1);

INSERT INTO treatment
(treatment_type, procedure, notes, visit_id)
VALUES
('Nawodnienie', 'Stwierdzono osłabienie spowodowane gorącą pogodą. Podano wodę z elektrolitami i stan kaczki znacznie się poprawił.', 
'Zalecono właścicielowi obserwację kaczki.', 2);

INSERT INTO diagnosis
(diagnosis_type, notes, visit_id)
VALUES
('Ślepota', 'Kaczka ma lekką ślepotę lewego oka', 9);

INSERT INTO diagnosis
(diagnosis_type, notes, visit_id)
VALUES
('Niewydolność serca', 'Kot ma lekką niewydolność serca.', 3),
('Niedoczynność tarczycy', 'Stwierdzono lekką niewydolność tarczycy', 3);

INSERT INTO medicine_plan
(medicine_name, dosage, dosage_unit, frequency, duration, diagnosis_id)
VALUES
('Lasix', 2.0, 'tabletka', '2 razy dziennie', 'cały czas', 2),
('Benazepril', 5.0, 'ml', 'raz na tydzień', 'cały czas', 2),
('Soloxine', 1.5, 'tabletka', '3 razy dziennie', 'cały czas', 3);

INSERT INTO prescription
(prescription_date, medicine_name, medicine_amount, visit_id)
VALUES
('2019-11-24', 'Lasix', 10, 3),
('2019-11-24', 'Benazepril', 4, 3),
('2019-11-24', 'Soloxine', 14, 3),
('2021-07-22', 'Lasix', 20, 7),
('2021-07-22', 'Benazepril', 8, 7),
('2021-07-22', 'Soloxine', 28, 7);

INSERT INTO lab_test
(test_date, test_type, test_results, notes, visit_id)
VALUES
('2019-11-24', 'FT4', '4.5 jednostek', 'Wyniki sugerują niedoczynność tarczycy', 3);

INSERT INTO treatment
(treatment_type, procedure, notes, visit_id)
VALUES
('Zabieg', 'Usunięto igły jeża z pysku psa, podano antybiotyki.', null, 5);

INSERT INTO lab_test
(test_date, test_type, test_results, notes, visit_id)
VALUES
('2020-12-12', 'Leukocyty', '13.0', 'Podejrzane lekkie zakażenie.', 5);

INSERT INTO diagnosis
(diagnosis_type, notes, visit_id)
VALUES
('Zakażenie bakteryjne', 'Zakażenie batkeryjne spowodowane obrażeniami od igieł jeża', 5);

INSERT INTO medicine_plan
(medicine_name, dosage, dosage_unit, frequency, duration, diagnosis_id)
VALUES
('Amoksycilina', 2.0, 'tabletka', '2 razy dziennie', 'przez tydzień', 4);

INSERT INTO prescription
(prescription_date, medicine_name, medicine_amount, visit_id)
VALUES
('2020-12-12', 'Amoksycilina', 1, 5);

INSERT INTO lab_test
(test_date, test_type, test_results, notes, visit_id)
VALUES
('2023-04-16', 'USG', 'Widoczny wczesny etap ciąży', 'Pierwsza ciąża psa, przebieg normalny.', 10);

INSERT INTO lab_test
(test_date, test_type, test_results, notes, visit_id)
VALUES
('2021-07-20', 'RTG', 'Złamanie lewej przedniej kończyny w trzech miejscach.', null, 6),
('2021-07-20', 'Hemoglobina', '74.32 - znacznie poniżej normy', null, 6)
;

INSERT INTO treatment
(treatment_type, procedure, notes, visit_id)
VALUES
('Operacja', 'Przeprowadzono nagłą operacje lewej przedniej kończyny psa. Zatrzymano krwawienie i nastawiono kości. Operacja przebiegła pomyślnie',
'Zalecona obserwacja pod wzgl. infekcji', 6);

INSERT INTO diagnosis
(diagnosis_type, notes, visit_id)
VALUES
('Zakażenie pooperacyjne', null, 8);

INSERT INTO medicine_plan
(medicine_name, dosage, dosage_unit, frequency, duration, diagnosis_id)
VALUES
('Amoksycilina', 4.0, 'tabletka', '2 razy dziennie', 'przez miesiąc', 5);

INSERT INTO prescription
(prescription_date, medicine_name, medicine_amount, visit_id)
VALUES
('2021-07-26', 'Amoksycilina', 8, 8);






