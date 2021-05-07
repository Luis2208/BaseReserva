-- MySQL Script generated by MySQL Workbench
-- Tue Feb 26 12:20:32 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema basereserva
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema basereserva
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `basereserva` DEFAULT CHARACTER SET utf8 ;
USE `basereserva` ;

-- -----------------------------------------------------
-- Table `basereserva`.`Habitación`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `basereserva`.`Habitación` (
  `idHabitación` INT NOT NULL AUTO_INCREMENT,
  `numero` VARCHAR(4) NOT NULL,
  `piso` VARCHAR(2) NOT NULL,
  `descripcion` VARCHAR(255) NULL,
  `caracteristicas` VARCHAR(512) NULL,
  `precio_diario` DECIMAL(7,2) NOT NULL,
  `estado` VARCHAR(15) NOT NULL,
  `tipo_habitacion` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idHabitación`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `basereserva`.`Persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `basereserva`.`Persona` (
  `idPersona` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  `apaterno` VARCHAR(20) NOT NULL,
  `amaterno` VARCHAR(20) NOT NULL,
  `tipo_documento` VARCHAR(15) NOT NULL,
  `num_documento` VARCHAR(8) NOT NULL,
  `direccion` VARCHAR(100) NULL,
  `telefono` VARCHAR(8) NULL,
  `email` VARCHAR(25) NULL,
  `Personacol` VARCHAR(45) NULL,
  PRIMARY KEY (`idPersona`),
  UNIQUE INDEX `telefono_UNIQUE` (`telefono` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `basereserva`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `basereserva`.`Cliente` (
  `idPersona` INT NOT NULL,
  `codigo_cliente` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idPersona`),
  UNIQUE INDEX `codigo_cliente_UNIQUE` (`codigo_cliente` ASC),
  CONSTRAINT `fk_Persona_Cliente`
    FOREIGN KEY (`idPersona`)
    REFERENCES `basereserva`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `basereserva`.`Trabajador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `basereserva`.`Trabajador` (
  `idPersona` INT NOT NULL,
  `sueldo` DECIMAL(7,2) NOT NULL,
  `acceso` VARCHAR(15) NOT NULL,
  `login` VARCHAR(15) NOT NULL,
  `password` VARCHAR(20) NOT NULL,
  `estado` VARCHAR(1) NOT NULL,
  PRIMARY KEY (`idPersona`),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC),
  CONSTRAINT `fk_persona_trabajador`
    FOREIGN KEY (`idPersona`)
    REFERENCES `basereserva`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `basereserva`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `basereserva`.`Producto` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `decripcion` VARCHAR(255) NULL,
  `unidad_medida` VARCHAR(20) NOT NULL,
  `precio_venta` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`idProducto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `basereserva`.`Reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `basereserva`.`Reserva` (
  `idReserva` INT NOT NULL AUTO_INCREMENT,
  `idHabitacion` INT NOT NULL,
  `idCliente` INT NOT NULL,
  `idTrabajador` INT NOT NULL,
  `tipo_reserva` VARCHAR(20) NOT NULL,
  `fecha_reserva` DATE NOT NULL,
  `fecha_ingresa` DATE NOT NULL,
  `fecha_salida` DATE NOT NULL,
  `costo_alojamiento` DECIMAL(7,2) NOT NULL,
  `estado` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idReserva`),
  INDEX `fk_Reserva_Habitacion_idx` (`idHabitacion` ASC),
  INDEX `fk_Reserva_Cliente_idx` (`idCliente` ASC),
  INDEX `fk_Reserva_Trabajador_idx` (`idTrabajador` ASC),
  CONSTRAINT `fk_Reserva_Habitacion`
    FOREIGN KEY (`idHabitacion`)
    REFERENCES `basereserva`.`Habitación` (`idHabitación`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reserva_Cliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES `basereserva`.`Cliente` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reserva_Trabajador`
    FOREIGN KEY (`idTrabajador`)
    REFERENCES `basereserva`.`Trabajador` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `basereserva`.`Consumo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `basereserva`.`Consumo` (
  `idConsumo` INT NOT NULL AUTO_INCREMENT,
  `idReserva` INT NOT NULL,
  `idProducto` INT NOT NULL,
  `cantidad` DECIMAL(7,2) NOT NULL,
  `precio_venta` DECIMAL(7,2) NOT NULL,
  `estado` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idConsumo`),
  INDEX `fk_Consumo_Producto_idx` (`idProducto` ASC),
  INDEX `fk_Consumo_Reserva_idx` (`idReserva` ASC),
  CONSTRAINT `fk_Consumo_Producto`
    FOREIGN KEY (`idProducto`)
    REFERENCES `basereserva`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consumo_Reserva`
    FOREIGN KEY (`idReserva`)
    REFERENCES `basereserva`.`Reserva` (`idReserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `basereserva`.`Pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `basereserva`.`Pago` (
  `idPago` INT NOT NULL AUTO_INCREMENT,
  `idReserva` INT NOT NULL,
  `tipo_comprobante` VARCHAR(20) NOT NULL,
  `num_comprobante` VARCHAR(20) NOT NULL,
  `igv` DECIMAL(4,2) NOT NULL,
  `total_pago` DECIMAL(7,2) NOT NULL,
  `fecha_emision` DATE NOT NULL,
  `fecha_pago` DATE NOT NULL,
  PRIMARY KEY (`idPago`),
  INDEX `fk_Pago_Reserva_idx` (`idReserva` ASC),
  CONSTRAINT `fk_Pago_Reserva`
    FOREIGN KEY (`idReserva`)
    REFERENCES `basereserva`.`Reserva` (`idReserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;