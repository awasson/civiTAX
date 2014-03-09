CREATE TABLE IF NOT EXISTS `civi_tax_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tax` varchar(45) NOT NULL,
  `rate` decimal(4,2) NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id` ASC)
) ENGINE=InnoDB; CHARSET=utf8 COLLATE=utf8_unicode_ci$$



CREATE TABLE `civi_tax_invoicing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_id` varchar(255) NOT NULL DEFAULT '0',
  `tax_id` int(11) NOT NULL,
  `tax_name` varchar(45) NOT NULL,
  `pre_tax` varchar(7) NOT NULL DEFAULT '0',
  `tax_rate` varchar(7) NOT NULL DEFAULT '0',
  `tax_charged` varchar(45) NOT NULL DEFAULT '0',
  `post_tax` varchar(45) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) 
) ENGINE = InnoDB; CHARSET=utf8 COLLATE=utf8_unicode_ci$$



CREATE TABLE IF NOT EXISTS `civi_tax_contribution_type` (
  `tax_id` int(11) NOT NULL,
  `contribution_type_id` int(11) NOT NULL,
  KEY `tax_id` (`tax_id`),
  CONSTRAINT `civi_tax_contribution_type_ibfk_1` FOREIGN KEY (`tax_id`) REFERENCES `civi_tax_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB; CHARSET=utf8 COLLATE=utf8_unicode_ci$$