DROP PROCEDURE IF EXISTS sp_AddInstructor;
DELIMITER $$
CREATE PROCEDURE sp_AddInstructor(
	IN a_InstructorID INT, 
    IN a_InstructorLastName VARCHAR(45), 
    IN a_InstructorGender VARCHAR(10), 
    IN a_InstructorDepartment VARCHAR(10))
BEGIN
INSERT INTO instructors(InstructorID, InstructorLastName, InstructorGender, InstructorDepartment)
Values(a_InstructorID, a_InstructorLastName, a_InstructorGender, a_InstructorDepartment);
END $$

-- CALL sp_AddInstructor(5, 'Stewart', 'Female', 'CIT');