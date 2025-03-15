CREATE TABLE IF NOT EXISTS `jobs_account` (
	`job` VARCHAR(60) NOT NULL,
	`account` INT(11) NOT NULL,
	PRIMARY KEY (`job`) USING BTREE,
	INDEX `account` (`account`) USING BTREE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `jobs_activity` (
	`id` VARCHAR(60) NOT NULL,
	`job` VARCHAR(60) NOT NULL,
	`playtime` INT(11) NOT NULL,
	`lastcheckout` VARCHAR(60) NOT NULL,
	`lastcheckin` VARCHAR(60) NOT NULL,
	INDEX `id` (`id`) USING BTREE,
	INDEX `job` (`job`) USING BTREE,
	INDEX `playtime` (`playtime`) USING BTREE,
	INDEX `lastcheckout` (`lastcheckout`) USING BTREE,
	INDEX `lastcheckin` (`lastcheckin`) USING BTREE
) ENGINE=InnoDB;