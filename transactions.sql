DROP TABLE Comptes;
CREATE TABLE Comptes(NC INT, Nom VARCHAR(30), Solde FLOAT CHECK (Solde >= 0));

/* Atomicité */

-- Exercice 1

INSERT INTO Comptes(NC, Nom, Solde) VALUES(1, 'Paul', 100);
INSERT INTO Comptes(NC, Nom, Solde) VALUES(2, 'Paul', 200);

SELECT Nom, SUM(Solde) FROM Comptes GROUP BY Nom;

ROLLBACK;

SELECT Nom, SUM(Solde) FROM Comptes GROUP BY Nom;

-- Exercice 2

INSERT INTO Comptes(NC, Nom, Solde) VALUES(3, 'Pierre', 300);
INSERT INTO Comptes(NC, Nom, Solde) VALUES(4, 'Pierre', 400);

COMMIT;

INSERT INTO Comptes(NC, Nom, Solde) VALUES(1, 'Paul', 100);
INSERT INTO Comptes(NC, Nom, Solde) VALUES(2, 'Paul', 200);

SELECT Nom, SUM(Solde) FROM Comptes GROUP BY Nom;

ROLLBACK;

SELECT Nom, SUM(Solde) FROM Comptes GROUP BY Nom;

-- Exercice 3

SET AUTOCOMMIT ON;

INSERT INTO Comptes(NC, Nom, Solde) VALUES(5, 'Jacques', 500);
INSERT INTO Comptes(NC, Nom, Solde) VALUES(6, 'Jacques', 600);

SELECT Nom, SUM(Solde) FROM Comptes GROUP BY Nom;

ROLLBACK;

SELECT Nom, SUM(Solde) FROM Comptes GROUP BY Nom;

SET AUTOCOMMIT OFF;

-- Exercice 4

INSERT INTO Comptes(NC, Nom, Solde) VALUES(7, 'Jean', 700);
INSERT INTO Comptes(NC, Nom, Solde) VALUES(8, 'Jean', 800);

SAVEPOINT DeuxInserts;

INSERT INTO Comptes(NC, Nom, Solde) VALUES(9, 'Jean', 900);
INSERT INTO Comptes(NC, Nom, Solde) VALUES(10, 'Jean', 1000);

SELECT Nom, SUM(Solde) FROM Comptes WHERE Nom='Jean' GROUP BY Nom;

ROLLBACK TO DeuxInserts;

SELECT Nom, SUM(Solde) FROM Comptes WHERE Nom='Jean' GROUP BY Nom;

ROLLBACK;

SELECT Nom, SUM(Solde) FROM Comptes WHERE Nom='Jean' GROUP BY Nom;

/* Cohérence */

-- Exercice 1

INSERT INTO Comptes(NC, Nom, Solde) VALUES(11, 'Claude', 100);

INSERT INTO Comptes(NC, Nom, Solde) VALUES(12, 'Henri', 200);

UPDATE Comptes SET Solde = Solde + 50 WHERE NC=12;

UPDATE Comptes SET Solde = Solde - 150 WHERE NC=11;

SELECT Nom, SUM(Solde) FROM Comptes WHERE Nom='Claude' OR Nom='Henri' GROUP BY Nom;

COMMIT;

SELECT * FROM Comptes;
