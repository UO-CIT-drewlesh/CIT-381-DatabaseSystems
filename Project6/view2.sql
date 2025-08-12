
DROP VIEW IF EXISTS vw_register_results;
CREATE VIEW vw_register_results AS
SELECT
	CONCAT(am.AlumLastName,
		IF(am.AlumFirstName IS NOT NULL,
			CONCAT(', ', am.AlumFirstName), '')) AS 'Member Name',
	mr.RegisterResults as 'Registration'
FROM 
	alumnimembers am
		INNER JOIN
	memberregister mr USING(RegisterID);

SELECT * FROM vw_register_results;