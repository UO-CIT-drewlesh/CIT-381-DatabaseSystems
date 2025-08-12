-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema alumni
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema alumni
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `alumni` DEFAULT CHARACTER SET utf8 ;
USE `alumni` ;

-- -----------------------------------------------------
-- Table `alumni`.`Pathways`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alumni`.`Pathways` (
  `PathwayID` INT NOT NULL AUTO_INCREMENT,
  `PathwayName` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`PathwayID`),
  UNIQUE INDEX `idContent_UNIQUE` (`PathwayID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alumni`.`MemberRegister`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alumni`.`MemberRegister` (
  `RegisterID` INT NOT NULL AUTO_INCREMENT,
  `RegisterEmail` VARCHAR(45) NOT NULL,
  `RegisterUsername` VARCHAR(45) NOT NULL,
  `RegisterPassword` VARCHAR(45) NOT NULL,
  `RegisterResults` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`RegisterID`),
  UNIQUE INDEX `idWebPage_Join_UNIQUE` (`RegisterID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alumni`.`AlumniMembers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alumni`.`AlumniMembers` (
  `AlumID` INT NOT NULL AUTO_INCREMENT,
  `RegisterID` INT NOT NULL,
  `PathwayID` INT NOT NULL,
  `AlumFirstName` VARCHAR(45) NOT NULL,
  `AlumLastName` VARCHAR(45) NOT NULL,
  `AlumPhoneNumber` VARCHAR(45) NOT NULL,
  `AlumGradYear` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`AlumID`, `PathwayID`, `RegisterID`),
  UNIQUE INDEX `AlumID_UNIQUE` (`AlumID` ASC) VISIBLE,
  INDEX `fk_Alumni Members_Pathways_idx` (`PathwayID` ASC) VISIBLE,
  INDEX `fk_RegisterID_idx` (`RegisterID` ASC) VISIBLE,
  CONSTRAINT `fk_Alumni Members_Pathways`
    FOREIGN KEY (`PathwayID`)
    REFERENCES `alumni`.`Pathways` (`PathwayID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RegisterID`
    FOREIGN KEY (`RegisterID`)
    REFERENCES `alumni`.`MemberRegister` (`RegisterID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alumni`.`AlumBlogs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alumni`.`AlumBlogs` (
  `BlogID` INT NOT NULL AUTO_INCREMENT,
  `AlumID` INT NOT NULL,
  `PathwayID` INT NOT NULL,
  PRIMARY KEY (`BlogID`, `AlumID`, `PathwayID`),
  UNIQUE INDEX `idAlumBlogs_UNIQUE` (`BlogID` ASC) VISIBLE,
  INDEX `fk_AlumBlogs_Alumni Members1_idx` (`AlumID` ASC, `PathwayID` ASC) VISIBLE,
  CONSTRAINT `fk_AlumBlogs_Alumni Members1`
    FOREIGN KEY (`AlumID` , `PathwayID`)
    REFERENCES `alumni`.`AlumniMembers` (`AlumID` , `PathwayID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alumni`.`Webpages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alumni`.`Webpages` (
  `PageID` INT NOT NULL,
  `PageName` VARCHAR(45) NOT NULL,
  `PageDetails` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`PageID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alumni`.`PagesContents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alumni`.`PagesContents` (
  `PageContentID` INT NOT NULL AUTO_INCREMENT,
  `PageID` INT NOT NULL,
  `PageContentText` VARCHAR(255) NOT NULL,
  `PageContentCategory` VARCHAR(45) NOT NULL,
  `ContentDate` DATETIME NULL,
  PRIMARY KEY (`PageContentID`, `PageID`),
  INDEX `fk_WebsiteContent_HomePage1_idx` (`PageID` ASC) VISIBLE,
  CONSTRAINT `fk_WebsiteContent_HomePage1`
    FOREIGN KEY (`PageID`)
    REFERENCES `alumni`.`Webpages` (`PageID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alumni`.`BlogEntries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alumni`.`BlogEntries` (
  `EntryID` INT NOT NULL AUTO_INCREMENT,
  `BlogID` INT NOT NULL,
  `EntryTitle` VARCHAR(45) NOT NULL,
  `EntryText` VARCHAR(750) NOT NULL,
  PRIMARY KEY (`EntryID`, `BlogID`),
  UNIQUE INDEX `idBlog_Entries_UNIQUE` (`EntryID` ASC) VISIBLE,
  INDEX `BlogID_idx` (`BlogID` ASC) VISIBLE,
  CONSTRAINT `BlogID`
    FOREIGN KEY (`BlogID`)
    REFERENCES `alumni`.`AlumBlogs` (`BlogID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alumni`.`BlogComments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alumni`.`BlogComments` (
  `CommentID` INT NOT NULL AUTO_INCREMENT,
  `EntryID` INT NOT NULL,
  `CommentTitle` VARCHAR(45) NOT NULL,
  `CommentText` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`CommentID`, `EntryID`),
  UNIQUE INDEX `idBlog_Comments_UNIQUE` (`CommentID` ASC) VISIBLE,
  INDEX `EntryID_idx` (`EntryID` ASC) VISIBLE,
  CONSTRAINT `EntryID`
    FOREIGN KEY (`EntryID`)
    REFERENCES `alumni`.`BlogEntries` (`EntryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alumni`.`MemberUpdates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alumni`.`MemberUpdates` (
  `UpdateID` INT NOT NULL AUTO_INCREMENT,
  `AlumID` INT NOT NULL,
  `UpdatePhoneNumber` VARCHAR(45) NULL,
  `UpdateEmail` VARCHAR(45) NULL,
  `UpdateUsername` VARCHAR(45) NULL,
  `UpdatePassword` VARCHAR(45) NULL,
  PRIMARY KEY (`UpdateID`, `AlumID`),
  UNIQUE INDEX `idMemberUpdate_UNIQUE` (`UpdateID` ASC) VISIBLE,
  INDEX `AlumID_idx` (`AlumID` ASC) VISIBLE,
  CONSTRAINT `AlumID`
    FOREIGN KEY (`AlumID`)
    REFERENCES `alumni`.`AlumniMembers` (`AlumID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alumni`.`Login`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alumni`.`Login` (
  `LoginID` INT NOT NULL AUTO_INCREMENT,
  `AlumID` INT NOT NULL,
  `LoginUser` VARCHAR(45) NOT NULL,
  `LoginPassword` VARCHAR(45) NOT NULL,
  `LoginAttemptDetails` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`LoginID`, `AlumID`),
  UNIQUE INDEX `idLogin_UNIQUE` (`LoginID` ASC) VISIBLE,
  INDEX `fk_Login_AlumniMembers1_idx` (`AlumID` ASC) VISIBLE,
  CONSTRAINT `fk_Login_AlumniMembers1`
    FOREIGN KEY (`AlumID`)
    REFERENCES `alumni`.`AlumniMembers` (`AlumID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `alumni`.`Pathways`
-- -----------------------------------------------------
START TRANSACTION;
USE `alumni`;
INSERT INTO `alumni`.`Pathways` (`PathwayID`, `PathwayName`) VALUES (1, 'Ballmer Institute for Children\'s Behavioral Health');
INSERT INTO `alumni`.`Pathways` (`PathwayID`, `PathwayName`) VALUES (2, 'College of Arts and Sciences');
INSERT INTO `alumni`.`Pathways` (`PathwayID`, `PathwayName`) VALUES (3, 'College of Design');
INSERT INTO `alumni`.`Pathways` (`PathwayID`, `PathwayName`) VALUES (4, 'College of Education');
INSERT INTO `alumni`.`Pathways` (`PathwayID`, `PathwayName`) VALUES (5, 'Lundquist College of Business');
INSERT INTO `alumni`.`Pathways` (`PathwayID`, `PathwayName`) VALUES (6, 'School of Computer and Data Sciences');
INSERT INTO `alumni`.`Pathways` (`PathwayID`, `PathwayName`) VALUES (7, 'School of Global Studies and Languages');
INSERT INTO `alumni`.`Pathways` (`PathwayID`, `PathwayName`) VALUES (8, 'School of Law');
INSERT INTO `alumni`.`Pathways` (`PathwayID`, `PathwayName`) VALUES (9, 'School of Music and Dance');

COMMIT;


-- -----------------------------------------------------
-- Data for table `alumni`.`MemberRegister`
-- -----------------------------------------------------
START TRANSACTION;
USE `alumni`;
INSERT INTO `alumni`.`MemberRegister` (`RegisterID`, `RegisterEmail`, `RegisterUsername`, `RegisterPassword`, `RegisterResults`) VALUES (1, 'larrylobster@email.com', 'LarryLobs', 'password', 'Accepted');
INSERT INTO `alumni`.`MemberRegister` (`RegisterID`, `RegisterEmail`, `RegisterUsername`, `RegisterPassword`, `RegisterResults`) VALUES (2, 'spongebob@email.com', 'Spongeybob', 'password2', 'Accepted');
INSERT INTO `alumni`.`MemberRegister` (`RegisterID`, `RegisterEmail`, `RegisterUsername`, `RegisterPassword`, `RegisterResults`) VALUES (3, 'garythesnail@email.com', 'GarysAsnail', 'password3', 'Accepted');
INSERT INTO `alumni`.`MemberRegister` (`RegisterID`, `RegisterEmail`, `RegisterUsername`, `RegisterPassword`, `RegisterResults`) VALUES (4, 'squidwardtentacles@email.com', 'squidwithtentacles', 'password4', 'Accepted');
INSERT INTO `alumni`.`MemberRegister` (`RegisterID`, `RegisterEmail`, `RegisterUsername`, `RegisterPassword`, `RegisterResults`) VALUES (5, 'spiderguy@email.com', 'SpiderMan', 'password5', 'Rejected');

COMMIT;


-- -----------------------------------------------------
-- Data for table `alumni`.`Webpages`
-- -----------------------------------------------------
START TRANSACTION;
USE `alumni`;
INSERT INTO `alumni`.`Webpages` (`PageID`, `PageName`, `PageDetails`) VALUES (1, 'Home', 'capturing messages');
INSERT INTO `alumni`.`Webpages` (`PageID`, `PageName`, `PageDetails`) VALUES (2, 'Join', 'register, must be accepted');
INSERT INTO `alumni`.`Webpages` (`PageID`, `PageName`, `PageDetails`) VALUES (3, 'Login/Update', 'update contact information/login');
INSERT INTO `alumni`.`Webpages` (`PageID`, `PageName`, `PageDetails`) VALUES (4, 'Events', 'CIT-related events');
INSERT INTO `alumni`.`Webpages` (`PageID`, `PageName`, `PageDetails`) VALUES (5, 'Blog', 'staff/alumni monthly articles');
INSERT INTO `alumni`.`Webpages` (`PageID`, `PageName`, `PageDetails`) VALUES (6, 'Contact', 'website contact information');

COMMIT;

