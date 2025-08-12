-- MySQL Workbench Forward Engineering
-- ---------------------------
-- Drew Lesh
-- CIT 381
-- Project 3
-- 10.22.23
-- ---------------------------
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema store
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `store` ;
USE `store` ;

-- -----------------------------------------------------
-- Table `store`.`store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store`.`store` (
  `StoreID` INT NOT NULL AUTO_INCREMENT,
  `Region` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`StoreID`),
  UNIQUE INDEX `Region_UNIQUE` (`Region` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `store`.`manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store`.`manager` (
  `ManagerID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `store_Store ID` INT NOT NULL,
  PRIMARY KEY (`ManagerID`),
  INDEX `fk_manager_store1_idx` (`store_Store ID` ASC) VISIBLE,
  CONSTRAINT `fk_manager_store1`
    FOREIGN KEY (`store_Store ID`)
    REFERENCES `store`.`store` (`StoreID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `store`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store`.`employees` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `last` VARCHAR(45) NOT NULL,
  `first` VARCHAR(45) NOT NULL,
  `hire date` DATE NOT NULL,
  `release date` DATE NOT NULL,
  `manager` VARCHAR(45) NOT NULL,
  `manager_ManagerID` INT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_employees_manager1_idx` (`manager_ManagerID` ASC) VISIBLE,
  CONSTRAINT `fk_employees_manager1`
    FOREIGN KEY (`manager_ManagerID`)
    REFERENCES `store`.`manager` (`ManagerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `store`.`EmployeeStores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store`.`EmployeeStores` (
  `employees_ID` INT NOT NULL,
  `store_StoreID` INT NOT NULL,
  PRIMARY KEY (`employees_ID`, `store_StoreID`),
  INDEX `fk_employees_has_store_store1_idx` (`store_StoreID` ASC) VISIBLE,
  INDEX `fk_employees_has_store_employees1_idx` (`employees_ID` ASC) VISIBLE,
  CONSTRAINT `fk_employees_has_store_employees1`
    FOREIGN KEY (`employees_ID`)
    REFERENCES `store`.`employees` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employees_has_store_store1`
    FOREIGN KEY (`store_StoreID`)
    REFERENCES `store`.`store` (`StoreID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `store`.`store`
-- -----------------------------------------------------
START TRANSACTION;
USE `store`;
INSERT INTO `store`.`store` (`StoreID`, `Region`) VALUES (1, 'West');
INSERT INTO `store`.`store` (`StoreID`, `Region`) VALUES (2, 'North');
INSERT INTO `store`.`store` (`StoreID`, `Region`) VALUES (3, 'South');

COMMIT;


-- -----------------------------------------------------
-- Data for table `store`.`manager`
-- -----------------------------------------------------
START TRANSACTION;
USE `store`;
INSERT INTO `store`.`manager` (`ManagerID`, `Name`, `store_Store ID`) VALUES (1, 'Shaley', 2);
INSERT INTO `store`.`manager` (`ManagerID`, `Name`, `store_Store ID`) VALUES (2, 'Wagner', 3);
INSERT INTO `store`.`manager` (`ManagerID`, `Name`, `store_Store ID`) VALUES (3, 'Mary', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `store`.`employees`
-- -----------------------------------------------------
START TRANSACTION;
USE `store`;
INSERT INTO `store`.`employees` (`ID`, `last`, `first`, `hire date`, `release date`, `manager`, `manager_ManagerID`) VALUES (1, 'Murph', 'Aaron', '01-01-23', '2-3-23', 'Wagner', 2);
INSERT INTO `store`.`employees` (`ID`, `last`, `first`, `hire date`, `release date`, `manager`, `manager_ManagerID`) VALUES (2, 'Lain', 'Marvin', '02-04-22', '4-5-23', 'Shaley', 1);
INSERT INTO `store`.`employees` (`ID`, `last`, `first`, `hire date`, `release date`, `manager`, `manager_ManagerID`) VALUES (3, 'Blart', 'Blake', '01-04-22', '1-5-23', 'Wagner', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `store`.`EmployeeStores`
-- -----------------------------------------------------
START TRANSACTION;
USE `store`;
INSERT INTO `store`.`EmployeeStores` (`employees_ID`, `store_StoreID`) VALUES (1, 2);
INSERT INTO `store`.`EmployeeStores` (`employees_ID`, `store_StoreID`) VALUES (1, 3);
INSERT INTO `store`.`EmployeeStores` (`employees_ID`, `store_StoreID`) VALUES (2, 1);
INSERT INTO `store`.`EmployeeStores` (`employees_ID`, `store_StoreID`) VALUES (3, 3);
INSERT INTO `store`.`EmployeeStores` (`employees_ID`, `store_StoreID`) VALUES (3, 2);

COMMIT;

-- ------------------------------
-- select * from employees;
-- select * from employeestores;
-- select * from manager;
-- -------------------------------
-- --------------------------------------------------------------
-- select e.first, e.last, s.StoreID, m.ManagerID
-- from employees as e
-- INNER JOIN manager as m ON e.manager_ManagerID = m.ManagerID
-- INNER JOIN employeestores as es ON e.ID = es.employees_ID
-- INNER JOIN store as s ON s.StoreID = es.store_StoreID;
-- --------------------------------------------------------------