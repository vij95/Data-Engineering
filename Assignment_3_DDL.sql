SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
SET SQL_SAFE_UPDATES=0; 

USE `sakila_snowflake` ;

CREATE TABLE IF NOT EXISTS `sakila_snowflake`.`fact_rental` (
  `rental_id` INT(10) NOT NULL,
  `rental_last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `customer_key` INT(8) NOT NULL,
  `staff_key` INT(8) NOT NULL,
  `film_key` INT(8) NOT NULL,
  `store_key` INT(8) NOT NULL,
  `rental_date_key` BIGINT(20) NOT NULL,
  `return_date_key` BIGINT(20) NULL DEFAULT NULL,
  `count_returns` INT(10) NOT NULL,
  `count_rentals` INT(8) NOT NULL,
  `rental_duration` INT(10) NULL DEFAULT NULL,
  `dollar_amount` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`rental_id`),
  INDEX `dim_customer_fact_rental_fk` (`customer_key` ASC),
  INDEX `dim_staff_1_fact_rental_fk` (`staff_key` ASC),
  INDEX `dim_film_fact_rental_fk` (`film_key` ASC),
  INDEX `dim_store_fact_rental_fk` (`store_key` ASC),
  INDEX `dim_date_fact_rental_1_fk` (`rental_date_key` ASC),
  INDEX `dim_date_fact_rental_2_fk` (`return_date_key` ASC),
  CONSTRAINT `dim_customer_fact_rental_fk`
    FOREIGN KEY (`customer_key`)
    REFERENCES `sakila_snowflake`.`dim_customer` (`customer_key`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `dim_staff_1_fact_rental_fk`
    FOREIGN KEY (`staff_key`)
    REFERENCES `sakila_snowflake`.`dim_staff` (`staff_key`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `dim_film_fact_rental_fk`
    FOREIGN KEY (`film_key`)
    REFERENCES `sakila_snowflake`.`dim_film` (`film_key`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `dim_store_fact_rental_fk`
    FOREIGN KEY (`store_key`)
    REFERENCES `sakila_snowflake`.`dim_store` (`store_key`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `dim_staff_fact_rental_fk`
    FOREIGN KEY (`rental_date_key`)
    REFERENCES `sakila_snowflake`.`dim_date` (`date_Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `dim_date_fact_rental_1_fk`
    FOREIGN KEY (`rental_date_key`)
    REFERENCES `sakila_snowflake`.`dim_date` (`date_Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `dim_date_fact_rental_2_fk`
    FOREIGN KEY (`return_date_key`)
    REFERENCES `sakila_snowflake`.`dim_date` (`date_Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
