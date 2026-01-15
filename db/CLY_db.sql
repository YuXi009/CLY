CREATE TABLE users (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(250) NOT NULL UNIQUE,
    password VARCHAR(250) NOT NULL
);

CREATE TABLE Patient (
  patienten_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR (100) NOT NULL,
  Geburtsdatum DATE,
  Geschlecht VARCHAR(20),
  Gewicht INT,
  Aktivitaetsstatus BOOLEAN,
  Versicherungsnummer INT
);


CREATE TABLE Allergie (
  allergie_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(100)
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

CREATE TABLE Ernaehrungspraeferenzen (
  praeferenz_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(100)
);

CREATE TABLE Patient_Ernaehrungspraeferenzen (
  patienten_id INT NOT NULL,
  praeferenz_id INT NOT NULL,
  PRIMARY KEY (patienten_id, praeferenz_id),
  FOREIGN KEY (patienten_id) REFERENCES Patient(patienten_id),
  FOREIGN KEY (praeferenz_id) REFERENCES Ernaehrungspraeferenzen(praeferenz_id)
);
INSERT INTO Ernaehrungspraeferenzen (Name) VALUES
('Vegetarisch'),
('Vegan'),
('Glutenfrei'),
('Laktosefrei'),
('Halal'),
('Koscher'),
('Kein Schweinefleisch');

CREATE TABLE Medikament (
  medikament_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(100),
  Wirkstoff VARCHAR(100),
  Dosierung DECIMAL(10,2),
  Beschreibung MEDIUMTEXT
);

CREATE TABLE Patient_Medikament (
  patienten_id INT NOT NULL,
  medikament_id INT NOT NULL,
  PRIMARY KEY (patienten_id, medikament_id),
  FOREIGN KEY (patienten_id) REFERENCES Patient(patienten_id),
  FOREIGN KEY (medikament_id) REFERENCES Medikament(medikament_id)
);

INSERT INTO Medikament 
(medikament_id, Name, Wirkstoff, Dosierung, Beschreibung)
VALUES
(1, 'Aspirin', 'Acetylsalicylsäure', 500.00, 'Schmerzmittel, entzündungshemmend; kann Magen reizen'),
(2, 'Paracetamol', 'Paracetamol', 500.00, 'Schmerz- und fiebersenkend; leberschonend dosieren'),
(3, 'Ibuprofen', 'Ibuprofen', 400.00, 'Schmerzmittel; nicht nüchtern einnehmen'),
(4, 'Metformin', 'Metforminhydrochlorid', 850.00, 'Blutzuckersenkend bei Diabetes Typ 2'),
(5, 'Eisenpraeparat', 'Eisensulfat', 100.00, 'Zur Behandlung von Eisenmangel; nicht mit Milch einnehmen');



CREATE TABLE Gericht (
  gericht_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(50),
  meal_type ENUM('Fruehstueck','Mittagessen','Abendessen') NOT NULL,
  Beschreibung VARCHAR(255),
  Portionsgroesse VARCHAR(20),
  Naehrwerte VARCHAR(255)
);

INSERT INTO Gericht (Name, meal_type, Beschreibung, Portionsgroesse, Naehrwerte) VALUES
-- Frühstück
('Haferflocken mit Früchten (vegan, glutenfrei)', 'Fruehstueck', 'Glutenfreie Haferflocken mit Banane & Beeren, ohne Milch', '300g', 'Ballaststoffe, Vitamine'),
('Reiswaffeln mit Hummus', 'Fruehstueck', 'Reiswaffeln mit Hummus und Gurke', '250g', 'Protein, Kohlenhydrate'),
('Joghurt mit Beeren', 'Fruehstueck', 'Naturjoghurt mit Beeren', '250g', 'Protein, Kalzium'),

-- Mittagessen
('Gemüse-Reis-Bowl', 'Mittagessen', 'Reis mit Gemüse, ohne Soja-Sauce', '450g', 'Vitamine, Kohlenhydrate'),
('Hähnchen mit Reis (halal)', 'Mittagessen', 'Gegrilltes Hähnchen mit Reis & Gemüse', '450g', 'Protein, Kohlenhydrate'),
('Rindfleisch-Eintopf (koscher möglich)', 'Mittagessen', 'Rind mit Kartoffeln & Karotten', '450g', 'Protein, Eisen'),
('Linsensuppe (vegan)', 'Mittagessen', 'Linsensuppe mit Gemüse', '400ml', 'Protein, Ballaststoffe'),
('Pasta mit Pesto (enthält Nüsse)', 'Mittagessen', 'Pasta mit Basilikum-Pesto', '400g', 'Kohlenhydrate, Fett'),

-- Abendessen
('Kartoffel-Gemüse-Pfanne', 'Abendessen', 'Kartoffeln mit Gemüse, ohne Milchprodukte', '400g', 'Vitamine'),
('Ofenlachs mit Gemüse', 'Abendessen', 'Lachsfilet mit Gemüse', '400g', 'Omega-3, Protein'),
('Shrimp-Reis-Pfanne', 'Abendessen', 'Garnelen mit Reis und Gemüse', '400g', 'Protein'),
('Sesam-Tofu mit Gemüse', 'Abendessen', 'Tofu mit Gemüse, Sesam-Topping', '400g', 'Protein'),
('Omelett', 'Abendessen', 'Eieromelett mit Gemüse', '350g', 'Protein');

INSERT INTO Gericht (Name, meal_type, Beschreibung, Portionsgroesse, Naehrwerte) VALUES
-- =========================
-- FRUEHSTUECK (20+)
-- =========================
('Obstsalat Deluxe', 'Fruehstueck', 'Frische Früchte nach Saison', '300g', 'Vitamine, Ballaststoffe'),
('Reisbrei mit Zimt', 'Fruehstueck', 'Reisbrei mit Zimt und Apfel', '300g', 'Kohlenhydrate, Ballaststoffe'),
('Hirsebrei mit Beeren', 'Fruehstueck', 'Hirsebrei mit Beeren', '300g', 'Mineralstoffe, Ballaststoffe'),
('Smoothie Bowl (ohne Nüsse)', 'Fruehstueck', 'Beeren-Bananen Bowl', '300g', 'Vitamine'),
('Avocado-Tomaten-Salat', 'Fruehstueck', 'Avocado, Tomate, Zitrone', '250g', 'Fette, Vitamine'),
('Kartoffelrösti mit Apfelmus', 'Fruehstueck', 'Rösti aus Kartoffeln, Apfelmus', '300g', 'Kohlenhydrate'),
('Maisgrießbrei (Polenta süß)', 'Fruehstueck', 'Süße Polenta mit Früchten', '300g', 'Kohlenhydrate'),
('Reiswaffeln mit Marmelade', 'Fruehstueck', 'Reiswaffeln + Marmelade', '200g', 'Kohlenhydrate'),
('Haferbrei (glutenfrei)', 'Fruehstueck', 'GF Oats mit Banane', '300g', 'Ballaststoffe'),
('Joghurt (laktosefrei) mit Früchten', 'Fruehstueck', 'Laktosefrei + Früchte', '300g', 'Protein, Vitamine'),
('Rührei mit Spinat', 'Fruehstueck', 'Eier + Spinat', '250g', 'Protein, Eisen'),
('Vollkornbrot mit Ei', 'Fruehstueck', 'Brot + Ei', '250g', 'Protein, Eisen'),
('Glutenfreies Brot mit Avocado', 'Fruehstueck', 'GF Brot + Avocado', '250g', 'Fette'),
('Tomatenreis (mild)', 'Fruehstueck', 'Reis mit Tomate', '300g', 'Kohlenhydrate'),
('Bananen-Hafer-Smoothie (laktosefrei)', 'Fruehstueck', 'Banane + LF Drink', '300ml', 'Kalium'),
('Bircher (laktosefrei)', 'Fruehstueck', 'LF Joghurt, Apfel, GF Oats', '300g', 'Ballaststoffe'),
('Porridge mit Dattel', 'Fruehstueck', 'Hafer/ GF Option möglich', '300g', 'Ballaststoffe'),
('Apfelmus mit Zwieback (glutenfrei)', 'Fruehstueck', 'Apfelmus + GF Zwieback', '250g', 'Kohlenhydrate'),
('Kartoffel-Gemüse-Pfanne', 'Fruehstueck', 'Kartoffeln + Gemüse', '350g', 'Vitamine'),
('Kürbisbrei', 'Fruehstueck', 'Kürbisbrei süß', '300g', 'Vitamine'),

-- =========================
-- MITTAGESSEN (25+)
-- =========================
('Gemüse-Reis-Pfanne', 'Mittagessen', 'Reis mit Gemüse', '450g', 'Vitamine, Kohlenhydrate'),
('Kichererbsen-Curry', 'Mittagessen', 'Kichererbsen & Gemüse', '450g', 'Protein, Ballaststoffe'),
('Linsen-Dal mit Reis', 'Mittagessen', 'Linsen dal + Reis', '450g', 'Protein, Ballaststoffe'),
('Kartoffel-Gemüse-Eintopf', 'Mittagessen', 'Eintopf', '500g', 'Vitamine'),
('Rind-Gulasch mit Reis', 'Mittagessen', 'Rind + Reis', '500g', 'Eisen, Protein'),
('Hähnchen mit Ofengemüse', 'Mittagessen', 'Hähnchen + Gemüse', '500g', 'Protein'),
('Fischfilet mit Kartoffeln', 'Mittagessen', 'Fisch + Kartoffeln', '450g', 'Omega-3'),
('Tofu-Gemüse-Pfanne', 'Mittagessen', 'Tofu + Gemüse + Reis', '450g', 'Protein'),
('Bohnen-Chili', 'Mittagessen', 'Chili sin carne', '450g', 'Protein, Ballaststoffe'),
('Quinoa-Gemüse-Bowl', 'Mittagessen', 'Quinoa + Gemüse', '450g', 'Protein'),
('Reisnudeln mit Gemüse', 'Mittagessen', 'Reisnudeln + Gemüse', '450g', 'Kohlenhydrate'),
('Kartoffelgratin (laktosefrei)', 'Mittagessen', 'LF Alternative', '450g', 'Kohlenhydrate'),
('Gemüse-Suppe mit Reis', 'Mittagessen', 'Suppe + Reis', '500ml', 'Vitamine'),
('Tomatenpasta (glutenfrei)', 'Mittagessen', 'GF Pasta + Tomatensauce', '450g', 'Kohlenhydrate'),
('Bulgur-Gemüse-Pfanne', 'Mittagessen', 'Bulgur + Gemüse', '450g', 'Ballaststoffe'),
('Falafel-Teller', 'Mittagessen', 'Falafel + Reis + Salat', '450g', 'Protein'),
('Ratatouille mit Reis', 'Mittagessen', 'Gemüsegericht + Reis', '450g', 'Vitamine'),
('Pilz-Risotto (laktosefrei)', 'Mittagessen', 'Risotto LF', '450g', 'Kohlenhydrate'),
('Kürbis-Suppe', 'Mittagessen', 'Kürbiscremesuppe', '500ml', 'Vitamine'),
('Spinat-Kartoffel-Pfanne', 'Mittagessen', 'Spinat + Kartoffeln', '450g', 'Eisen'),
('Rote Linsen Pasta (glutenfrei)', 'Mittagessen', 'GF Pasta aus Linsen', '450g', 'Protein'),
('Koscher geeignet: Gemüse-Reis', 'Mittagessen', 'Einfaches Gemüse-Reis Gericht', '450g', 'Kohlenhydrate'),
('Halal geeignet: Hähnchen-Reis', 'Mittagessen', 'Hähnchen + Reis (Halal)', '450g', 'Protein'),
('Kein Schwein: Rind + Kartoffeln', 'Mittagessen', 'Rindfleisch + Kartoffeln', '450g', 'Protein'),
('Gemüse-Lasagne (glutenfrei, laktosefrei)', 'Mittagessen', 'GF/LF Lasagne', '450g', 'Kohlenhydrate'),

-- =========================
-- ABENDESSEN (20+)
-- =========================
('Kartoffel-Lauch-Suppe', 'Abendessen', 'Suppe', '500ml', 'Vitamine'),
('Tomaten-Bohnensuppe', 'Abendessen', 'Tomate + Bohnen', '500ml', 'Protein'),
('Gemüse-Chili', 'Abendessen', 'Chili sin carne', '450g', 'Protein'),
('Gemüse-Risotto (laktosefrei)', 'Abendessen', 'LF Risotto', '450g', 'Kohlenhydrate'),
('Reis mit Gemüse', 'Abendessen', 'Einfach, mild', '450g', 'Kohlenhydrate'),
('Hähnchensuppe', 'Abendessen', 'Hähnchen + Gemüse', '500ml', 'Protein'),
('Fischsuppe', 'Abendessen', 'Fisch + Gemüse', '500ml', 'Omega-3'),
('Linsensuppe', 'Abendessen', 'Linsen + Gemüse', '500ml', 'Protein'),
('Ofenkartoffeln mit Kräutern', 'Abendessen', 'Kartoffeln', '450g', 'Kohlenhydrate'),
('Ratatouille', 'Abendessen', 'Gemüsegericht', '450g', 'Vitamine'),
('Reisnudel-Suppe', 'Abendessen', 'Reisnudeln + Gemüse', '500ml', 'Kohlenhydrate'),
('Gemüse-Pfanne', 'Abendessen', 'Gemüse mix', '450g', 'Vitamine'),
('Quinoa-Salat', 'Abendessen', 'Quinoa + Gemüse', '400g', 'Protein'),
('Falafel ohne Sesam', 'Abendessen', 'Falafel ohne Tahini', '450g', 'Protein'),
('Tofu-Suppe', 'Abendessen', 'Tofu + Gemüse', '500ml', 'Protein'),
('Kartoffel-Spinat-Eintopf', 'Abendessen', 'Kartoffel + Spinat', '500ml', 'Eisen'),
('Reis mit Hummus (ohne Sesam)', 'Abendessen', 'Hummus ohne Tahini', '450g', 'Protein'),
('Gemüse-Curry', 'Abendessen', 'Gemüse curry mild', '450g', 'Vitamine'),
('Reis mit Linsen', 'Abendessen', 'Reis + Linsen', '450g', 'Protein'),
('Früchte-Kompot', 'Abendessen', 'Leichtes Dessert', '250g', 'Vitamine');

CREATE TABLE Gericht_Allergie (
  gericht_id INT NOT NULL,
  allergie_id INT NOT NULL,
  PRIMARY KEY (gericht_id, allergie_id),
  FOREIGN KEY (gericht_id) REFERENCES Gericht(gericht_id),
  FOREIGN KEY (allergie_id) REFERENCES Allergie(allergie_id) 
);


-- Eier
INSERT INTO Gericht_Allergie (gericht_id, allergie_id)
SELECT g.gericht_id, a.allergie_id
FROM Gericht g, Allergie a
WHERE g.Name IN ('Rührei mit Spinat','Vollkornbrot mit Ei') AND a.Name='Eier';

-- Gluten (nur bei Brot/Bulgur normal)
INSERT INTO Gericht_Allergie (gericht_id, allergie_id)
SELECT g.gericht_id, a.allergie_id
FROM Gericht g, Allergie a
WHERE g.Name IN ('Vollkornbrot mit Ei','Bulgur-Gemüse-Pfanne') AND a.Name='Gluten';

-- Fisch
INSERT INTO Gericht_Allergie (gericht_id, allergie_id)
SELECT g.gericht_id, a.allergie_id
FROM Gericht g, Allergie a
WHERE g.Name IN ('Fischfilet mit Kartoffeln','Fischsuppe','Lachs mit Reis') AND a.Name='Fisch';

-- Soja (Tofu)
INSERT INTO Gericht_Allergie (gericht_id, allergie_id)
SELECT g.gericht_id, a.allergie_id
FROM Gericht g, Allergie a
WHERE g.Name IN ('Tofu-Gemüse-Pfanne','Tofu-Suppe') AND a.Name='Soja';

-- Sesam (nur wenn ihr es wirklich mit Tahini macht)
INSERT INTO Gericht_Allergie (gericht_id, allergie_id)
SELECT g.gericht_id, a.allergie_id
FROM Gericht g, Allergie a
WHERE g.Name IN ('Falafel-Teller') AND a.Name='Sesam';

CREATE TABLE Gericht_Ernaehrungspraeferenzen (
  gericht_id INT NOT NULL,
  praeferenz_id INT NOT NULL,
  PRIMARY KEY (gericht_id, praeferenz_id),
  FOREIGN KEY (gericht_id) REFERENCES Gericht(gericht_id),
  FOREIGN KEY (praeferenz_id) REFERENCES Ernaehrungspraeferenzen(praeferenz_id)
);

-- Vegan + Vegetarisch + Glutenfrei: Haferflocken (vegan, glutenfrei)
INSERT INTO Gericht_Ernaehrungspraeferenzen (gericht_id, praeferenz_id)
SELECT gericht_id, 2 FROM Gericht WHERE Name='Haferflocken mit Früchten (vegan, glutenfrei)';
INSERT INTO Gericht_Ernaehrungspraeferenzen (gericht_id, praeferenz_id)
SELECT gericht_id, 1 FROM Gericht WHERE Name='Haferflocken mit Früchten (vegan, glutenfrei)';
INSERT INTO Gericht_Ernaehrungspraeferenzen (gericht_id, praeferenz_id)
SELECT gericht_id, 3 FROM Gericht WHERE Name='Haferflocken mit Früchten (vegan, glutenfrei)';

-- Vegan + Vegetarisch + Glutenfrei: Linsensuppe
INSERT INTO Gericht_Ernaehrungspraeferenzen (gericht_id, praeferenz_id)
SELECT gericht_id, 2 FROM Gericht WHERE Name='Linsensuppe (vegan)';
INSERT INTO Gericht_Ernaehrungspraeferenzen (gericht_id, praeferenz_id)
SELECT gericht_id, 1 FROM Gericht WHERE Name='Linsensuppe (vegan)';
INSERT INTO Gericht_Ernaehrungspraeferenzen (gericht_id, praeferenz_id)
SELECT gericht_id, 3 FROM Gericht WHERE Name='Linsensuppe (vegan)';

-- Laktosefrei + Glutenfrei: Gemüse-Reis-Bowl
INSERT INTO Gericht_Ernaehrungspraeferenzen (gericht_id, praeferenz_id)
SELECT gericht_id, 4 FROM Gericht WHERE Name='Gemüse-Reis-Bowl';
INSERT INTO Gericht_Ernaehrungspraeferenzen (gericht_id, praeferenz_id)
SELECT gericht_id, 3 FROM Gericht WHERE Name='Gemüse-Reis-Bowl';

-- Halal + Kein Schweinefleisch (+ Glutenfrei): Hähnchen mit Reis
INSERT INTO Gericht_Ernaehrungspraeferenzen (gericht_id, praeferenz_id)
SELECT gericht_id, 5 FROM Gericht WHERE Name='Hähnchen mit Reis (halal)';
INSERT INTO Gericht_Ernaehrungspraeferenzen (gericht_id, praeferenz_id)
SELECT gericht_id, 7 FROM Gericht WHERE Name='Hähnchen mit Reis (halal)';
INSERT INTO Gericht_Ernaehrungspraeferenzen (gericht_id, praeferenz_id)
SELECT gericht_id, 3 FROM Gericht WHERE Name='Hähnchen mit Reis (halal)';

-- Koscher + Kein Schweinefleisch: Rindfleisch-Eintopf
INSERT INTO Gericht_Ernaehrungspraeferenzen (gericht_id, praeferenz_id)
SELECT gericht_id, 6 FROM Gericht WHERE Name='Rindfleisch-Eintopf (koscher möglich)';
INSERT INTO Gericht_Ernaehrungspraeferenzen (gericht_id, praeferenz_id)
SELECT gericht_id, 7 FROM Gericht WHERE Name='Rindfleisch-Eintopf (koscher möglich)';

-- Vegetarisch (nicht vegan): Omelett
INSERT INTO Gericht_Ernaehrungspraeferenzen (gericht_id, praeferenz_id)
SELECT gericht_id, 1 FROM Gericht WHERE Name='Omelett';

-- “Kein Schweinefleisch” kannst du fast überall setzen, wenn kein Schwein drin ist:
INSERT INTO Gericht_Ernaehrungspraeferenzen (gericht_id, praeferenz_id)
SELECT gericht_id, 7 FROM Gericht WHERE Name='Ofenlachs mit Gemüse';


CREATE TABLE Patient_Ernaehrungsplan (
  plan_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  patienten_id INT NOT NULL,
  plan_datum DATE NOT NULL,
  meal_type ENUM('Fruehstueck','Mittagessen','Abendessen') NOT NULL,
  gericht_id INT NOT NULL,
  UNIQUE(patienten_id, plan_datum, meal_type),
  FOREIGN KEY (patienten_id) REFERENCES Patient(patienten_id),
  FOREIGN KEY (gericht_id) REFERENCES Gericht(gericht_id)
);

# Vegan
INSERT INTO Gericht_Ernaehrungspraeferenzen (gericht_id, praeferenz_id)
SELECT g.gericht_id, p.praeferenz_id
FROM Gericht g, Ernaehrungspraeferenzen p
WHERE p.Name='Vegan'
AND g.Name IN (
  'Obstsalat Deluxe','Reisbrei mit Zimt','Hirsebrei mit Beeren','Smoothie Bowl (ohne Nüsse)',
  'Avocado-Tomaten-Salat','Reiswaffeln mit Marmelade','Maisgrießbrei (Polenta süß)','Tomatenreis (mild)',
  'Gemüse-Reis-Pfanne','Kichererbsen-Curry','Linsen-Dal mit Reis','Kartoffel-Gemüse-Eintopf',
  'Bohnen-Chili','Quinoa-Gemüse-Bowl','Reisnudeln mit Gemüse','Gemüse-Suppe mit Reis',
  'Ratatouille mit Reis','Kürbis-Suppe','Spinat-Kartoffel-Pfanne','Ratatouille',
  'Tomaten-Bohnensuppe','Kartoffel-Lauch-Suppe','Linsensuppe','Ofenkartoffeln mit Kräutern',
  'Gemüse-Curry','Reis mit Linsen','Früchte-Kompot'
);

# Vegetarisch
INSERT INTO Gericht_Ernaehrungspraeferenzen (gericht_id, praeferenz_id)
SELECT g.gericht_id, p.praeferenz_id
FROM Gericht g, Ernaehrungspraeferenzen p
WHERE p.Name='Vegetarisch'
AND g.Name IN (
  'Obstsalat Deluxe','Reisbrei mit Zimt','Hirsebrei mit Beeren','Smoothie Bowl (ohne Nüsse)',
  'Avocado-Tomaten-Salat','Reiswaffeln mit Marmelade','Maisgrießbrei (Polenta süß)','Tomatenreis (mild)',
  'Gemüse-Reis-Pfanne','Kichererbsen-Curry','Linsen-Dal mit Reis','Kartoffel-Gemüse-Eintopf',
  'Bohnen-Chili','Quinoa-Gemüse-Bowl','Reisnudeln mit Gemüse','Gemüse-Suppe mit Reis',
  'Ratatouille mit Reis','Pilz-Risotto (laktosefrei)','Kürbis-Suppe','Spinat-Kartoffel-Pfanne',
  'Falafel-Teller','Gemüse-Chili','Gemüse-Risotto (laktosefrei)','Reis mit Gemüse','Quinoa-Salat'
);

# Glutenfrei
INSERT INTO Gericht_Ernaehrungspraeferenzen (gericht_id, praeferenz_id)
SELECT g.gericht_id, p.praeferenz_id
FROM Gericht g, Ernaehrungspraeferenzen p
WHERE p.Name='Glutenfrei'
AND g.Name IN (
  'Obstsalat Deluxe','Reisbrei mit Zimt','Hirsebrei mit Beeren','Smoothie Bowl (ohne Nüsse)',
  'Reiswaffeln mit Marmelade','Maisgrießbrei (Polenta süß)','Haferbrei (glutenfrei)',
  'Gemüse-Reis-Pfanne','Kichererbsen-Curry','Linsen-Dal mit Reis','Kartoffel-Gemüse-Eintopf',
  'Bohnen-Chili','Quinoa-Gemüse-Bowl','Reisnudeln mit Gemüse','Tomatenpasta (glutenfrei)',
  'Rote Linsen Pasta (glutenfrei)','Kürbis-Suppe','Kartoffel-Lauch-Suppe','Tomaten-Bohnensuppe',
  'Gemüse-Chili','Reis mit Linsen','Ofenkartoffeln mit Kräutern'
);

# Laktosefrei
INSERT INTO Gericht_Ernaehrungspraeferenzen (gericht_id, praeferenz_id)
SELECT g.gericht_id, p.praeferenz_id
FROM Gericht g, Ernaehrungspraeferenzen p
WHERE p.Name='Laktosefrei'
AND g.Name IN (
  'Joghurt (laktosefrei) mit Früchten','Bircher (laktosefrei)','Bananen-Hafer-Smoothie (laktosefrei)',
  'Kichererbsen-Curry','Linsen-Dal mit Reis','Gemüse-Reis-Pfanne','Bohnen-Chili','Quinoa-Gemüse-Bowl',
  'Kartoffelgratin (laktosefrei)','Pilz-Risotto (laktosefrei)','Gemüse-Risotto (laktosefrei)',
  'Kartoffel-Lauch-Suppe','Tomaten-Bohnensuppe','Gemüse-Chili','Ofenkartoffeln mit Kräutern'
);

# Kein Schweinefleisch
INSERT INTO Gericht_Ernaehrungspraeferenzen (gericht_id, praeferenz_id)
SELECT g.gericht_id, p.praeferenz_id
FROM Gericht g, Ernaehrungspraeferenzen p
WHERE p.Name='Kein Schweinefleisch'
AND g.Name IN (
  'Hähnchen mit Ofengemüse','Rind-Gulasch mit Reis','Fischfilet mit Kartoffeln','Kichererbsen-Curry',
  'Gemüse-Reis-Pfanne','Quinoa-Gemüse-Bowl','Gemüse-Chili','Kartoffel-Lauch-Suppe','Tomaten-Bohnensuppe'
);

-- Welche Allergene hat welches Gericht?
SELECT g.Name AS Gericht, a.Name AS Allergen
FROM Gericht g
JOIN Gericht_Allergie ga ON ga.gericht_id = g.gericht_id
JOIN Allergie a ON a.allergie_id = ga.allergie_id
ORDER BY g.Name, a.Name;

-- Welche Präferenzen erfüllt welches Gericht?
SELECT g.Name AS Gericht, e.Name AS Praeferenz
FROM Gericht g
JOIN Gericht_Ernaehrungspraeferenzen ge ON ge.gericht_id = g.gericht_id
JOIN Ernaehrungspraeferenzen e ON e.praeferenz_id = ge.praeferenz_id
ORDER BY g.Name, e.Name;
