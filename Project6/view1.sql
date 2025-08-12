DROP VIEW IF EXISTS vw_alumname;
CREATE VIEW vw_alumname AS
SELECT
	CONCAT(am.AlumLastName,
		IF(am.AlumFirstName IS NOT NULL,
			CONCAT(', ', am.AlumFirstName), '')) AS 'Member Name'
FROM alumnimembers am;

SELECT * FROM vw_alumname;