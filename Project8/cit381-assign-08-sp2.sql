DROP PROCEDURE IF EXISTS sp_AddCourse;
DELIMITER //
CREATE PROCEDURE sp_AddCourse(
	IN a_CourseID INT,
    IN a_CourseName VARCHAR(120),
    IN a_CourseLevel INT,
    IN a_CourseTerm VARCHAR(10),
    IN a_CourseYear INT,
    IN a_InstructorID INT)
BEGIN
INSERT INTO courses(CourseID, CourseName, CourseLevel, CourseTerm, CourseYear, InstructorID)
Values(a_CourseID, a_CourseName, a_CourseLevel, a_CourseTerm, a_CourseYear, a_InstructorID);
END //

-- CALL sp_AddCourse(5, 'Web Application Development I', 281, 'Spring', 2023, 5);