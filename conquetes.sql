CREATE SEQUENCE codeNavireSeq;
CREATE SEQUENCE codeMission;
CREATE SEQUENCE codePilote;
CREATE SEQUENCE codeGalaxie;

CREATE TABLE Navire (
    codeNavire INTEGER DEFAULT codeNavireSeq.nextval PRIMARY KEY,
    rayonAction NUMBER NOT NULL CHECK (rayonAction > 0),
    nbPilotes INTEGER NOT NULL CHECK (nbPilotes > 0),
    vitMax NUMBER NOT NULL CHECK (vitMax > 0)
);

CREATE TABLE Mission (
    codeMission INTEGER DEFAULT codeMission.nextval PRIMARY KEY,
    typeMission VARCHAR(30) REFERENCES TypeMission,
    dateMission DATE,
    nbVaisseaux INTEGER,
    vitMin NUMBER,
    rayonEng NUMBER
);

CREATE TABLE Pilote (
    codePilote INTEGER DEFAULT codePilote.nextval PRIMARY KEY,
    nomPilote VARCHAR(30),
    prenom VARCHAR(30),
    age INTEGER,
    grade VARCHAR(30)
);

CREATE TABLE Galaxie (
    codeGalaxie INTEGER DEFAULT codeGalaxie.nextval PRIMARY KEY,
    nomGalaxie VARCHAR(30),
    dist NUMBER
);
