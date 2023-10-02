DROP TABLE Comptes;
CREATE TABLE Comptes(NC INT, Nom VARCHAR(30), Solde FLOAT CHECK (Solde >=0));

/* Atomicité */

-- Exercice 1

INSERT INTO Comptes(NC, Nom, Solde) VALUES(1, 'Paul', 5000);
INSERT INTO Comptes(NC, Nom, Solde) VALUES(2, 'Paul', 1500);

SELECT SUM(SOLDE) FROM COMPTES;

ROLLBACK;

SELECT SUM(SOLDE) FROM COMPTES;
