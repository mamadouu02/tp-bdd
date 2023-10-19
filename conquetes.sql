CREATE SEQUENCE codeNavireSeq;
CREATE SEQUENCE codePiloteSeq;
CREATE SEQUENCE codeGalaxieSeq;
CREATE SEQUENCE codeMissionSeq;

CREATE TABLE Navire (
    codeNavire INTEGER DEFAULT codeNavireSeq.NEXTVAL PRIMARY KEY,
    rayonAction NUMBER NOT NULL CHECK (rayonAction > 0),
    nbPilotes INTEGER NOT NULL CHECK (nbPilotes > 0),
    vitMax NUMBER NOT NULL CHECK (vitMax > 0)
);

CREATE TABLE Pilote (
    codePilote INTEGER DEFAULT codePiloteSeq.NEXTVAL PRIMARY KEY,
    nomPilote VARCHAR(30),
    prenom VARCHAR(30),
    age INTEGER,
    grade VARCHAR(30)
);

CREATE TABLE Galaxie (
    codeGalaxie INTEGER DEFAULT codeGalaxieSeq.NEXTVAL PRIMARY KEY,
    nomGalaxie VARCHAR(30),
    dist NUMBER
);

CREATE TABLE Mission (
    codeMission INTEGER DEFAULT codeMissionSeq.NEXTVAL PRIMARY KEY,
    typeMission VARCHAR(30) REFERENCES TypeMission,
    dateMission DATE,
    nbVaisseaux INTEGER,
    vitMin NUMBER,
    rayonEng NUMBER
);

CREATE TABLE Equipage ();

CREATE TABLE NavireTransport ();

CREATE TABLE NavireCombat ();

CREATE TABLE Planete ();

CREATE TABLE TypeMission ();