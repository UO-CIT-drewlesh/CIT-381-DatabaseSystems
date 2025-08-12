-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema auction
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema auction
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `auction` DEFAULT CHARACTER SET utf8 ;
USE `auction` ;

-- -----------------------------------------------------
-- Table `auction`.`seller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `auction`.`seller` (
  `seller_ID` INT NOT NULL AUTO_INCREMENT,
  `seller_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`seller_ID`),
  UNIQUE INDEX `idsellers_UNIQUE` (`seller_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `auction`.`item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `auction`.`item` (
  `item_ID` INT NOT NULL AUTO_INCREMENT,
  `opening_Price` INT NOT NULL,
  `reserve_Price` INT NOT NULL,
  `item_Description` VARCHAR(45) NOT NULL,
  `ending_Time` TIME NOT NULL,
  `seller_seller_ID` INT NOT NULL,
  PRIMARY KEY (`item_ID`, `seller_seller_ID`),
  UNIQUE INDEX `itemNumber_UNIQUE` (`item_ID` ASC) VISIBLE,
  INDEX `fk_auctionSite_sellers1_idx` (`seller_seller_ID` ASC) VISIBLE,
  CONSTRAINT `fk_auctionSite_sellers1`
    FOREIGN KEY (`seller_seller_ID`)
    REFERENCES `auction`.`seller` (`seller_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `auction`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `auction`.`customer` (
  `customer_ID` INT NOT NULL AUTO_INCREMENT,
  `customer_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customer_ID`),
  UNIQUE INDEX `idCustomers_UNIQUE` (`customer_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `auction`.`customerBid`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `auction`.`customerBid` (
  `bid_ID` INT NOT NULL AUTO_INCREMENT,
  `customer_customer_ID` INT NOT NULL,
  `item_item_ID` INT NOT NULL,
  `customer_Bid` INT NOT NULL,
  `bid_Time` TIME NOT NULL,
  `sale_ID` INT NULL,
  PRIMARY KEY (`bid_ID`, `item_item_ID`, `customer_customer_ID`),
  INDEX `fk_customers_has_auctionSite_auctionSite1_idx` (`item_item_ID` ASC) VISIBLE,
  INDEX `fk_customers_has_auctionSite_customers_idx` (`customer_customer_ID` ASC) VISIBLE,
  UNIQUE INDEX `bidID_UNIQUE` (`bid_ID` ASC) VISIBLE,
  CONSTRAINT `fk_customers_has_auctionSite_customers`
    FOREIGN KEY (`customer_customer_ID`)
    REFERENCES `auction`.`customer` (`customer_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customers_has_auctionSite_auctionSite1`
    FOREIGN KEY (`item_item_ID`)
    REFERENCES `auction`.`item` (`item_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `auction`.`seller`
-- -----------------------------------------------------
START TRANSACTION;
USE `auction`;
INSERT INTO `auction`.`seller` (`seller_ID`, `seller_Name`) VALUES (1, 'Mathew');
INSERT INTO `auction`.`seller` (`seller_ID`, `seller_Name`) VALUES (2, 'Rachelle');
INSERT INTO `auction`.`seller` (`seller_ID`, `seller_Name`) VALUES (3, 'Mary');

COMMIT;


-- -----------------------------------------------------
-- Data for table `auction`.`item`
-- -----------------------------------------------------
START TRANSACTION;
USE `auction`;
INSERT INTO `auction`.`item` (`item_ID`, `opening_Price`, `reserve_Price`, `item_Description`, `ending_Time`, `seller_seller_ID`) VALUES (1, 5, 2, 'Trinket', '03:20:00', 1);
INSERT INTO `auction`.`item` (`item_ID`, `opening_Price`, `reserve_Price`, `item_Description`, `ending_Time`, `seller_seller_ID`) VALUES (2, 50, 10, 'Vintage Shirt', '05:00:00', 2);
INSERT INTO `auction`.`item` (`item_ID`, `opening_Price`, `reserve_Price`, `item_Description`, `ending_Time`, `seller_seller_ID`) VALUES (3, 200, 50, 'Neon Sign', '12:00:00', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `auction`.`customer`
-- -----------------------------------------------------
START TRANSACTION;
USE `auction`;
INSERT INTO `auction`.`customer` (`customer_ID`, `customer_Name`) VALUES (1, 'Adam');
INSERT INTO `auction`.`customer` (`customer_ID`, `customer_Name`) VALUES (2, 'Rick');
INSERT INTO `auction`.`customer` (`customer_ID`, `customer_Name`) VALUES (3, 'Murph');

COMMIT;


-- -----------------------------------------------------
-- Data for table `auction`.`customerBid`
-- -----------------------------------------------------
START TRANSACTION;
USE `auction`;
INSERT INTO `auction`.`customerBid` (`bid_ID`, `customer_customer_ID`, `item_item_ID`, `customer_Bid`, `bid_Time`, `sale_ID`) VALUES (1, 1, 1, 2, '1:00:00', NULL);
INSERT INTO `auction`.`customerBid` (`bid_ID`, `customer_customer_ID`, `item_item_ID`, `customer_Bid`, `bid_Time`, `sale_ID`) VALUES (2, 2, 1, 3, '2:00:00', NULL);
INSERT INTO `auction`.`customerBid` (`bid_ID`, `customer_customer_ID`, `item_item_ID`, `customer_Bid`, `bid_Time`, `sale_ID`) VALUES (3, 1, 1, 4, '3:10:00', 1);
INSERT INTO `auction`.`customerBid` (`bid_ID`, `customer_customer_ID`, `item_item_ID`, `customer_Bid`, `bid_Time`, `sale_ID`) VALUES (4, 3, 2, 10, '3:00:00', NULL);
INSERT INTO `auction`.`customerBid` (`bid_ID`, `customer_customer_ID`, `item_item_ID`, `customer_Bid`, `bid_Time`, `sale_ID`) VALUES (5, 2, 2, 30, '4:00:00', NULL);
INSERT INTO `auction`.`customerBid` (`bid_ID`, `customer_customer_ID`, `item_item_ID`, `customer_Bid`, `bid_Time`, `sale_ID`) VALUES (6, 1, 2, 40, '4:58:00', 2);

COMMIT;

-- select * from customerbid;
-- select * from item;
-- select * from seller;
-- select * from customer;

-- select i.item_Description as Details, s.seller_Name as Seller, c.customer_Name as Customer, cb.customer_Bid as $Bid, cb.sale_ID as Sale
-- from item i
-- INNER JOIN seller as s ON i.seller_seller_ID = s.seller_ID
-- INNER JOIN customerbid as cb ON i.item_ID = cb.item_item_ID
-- INNER JOIN customer as c ON cb.customer_customer_ID = c.customer_ID;

