-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema rgbycch
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `rgbycch` ;

-- -----------------------------------------------------
-- Schema rgbycch
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `rgbycch` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
SHOW WARNINGS;
USE `rgbycch` ;

-- -----------------------------------------------------
-- Table `rgbycch`.`t_player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rgbycch`.`t_player` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `rgbycch`.`t_player` (
  `pk` INT(11) UNIQUE NOT NULL AUTO_INCREMENT,
  `nm` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`pk`));

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `rgbycch`.`t_match`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rgbycch`.`t_match` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `rgbycch`.`t_match` (
  `pk` INT(11) UNIQUE NOT NULL AUTO_INCREMENT,
  `nm` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`pk`));

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `rgbycch`.`t_match_event_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rgbycch`.`t_match_event_category` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `rgbycch`.`t_match_event_category` (
  `pk` INT(11) UNIQUE NOT NULL AUTO_INCREMENT,
  `nm` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`pk`));

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `rgbycch`.`t_match_event_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rgbycch`.`t_match_event_type` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `rgbycch`.`t_match_event_type` (
  `pk` INT(11) UNIQUE NOT NULL AUTO_INCREMENT,
  `nm` VARCHAR(60) NOT NULL,
  `mtch_evt_ctgry_fk` INT(11) UNIQUE NOT NULL,
  PRIMARY KEY (`pk`),
  CONSTRAINT `fk_t_match_event_type_t_match_event_category1`
    FOREIGN KEY (`mtch_evt_ctgry_fk`)
    REFERENCES `rgbycch`.`t_match_event_category` (`pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

