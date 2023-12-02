CREATE SEQUENCE code_navire_seq;
CREATE SEQUENCE code_pilote_seq;
CREATE SEQUENCE code_galaxie_seq;
CREATE SEQUENCE code_mission_seq;
CREATE SEQUENCE code_equipage_seq;
CREATE SEQUENCE code_planete_seq;
CREATE SEQUENCE code_type_mission_seq;

CREATE TABLE navire (
    code_navire INTEGER DEFAULT code_navire_seq.NEXTVAL PRIMARY KEY,
    rayon_acion NUMBER NOT NULL CHECK (rayon_acion > 0),
    nb_pilotes INTEGER NOT NULL CHECK (nb_pilotes > 0),
    vit_max NUMBER NOT NULL CHECK (vit_max > 0)
);

CREATE TABLE pilote (
    code_pilote INTEGER DEFAULT code_pilote_seq.NEXTVAL PRIMARY KEY,
    nom_pilote VARCHAR(30) NOT NULL,
    prenom VARCHAR(30) NOT NULL,
    age INTEGER NOT NULL CHECK (age > 0),
    grade VARCHAR(30) NOT NULL
);

CREATE TABLE galaxie (
    code_galaxie INTEGER DEFAULT code_galaxie_seq.NEXTVAL PRIMARY KEY,
    nom_galaxie VARCHAR(30) NOT NULL,
    dist NUMBER NOT NULL CHECK (dist > 0)
);

CREATE TABLE type_mission (
    type_mission VARCHAR(30) NOT NULL CHECK (type_mission IN ('transport', 'combat', 'pillage', 'interception')) PRIMARY KEY
);

CREATE TABLE mission (
    code_mission INTEGER DEFAULT code_mission_seq.NEXTVAL PRIMARY KEY,
    type_mission VARCHAR(30) NOT NULL REFERENCES type_mission(type_mission),
    date_mission DATE NOT NULL,
    nb_vaisseaux INTEGER NOT NULL CHECK (nb_vaisseaux > 0),
    vit_min NUMBER NOT NULL CHECK (vit_min > 0),
    rayon_eng NUMBER NOT NULL CHECK (rayon_eng > 0)
);

CREATE TABLE equipage (
    code_equipage INTEGER DEFAULT code_equipage_seq.NEXTVAL PRIMARY KEY,
    nb_personnes INTEGER NOT NULL CHECK (nb_personnes > 0)
);

CREATE TABLE navire_transport (
    code_navire INTEGER PRIMARY KEY REFERENCES navire(code_navire),
    capacite INTEGER NOT NULL CHECK (capacite > 0)
);

CREATE TABLE navire_combat (
    code_navire INTEGER PRIMARY KEY REFERENCES navire(code_navire),
    taille_min_eq INTEGER NOT NULL CHECK (taille_min_eq > 0),
    taille_max_eq INTEGER NOT NULL,
    CHECK (taille_min_eq <= taille_max_eq)
);

CREATE TABLE planete (
    code_galaxie INTEGER REFERENCES galaxie(code_galaxie),
    code_planete INTEGER DEFAULT code_planete_seq.NEXTVAL,
    nom_planete VARCHAR(30) NOT NULL,
    comp_milieu VARCHAR(30) NOT NULL CHECK (comp_milieu IN ('acide', 'neutre', 'basique')),
    vit_lib NUMBER NOT NULL CHECK (vit_lib > 0),
    statut VARCHAR(30) NOT NULL CHECK (statut IN ('non exploree', 'reconnue', 'integree')),
    PRIMARY KEY (code_galaxie, code_planete)
);

CREATE TABLE eng_equipages (
    code_mission INTEGER NOT NULL REFERENCES mission(code_mission),
    code_navire INTEGER NOT NULL REFERENCES navire_combat(code_navire),
    code_equipage INTEGER NOT NULL REFERENCES equipage(code_equipage),
    PRIMARY KEY (code_mission, code_navire),
    UNIQUE (code_mission, code_equipage)
);