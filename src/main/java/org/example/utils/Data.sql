-- Insertion dans typepret (types de prêt)
INSERT INTO typepret(type) VALUES 
('surplace'),
('domicile');

-- Insertion dans jourferie (jours fériés connus en France par exemple)
INSERT INTO jourferie(date, nom) VALUES
('2025-01-01', 'Nouvel An'),
('2025-04-01', 'Lundi de Pâques'),
('2025-05-01', 'Fête du Travail'),
('2025-05-08', 'Victoire 1945'),
('2025-05-09', 'Ascension'),
('2025-05-20', 'Lundi de Pentecôte'),
('2025-07-14', 'Fête Nationale'),
('2025-08-15', 'Assomption'),
('2025-11-01', 'Toussaint'),
('2025-11-11', 'Armistice 1918'),
('2025-12-25', 'Noël');

-- Insertion dans typeadherent (types d’adhérents avec leurs règles)
INSERT INTO typeadherent(nom, quota_max) VALUES
('Etudiant', 3),
('Enseignant', 10),
('Visiteur', 1),
('Professionnel', 4);

-- Pour les étudiants
INSERT INTO reglepret(type_adherent, type_pret, duree_jours) VALUES
('Etudiant', 'surplace', 1),
('Etudiant', 'domicile', 7);

-- Pour les enseignants
INSERT INTO reglepret(type_adherent, type_pret, duree_jours) VALUES
('Enseignant', 'surplace', 2),
('Enseignant', 'domicile', 21);

-- Pour les visiteurs
INSERT INTO reglepret(type_adherent, type_pret, duree_jours) VALUES
('Visiteur', 'surplace', 1);  -- Pas de prêt à domicile

INSERT INTO reglepret(type_adherent, type_pret, duree_jours) VALUES
('Professionnel', 'surplace', 2),
('Professionnel', 'domicile', 14);

INSERT INTO admin(nom, email, motDePasse) VALUES
('Sedera', 'sederavalisoarandrianantenaina@gmail.com', 'mysuccess');

INSERT INTO adherent (nom, email, motDePasse, type_adherent, inscription)
VALUES ('Rakoto Jean', 'rakotojean@email.com', '1234', 'Etudiant', CURRENT_DATE);

INSERT INTO inscription(id_adherent,date_debut,date_fin) VALUES(2,'2025-06-01','2025-07-01');

-- regle de reservation
-- Pour les étudiants
INSERT INTO reglereservation (type_adherent, quota_max, duree_max_jours)
VALUES ('Etudiant', 3, 15);

-- Pour les enseignants
INSERT INTO reglereservation (type_adherent, quota_max, duree_max_jours)
VALUES ('Enseignant', 5, 30);

INSERT INTO reglereservation (type_adherent, quota_max, duree_max_jours)
VALUES ('Visiteur', 2, 1);

INSERT INTO reglereservation (type_adherent, quota_max, duree_max_jours)
VALUES ('Professionnel', 5, 30);
