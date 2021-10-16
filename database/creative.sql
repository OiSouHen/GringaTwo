CREATE DATABASE IF NOT EXISTS `creative`;
USE `creative`;

DROP TABLE IF EXISTS `vrp_barbershop`;
CREATE TABLE `vrp_barbershop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `fathers` int(11) NOT NULL DEFAULT 0,
  `kinship` int(11) NOT NULL DEFAULT 0,
  `eyecolor` int(11) NOT NULL DEFAULT 0,
  `skincolor` int(11) NOT NULL DEFAULT 0,
  `acne` int(11) NOT NULL DEFAULT 0,
  `stains` int(11) NOT NULL DEFAULT 0,
  `freckles` int(11) NOT NULL DEFAULT 0,
  `aging` int(11) NOT NULL DEFAULT 15,
  `hair` int(11) NOT NULL DEFAULT 0,
  `haircolor` int(11) NOT NULL DEFAULT 0,
  `haircolor2` int(11) NOT NULL DEFAULT 0,
  `makeup` int(11) NOT NULL DEFAULT 0,
  `makeupintensity` int(11) NOT NULL DEFAULT 0,
  `makeupcolor` int(11) NOT NULL DEFAULT 0,
  `lipstick` int(11) NOT NULL DEFAULT 0,
  `lipstickintensity` int(11) NOT NULL DEFAULT 0,
  `lipstickcolor` int(11) NOT NULL DEFAULT 0,
  `eyebrow` int(11) NOT NULL DEFAULT 0,
  `eyebrowintensity` int(11) NOT NULL DEFAULT 10,
  `eyebrowcolor` int(11) NOT NULL DEFAULT 0,
  `beard` int(11) NOT NULL DEFAULT 0,
  `beardintentisy` int(11) NOT NULL DEFAULT 10,
  `beardcolor` int(11) NOT NULL DEFAULT 0,
  `blush` int(11) NOT NULL DEFAULT 0,
  `blushintentisy` int(11) NOT NULL DEFAULT 0,
  `blushcolor` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `vrp_chests`;
CREATE TABLE `vrp_chests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permiss` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `x` text NOT NULL,
  `y` text NOT NULL,
  `z` text NOT NULL,
  `grid` int(11) NOT NULL DEFAULT 0,
  `weight` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `vrp_fines`;
CREATE TABLE `vrp_fines` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `nuser_id` int(11) NOT NULL DEFAULT 0,
  `date` varchar(25) NOT NULL DEFAULT '0.0.0',
  `price` int(11) NOT NULL DEFAULT 0,
  `text` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `nuser_id` (`nuser_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `vrp_homes`;
CREATE TABLE `vrp_homes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `home` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL,
  `owner` int(1) NOT NULL DEFAULT 0,
  `vault` int(5) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`home`,`user_id`) USING BTREE,
  KEY `home` (`home`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `vrp_infos`;
CREATE TABLE `vrp_infos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(50) NOT NULL,
  `whitelist` tinyint(1) DEFAULT 0,
  `banned` tinyint(1) DEFAULT 0,
  `gems` int(11) NOT NULL DEFAULT 0,
  `premium` int(12) NOT NULL DEFAULT 0,
  `predays` int(2) NOT NULL DEFAULT 0,
  `priority` int(3) NOT NULL DEFAULT 0,
  `chars` int(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `steam` (`steam`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `vrp_invoice`;
CREATE TABLE `vrp_invoice` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `nuser_id` int(11) NOT NULL DEFAULT 0,
  `date` varchar(25) NOT NULL DEFAULT '0.0.0',
  `price` int(11) NOT NULL DEFAULT 0,
  `text` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `nuser_id` (`nuser_id`),
  KEY `user_id` (`user_id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `vrp_permissions`;
CREATE TABLE `vrp_permissions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 1,
  `permiss` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `vrp_player_houses`;
CREATE TABLE `vrp_player_houses` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `house` varchar(50) NOT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `keyholders` text DEFAULT NULL,
  `decorations` text DEFAULT NULL,
  `stash` text DEFAULT NULL,
  `outfit` text DEFAULT NULL,
  `logout` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 CHECKSUM=1;

DROP TABLE IF EXISTS `vrp_races`;
CREATE TABLE `vrp_races` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `vehicle` varchar(250) NOT NULL,
  `raceid` int(11) NOT NULL DEFAULT 0,
  `points` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `vrp_salary`;
CREATE TABLE `vrp_salary` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `date` varchar(25) DEFAULT NULL,
  `price` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `vrp_srv_data`;
CREATE TABLE `vrp_srv_data` (
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`dkey`),
  KEY `dkey` (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `vrp_user_data`;
CREATE TABLE `vrp_user_data` (
  `user_id` int(11) NOT NULL,
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`user_id`,`dkey`),
  KEY `user_id` (`user_id`),
  KEY `dkey` (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `vrp_users`;
CREATE TABLE `vrp_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(100) DEFAULT NULL,
  `registration` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `name` varchar(50) DEFAULT 'Lucas',
  `name2` varchar(50) DEFAULT 'Hen',
  `bank` int(12) NOT NULL DEFAULT 1500,
  `garage` int(3) NOT NULL DEFAULT 2,
  `prison` int(6) NOT NULL DEFAULT 0,
  `locate` int(1) NOT NULL DEFAULT 1,
  `loc` varchar(5) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT 'Sul',
  `deleted` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `vrp_vehicles`;
CREATE TABLE `vrp_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `plate` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `arrest` int(1) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0,
  `premiumtime` int(11) NOT NULL DEFAULT 0,
  `rentaltime` int(11) NOT NULL DEFAULT 0,
  `engine` int(4) NOT NULL DEFAULT 1000,
  `body` int(4) NOT NULL DEFAULT 1000,
  `fuel` int(3) NOT NULL DEFAULT 100,
  `work` varchar(10) NOT NULL DEFAULT 'false',
  `doors` varchar(254) NOT NULL,
  `windows` varchar(254) NOT NULL,
  `tyres` varchar(254) NOT NULL,
  PRIMARY KEY (`id`,`user_id`,`vehicle`) USING BTREE,
  KEY `user_id` (`user_id`),
  KEY `vehicle` (`vehicle`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `vrp_weapons`;
CREATE TABLE `vrp_weapons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `weapon` text NOT NULL,
  `ammo` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;