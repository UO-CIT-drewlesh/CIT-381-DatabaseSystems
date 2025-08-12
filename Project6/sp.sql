-- Store procedure
-- Deletes a specific row using AlumID when 'CAll sp_deleteRow(AlumID)'

DROP PROCEDURE IF EXISTS sp_deleteRow;
DELIMITER //
CREATE PROCEDURE sp_deleteRow(IN ID int(10))
BEGIN
DELETE FROM alumnimembers WHERE AlumID=ID;
END //
