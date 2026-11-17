CREATE TABLE IF NOT EXISTS `users` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `license` VARCHAR(100) NOT NULL,
    `discord` VARCHAR(100) DEFAULT NULL,
    `ip` VARCHAR(50) DEFAULT NULL,
    `admin` INT DEFAULT NULL,
    `cash` INT DEFAULT NULL,
    `bank` INT DEFAULT NULL,
    `health` INT DEFAULT NULL,
    `armor` INT DEFAULT NULL,
    `position` LONGTEXT DEFAULT NULL,
    `hunger` INT DEFAULT NULL,
    `thirst` INT DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `license` (`license`)
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_general_ci;
