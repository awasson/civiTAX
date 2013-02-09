CREATE TABLE IF NOT EXISTS `civi_tax_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tax` varchar(45) NOT NULL,
  `rate` decimal(4,2) NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id` ASC)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `civicrm`.`civi_tax_invoicing` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `invoice_id` VARCHAR(255) NOT NULL DEFAULT 0 ,
  `pre_tax` FLOAT NOT NULL DEFAULT 0 ,
  `tax` FLOAT NOT NULL DEFAULT 0 ,
  `tax_charged` FLOAT NOT NULL DEFAULT 0 ,
  `post_tax` FLOAT NOT NULL DEFAULT 0 ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) 
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `civi_tax_contribution_type` (
  `tax_id` int(11) NOT NULL,
  `contribution_type_id` int(11) NOT NULL,
  KEY `tax_id` (`tax_id`),
  CONSTRAINT `civi_tax_contribution_type_ibfk_1` FOREIGN KEY (`tax_id`) REFERENCES `civi_tax_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;