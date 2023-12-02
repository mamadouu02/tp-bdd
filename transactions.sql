DROP TABLE comptes;

CREATE TABLE comptes (
    nc INT,
    nom VARCHAR(30),
    solde FLOAT CHECK (solde >= 0)
);

/* Atomicité */

-- Exercice 1

INSERT INTO comptes (nc, nom, solde) VALUES (1, 'Paul', 100);
INSERT INTO comptes (nc, nom, solde) VALUES (2, 'Paul', 200);

SELECT nom, SUM(solde) FROM comptes GROUP BY nom;

ROLLBACK;

SELECT nom, SUM(solde) FROM comptes GROUP BY nom;

-- Exercice 2

INSERT INTO comptes (nc, nom, solde) VALUES (3, 'Pierre', 300);
INSERT INTO comptes (nc, nom, solde) VALUES (4, 'Pierre', 400);

COMMIT;

INSERT INTO comptes (nc, nom, solde) VALUES (1, 'Paul', 100);
INSERT INTO comptes (nc, nom, solde) VALUES (2, 'Paul', 200);

SELECT nom, SUM(solde) FROM comptes GROUP BY nom;

ROLLBACK;

SELECT nom, SUM(solde) FROM comptes GROUP BY nom;

-- Exercice 3

SET AUTOCOMMIT ON;

INSERT INTO comptes (nc, nom, solde) VALUES (5, 'Jacques', 500);
INSERT INTO comptes (nc, nom, solde) VALUES (6, 'Jacques', 600);

SELECT nom, SUM(solde) FROM comptes GROUP BY nom;

ROLLBACK;

SELECT nom, SUM(solde) FROM comptes GROUP BY nom;

SET AUTOCOMMIT OFF;

-- Exercice 4

INSERT INTO comptes (nc, nom, solde) VALUES (7, 'Jean', 700);
INSERT INTO comptes (nc, nom, solde) VALUES (8, 'Jean', 800);

SAVEPOINT deuxinserts;

INSERT INTO comptes (nc, nom, solde) VALUES (9, 'Jean', 900);
INSERT INTO comptes (nc, nom, solde) VALUES (10, 'Jean', 1000);

SELECT nom, SUM(solde) FROM comptes WHERE nom = 'Jean' GROUP BY nom;

ROLLBACK TO deuxinserts;

SELECT nom, SUM(solde) FROM comptes WHERE nom = 'Jean' GROUP BY nom;

ROLLBACK;

SELECT nom, SUM(solde) FROM comptes WHERE nom = 'Jean' GROUP BY nom;

/* Cohérence */

-- Exercice 1

INSERT INTO comptes (nc, nom, solde) VALUES (11, 'Claude', 100);

INSERT INTO comptes (nc, nom, solde) VALUES (12, 'Henri', 200);

UPDATE comptes SET solde = solde + 50 WHERE nc = 12;

UPDATE comptes SET solde = solde - 150 WHERE nc = 11;

SELECT nom, SUM(solde) FROM comptes WHERE nom = 'Claude' OR nom = 'Henri' GROUP BY nom;

COMMIT;

SELECT * FROM comptes;

/* Isolation */

/* Session S1 */

-- Exercice 1

DELETE FROM comptes WHERE nom = 'Jacques';

COMMIT;

-- Exercice 2

SELECT nom, SUM(solde) FROM comptes GROUP BY nom;

COMMIT;

INSERT INTO comptes (nc, nom, solde) VALUES (14, 'Paul', 1000);

COMMIT;

-- Exercice 3

UPDATE comptes SET solde = solde + 100 WHERE nom = 'Paul';

UPDATE comptes SET solde = solde - 100 WHERE nom = 'Pierre';

ROLLBACK;

SELECT nom, SUM(solde) FROM comptes GROUP BY nom;

/* Session S2 */

-- Exercice 1

SELECT * FROM comptes;

UPDATE comptes SET solde = 10000;

COMMIT;

-- Exercice 2

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

INSERT INTO comptes (nc, nom, solde) VALUES (13, 'Paul', 500);

COMMIT;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SELECT nom, SUM(solde) FROM comptes GROUP BY nom;

COMMIT;

SELECT nom, SUM(solde) FROM comptes GROUP BY nom;

COMMIT;

-- Exercice 3

UPDATE comptes SET solde = solde + 50 WHERE nom = 'Pierre';

UPDATE comptes SET solde = solde + 200 WHERE nom = 'Paul';

COMMIT;