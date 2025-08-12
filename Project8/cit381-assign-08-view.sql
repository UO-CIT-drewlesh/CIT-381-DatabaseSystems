DROP VIEW IF EXISTS vw_p8;
CREATE VIEW vw_p8 AS
SELECT CourseName, CourseLevel, i.InstructorLastName, CourseTerm, CourseYear
From courses c
INNER JOIN instructors i USING(InstructorID);

-- select * from vw_p8;
