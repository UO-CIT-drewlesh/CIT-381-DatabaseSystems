-- ------
-- Drew Lesh
-- Project 4
-- ------

SELECT * FROM webpages;
SELECT * FROM pathways;
SELECT * FROM memberregister;

SELECT p.PathwayName, am.AlumFirstName, am.AlumLastName as MemberName FROM pathways p
INNER JOIN alumnimembers am USING (pathwayID);

SELECT * from alumnimembers
WHERE pathwayID IN
(SELECT pathwayID FROM pathways WHERE pathwayID='9');
