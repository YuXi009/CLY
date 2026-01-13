CREATE TABLE users (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(250) NOT NULL UNIQUE,
    password VARCHAR(250) NOT NULL
);

CREATE TABLE Patient (
  patienten_id INT NOT NULL AUTO_INCREMENT,
  Name VARCHAR (100) NOT NULL,
  Geburtsdatum DATE,
  Geschlecht VARCHAR(20),
  Gewicht INT,
  Aktivitaetsstatus BOOLEAN,
  Versicherungsnummer INT
);


CREATE TABLE Allergie (
  allergie_id INT NOT NULL AUTO_INCREMENT,
  Name VARCHAR(100),
);

CREATE TABLE Patient_Allergie (
  patienten_id INT NOT NULL,
  allergie_id INT NOT NULL,
  PRIMARY KEY (patienten_id, allergie_id),
  FOREIGN KEY (patienten_id) REFERENCES Patient(patienten_id),
  FOREIGN KEY (allergie_id) REFERENCES Allergie(allergie_id)
);

INSERT INTO Allergie
(allergie_id, Name)
VALUES
(1,'Nüsse'), (2, 'Erdnüsse'), (3, 'Laktose'), (4, 'Gluten'), (5, 'Eier'), (6, 'Fisch'), (7, 'Meeresfrüchte'), (8, 'Soja'), (9, 'Sesam');

CREATE TABLE Ernaerungspraeferenzen (
  praeferenz_id INT NOT NULL AUTO_INCREMENT,
  Name VARCHAR(100)
);

CREATE Patienten_Ernaerungspraeferenzen (
  patienten_id INT NOT NULL,
  praeferenz_id INT NOT NULL,
  PRIMARY KEY (patienten_id, praeferenz_id),
  FOREIGN KEY (patienten_id) REFERENCES Patient(patienten_id),
  FOREIGN KEY (praeferenz_id) REFERENCES Ernaerungspraeferenzen(praferenz_id)
);
INSERT INTO Ernaerungspraeferenzen (Name) VALUES
('Vegetarisch'),
('Vegan'),
('Glutenfrei'),
('Laktosefrei'),
('Halal'),
('Koscher'),
('Kein Schweinefleisch');

CREATE TABLE Medikamente (
  medikament_id INT NOT NULL AUTO_INCREMENT,
  Name VARCHAR(50),
  Wirkstoff MEDIUMTEXT,
  Dosis DECIMAL(10,2),
  Beschreibung MEDIUMTEXT
);

INSERT INTO Medikamente 
(medikament_id, Name, Wirkstoff, Dosis, Beschreibung)
VALUES
(1, 'Aspirin', 'Acetylsalicylsäure', 500.00, 'Schmerzmittel, entzündungshemmend; kann Magen reizen'),
(2, 'Paracetamol', 'Paracetamol', 500.00, 'Schmerz- und fiebersenkend; leberschonend dosieren'),
(3, 'Ibuprofen', 'Ibuprofen', 400.00, 'Schmerzmittel; nicht nüchtern einnehmen'),
(4, 'Metformin', 'Metforminhydrochlorid', 850.00, 'Blutzuckersenkend bei Diabetes Typ 2'),
(5, 'Eisenpraeparat', 'Eisensulfat', 100.00, 'Zur Behandlung von Eisenmangel; nicht mit Milch einnehmen');


CREATE TABLE Lebensmittel (
  lebensmittel_id INT NOT NULL AUTO_INCREMENT,
  Name VARCHAR(50),
  Naehrwerte VARCHAR(50)
);

INSERT INTO Lebensmittel
(lebensmittel_id, Name, Naehrwerte)
VALUES
(1, 'Apfel', 'Ballaststoffe, Vitamin C'),
(2, 'Banane', 'Kalium, Magnesium'),
(3, 'Milch', 'Kalzium, Protein'),
(4, 'Vollkornbrot', 'Ballaststoffe, Eisen'),
(5, 'Lachs', 'Omega-3-Fettsaeuren, Vitamin D'),
(6, 'Spinat', 'Eisen, Magnesium'),
(7, 'Reis', 'Kohlenhydrate'),
(8, 'Ei', 'Protein, Vitamin B12');

CREATE TABLE Gericht (
  gericht_id INT NOT NULL AUTO_INCREMENT,
  Name VARCHAR(50),
  Beschreibung MEDIUMTEXT,
  Portionsgroesse VARCHAR(50),
  Naehrwerte VARCHAR(50)
);

INSERT INTO Gericht
(gericht_id, Name, Beschreibung, Portionsgroesse, Naehrwerte)
VALUES
(1, 'Haferflocken mit Fruechten', 'Haferflocken mit Apfel und Banane', '300g', 'Ballaststoffe, Magnesium, Vitamin C'),
(2, 'Lachs mit Reis', 'Geduensteter Lachs mit Reis und Gemuese', '450g', 'Omega-3, Protein, Vitamin D'),
(3, 'Gemuesesuppe', 'Leichte Suppe mit Karotten, Kartoffeln und Sellerie', '350ml', 'Vitamine, Mineralstoffe'),
(4, 'Vollkornbrot mit Ei', 'Vollkornbrot mit gekochtem Ei', '250g', 'Protein, Eisen, Vitamin B12'),
(5, 'Spinatnudeln', 'Pasta mit Spinatsauce', '400g', 'Eisen, Kohlenhydrate');
