-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Flight_booking_system
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Flight_booking_system
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Flight_booking_system` DEFAULT CHARACTER SET utf8 ;
USE `Flight_booking_system` ;

-- -----------------------------------------------------
-- Table `Flight_booking_system`.`Passengers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Flight_booking_system`.`Passengers` (
  `Passenger_id` INT NOT NULL AUTO_INCREMENT,
  `First_name` VARCHAR(50) NOT NULL,
  `Middle_name` VARCHAR(50) NULL,
  `Last_name` VARCHAR(50) NOT NULL,
  `Email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Passenger_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Flight_booking_system`.`Airports`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Flight_booking_system`.`Airports` (
  `Airport_id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(150) NOT NULL,
  `Location` VARCHAR(150) NOT NULL,
  `IATA` CHAR(3) NOT NULL,
  PRIMARY KEY (`Airport_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Flight_booking_system`.`Flights`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Flight_booking_system`.`Flights` (
  `Flight_id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(250) NOT NULL,
  `Distance` VARCHAR(50) NOT NULL,
  `Duration` TIME NOT NULL,
  `Departure_time` DATETIME NOT NULL,
  `Arrival_time` DATETIME NOT NULL,
  `Departure_location` INT NOT NULL,
  `Arrival_location` INT NOT NULL,
  PRIMARY KEY (`Flight_id`),
  INDEX `fk_flights_airport1_idx` (`Departure_location` ASC) VISIBLE,
  INDEX `fk_flights_airport2_idx` (`Arrival_location` ASC) VISIBLE,
  CONSTRAINT `fk_flights_airport1`
    FOREIGN KEY (`Departure_location`)
    REFERENCES `Flight_booking_system`.`Airports` (`Airport_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_flights_airport2`
    FOREIGN KEY (`Arrival_location`)
    REFERENCES `Flight_booking_system`.`Airports` (`Airport_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Flight_booking_system`.`Flight_Class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Flight_booking_system`.`Flight_Class` (
  `Class_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Class_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Flight_booking_system`.`Tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Flight_booking_system`.`Tickets` (
  `Ticket_id` INT NOT NULL,
  `Passenger_id` INT NOT NULL,
  `Flight_Class_id` INT NOT NULL,
  `Flight_id` INT NOT NULL,
  `Ticket_number` INT NOT NULL,
  `Price` DECIMAL(6,2) NOT NULL,
  `Time` DATETIME NOT NULL,
  `Confirmation_number` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Ticket_id`),
  INDEX `fk_Tickets_Passengers_idx` (`Passenger_id` ASC) VISIBLE,
  INDEX `fk_Tickets_Flights1_idx` (`Flight_id` ASC) VISIBLE,
  INDEX `fk_Tickets_Flight_Class1_idx` (`Flight_Class_id` ASC) VISIBLE,
  CONSTRAINT `fk_Tickets_Passengers`
    FOREIGN KEY (`Passenger_id`)
    REFERENCES `Flight_booking_system`.`Passengers` (`Passenger_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Tickets_Flights`
    FOREIGN KEY (`Flight_id`)
    REFERENCES `Flight_booking_system`.`Flights` (`Flight_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Tickets_Flight_Class1`
    FOREIGN KEY (`Flight_Class_id`)
    REFERENCES `Flight_booking_system`.`Flight_Class` (`Class_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
