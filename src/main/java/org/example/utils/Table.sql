CREATE DATABASE biblio;
\c biblio;

-- TABLE livre
CREATE TABLE livre (
    id_livre SERIAL PRIMARY KEY,
    titre VARCHAR(100) NOT NULL,
    auteur VARCHAR(100),
    editeur VARCHAR(100),
    isbn VARCHAR(20) UNIQUE,
    limite_age INT DEFAULT 0,               -- 0 = pas de restriction
    pret_domicile BOOLEAN DEFAULT TRUE      -- est-ce que ce livre peut être emprunté à domicile ?
);

-- TABLE exemplaire
CREATE TABLE exemplaire (
    id_exemplaire SERIAL PRIMARY KEY,
    etat VARCHAR(50),
    disponible BOOLEAN DEFAULT TRUE,
    id_livre INT NOT NULL,
    FOREIGN KEY (id_livre) REFERENCES livre(id_livre)
);


CREATE TABLE typeadherent (
    nom VARCHAR(50) PRIMARY KEY,
    quota_max INT,
    jours_penalite INT
);
ALTER TABLE typeadherent ADD COLUMN prolongement_max INT;

CREATE TABLE adherent (
    id_adherent SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    type_adherent VARCHAR(50) NOT NULL,
    inscription DATE,
    penalites NUMERIC(8,2) DEFAULT 0,
    FOREIGN KEY (type_adherent) REFERENCES typeadherent(nom)
);

CREATE TABLE typepret (
    type VARCHAR(50) PRIMARY KEY
);

CREATE TABLE reglepret (
    id SERIAL PRIMARY KEY,
    type_adherent VARCHAR(50) NOT NULL,
    type_pret VARCHAR(50) NOT NULL,
    duree_jours INT NOT NULL,
    CONSTRAINT fk_reglepret_typeadherent FOREIGN KEY (type_adherent) REFERENCES typeadherent(nom),
    CONSTRAINT fk_reglepret_typepret FOREIGN KEY (type_pret) REFERENCES typepret(type),
    CONSTRAINT uq_reglepret UNIQUE (type_adherent, type_pret)
);

CREATE TABLE pret (
    id_pret SERIAL PRIMARY KEY,
    id_exemplaire INT NOT NULL,
    id_adherent INT NOT NULL,
    date_debut DATE NOT NULL,
    date_retour DATE,
    type_pret VARCHAR(50),
    FOREIGN KEY (id_exemplaire) REFERENCES exemplaire(id_exemplaire),
    FOREIGN KEY (id_adherent) REFERENCES adherent(id_adherent),
    FOREIGN KEY (type_pret) REFERENCES typepret(type)
);
ALTER TABLE pret ADD COLUMN rendu BOOLEAN DEFAULT FALSE;

CREATE TABLE prolongement (
    id_prolongement SERIAL PRIMARY KEY,
    id_pret INT NOT NULL,
    ancienne_date DATE NOT NULL,
    nouvelle_date DATE NOT NULL,
    FOREIGN KEY (id_pret) REFERENCES pret(id_pret) ON DELETE CASCADE
);

CREATE TABLE reservation (
    id_reservation SERIAL PRIMARY KEY,
    id_adherent INT NOT NULL,
    id_livre INT NOT NULL,
    type_pret VARCHAR(20) NOT NULL,
    date_reservation DATE NOT NULL,
    date_fin_reservation DATE,
    valide BOOLEAN DEFAULT FALSE,
    
    FOREIGN KEY (id_adherent) REFERENCES adherent(id_adherent),
    FOREIGN KEY (id_livre) REFERENCES livre(id_livre),
    FOREIGN KEY (type_pret) REFERENCES typepret(type)
);

CREATE TABLE reglereservation (
    id SERIAL PRIMARY KEY,
    type_adherent VARCHAR(50) REFERENCES typeadherent(nom),
    quota_max INT NOT NULL,
    duree_max_jours INT
);


CREATE TABLE penalite (
    id_penalite SERIAL PRIMARY KEY,
    id_pret INT NOT NULL,
    motif TEXT,
    applique BOOLEAN DEFAULT FALSE,
    date_debut DATE, -- date de retour théorique
    date_fin DATE,   -- date de retour théorique + nb jours pénalité
    FOREIGN KEY (id_pret) REFERENCES pret(id_pret)
);

CREATE TABLE jourferie (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE reglereport (
    id SERIAL PRIMARY KEY,
    choix VARCHAR(10) NOT NULL CHECK (choix IN ('avant', 'apres'))
);

CREATE TABLE cotisation (
    id_cotisation SERIAL PRIMARY KEY,
    id_adherent INT NOT NULL,
    type VARCHAR(50),
    montant NUMERIC(6,2),
    date_cotisation DATE,
    FOREIGN KEY (id_adherent) REFERENCES adherent(id_adherent)
);

CREATE TABLE inscription (
    id SERIAL PRIMARY KEY,
    id_adherent INT REFERENCES adherent(id_adherent),
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    CONSTRAINT uq_abonnement UNIQUE (id_adherent, date_debut)
);


CREATE TABLE admin (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    motDePasse VARCHAR(100) NOT NULL
);

ALTER TABLE adherent ADD COLUMN motDePasse VARCHAR(100);
ALTER TABLE adherent ADD COLUMN date_fin_penalite DATE;

CREATE TABLE rendu (
    id_rendu SERIAL PRIMARY KEY,
    id_pret INT NOT NULL,
    date_rendu DATE NOT NULL,
    FOREIGN KEY (id_pret) REFERENCES pret(id_pret) ON DELETE CASCADE
);

