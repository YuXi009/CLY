DELETE FROM Patient WHERE patienten_id = 0;
ALTER TABLE Patient MODIFY patienten_id INT NOT NULL AUTO_INCREMENT;

INSERT INTO Patient
    -> (patienten_id, Name, Geburtsdatum, Geschlecht, Gewicht, Aktivitaetsstatus, Versicherungsnummer)
    -> VALUES
    -> (1, 'Max Mustermann', '1985-06-15', 'Männlich', 80, 1, 123456789),
    -> (2, 'Erika Musterfrau', '1990-09-25', 'Weiblich', 65, 0, 987654321),
    -> (3, 'Hans Beispiel', '1975-12-05', 'Männlich', 90, 1, 456789123),
    -> (4, 'Anna Beispielin', '2000-03-30', 'Weiblich', 55, 1, 321654987),
    -> (5, 'Peter Test', '1965-11-20', 'Männlich', 85, 0, 654321789);