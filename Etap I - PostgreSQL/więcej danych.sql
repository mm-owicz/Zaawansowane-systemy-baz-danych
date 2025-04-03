-- more data


delete from pet where pet_id > 6;
delete from pet_owner where owner_id > 5;
delete from visit where visit_id > 10;
delete from lab_test where lab_test_id > 5;
delete from treatment where treatment_id > 5;
delete from diagnosis where diagnosis_id > 5;

INSERT INTO pet_owner 
(first_name, last_name, phone_number, email_address)
VALUES
('Jan', 'Kowalski', '555-111-222', 'jan.kowalski@example.com'),
('Marta', 'Nowak', '555-222-333', 'marta.nowak@example.com'),
('Tomasz', 'Wiśniewski', '555-333-444', 'tomasz.wisniewski@example.com'),
('Anna', 'Wójcik', '555-444-555', 'anna.wojcik@example.com'),
('Piotr', 'Kozłowski', '555-555-666', 'piotr.kozlowski@example.com'),
('Katarzyna', 'Jankowski', '555-666-777', 'katarzyna.jankowski@example.com'),
('Wojciech', 'Szymański', '555-777-888', 'wojciech.szymanski@example.com'),
('Natalia', 'Dąbrowska', '555-888-999', 'natalia.dabrowska@example.com'),
('Łukasz', 'Kaczmarek', '555-999-000', 'lukasz.kaczmarek@example.com'),
('Zuzanna', 'Nowicka', '555-000-111', 'zuzanna.nowicka@example.com'),
('Zofia', 'Nowak', '512-345-678', 'zofia.nowak@example.com'),
('Krzysztof', 'Kowalski', '789-456-123', 'krzysztof.kowalski@example.com'),
('Agnieszka', 'Wiśniewska', '321-654-987', 'agnieszka.wisniewska@example.com'),
('Piotr', 'Wójcik', '654-321-098', 'piotr.wojcik@example.com'),
('Marta', 'Kaczmarek', '234-567-890', 'marta.kaczmarek@example.com'),
('Jakub', 'Zieliński', '876-543-210', 'jakub.zielinski@example.com'),
('Natalia', 'Szymańska', '432-109-876', 'natalia.szymanska@example.com'),
('Tomasz', 'Lewandowski', '543-210-987', 'tomasz.lewandowski@example.com'),
('Monika', 'Dąbrowska', '678-901-234', 'monika.dabrowska@example.com'),
('Patryk', 'Kowalczyk', '987-654-321', 'patryk.kowalczyk@example.com');

INSERT INTO pet
(pet_name, date_of_birth, gender, species_id, owner_id)
VALUES
('Boniek', '2017-10-06', 'M', 1, 6),
('Mia', '2020-05-10', 'F', 2, 7),
('Kora', '2019-02-15', 'F', 3, 8),
('Rex', '2021-08-20', 'M', 1, 9),
('Bella', '2020-03-12', 'F', 2, 10),
('Tigi', '2017-07-22', 'M', 3, 11),
('Leo', '2016-12-30', 'M', 1, 12),
('Coco', '2018-06-18', 'F', 2, 13),
('Luna', '2019-09-25', 'F', 3, 14),
('Rocky', '2021-01-13', 'M', 1, 15),
('Zosia', '2020-11-11', 'F', 2, 16),
('Burek', '2018-04-04', 'M', 1, 17),
('Gucio', '2019-10-08', 'M', 3, 18),
('Kicia', '2020-12-01', 'F', 2, 19),
('Puszek', '2018-05-22', 'M', 1, 20),
('Misia', '2021-02-02', 'F', 2, 21),
('Felix', '2019-03-03', 'M', 3, 22),
('Bambi', '2020-08-15', 'F', 1, 23),
('Fela', '2021-07-07', 'F', 2, 24),
('Bobby', '2018-01-20', 'M', 3, 25),
('Zyga', '2022-04-17', 'F', 2, 6),   
('Tina', '2021-05-10', 'F', 3, 6),     
('Max', '2019-01-15', 'M', 1, 7),      
('Milo', '2020-06-20', 'M', 1, 7),    
('Roxy', '2019-02-12', 'F', 2, 8),    
('Daisy', '2020-03-18', 'F', 2, 8),    
('Buddy', '2018-09-25', 'M', 1, 9),    
('Chester', '2019-11-30', 'M', 3, 10),  
('Lola', '2020-08-05', 'F', 2, 12),     
('Oscar', '2018-12-01', 'M', 3, 13);    

