-- --------------------
-- Drew Lesh
-- Project 2
-- CIT 381
-- --------------------

-- MySQL Workbench Forward Engineering

-- -----------------------------------------------------
-- Schema wedding
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Wedding` DEFAULT CHARACTER SET utf8 ;
USE `Wedding` ;

-- -----------------------------------------------------
-- Table `person`.`relationship`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `person` (
  `personID` INT NOT NULL AUTO_INCREMENT UNIQUE,
  `lastName` VARCHAR(45) NOT NULL,
  `firstName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`personID`),
  UNIQUE INDEX `idperson_UNIQUE` (`personID` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `wedding`.`relationship`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `relationship` (
  `relationshipNumber` INT NOT NULL AUTO_INCREMENT,
  `personID` INT NOT NULL UNIQUE,
  `relationID` INT NOT NULL,
  PRIMARY KEY (`relationshipNumber`),
  CONSTRAINT `pk_personID`
    FOREIGN KEY (`personID`)
    REFERENCES `person` (`personID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `wedding`.`family`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `family` (
  `personID` INT NOT NULL UNIQUE,
  `familyCode` INT NOT NULL,
  `attendeeStatus` VARCHAR(45) NOT NULL,
  INDEX `fk_relationship_has_person_relationship1_idx` (`personID` ASC) VISIBLE,
  CONSTRAINT `fk_relationship_has_person_relationship1`
    FOREIGN KEY (`personID`)
    REFERENCES `relationship` (`personID`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `wedding`.`friend`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `friend` (
  `personID` INT NOT NULL UNIQUE,
  `friendshipsCode` INT NOT NULL,
  `attendeeStatus` VARCHAR(45) NOT NULL,
  INDEX `fk_relationship_has_person_relationship2_idx` (`personID` ASC) VISIBLE,
  CONSTRAINT `fk_relationship_has_person_relationship2`
    FOREIGN KEY (`personID`)
    REFERENCES `relationship` (`personID`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb3;

-- insert values into PERSON table
INSERT INTO person(LastName, FirstName)
Values 
('Leavesly', 'Amanda'),
('Leavesly', 'Adam'),
('Leavesly', 'Susan'),
('Leavesly', 'Bradlee'),
('Root', 'James'),
('Root', 'Layla'),
('Murphy', 'Shaun'),
('Wells', 'Ashley'),
('Smith', 'Kate'),
('West', 'Tyler'),
('Chrissie', 'Shannon');

-- insert values into RELATIONSHIP table
INSERT INTO relationship(personID, relationID)
VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 2),
(8, 2),
(9, 2),
(10, 2),
(11, 2);

-- insert values into FAMILY table
INSERT INTO family(personID, familyCode, attendeeStatus)
VALUES
(1, 1, 'Hostess'),
(2, 1, 'Bride Escort'),
(3, 1, 'Flower Girl'),
(4, 1, 'Usher'),
(5, 2, 'Food'),
(6, 2, 'Food');

-- insert values into FRIEND table
INSERT INTO friend(personID, friendshipsCode, attendeeStatus)
VALUES
(7, 3, "Best man"),
(8, 4, "Maid of honor"),
(9, 4, "Attendee"),
(10, 3, "Attendee"),
(11, 5, "Attendee");
