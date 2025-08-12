-- ---------------------
-- Drew Lesh
-- Project 2
-- CIT 381
-- ---------------------

-- 1. Query to list all persons with family relationships using joins
SELECT * FROM person
INNER JOIN relationship as r USING(personID)
INNER JOIN family USING(personID)
WHERE r.relationID = 1;


-- 2. A query to list all persons with friendship relationships using joins
SELECT * FROM person
INNER JOIN relationship as r USING(personID)
INNER JOIN friend as f USING(personID)
WHERE r.relationID = 2;


-- 3. A query to list all persons, with or without a relationship of any kind, and any family relationships
SELECT * FROM person p
LEFT JOIN relationship USING(personID);