SHOW WARNINGS;
CREATE INDEX `fk_t_match_event_type_t_match_event_category1_idx` ON `rgbycch`.`t_match_event_type` (`mtch_evt_ctgry_fk` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `rgbycch`.`t_club`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rgbycch`.`t_club` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `rgbycch`.`t_club` (
  `pk` INT(11) UNIQUE NOT NULL AUTO_INCREMENT,
  `nm` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`pk`));

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `rgbycch`.`t_team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rgbycch`.`t_team` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `rgbycch`.`t_team` (
  `pk` INT(11) UNIQUE NOT NULL AUTO_INCREMENT,
  `nm` VARCHAR(60) NOT NULL,
  `clb_fk` INT(11) UNIQUE NOT NULL,
  PRIMARY KEY (`pk`),
  CONSTRAINT `fk_t_team_t_club1`
    FOREIGN KEY (`clb_fk`)
    REFERENCES `rgbycch`.`t_club` (`pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

SHOW WARNINGS;
CREATE INDEX `fk_t_team_t_club1_idx` ON `rgbycch`.`t_team` (`clb_fk` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `rgbycch`.`t_match_squad_member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rgbycch`.`t_match_squad_member` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `rgbycch`.`t_match_squad_member` (
  `pk` INT(11) UNIQUE NOT NULL AUTO_INCREMENT,
  `nm` VARCHAR(60) NOT NULL,
  `mtch_pk` INT(11) UNIQUE NOT NULL,
  `plyr_` INT(11) UNIQUE NOT NULL,
  `tm_fk` INT(11) UNIQUE NOT NULL,
  PRIMARY KEY (`pk`),
  CONSTRAINT `fk_t_match_squad_t_match1`
    FOREIGN KEY (`mtch_pk`)
    REFERENCES `rgbycch`.`t_match` (`pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_match_squad_t_player1`
    FOREIGN KEY (`plyr_`)
    REFERENCES `rgbycch`.`t_player` (`pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_match_squad_member_t_team1`
    FOREIGN KEY (`tm_fk`)
    REFERENCES `rgbycch`.`t_team` (`pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

SHOW WARNINGS;
CREATE INDEX `fk_t_match_squad_t_match1_idx` ON `rgbycch`.`t_match_squad_member` (`mtch_pk` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_t_match_squad_t_player1_idx` ON `rgbycch`.`t_match_squad_member` (`plyr_` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_t_match_squad_member_t_team1_idx` ON `rgbycch`.`t_match_squad_member` (`tm_fk` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `rgbycch`.`t_match_event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rgbycch`.`t_match_event` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `rgbycch`.`t_match_event` (
  `pk` INT(11) UNIQUE NOT NULL AUTO_INCREMENT,
  `nm` VARCHAR(60) NOT NULL,
  `mtch_fk` INT(11) UNIQUE NOT NULL,
  `mtch_evnt_fk` INT(11) UNIQUE NOT NULL,
  `mtch_sqd_mmbr_fk` INT(11) UNIQUE NOT NULL,
  PRIMARY KEY (`pk`),
  CONSTRAINT `fk_t_match_event_t_match1`
    FOREIGN KEY (`mtch_fk`)
    REFERENCES `rgbycch`.`t_match` (`pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_match_event_t_match_event_type1`
    FOREIGN KEY (`mtch_evnt_fk`)
    REFERENCES `rgbycch`.`t_match_event_type` (`pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_match_event_t_match_squad1`
    FOREIGN KEY (`mtch_sqd_mmbr_fk`)
    REFERENCES `rgbycch`.`t_match_squad_member` (`pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

SHOW WARNINGS;
CREATE INDEX `fk_t_match_event_t_match1_idx` ON `rgbycch`.`t_match_event` (`mtch_fk` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_t_match_event_t_match_event_type1_idx` ON `rgbycch`.`t_match_event` (`mtch_evnt_fk` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_t_match_event_t_match_squad1_idx` ON `rgbycch`.`t_match_event` (`mtch_sqd_mmbr_fk` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `rgbycch`.`t_practice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rgbycch`.`t_practice` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `rgbycch`.`t_practice` (
  `pk` INT(11) UNIQUE NOT NULL AUTO_INCREMENT,
  `nm` VARCHAR(60) NOT NULL,
  `tm_fk` INT(11) UNIQUE NOT NULL,
  PRIMARY KEY (`pk`),
  CONSTRAINT `fk_t_practice_t_team1`
    FOREIGN KEY (`tm_fk`)
    REFERENCES `rgbycch`.`t_team` (`pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

SHOW WARNINGS;
CREATE INDEX `fk_t_practice_t_team1_idx` ON `rgbycch`.`t_practice` (`tm_fk` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `rgbycch`.`t_unit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rgbycch`.`t_unit` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `rgbycch`.`t_unit` (
  `pk` INT(11) UNIQUE NOT NULL AUTO_INCREMENT,
  `nm` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`pk`));

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `rgbycch`.`t_unit_member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rgbycch`.`t_unit_member` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `rgbycch`.`t_unit_member` (
  `pk` INT(11) UNIQUE NOT NULL AUTO_INCREMENT,
  `nm` VARCHAR(60) NOT NULL,
  `unt_fk` INT(11) UNIQUE NOT NULL,
  `plyr_fk` INT(11) UNIQUE NOT NULL,
  PRIMARY KEY (`pk`),
  CONSTRAINT `fk_t_unit_member_t_unit1`
    FOREIGN KEY (`unt_fk`)
    REFERENCES `rgbycch`.`t_unit` (`pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_unit_member_t_player1`
    FOREIGN KEY (`plyr_fk`)
    REFERENCES `rgbycch`.`t_player` (`pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

SHOW WARNINGS;
CREATE INDEX `fk_t_unit_member_t_unit1_idx` ON `rgbycch`.`t_unit_member` (`unt_fk` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_t_unit_member_t_player1_idx` ON `rgbycch`.`t_unit_member` (`plyr_fk` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `rgbycch`.`t_practice_drill`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rgbycch`.`t_practice_drill` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `rgbycch`.`t_practice_drill` (
  `pk` INT(11) UNIQUE NOT NULL AUTO_INCREMENT,
  `nm` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`pk`));

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `rgbycch`.`t_practice_block_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rgbycch`.`t_practice_block_type` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `rgbycch`.`t_practice_block_type` (
  `pk` INT(11) UNIQUE NOT NULL AUTO_INCREMENT,
  `nm` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`pk`));

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `rgbycch`.`t_practice_block`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rgbycch`.`t_practice_block` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `rgbycch`.`t_practice_block` (
  `pk` INT(11) UNIQUE NOT NULL AUTO_INCREMENT,
  `nm` VARCHAR(60) NOT NULL,
  `prctc_fk` INT(11) UNIQUE NOT NULL,
  `unt_fk` INT(11) UNIQUE NOT NULL,
  `prctc_drll_fk` INT(11) UNIQUE NULL,
  `prctc_blck_typ_fk` INT(11) UNIQUE NOT NULL,
  PRIMARY KEY (`pk`),
  CONSTRAINT `fk_t_practice_block_t_practice1`
    FOREIGN KEY (`prctc_fk`)
    REFERENCES `rgbycch`.`t_practice` (`pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_practice_block_t_unit1`
    FOREIGN KEY (`unt_fk`)
    REFERENCES `rgbycch`.`t_unit` (`pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_practice_block_t_practice_drill1`
    FOREIGN KEY (`prctc_drll_fk`)
    REFERENCES `rgbycch`.`t_practice_drill` (`pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_practice_block_t_practice_block_type1`
    FOREIGN KEY (`prctc_blck_typ_fk`)
    REFERENCES `rgbycch`.`t_practice_block_type` (`pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

SHOW WARNINGS;
CREATE INDEX `fk_t_practice_block_t_practice1_idx` ON `rgbycch`.`t_practice_block` (`prctc_fk` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_t_practice_block_t_unit1_idx` ON `rgbycch`.`t_practice_block` (`unt_fk` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_t_practice_block_t_practice_drill1_idx` ON `rgbycch`.`t_practice_block` (`prctc_drll_fk` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_t_practice_block_t_practice_block_type1_idx` ON `rgbycch`.`t_practice_block` (`prctc_blck_typ_fk` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `rgbycch`.`t_team_member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rgbycch`.`t_team_member` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `rgbycch`.`t_team_member` (
  `pk` INT(11) UNIQUE NOT NULL AUTO_INCREMENT,
  `nm` VARCHAR(45) NULL,
  `plyr_fk` INT(11) UNIQUE NOT NULL,
  `tm_fk` INT(11) UNIQUE NOT NULL,
  PRIMARY KEY (`pk`),
  CONSTRAINT `fk_t_team_member_t_player1`
    FOREIGN KEY (`plyr_fk`)
    REFERENCES `rgbycch`.`t_player` (`pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_team_member_t_team1`
    FOREIGN KEY (`tm_fk`)
    REFERENCES `rgbycch`.`t_team` (`pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

SHOW WARNINGS;
CREATE INDEX `fk_t_team_member_t_player1_idx` ON `rgbycch`.`t_team_member` (`plyr_fk` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_t_team_member_t_team1_idx` ON `rgbycch`.`t_team_member` (`tm_fk` ASC);

SHOW WARNINGS;
SET SQL_MODE = '';
GRANT USAGE ON *.* TO rgbycch_web;
 DROP USER rgbycch_web;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

SHOW WARNINGS;
CREATE USER 'rgbycch_web' IDENTIFIED BY '6fltPwrd';

GRANT SELECT, INSERT, TRIGGER ON TABLE `rgbycch`.* TO 'rgbycch_web';
GRANT SELECT ON TABLE `rgbycch`.* TO 'rgbycch_web';
SHOW WARNINGS;
SET SQL_MODE = '';
GRANT USAGE ON *.* TO rgbycch;
 DROP USER rgbycch;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

SHOW WARNINGS;
CREATE USER 'rgbycch_admin' IDENTIFIED BY '6fltPwrd';

GRANT ALL ON `rgbycch`.* TO 'rgbycch_admin';
GRANT SELECT ON TABLE `rgbycch`.* TO 'rgbycch_admin';
GRANT SELECT, INSERT, TRIGGER ON TABLE `rgbycch`.* TO 'rgbycch_admin';
GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `rgbycch`.* TO 'rgbycch_admin';
SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
