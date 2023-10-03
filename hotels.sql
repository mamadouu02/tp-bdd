-- Tables
SELECT * FROM resorts;
SELECT * FROM hotels;
SELECT * FROM rooms;
SELECT * FROM guests;
SELECT * FROM bookings;

-- R1
SELECT
    ns,
    noms,
    capch
FROM
    resorts
WHERE
    types = 'montagne';

-- R2
SELECT
    nomh,
    nh,
    adrh,
    telh,
    cath
FROM
    hotels  h,
    resorts r
WHERE
    h.ns = r.ns
    AND types = 'mer';

-- R3
SELECT
    DISTINCT noms
FROM
    resorts r,
    hotels  h
WHERE
    r.ns = h.ns
    AND types = 'mer'
    AND cath = 4;

-- R4
SELECT
    DISTINCT nomcl,
    adrcl
FROM
    guests   g,
    bookings b,
    resorts  r
WHERE
    g.ncl = b.ncl
    AND b.ns = r.ns
    AND types = 'montagne';

-- R5
SELECT
    nch,
    h.nh
FROM
    rooms   rm,
    hotels  h,
    resorts r
WHERE
    rm.nh = h.nh
    AND rm.ns = r.ns
    AND h.ns = r.ns
    AND cath = 2
    AND types = 'montagne'
    AND prix < 50;

-- R6
SELECT
    DISTINCT nomcl
FROM
    guests   g,
    resorts  r,
    hotels   h,
    rooms    rm,
    bookings b
WHERE
    g.ncl = b.ncl
    AND b.ns = r.ns
    AND b.nh = h.nh
    AND h.ns = r.ns
    AND b.nch = rm.nch
    AND rm.ns = r.ns
    AND rm.nh = h.nh
    AND types = 'mer'
    AND typch LIKE 'D%';

-- R7
SELECT
    DISTINCT nomcl
FROM
    guests   g,
    hotels   h,
    bookings b
WHERE
    g.ncl = b.ncl
    AND b.nh = h.nh
    AND adrcl = adrh;

-- R8
SELECT
    ns,
    nh
FROM
    hotels
WHERE
    cath = 4 MINUS
    SELECT
        ns,
        nh
    FROM
        rooms
    WHERE
        typch <> 'SDB';