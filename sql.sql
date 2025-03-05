CREATE TABLE `jobs_account` (
	`job` VARCHAR(60) NOT NULL,
	`account` INT(11) NOT NULL,
	PRIMARY KEY (`job`) USING BTREE,
	INDEX `account` (`account`) USING BTREE
) ENGINE=InnoDB;