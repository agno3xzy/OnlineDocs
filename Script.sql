-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema OnlineDocs
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema OnlineDocs
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `OnlineDocs` DEFAULT CHARACTER SET utf8 ;
USE `OnlineDocs` ;

-- -----------------------------------------------------
-- Table `OnlineDocs`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OnlineDocs`.`user` (
  `iduser` INT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`iduser`),
  UNIQUE INDEX `user_name_UNIQUE` (`user_name` ASC),
  UNIQUE INDEX `iduser_UNIQUE` (`iduser` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineDocs`.`document`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OnlineDocs`.`document` (
  `iddocument` INT NOT NULL AUTO_INCREMENT,
  `document_name` VARCHAR(45) NOT NULL,
  `create_time` DATETIME(6) NOT NULL,
  `last_modify_time` DATETIME(6) NOT NULL,
  `text_path` VARCHAR(128) NOT NULL,
  `log_path` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`iddocument`),
  UNIQUE INDEX `iddocument_UNIQUE` (`iddocument` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineDocs`.`cooperate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OnlineDocs`.`cooperate` (
  `permission` VARCHAR(20) NOT NULL,
  `user_iduser` INT NOT NULL,
  `document_iddocument` INT NOT NULL,
  INDEX `fk_cooperate_user_idx` (`user_iduser` ASC),
  INDEX `fk_cooperate_document1_idx` (`document_iddocument` ASC),
  CONSTRAINT `fk_cooperate_user`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `OnlineDocs`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cooperate_document1`
    FOREIGN KEY (`document_iddocument`)
    REFERENCES `OnlineDocs`.`document` (`iddocument`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;