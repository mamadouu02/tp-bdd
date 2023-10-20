CREATE SEQUENCE codeNavireSeq;
CREATE SEQUENCE codePiloteSeq;
CREATE SEQUENCE codeGalaxieSeq;
CREATE SEQUENCE codeMissionSeq;
CREATE SEQUENCE codeEquipageSeq;
CREATE SEQUENCE codePlaneteSeq;
CREATE SEQUENCE codeTypeMissionSeq;

CREATE TABLE Navire (
    codeNavire INTEGER DEFAULT codeNavireSeq.NEXTVAL PRIMARY KEY,
    rayonAction NUMBER NOT NULL CHECK (rayonAction > 0),
    nbPilotes INTEGER NOT NULL CHECK (nbPilotes > 0),
    vitMax NUMBER NOT NULL CHECK (vitMax > 0)
);

CREATE TABLE Pilote (
    codePilote INTEGER DEFAULT codePiloteSeq.NEXTVAL PRIMARY KEY,
    nomPilote VARCHAR(30) NOT NULL,
    prenom VARCHAR(30) NOT NULL,
    age INTEGER NOT NULL CHECK (age > 0),
    grade VARCHAR(30) NOT NULL
);

CREATE TABLE Galaxie (
    codeGalaxie INTEGER DEFAULT codeGalaxieSeq.NEXTVAL PRIMARY KEY,
    nomGalaxie VARCHAR(30) NOT NULL,
    dist NUMBER NOT NULL CHECK (dist > 0)
);

CREATE TABLE Mission (
    codeMission INTEGER DEFAULT codeMissionSeq.NEXTVAL PRIMARY KEY,
    typeMission VARCHAR(30) NOT NULL REFERENCES TypeMission(typeMission),
    dateMission DATE NOT NULL,
    nbVaisseaux INTEGER NOT NULL CHECK (nbVaisseaux > 0),
    vitMin NUMBER NOT NULL CHECK (vitMin > 0),
    rayonEng NUMBER NOT NULL CHECK (rayonEng > 0)
);

CREATE TABLE Equipage (
    codeEquipage INTEGER DEFAULT codeEquipageSeq.NEXTVAL PRIMARY KEY,
    nbPersonnes INTEGER NOT NULL CHECK (nbPersonnes > 0)
);

CREATE TABLE NavireTransport (
    codeNavire INTEGER PRIMARY KEY REFERENCES Navire(codeNavire),
    capacite INTEGER NOT NULL CHECK (capacite > 0)
);

CREATE TABLE NavireCombat (
    codeNavire INTEGER PRIMARY KEY REFERENCES Navire(codeNavire),
    tailleMinEq INTEGER NOT NULL CHECK (tailleMinEq > 0),
    tailleMaxEq INTEGER NOT NULL CHECK (tailleMaxEq >= tailleMinEq)
);

CREATE TABLE Planete (
    codeGalaxie INTEGER REFERENCES Galaxie(codeGalaxie),
    codePlanete INTEGER DEFAULT codePlaneteSeq.NEXTVAL,
    nomPlanete VARCHAR(30) NOT NULL,
    compMilieu VARCHAR(30) NOT NULL CHECK (compMilieu IN ('acide', 'neutre', 'basique')),
    vitLib NUMBER NOT NULL CHECK (vitLib > 0),
    statut VARCHAR(30) NOT NULL CHECK (statut IN ('non exploree', 'reconnue', 'integree')),
    PRIMARY KEY (codeGalaxie, codePlanete)
);

CREATE TABLE TypeMission (
    typeMission VARCHAR(30) NOT NULL CHECK (typeMission IN ('transport', 'combat', 'pillage', 'interception')) PRIMARY KEY
);

CREATE TABLE EngEquipages (
    codeMission INTEGER NOT NULL REFERENCES Mission(codeMission),
    codeNavire INTEGER NOT NULL REFERENCES NavireCombat(codeNavire),
    codeEquipage INTEGER NOT NULL REFERENCES Equipage(codeEquipage),
    PRIMARY KEY (codeMission, codeNavire),
    UNIQUE (codeMission, codeEquipage)
);