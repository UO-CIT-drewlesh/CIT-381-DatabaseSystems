-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cit381-assign07-schema
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `cit381-assign07-schema` ;

-- -----------------------------------------------------
-- Schema cit381-assign07-schema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cit381-assign07-schema` DEFAULT CHARACTER SET utf8 ;
USE `cit381-assign07-schema` ;

-- -----------------------------------------------------
-- Table `cit381-assign07-schema`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cit381-assign07-schema`.`users` ;

CREATE TABLE IF NOT EXISTS `cit381-assign07-schema`.`users` (
  `UserID` INT NOT NULL AUTO_INCREMENT,
  `AuthorName` VARCHAR(45) NOT NULL,
  `RedditLink` VARCHAR(120) NOT NULL,
  `CakeDay` DATE NULL,
  `PostKarma` INT NULL,
  `CommentKarma` INT NULL,
  PRIMARY KEY (`UserID`, `AuthorName`),
  UNIQUE INDEX `idusers_UNIQUE` (`AuthorName` ASC) VISIBLE,
  UNIQUE INDEX `UserID_UNIQUE` (`UserID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cit381-assign07-schema`.`posts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cit381-assign07-schema`.`posts` ;

CREATE TABLE IF NOT EXISTS `cit381-assign07-schema`.`posts` (
  `PostID` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(150) NOT NULL,
  `AuthorName` VARCHAR(60) NOT NULL,
  `DateAndTime` DATETIME NOT NULL,
  `RedditLink` VARCHAR(150) NOT NULL,
  `OtherLink` VARCHAR(150) NULL,
  `NumberComments` INT NOT NULL,
  `NumberCrossPosts` INT NOT NULL,
  `LinkToComments` VARCHAR(120) NULL,
  PRIMARY KEY (`PostID`, `AuthorName`),
  UNIQUE INDEX `idposts_UNIQUE` (`PostID` ASC) VISIBLE,
  UNIQUE INDEX `RedditLink_UNIQUE` (`RedditLink` ASC) VISIBLE,
  INDEX `fk_posts_users_idx` (`AuthorName` ASC) VISIBLE,
  CONSTRAINT `fk_posts_users`
    FOREIGN KEY (`AuthorName`)
    REFERENCES `cit381-assign07-schema`.`users` (`AuthorName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cit381-assign07-schema`.`comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cit381-assign07-schema`.`comments` ;

CREATE TABLE IF NOT EXISTS `cit381-assign07-schema`.`comments` (
  `CommentID` INT NOT NULL AUTO_INCREMENT,
  `PostID` INT NOT NULL,
  `AuthorName` VARCHAR(45) NOT NULL,
  `TitlePost` VARCHAR(60) NOT NULL,
  `DateAndTime` DATETIME NOT NULL,
  PRIMARY KEY (`CommentID`, `PostID`, `AuthorName`),
  UNIQUE INDEX `idcomments_UNIQUE` (`CommentID` ASC) VISIBLE,
  INDEX `fk_comments_posts1_idx` (`PostID` ASC, `AuthorName` ASC) VISIBLE,
  CONSTRAINT `fk_comments_posts1`
    FOREIGN KEY (`PostID` , `AuthorName`)
    REFERENCES `cit381-assign07-schema`.`posts` (`PostID` , `AuthorName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `cit381-assign07-schema`.`users`
-- -----------------------------------------------------
START TRANSACTION;
USE `cit381-assign07-schema`;
INSERT INTO `cit381-assign07-schema`.`users` (`UserID`, `AuthorName`, `RedditLink`, `CakeDay`, `PostKarma`, `CommentKarma`) VALUES (1, 'morethandork', 'https://www.reddit.com/user/morethandork/', '2009-09-02', 37337, 81337);
INSERT INTO `cit381-assign07-schema`.`users` (`UserID`, `AuthorName`, `RedditLink`, `CakeDay`, `PostKarma`, `CommentKarma`) VALUES (2, 'AutoModerator', 'https://www.reddit.com/user/AutoModerator/', '2012-01-05', 3141592, 3141592);
INSERT INTO `cit381-assign07-schema`.`users` (`UserID`, `AuthorName`, `RedditLink`, `CakeDay`, `PostKarma`, `CommentKarma`) VALUES (3, 'stomach-bug', 'https://www.reddit.com/user/stomach-bug/', '2023-01-06', 4427, 8552);
INSERT INTO `cit381-assign07-schema`.`users` (`UserID`, `AuthorName`, `RedditLink`, `CakeDay`, `PostKarma`, `CommentKarma`) VALUES (4, 'xxStayFly81xx', 'https://www.reddit.com/user/xxStayFly81xx/', '2014-04-26', 49755, 17052);
INSERT INTO `cit381-assign07-schema`.`users` (`UserID`, `AuthorName`, `RedditLink`, `CakeDay`, `PostKarma`, `CommentKarma`) VALUES (5, 'FancyPrint7365', 'https://www.reddit.com/user/FancyPrint7365/', '2022-01-22', 400, 5267);
INSERT INTO `cit381-assign07-schema`.`users` (`UserID`, `AuthorName`, `RedditLink`, `CakeDay`, `PostKarma`, `CommentKarma`) VALUES (6, 'eanregguht', 'https://www.reddit.com/user/eanregguht/', '2023-10-09', 355, 8897);
INSERT INTO `cit381-assign07-schema`.`users` (`UserID`, `AuthorName`, `RedditLink`, `CakeDay`, `PostKarma`, `CommentKarma`) VALUES (7, 'Cmahones03', 'https://www.reddit.com/user/Cmahones03/', '2017-11-14', 1899, 1786);
INSERT INTO `cit381-assign07-schema`.`users` (`UserID`, `AuthorName`, `RedditLink`, `CakeDay`, `PostKarma`, `CommentKarma`) VALUES (8, 'daddybronny', 'https://www.reddit.com/user/daddybronny/', '2019-03-07', 3373, 3553);
INSERT INTO `cit381-assign07-schema`.`users` (`UserID`, `AuthorName`, `RedditLink`, `CakeDay`, `PostKarma`, `CommentKarma`) VALUES (9, 'Beautiful_Ad55', 'https://www.reddit.com/user/Beautiful_Ad55/', '2020-09-09', 3857, 4056);
INSERT INTO `cit381-assign07-schema`.`users` (`UserID`, `AuthorName`, `RedditLink`, `CakeDay`, `PostKarma`, `CommentKarma`) VALUES (10, 'KnicksNBAchamps2021', 'https://www.reddit.com/user/KnicksNBAchamps2021/', '2020-03-22', 2312, 5434);

COMMIT;


-- -----------------------------------------------------
-- Data for table `cit381-assign07-schema`.`posts`
-- -----------------------------------------------------
START TRANSACTION;
USE `cit381-assign07-schema`;
INSERT INTO `cit381-assign07-schema`.`posts` (`PostID`, `Title`, `AuthorName`, `DateAndTime`, `RedditLink`, `OtherLink`, `NumberComments`, `NumberCrossPosts`, `LinkToComments`) VALUES (1, 'In-Season Rules and FAQ', 'morethandork', '2023-10-18 08:06:42 ', 'https://www.reddit.com/r/nbadiscussion/comments/17azzy6/inseason_rules_and_faq/', 'https://www.reddit.com/r/NBATalk', 5, 0, NULL);
INSERT INTO `cit381-assign07-schema`.`posts` (`PostID`, `Title`, `AuthorName`, `DateAndTime`, `RedditLink`, `OtherLink`, `NumberComments`, `NumberCrossPosts`, `LinkToComments`) VALUES (2, 'Weekly Questions Thread: November 20, 2023', 'AutoModerator', '2023-11-20 12:00:23', 'https://www.reddit.com/r/nbadiscussion/comments/17zmyn5/weekly_questions_thread_november_20_2023/', 'https://www.reddit.com/r/nbadiscussion/wiki/rules#wiki_submission_rules', 1, 0, NULL);
INSERT INTO `cit381-assign07-schema`.`posts` (`PostID`, `Title`, `AuthorName`, `DateAndTime`, `RedditLink`, `OtherLink`, `NumberComments`, `NumberCrossPosts`, `LinkToComments`) VALUES (3, 'Did the Lakers make a mistake with letting Lonnie Walker go?', 'stomach-bug', '2023-11-22 02:26:36', 'https://www.reddit.com/r/nbadiscussion/comments/180yiis/did_the_lakers_make_a_mistake_with_letting_lonnie/', NULL, 0, 0, NULL);
INSERT INTO `cit381-assign07-schema`.`posts` (`PostID`, `Title`, `AuthorName`, `DateAndTime`, `RedditLink`, `OtherLink`, `NumberComments`, `NumberCrossPosts`, `LinkToComments`) VALUES (4, 'Clippers should look to try to acquire Capela from Atlanta', 'xxStayFly81xx', '2023-11-21 06:43:26', 'https://www.reddit.com/r/nbadiscussion/comments/180o2xz/clippers_should_look_to_try_to_acquire_capela/', NULL, 32, 0, NULL);
INSERT INTO `cit381-assign07-schema`.`posts` (`PostID`, `Title`, `AuthorName`, `DateAndTime`, `RedditLink`, `OtherLink`, `NumberComments`, `NumberCrossPosts`, `LinkToComments`) VALUES (5, 'Do the warriors actually have assets to make a trade for Lavine, Markannen or other stars?', 'FancyPrint7365', '2023-11-20 08:09:28', 'https://www.reddit.com/r/nbadiscussion/comments/17zxmwa/do_the_warriors_actually_have_assets_to_make_a/', NULL, 156, 0, NULL);
INSERT INTO `cit381-assign07-schema`.`posts` (`PostID`, `Title`, `AuthorName`, `DateAndTime`, `RedditLink`, `OtherLink`, `NumberComments`, `NumberCrossPosts`, `LinkToComments`) VALUES (6, 'The Spurs need to start Tre Jones.', 'eanregguht', '2023-11-20 08:12:20', 'https://www.reddit.com/r/nbadiscussion/comments/17zxpgq/the_spurs_need_to_start_tre_jones/', NULL, 72, 0, NULL);
INSERT INTO `cit381-assign07-schema`.`posts` (`PostID`, `Title`, `AuthorName`, `DateAndTime`, `RedditLink`, `OtherLink`, `NumberComments`, `NumberCrossPosts`, `LinkToComments`) VALUES (7, 'Proving that Draymond Green gets ejected MORE OFTEN when Steph Curry is not playing (using simulation):', 'Cmahones03', '2023-11-20 09:01:22', 'https://www.reddit.com/r/nbadiscussion/comments/17zkc8o/proving_that_draymond_green_gets_ejected_more/', 'https://imgur.com/CDHepy7', 38, 0, NULL);
INSERT INTO `cit381-assign07-schema`.`posts` (`PostID`, `Title`, `AuthorName`, `DateAndTime`, `RedditLink`, `OtherLink`, `NumberComments`, `NumberCrossPosts`, `LinkToComments`) VALUES (8, 'LeBron James\' unbreakable record VS the indisputable GOAT', 'daddybronny', '2023-11-19 08:10:50', 'https://www.reddit.com/r/nbadiscussion/comments/17z5pqp/lebron_james_unbreakable_record_vs_the/', NULL, 259, 0, NULL);
INSERT INTO `cit381-assign07-schema`.`posts` (`PostID`, `Title`, `AuthorName`, `DateAndTime`, `RedditLink`, `OtherLink`, `NumberComments`, `NumberCrossPosts`, `LinkToComments`) VALUES (9, 'Would single-elimination games in the NBA-Playoffs make the NBA more popular?', 'Beautiful_Ad55', '2023-11-21 02:00:54', 'https://www.reddit.com/r/nbadiscussion/comments/180hnb3/would_singleelimination_games_in_the_nbaplayoffs/', NULL, 97, 0, NULL);
INSERT INTO `cit381-assign07-schema`.`posts` (`PostID`, `Title`, `AuthorName`, `DateAndTime`, `RedditLink`, `OtherLink`, `NumberComments`, `NumberCrossPosts`, `LinkToComments`) VALUES (10, 'If Kobe and CP3 had paired up in 2012 and had a strong supporting cast that was suited for them would they have won a championship?', 'KnicksNBAchamps2021', '2023-11-19 10:20:25', 'https://www.reddit.com/r/nbadiscussion/comments/17z8png/if_kobe_and_cp3_had_paired_up_in_2012_and_had_a/', NULL, 75, 0, NULL);

COMMIT;

