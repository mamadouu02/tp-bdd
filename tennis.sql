-- Tables
SELECT * FROM joueurs;
SELECT * FROM rencontres;
SELECT * FROM gains;
SELECT * FROM sponsors;

-- R1
SELECT
    j.nj,
    prime
FROM
    joueurs j,
    gains   g
WHERE
    j.nj = g.nj
    AND g.nomsponsor = 'PEUGEOT'
    AND g.annee BETWEEN 2003 AND 2005;

-- R2
SELECT
    DISTINCT nom,
    age
FROM
    joueurs    j,
    rencontres r
WHERE
    (j.nj = r.njgagnant
    OR j.nj = r.njperdant)
    AND r.lieutournoi = 'Roland Garros'
    AND r.annee = 2005;

-- R3
SELECT
    DISTINCT nom,
    nationalite
FROM
    joueurs    j,
    rencontres r,
    gains      g
WHERE
    j.nj = r.njgagnant
    AND j.nj = g.nj
    AND g.nomsponsor = 'PEUGEOT'
    AND r.lieutournoi = 'Roland Garros';

-- R4
SELECT
    DISTINCT nom,
    nationalite
FROM
    joueurs    j,
    rencontres r
WHERE
    (j.nj = r.njgagnant
    OR j.nj = r.njperdant)
    AND r.lieutournoi = 'Roland Garros'
    AND r.annee = 2006 INTERSECT
    SELECT
        DISTINCT nom,
        nationalite
    FROM
        joueurs    j,
        rencontres r
    WHERE
        (j.nj = r.njgagnant
        OR j.nj = r.njperdant)
        AND r.lieutournoi = 'Wimbledon'
        AND r.annee = 2006;

-- R5
SELECT
    DISTINCT nom
FROM
    joueurs j,
    gains   g
WHERE
    j.nj = g.nj
    AND g.lieutournoi = 'Roland Garros'
    AND g.prime >= 150000 MINUS
    SELECT
        DISTINCT nom
    FROM
        joueurs j,
        gains   g
    WHERE
        j.nj = g.nj
        AND g.lieutournoi = 'Roland Garros'
        AND g.prime < 150000;

-- R6
SELECT
    DISTINCT nom,
    prenom,
    age,
    nationalite
FROM
    joueurs    j,
    rencontres r
WHERE
    (j.nj = r.njgagnant
    OR j.nj = r.njperdant)
    AND r.lieutournoi = 'Roland Garros'
GROUP BY
    DISTINCT nom,
    prenom,
    age,
    nationalite
HAVING
    COUNT(DISTINCT annee) = (
        SELECT
            COUNT(DISTINCT annee)
        FROM
            rencontres
        WHERE
            lieutournoi = 'Roland Garros'
    );

-- R7
SELECT
    DISTINCT nom,
    prenom
FROM
    joueurs j,
    gains   g1,
    gains   g2
WHERE
    j.nj = g1.nj
    AND j.nj = g2.nj
    AND g1.lieutournoi = 'Wimbledon'
    AND g2.lieutournoi = 'Wimbledon'
    AND g1.annee = 2004
    AND g2.annee = 2005
    AND g1.rang < g2.rang;

-- R8
SELECT
    annee,
    SUM(prime)
FROM
    gains
WHERE
    lieutournoi = 'Roland Garros'
GROUP BY
    annee
HAVING
    COUNT(DISTINCT nj) > 15;