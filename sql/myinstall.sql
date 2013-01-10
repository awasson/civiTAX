CREATE TABLE IF NOT EXISTS `civi_tax_type` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `tax` VARCHAR(45) NOT NULL ,
  `rate` DECIMAL(4,2) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `civicrm`.`civi_tax_invoicing` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `invoice_id` VARCHAR(255) NOT NULL DEFAULT 0 ,
  `pre_tax` FLOAT NOT NULL DEFAULT 0 ,
  `tax` FLOAT NOT NULL DEFAULT 0 ,
  `tax_charged` FLOAT NOT NULL DEFAULT 0 ,
  `post_tax` FLOAT NOT NULL DEFAULT 0 ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
ENGINE = InnoDB;