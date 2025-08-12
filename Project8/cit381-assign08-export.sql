-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cit381-assign08-schema
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `cit381-assign08-schema` ;

-- -----------------------------------------------------
-- Schema cit381-assign08-schema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cit381-assign08-schema` DEFAULT CHARACTER SET utf8mb3 ;
USE `cit381-assign08-schema` ;

-- -----------------------------------------------------
-- Table `cit381-assign08-schema`.`instructors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cit381-assign08-schema`.`instructors` ;

CREATE TABLE IF NOT EXISTS `cit381-assign08-schema`.`instructors` (
  `InstructorID` INT NOT NULL AUTO_INCREMENT,
  `InstructorLastName` VARCHAR(45) NOT NULL,
  `InstructorGender` VARCHAR(20) NOT NULL,
  `InstructorDepartment` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`InstructorID`),
  UNIQUE INDEX `idProfessors_UNIQUE` (`InstructorID` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cit381-assign08-schema`.`courses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cit381-assign08-schema`.`courses` ;

CREATE TABLE IF NOT EXISTS `cit381-assign08-schema`.`courses` (
  `CourseID` INT NOT NULL AUTO_INCREMENT,
  `CourseName` VARCHAR(150) NOT NULL,
  `CourseLevel` INT NOT NULL,
  `CourseTerm` VARCHAR(10) NOT NULL,
  `CourseYear` YEAR NOT NULL,
  `InstructorID` INT NOT NULL,
  PRIMARY KEY (`CourseID`, `InstructorID`),
  UNIQUE INDEX `idCourses_UNIQUE` (`CourseID` ASC) VISIBLE,
  INDEX `fk_Courses_Instructors_idx` (`InstructorID` ASC) VISIBLE,
  CONSTRAINT `fk_Courses_Instructors`
    FOREIGN KEY (`InstructorID`)
    REFERENCES `cit381-assign08-schema`.`instructors` (`InstructorID`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cit381-assign08-schema`.`coursehighlights`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cit381-assign08-schema`.`coursehighlights` ;

CREATE TABLE IF NOT EXISTS `cit381-assign08-schema`.`coursehighlights` (
  `TopicID` INT NOT NULL AUTO_INCREMENT,
  `Topic` VARCHAR(45) NOT NULL,
  `TopicDescription` VARCHAR(600) NOT NULL,
  `Courses_CourseID` INT NOT NULL,
  PRIMARY KEY (`TopicID`, `Courses_CourseID`),
  UNIQUE INDEX `HighlightID_UNIQUE` (`TopicID` ASC) VISIBLE,
  INDEX `fk_CourseHighlights_Courses_idx` (`Courses_CourseID` ASC) VISIBLE,
  CONSTRAINT `fk_CourseHighlights_Courses`
    FOREIGN KEY (`Courses_CourseID`)
    REFERENCES `cit381-assign08-schema`.`courses` (`CourseID`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- procedure sp_AddCourse
-- -----------------------------------------------------

USE `cit381-assign08-schema`;
DROP procedure IF EXISTS `cit381-assign08-schema`.`sp_AddCourse`;

DELIMITER $$
USE `cit381-assign08-schema`$$
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
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_AddInstructor
-- -----------------------------------------------------

USE `cit381-assign08-schema`;
DROP procedure IF EXISTS `cit381-assign08-schema`.`sp_AddInstructor`;

DELIMITER $$
USE `cit381-assign08-schema`$$
CREATE PROCEDURE sp_AddInstructor(
	IN a_InstructorID INT,
    IN a_InstructorLastName VARCHAR(80),
    IN a_InstructorGender VARCHAR(20),
    IN a_InstructorDepartment VARCHAR(15))
BEGIN
INSERT INTO courses(InstructorID, InstructorLastName, InstructorGender, InstructorDepartment)
Values(a_InstructorID, a_InstructorLastName, a_InstructorGender, a_InstructorDeparment);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `cit381-assign08-schema`.`vw_p8`
-- -----------------------------------------------------
DROP VIEW IF EXISTS vw_p8;
CREATE VIEW vw_p8 AS
SELECT CourseName, CourseLevel, i.InstructorLastName, CourseTerm, CourseYear
From courses c
INNER JOIN instructors i USING(InstructorID);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `cit381-assign08-schema`.`instructors`
-- -----------------------------------------------------
START TRANSACTION;
USE `cit381-assign08-schema`;
INSERT INTO `cit381-assign08-schema`.`instructors` (`InstructorID`, `InstructorLastName`, `InstructorGender`, `InstructorDepartment`) VALUES (1, 'Colbert', 'Male', 'CIT');
INSERT INTO `cit381-assign08-schema`.`instructors` (`InstructorID`, `InstructorLastName`, `InstructorGender`, `InstructorDepartment`) VALUES (2, 'Wu', 'Male', 'EC');
INSERT INTO `cit381-assign08-schema`.`instructors` (`InstructorID`, `InstructorLastName`, `InstructorGender`, `InstructorDepartment`) VALUES (3, 'Ellis', 'Male', 'EC');
INSERT INTO `cit381-assign08-schema`.`instructors` (`InstructorID`, `InstructorLastName`, `InstructorGender`, `InstructorDepartment`) VALUES (4, 'Wolf', 'Male', 'MUS');
INSERT INTO `cit381-assign08-schema`.`instructors` (`InstructorID`, `InstructorLastName`, `InstructorGender`, `InstructorDepartment`) VALUES (5, 'Rubin', 'Male', 'EC');
INSERT INTO `cit381-assign08-schema`.`instructors` (`InstructorID`, `InstructorLastName`, `InstructorGender`, `InstructorDepartment`) VALUES (6, 'Stewart', 'Female', 'CIT');
INSERT INTO `cit381-assign08-schema`.`instructors` (`InstructorID`, `InstructorLastName`, `InstructorGender`, `InstructorDepartment`) VALUES (7, 'Wilson', 'Male', 'EC');
INSERT INTO `cit381-assign08-schema`.`instructors` (`InstructorID`, `InstructorLastName`, `InstructorGender`, `InstructorDepartment`) VALUES (8, 'Mullen', 'Female', 'EC');
INSERT INTO `cit381-assign08-schema`.`instructors` (`InstructorID`, `InstructorLastName`, `InstructorGender`, `InstructorDepartment`) VALUES (9, 'Evans', 'Male', 'EC');
INSERT INTO `cit381-assign08-schema`.`instructors` (`InstructorID`, `InstructorLastName`, `InstructorGender`, `InstructorDepartment`) VALUES (10, 'Alvarado', 'Male', 'PHIL');
INSERT INTO `cit381-assign08-schema`.`instructors` (`InstructorID`, `InstructorLastName`, `InstructorGender`, `InstructorDepartment`) VALUES (11, 'Wayte', 'Male', 'MUS');
INSERT INTO `cit381-assign08-schema`.`instructors` (`InstructorID`, `InstructorLastName`, `InstructorGender`, `InstructorDepartment`) VALUES (12, 'Unknown Instructor', 'Unknown Gender', 'EC');
INSERT INTO `cit381-assign08-schema`.`instructors` (`InstructorID`, `InstructorLastName`, `InstructorGender`, `InstructorDepartment`) VALUES (13, 'Miller', 'Male', 'EC');
INSERT INTO `cit381-assign08-schema`.`instructors` (`InstructorID`, `InstructorLastName`, `InstructorGender`, `InstructorDepartment`) VALUES (14, 'Flores', 'Male', 'CIS');
INSERT INTO `cit381-assign08-schema`.`instructors` (`InstructorID`, `InstructorLastName`, `InstructorGender`, `InstructorDepartment`) VALUES (15, 'Park', 'Male', 'ARTD');
INSERT INTO `cit381-assign08-schema`.`instructors` (`InstructorID`, `InstructorLastName`, `InstructorGender`, `InstructorDepartment`) VALUES (16, 'Nadalizadeh', 'Male', 'CINE');
INSERT INTO `cit381-assign08-schema`.`instructors` (`InstructorID`, `InstructorLastName`, `InstructorGender`, `InstructorDepartment`) VALUES (17, 'Ford', 'Male', 'BA');

COMMIT;


-- -----------------------------------------------------
-- Data for table `cit381-assign08-schema`.`courses`
-- -----------------------------------------------------
START TRANSACTION;
USE `cit381-assign08-schema`;
INSERT INTO `cit381-assign08-schema`.`courses` (`CourseID`, `CourseName`, `CourseLevel`, `CourseTerm`, `CourseYear`, `InstructorID`) VALUES (1, 'Database Systems', 381, 'Fall', 2023, 1);
INSERT INTO `cit381-assign08-schema`.`courses` (`CourseID`, `CourseName`, `CourseLevel`, `CourseTerm`, `CourseYear`, `InstructorID`) VALUES (2, 'Behavorial Economics and Its Applications', 328, 'Fall', 2023, 2);
INSERT INTO `cit381-assign08-schema`.`courses` (`CourseID`, `CourseName`, `CourseLevel`, `CourseTerm`, `CourseYear`, `InstructorID`) VALUES (3, 'Political Economy', 448, 'Fall', 2023, 3);
INSERT INTO `cit381-assign08-schema`.`courses` (`CourseID`, `CourseName`, `CourseLevel`, `CourseTerm`, `CourseYear`, `InstructorID`) VALUES (4, 'Music of the Americas', 359, 'Fall', 2023, 4);
INSERT INTO `cit381-assign08-schema`.`courses` (`CourseID`, `CourseName`, `CourseLevel`, `CourseTerm`, `CourseYear`, `InstructorID`) VALUES (5, 'Intro to Econometrics', 421, 'Spring', 2023, 5);
INSERT INTO `cit381-assign08-schema`.`courses` (`CourseID`, `CourseName`, `CourseLevel`, `CourseTerm`, `CourseYear`, `InstructorID`) VALUES (6, 'Web Application Development I', 281, 'Spring', 2023, 6);
INSERT INTO `cit381-assign08-schema`.`courses` (`CourseID`, `CourseName`, `CourseLevel`, `CourseTerm`, `CourseYear`, `InstructorID`) VALUES (7, 'Problems/Issues Developing Economies', 390, 'Spring', 2023, 7);
INSERT INTO `cit381-assign08-schema`.`courses` (`CourseID`, `CourseName`, `CourseLevel`, `CourseTerm`, `CourseYear`, `InstructorID`) VALUES (8, 'Introduction to Econometrics', 320, 'Winter', 2023, 8);
INSERT INTO `cit381-assign08-schema`.`courses` (`CourseID`, `CourseName`, `CourseLevel`, `CourseTerm`, `CourseYear`, `InstructorID`) VALUES (9, 'Intermediate Macroeconomic Theory', 313, 'Winter', 2023, 9);
INSERT INTO `cit381-assign08-schema`.`courses` (`CourseID`, `CourseName`, `CourseLevel`, `CourseTerm`, `CourseYear`, `InstructorID`) VALUES (10, 'Data Ethics', 223, 'Winter', 2023, 10);
INSERT INTO `cit381-assign08-schema`.`courses` (`CourseID`, `CourseName`, `CourseLevel`, `CourseTerm`, `CourseYear`, `InstructorID`) VALUES (11, 'US Pop Music 1800-1930', 263, 'Fall', 2022, 11);
INSERT INTO `cit381-assign08-schema`.`courses` (`CourseID`, `CourseName`, `CourseLevel`, `CourseTerm`, `CourseYear`, `InstructorID`) VALUES (12, 'Intro to Web Programming', 111, 'Fall', 2022, 1);
INSERT INTO `cit381-assign08-schema`.`courses` (`CourseID`, `CourseName`, `CourseLevel`, `CourseTerm`, `CourseYear`, `InstructorID`) VALUES (13, 'Intro to Macroeconomics', 202, 'Fall', 2022, 12);
INSERT INTO `cit381-assign08-schema`.`courses` (`CourseID`, `CourseName`, `CourseLevel`, `CourseTerm`, `CourseYear`, `InstructorID`) VALUES (14, 'Intro to Microeconomics', 201, 'Spring', 2022, 13);
INSERT INTO `cit381-assign08-schema`.`courses` (`CourseID`, `CourseName`, `CourseLevel`, `CourseTerm`, `CourseYear`, `InstructorID`) VALUES (15, 'Intermediate Microeconomics Theory', 210, 'Spring', 2022, 12);
INSERT INTO `cit381-assign08-schema`.`courses` (`CourseID`, `CourseName`, `CourseLevel`, `CourseTerm`, `CourseYear`, `InstructorID`) VALUES (16, 'Interactive Digital Arts', 252, 'Winter', 2022, 15);
INSERT INTO `cit381-assign08-schema`.`courses` (`CourseID`, `CourseName`, `CourseLevel`, `CourseTerm`, `CourseYear`, `InstructorID`) VALUES (17, 'Computer Science I', 210, 'Winter', 2022, 14);
INSERT INTO `cit381-assign08-schema`.`courses` (`CourseID`, `CourseName`, `CourseLevel`, `CourseTerm`, `CourseYear`, `InstructorID`) VALUES (18, 'Media Aesthetics', 260, 'Winter', 2022, 16);
INSERT INTO `cit381-assign08-schema`.`courses` (`CourseID`, `CourseName`, `CourseLevel`, `CourseTerm`, `CourseYear`, `InstructorID`) VALUES (19, 'Spreadsheet Analysis', 240, 'Winter', 2022, 17);

COMMIT;


-- -----------------------------------------------------
-- Data for table `cit381-assign08-schema`.`coursehighlights`
-- -----------------------------------------------------
START TRANSACTION;
USE `cit381-assign08-schema`;
INSERT INTO `cit381-assign08-schema`.`coursehighlights` (`TopicID`, `Topic`, `TopicDescription`, `Courses_CourseID`) VALUES (1, 'SQL', 'Introduced SQL langauge using MySQL as a database management system.', 1);
INSERT INTO `cit381-assign08-schema`.`coursehighlights` (`TopicID`, `Topic`, `TopicDescription`, `Courses_CourseID`) VALUES (2, 'Node', 'Learned to connect a fastify server to a database in MySQL, and formed queries to pull the data for use.', 1);
INSERT INTO `cit381-assign08-schema`.`coursehighlights` (`TopicID`, `Topic`, `TopicDescription`, `Courses_CourseID`) VALUES (3, 'Post-Colonialism', 'Learned the affects that colonialism has had on Latin American music. Before European invasion, we talked about music relating to Inca, Mayan, and Aztec civilizations, notably the way they thought about music/sounds and the reasons they used music. ', 4);

COMMIT;