INSERT INTO visit (visit_date, reason, pet_id, vet_id) VALUES
('2018-12-01', 'Szczepienie przeciwko wściekliźnie', 1, 5), 
('2021-03-10', 'Kontrola zdrowia', 2, 6),             -- 12
('2020-01-15', 'Konsultacja w sprawie nadwagi', 3, 5),   
('2022-06-22', 'Operacja usunięcia guza', 4, 7),    --14    
('2022-01-13', 'Wizyta kontrolna', 5, 6),                 
('2020-09-30', 'Problemy z oddychaniem', 6, 9),      -- 16    
('2019-11-11', 'Szczepienie', 7, 5),  
('2020-08-05', 'Konsultacja w sprawie alergii', 8, 6),   -- 18 
('2020-05-20', 'Problemy z okiem', 9, 8),                 
('2023-07-10', 'Kontrola pooperacyjna', 4, 7),          
('2023-04-14', 'Wizyta kontrolna', 11, 6),                 
('2020-02-20', 'Wizyta w celu wystawienia recepty', 12, 5),  
('2021-03-15', 'Szczepienie przeciwko chorobie wirusowej', 13, 6), -- 23
('2021-12-30', 'Konsultacja w sprawie utraty apetytu', 14, 5), 
('2018-05-05', 'Zabieg sterylizacji', 15, 7),       -- 25      
('2023-08-21', 'Szczepienie', 16, 8);   

INSERT INTO lab_test
(test_date, test_type, test_results, notes, visit_id)
VALUES
('2021-03-10', 'Hemoglobina', '9.8', 'Wynik ok', 12),
('2021-03-10', 'Białe krwinki', '9.6', 'Wynik ok', 12),
('2021-03-10', 'Białe krwinki', '11.3', 'Badania przedoperacyjne, nie ma przeciwskazań', 14),
('2020-09-30', 'RTG płuc', 'Widać lekkie nieprawidłowości', 'Podejrzenie astmy', 16),
('2020-08-05', 'Panel alergiczny', 'Alergia na kurz', null, 18),
('2020-08-05', 'Badanie przeciwciał', 'Widać dużo przeciwciał', null, 18)
;

INSERT INTO treatment
(treatment_type, procedure, notes, visit_id)
VALUES
('Szczepienie', 'Podano szczepionkę.', null, 11),
('Operacja', 'Usunięto guz.', 'Operacja przebiegła bezproblemowo', 14),
('Szczepienie', 'Podano szczepionkę na wściekliznę.', null, 17),
('Zabieg', 'Przemyto oczy zwierzęcia.', null, 19),
('Szczepienie', 'Podano 2 szczepionki.', null, 23),
('Zabieg', 'Przeprowadzono zabieg sterylizacji', null, 25),
('Szczepienie', 'Podano szcz. na wściekliznę.', null, 26)
;

INSERT INTO diagnosis
(diagnosis_type, notes, visit_id)
VALUES
('Nadwaga', 'Zalecono podawanie mniejszej ilości pokarmu i przysmaków', 13),
('Astma', 'Lekka astma', 16),
('Zakażenie bakteryjne', 'Zakażenie spowodowało utratę energii i apetytu', 24)
;

INSERT INTO medicine_plan
(medicine_name, dosage, dosage_unit, frequency, duration, diagnosis_id)
VALUES
('Amoksycilina', 1.0, 'tabletka', '1 raz dziennie ', 'przez tydzień', 8),
('Albuterol', 1.0, 'tabletka', '2 razy dziennie', 'cały czas', 7)
;

INSERT INTO prescription
(prescription_date, medicine_name, medicine_amount, visit_id)
VALUES
('2020-08-05', 'Benadryl ', 2, 18),
('2020-02-20', 'Buspirone', 4, 22),
('2021-12-30', 'Amoksycilina', 1, 24),
('2020-09-30', 'Albuterol', 10, 16)

;


