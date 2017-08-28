-- MySQL Script generated by MySQL Workbench
-- 08/28/17 22:46:36
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mi151_00_master_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mi151_00_master_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mi151_00_master_db` DEFAULT CHARACTER SET utf8 ;
USE `mi151_00_master_db` ;

-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`employee` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `employee_type` VARCHAR(45) NULL,
  `employee_fname` VARCHAR(45) NULL,
  `employee_mname` VARCHAR(45) NULL,
  `employee_lname` VARCHAR(45) NULL,
  `employee_contact_number` BIGINT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`template`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`template` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `template_type` VARCHAR(45) NULL,
  `template_description` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `customer_type` ENUM('Guest', 'Prospect') NULL,
  `customer_email` VARCHAR(45) NULL,
  `customer_fname` VARCHAR(45) NULL,
  `customer_mname` VARCHAR(45) NULL,
  `customer_lname` VARCHAR(45) NULL,
  `customer_contact_number` BIGINT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`email`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`email` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email_date` DATETIME NULL,
  `email_template` VARCHAR(45) NULL,
  `email_status` ENUM('Active', 'Inactive') NULL,
  `template_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_email_template1_idx` (`template_id` ASC),
  INDEX `fk_email_customer1_idx` (`customer_id` ASC),
  CONSTRAINT `fk_email_template1`
    FOREIGN KEY (`template_id`)
    REFERENCES `mi151_00_master_db`.`template` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_email_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mi151_00_master_db`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`customer_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`customer_history` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `customer_history_checkin` VARCHAR(45) NULL,
  `customer_history_checkout` VARCHAR(45) NULL,
  `customer_history_numberdays` VARCHAR(45) NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_customer_history_customer1_idx` (`customer_id` ASC),
  CONSTRAINT `fk_customer_history_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mi151_00_master_db`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`Existing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`Existing` (
  `customer_ID` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`customer_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`webvisit_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`webvisit_history` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `wvh_date` DATETIME NULL,
  `wvh_ip_address` VARCHAR(20) NULL,
  `wvh_url` VARCHAR(100) NULL,
  `wvh_cookie_information` VARCHAR(45) NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_webvisit_history_customer1_idx` (`customer_id` ASC),
  CONSTRAINT `fk_webvisit_history_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mi151_00_master_db`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`event` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `event_date_created` DATETIME NULL,
  `event_description` VARCHAR(400) NULL,
  `event_start_date` DATE NULL,
  `event_end_date` DATE NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_event_employee1_idx` (`employee_id` ASC),
  CONSTRAINT `fk_event_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `mi151_00_master_db`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`preference`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`preference` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `preference_category` VARCHAR(45) NULL,
  `preference_description` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`activity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`activity` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `activity_status` VARCHAR(45) NULL,
  `activity_description` VARCHAR(45) NULL,
  `email_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_activity_email1_idx` (`email_id` ASC),
  CONSTRAINT `fk_activity_email1`
    FOREIGN KEY (`email_id`)
    REFERENCES `mi151_00_master_db`.`email` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`email_event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`email_event` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `event_id` INT NOT NULL,
  `email_id` INT NOT NULL,
  INDEX `fk_event_has_email_email1_idx` (`email_id` ASC),
  INDEX `fk_event_has_email_event1_idx` (`event_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_event_has_email_event1`
    FOREIGN KEY (`event_id`)
    REFERENCES `mi151_00_master_db`.`event` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_has_email_email1`
    FOREIGN KEY (`email_id`)
    REFERENCES `mi151_00_master_db`.`email` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`guest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`guest` (
  `guest_id` INT NOT NULL,
  `guest_name` VARCHAR(120) NOT NULL,
  PRIMARY KEY (`guest_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`employee2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`employee2` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `employee_lastname` VARCHAR(45) NULL,
  `employee_firstname` VARCHAR(45) NULL,
  `employee_number` INT NULL,
  `employee_email` VARCHAR(45) NULL,
  `employee_occupation` VARCHAR(45) NULL,
  `employee_user_type` VARCHAR(45) BINARY NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`schedule1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`schedule1` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `schudule_date` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`checklist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`checklist` (
  `id` INT NOT NULL,
  `checklist_equipment` VARCHAR(45) NULL,
  `checklist_quantity_on_hand` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`facility`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`facility` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `facility_type` VARCHAR(45) NULL,
  `facility_status` VARCHAR(45) NULL,
  `facility_qrcode` VARCHAR(45) NULL,
  `checklist_id` INT NOT NULL,
  PRIMARY KEY (`id`, `checklist_id`),
  INDEX `fk_facility_checklist1_idx` (`checklist_id` ASC),
  CONSTRAINT `fk_facility_checklist1`
    FOREIGN KEY (`checklist_id`)
    REFERENCES `mi151_00_master_db`.`checklist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`employee_has_facility`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`employee_has_facility` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT NULL,
  `facility_id` INT NULL,
  INDEX `fk_employee_has_facility_facility1_idx` (`facility_id` ASC),
  INDEX `fk_employee_has_facility_employee_idx` (`employee_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_employee_has_facility_employee`
    FOREIGN KEY (`employee_id`)
    REFERENCES `mi151_00_master_db`.`employee2` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_has_facility_facility1`
    FOREIGN KEY (`facility_id`)
    REFERENCES `mi151_00_master_db`.`facility` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`employee_has_schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`employee_has_schedule` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT NULL,
  `schedule_id` INT NULL,
  INDEX `fk_employee_has_schedule_schedule1_idx` (`schedule_id` ASC),
  INDEX `fk_employee_has_schedule_employee1_idx` (`employee_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_employee_has_schedule_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `mi151_00_master_db`.`employee2` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_has_schedule_schedule1`
    FOREIGN KEY (`schedule_id`)
    REFERENCES `mi151_00_master_db`.`schedule1` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`schedule_has_facility`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`schedule_has_facility` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `schedule_id` INT NULL,
  `facility_id` INT NULL,
  `facility_checklist_id` INT NULL,
  INDEX `fk_schedule_has_facility_facility1_idx` (`facility_id` ASC, `facility_checklist_id` ASC),
  INDEX `fk_schedule_has_facility_schedule1_idx` (`schedule_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_schedule_has_facility_schedule1`
    FOREIGN KEY (`schedule_id`)
    REFERENCES `mi151_00_master_db`.`schedule1` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_schedule_has_facility_facility1`
    FOREIGN KEY (`facility_id` , `facility_checklist_id`)
    REFERENCES `mi151_00_master_db`.`facility` (`id` , `checklist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`checklist_template`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`checklist_template` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `checklist_template_type` VARCHAR(10) NULL,
  `checklist_template_equipment` VARCHAR(45) NULL,
  `checklist_template_temperature` VARCHAR(45) NULL,
  `checklist_template_equipment_number` INT NULL,
  `checklist_template_equipment_description` VARCHAR(60) NULL,
  `checklist_id` INT NOT NULL,
  PRIMARY KEY (`id`, `checklist_id`),
  INDEX `fk_checklist_template_checklist1_idx` (`checklist_id` ASC),
  CONSTRAINT `fk_checklist_template_checklist1`
    FOREIGN KEY (`checklist_id`)
    REFERENCES `mi151_00_master_db`.`checklist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`room_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`room_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `room_type` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`room2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`room2` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `room_type_id` INT NOT NULL,
  `room_qr` BLOB NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_room_room_type_idx` (`room_type_id` ASC),
  CONSTRAINT `fk_room_room_type`
    FOREIGN KEY (`room_type_id`)
    REFERENCES `mi151_00_master_db`.`room_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`employee4`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`employee4` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `employee_fname` VARCHAR(45) NULL,
  `employee_lname` VARCHAR(45) NULL,
  `employee_mi` VARCHAR(3) NULL,
  `employee_position` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`housekeeping_log_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`housekeeping_log_details` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `housekeeping_log_details_checklist` VARCHAR(45) NULL,
  `housekeeping_log_details_status` VARCHAR(45) NULL,
  `housekeeping_log_details_timecompleted` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`housekeeping_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`housekeeping_log` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `room_id` INT NOT NULL,
  `room_room_type_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  `housekeeping_log_status` VARCHAR(45) NULL,
  `housekeeping_log_timein` DATETIME NULL,
  `housekeeping_log_timeout` DATETIME NULL,
  `cleaning_status` VARCHAR(45) NULL,
  `inspected_by_employee_id` INT NULL,
  `inspection_status` VARCHAR(45) NULL,
  `housekeeping_log_details_id` INT NOT NULL,
  PRIMARY KEY (`id`, `room_id`, `room_room_type_id`, `employee_id`, `housekeeping_log_details_id`),
  INDEX `fk_room_has_employee_employee1_idx` (`employee_id` ASC),
  INDEX `fk_room_has_employee_room1_idx` (`room_id` ASC, `room_room_type_id` ASC),
  INDEX `fk_housekeeping_log_housekeeping_log_details1_idx` (`housekeeping_log_details_id` ASC),
  CONSTRAINT `fk_room_has_employee_room1`
    FOREIGN KEY (`room_id` , `room_room_type_id`)
    REFERENCES `mi151_00_master_db`.`room2` (`id` , `room_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_room_has_employee_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `mi151_00_master_db`.`employee4` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_housekeeping_log_housekeeping_log_details1`
    FOREIGN KEY (`housekeeping_log_details_id`)
    REFERENCES `mi151_00_master_db`.`housekeeping_log_details` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`checklist_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`checklist_category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `checklist_category_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`checklist_ref`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`checklist_ref` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `checklist_description` VARCHAR(60) NULL,
  `checklist_category_id` INT NOT NULL,
  PRIMARY KEY (`id`, `checklist_category_id`),
  INDEX `fk_checklist_ref_checklist_category1_idx` (`checklist_category_id` ASC),
  CONSTRAINT `fk_checklist_ref_checklist_category1`
    FOREIGN KEY (`checklist_category_id`)
    REFERENCES `mi151_00_master_db`.`checklist_category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`checklist_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`checklist_items` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `checklist_ref_id` INT NOT NULL,
  `room_type_id` INT NOT NULL,
  PRIMARY KEY (`id`, `checklist_ref_id`, `room_type_id`),
  INDEX `fk_checklist_ref_has_room_type_room_type1_idx` (`room_type_id` ASC),
  INDEX `fk_checklist_ref_has_room_type_checklist_ref1_idx` (`checklist_ref_id` ASC),
  CONSTRAINT `fk_checklist_ref_has_room_type_checklist_ref1`
    FOREIGN KEY (`checklist_ref_id`)
    REFERENCES `mi151_00_master_db`.`checklist_ref` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_checklist_ref_has_room_type_room_type1`
    FOREIGN KEY (`room_type_id`)
    REFERENCES `mi151_00_master_db`.`room_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`employee3`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`employee3` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `emp_name` VARCHAR(45) NULL,
  `emp_surname` VARCHAR(45) NULL,
  `emp_dept` VARCHAR(45) NULL,
  `emp_position` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`attendee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`attendee` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `attendee_fname` VARCHAR(45) NOT NULL,
  `attendee_Surname` VARCHAR(45) NULL,
  `attendee_password` VARCHAR(45) NULL,
  `attendee_email` VARCHAR(45) NOT NULL,
  `attendee_birthdate` VARCHAR(45) NULL,
  `attendee_gender` VARCHAR(45) NULL,
  `attendee_contact_num` VARCHAR(45) NULL,
  `attendee_date_created` VARCHAR(45) NULL,
  `employee_id` INT NOT NULL,
  `employee_id1` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_attendee_employee1_idx` (`employee_id1` ASC),
  CONSTRAINT `fk_attendee_employee1`
    FOREIGN KEY (`employee_id1`)
    REFERENCES `mi151_00_master_db`.`employee3` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`event1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`event1` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `event_name` VARCHAR(120) NULL,
  `event_venue` VARCHAR(120) NULL,
  `event_start_date` DATE NULL,
  `event_end_date` DATE NULL,
  `event_type` VARCHAR(45) NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_event1_employee1_idx` (`employee_id` ASC),
  CONSTRAINT `fk_event1_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `mi151_00_master_db`.`employee3` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = euckr;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`landmark`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`landmark` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `landmark_name` VARCHAR(45) NULL,
  `landmark_address` VARCHAR(45) NULL,
  `landmark_distance_from_attendee` VARCHAR(45) NOT NULL,
  `event_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_landmark_event1_idx` (`event_id` ASC),
  CONSTRAINT `fk_landmark_event1`
    FOREIGN KEY (`event_id`)
    REFERENCES `mi151_00_master_db`.`event1` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`feedback`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`feedback` (
  `id` INT NOT NULL,
  `feedback_rating` VARCHAR(45) NULL,
  `feedback_comment` VARCHAR(45) NULL,
  `attendee_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  `event_id` INT NOT NULL,
  `employee_id1` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_feedback_user1_idx` (`attendee_id` ASC),
  INDEX `fk_feedback_event1_idx` (`event_id` ASC),
  INDEX `fk_feedback_employee1_idx` (`employee_id1` ASC),
  CONSTRAINT `fk_feedback_user1`
    FOREIGN KEY (`attendee_id`)
    REFERENCES `mi151_00_master_db`.`attendee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_feedback_event1`
    FOREIGN KEY (`event_id`)
    REFERENCES `mi151_00_master_db`.`event1` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_feedback_employee1`
    FOREIGN KEY (`employee_id1`)
    REFERENCES `mi151_00_master_db`.`employee3` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`venue`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`venue` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `venue_name` VARCHAR(120) NULL,
  `venue_address` VARCHAR(120) NULL,
  `venue_desc` VARCHAR(150) NULL,
  `venue_contact_num` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`room1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`room1` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `room_name` VARCHAR(45) NULL,
  `room_type` VARCHAR(45) NULL,
  `room_desc` VARCHAR(150) NULL,
  `room_capacity` INT NULL,
  `venue_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_room_venue1_idx` (`venue_id` ASC),
  CONSTRAINT `fk_room_venue1`
    FOREIGN KEY (`venue_id`)
    REFERENCES `mi151_00_master_db`.`venue` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`event_has_room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`event_has_room` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `event_id` INT NOT NULL,
  `room_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_event_has_room_event1_idx` (`event_id` ASC),
  INDEX `fk_event_has_room_room1_idx` (`room_id` ASC),
  CONSTRAINT `fk_event_has_room_event1`
    FOREIGN KEY (`event_id`)
    REFERENCES `mi151_00_master_db`.`event1` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_has_room_room1`
    FOREIGN KEY (`room_id`)
    REFERENCES `mi151_00_master_db`.`room1` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = euckr;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`event_schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`event_schedule` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `event_speaker` VARCHAR(45) NULL,
  `event_time` VARCHAR(45) NULL,
  `event_id` INT NOT NULL,
  `event_has_room_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_event_schedule_event1_idx` (`event_id` ASC),
  INDEX `fk_event_schedule_event_has_room1_idx` (`event_has_room_id` ASC),
  CONSTRAINT `fk_event_schedule_event1`
    FOREIGN KEY (`event_id`)
    REFERENCES `mi151_00_master_db`.`event1` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_schedule_event_has_room1`
    FOREIGN KEY (`event_has_room_id`)
    REFERENCES `mi151_00_master_db`.`event_has_room` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`collaboration_space_has_attendee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`collaboration_space_has_attendee` (
  `id` INT NOT NULL,
  `attendee_id` INT NOT NULL,
  `collaboration_space_attendee_id` INT NOT NULL,
  `message` VARCHAR(140) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_collaboration_space_has_attendee_attendee1_idx` (`attendee_id` ASC),
  CONSTRAINT `fk_collaboration_space_has_attendee_attendee1`
    FOREIGN KEY (`attendee_id`)
    REFERENCES `mi151_00_master_db`.`attendee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`event_collaboration`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`event_collaboration` (
  `collaboration_id` INT NOT NULL,
  `message` VARCHAR(140) NULL,
  `date` DATE NULL,
  `time` VARCHAR(45) NULL,
  `event_id` INT NOT NULL,
  `attendee_id` INT NOT NULL,
  PRIMARY KEY (`collaboration_id`),
  INDEX `fk_event_collaboration_event1_idx` (`event_id` ASC),
  INDEX `fk_event_collaboration_attendee1_idx` (`attendee_id` ASC),
  CONSTRAINT `fk_event_collaboration_event1`
    FOREIGN KEY (`event_id`)
    REFERENCES `mi151_00_master_db`.`event1` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_collaboration_attendee1`
    FOREIGN KEY (`attendee_id`)
    REFERENCES `mi151_00_master_db`.`attendee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`newsfeed`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`newsfeed` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `newsfeed_post` VARCHAR(140) NULL,
  `newsfeed_comment` VARCHAR(45) NULL,
  `attendee_id` INT NOT NULL,
  `event_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_newsfeed_attendee1_idx` (`attendee_id` ASC),
  INDEX `fk_newsfeed_event1_idx` (`event_id` ASC),
  CONSTRAINT `fk_newsfeed_attendee1`
    FOREIGN KEY (`attendee_id`)
    REFERENCES `mi151_00_master_db`.`attendee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_newsfeed_event1`
    FOREIGN KEY (`event_id`)
    REFERENCES `mi151_00_master_db`.`event1` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`customer1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`customer1` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`room` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `room_type` VARCHAR(45) NOT NULL,
  `room_loc` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`check_in`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`check_in` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `room_id` INT NOT NULL,
  `check_in` DATE NOT NULL,
  `check_out` DATE NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ticket_room1_idx` (`room_id` ASC),
  INDEX `fk_ticket_customer1_idx` (`customer_id` ASC),
  CONSTRAINT `fk_ticket_room1X`
    FOREIGN KEY (`room_id`)
    REFERENCES `mi151_00_master_db`.`room` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_customer1X`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mi151_00_master_db`.`customer1` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`department` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dept_name` VARCHAR(45) NOT NULL,
  `dept_description` TEXT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`employee1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`employee1` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `department_id` INT NOT NULL,
  `fname` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `position` VARCHAR(45) NOT NULL,
  `supervisor` INT NOT NULL,
  `sched_start` TIME NOT NULL,
  `sched_end` TIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_employee_department1_idx` (`department_id` ASC),
  INDEX `fk_employee_employee1_idx` (`supervisor` ASC),
  CONSTRAINT `fk_employee_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `mi151_00_master_db`.`department` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_employee1`
    FOREIGN KEY (`supervisor`)
    REFERENCES `mi151_00_master_db`.`employee1` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `department_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `desc` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_category_department1_idx` (`department_id` ASC),
  CONSTRAINT `fk_category_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `mi151_00_master_db`.`department` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`ticket` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(45) NOT NULL,
  `time_start` TIMESTAMP NOT NULL,
  `time_end` TIMESTAMP NULL,
  `time_alloted` TIME NOT NULL,
  `escalation_level` INT NOT NULL,
  `desc` TEXT NOT NULL,
  `check_in_id` INT NOT NULL,
  `emp_repond_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  `emp_create_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ticket_check_in1_idx` (`check_in_id` ASC),
  INDEX `fk_ticket_employee1_idx` (`emp_repond_id` ASC),
  INDEX `fk_ticket_category1_idx` (`category_id` ASC),
  INDEX `fk_ticket_employee2_idx` (`emp_create_id` ASC),
  CONSTRAINT `fk_ticket_check_in1`
    FOREIGN KEY (`check_in_id`)
    REFERENCES `mi151_00_master_db`.`check_in` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_employee1`
    FOREIGN KEY (`emp_repond_id`)
    REFERENCES `mi151_00_master_db`.`employee1` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `mi151_00_master_db`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_employee2`
    FOREIGN KEY (`emp_create_id`)
    REFERENCES `mi151_00_master_db`.`employee1` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`transcript`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`transcript` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ticket_id` INT NOT NULL,
  `description` TEXT NOT NULL,
  `time` TIMESTAMP NOT NULL,
  `by_employee` INT NOT NULL,
  `current_emp_resp` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_transcript_ticket1_idx` (`ticket_id` ASC),
  INDEX `fk_transcript_employee1_idx` (`by_employee` ASC),
  INDEX `fk_transcript_employee2_idx` (`current_emp_resp` ASC),
  CONSTRAINT `fk_transcript_ticket1`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `mi151_00_master_db`.`ticket` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transcript_employee1`
    FOREIGN KEY (`by_employee`)
    REFERENCES `mi151_00_master_db`.`employee1` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transcript_employee2`
    FOREIGN KEY (`current_emp_resp`)
    REFERENCES `mi151_00_master_db`.`employee1` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi151_00_master_db`.`customer_preference`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi151_00_master_db`.`customer_preference` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `preference_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_customer_has_preference_preference1_idx` (`preference_id` ASC),
  INDEX `fk_customer_has_preference_customer1_idx` (`customer_id` ASC),
  CONSTRAINT `fk_customer_has_preference_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mi151_00_master_db`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_has_preference_preference1`
    FOREIGN KEY (`preference_id`)
    REFERENCES `mi151_00_master_db`.`preference` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
