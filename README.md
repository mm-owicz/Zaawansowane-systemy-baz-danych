# Zaawansowane systemy baz danych

Repozytorium do przedmiotu "Zaawansowane systemy baz danych", Informatyka II stopnia, Politechnika Warszawska.

Case study -> Case study do etapu I:
- Analiza zadania
- Diagram ERD
- Schemat logiczny bazy danych
  
Etap I -> Stworzenie bd w PostgreSQL:
- Storzenie tabel, relacji
- Użytkownicy, perspektywy
- Zapytania SQL
- Indeksy, analiza indeksów
  
Etap II -> Dodanie funkcjonalności do Etap I, migracja do MySQL:
- Funkcja użytkownika UDF
- Procedury dodawania nowych danych
- Złożona procedura
- Wyzwalacze (Triggery)
- Automatyzacja zadania (job'y)
- Kopia zapasowa (dump)
- Analiza różnic między dialektami PostgreSQL i MySQL, analiza narzędzi ETL
- Migracja PostgreSQL->MySQL za pomocą DBeaver, poprawki do migracji

Etap III -> Stworzenie bd w MongoDB (nowy zbiór danych):
- Przetworzenie, import danych, dodanie dokumentów zagnieżdzonych i referencji
- Implementacja logiki biznesowej: sekwencji do autoinkrementacji, funkcji do wstawiania/modyfikacji danych, agregacji
- Indeksy, analiza i testy indeksów
- Implementacja transakcji (w javascript)
- Zapytania geoprzestrzenne

Etap IV -> Stworzenie bd w Neo4j (nowy zbiór danych):
- Przetworzenie i import danych, ręczne dodawanie danych z MERGE
- Zapytania typu MATCH
- Dodanie indeksów, analiza indeksów
- Dodanie danych przestrzennych, zapytania przestrzenne
- Implementacja procedur w Javie
- Analiza zbioru danych - węzły przegubowe, mosty, podgrafy
- Funkcjonalności biblioteki APOC

