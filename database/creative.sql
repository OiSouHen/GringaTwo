CREATE DATABASE IF NOT EXISTS `creative`;
USE `creative`;

DROP TABLE IF EXISTS `phone_chat`;
CREATE TABLE `phone_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `phone_calls`;
CREATE TABLE `phone_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(10) NOT NULL COMMENT 'Meu número',
  `num` varchar(10) NOT NULL COMMENT 'Número do contato',
  `incoming` int(11) NOT NULL COMMENT 'Origem da chamada',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepts` int(11) NOT NULL COMMENT 'Chamada aceita ou não',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `phone_messages`;
CREATE TABLE `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transmitter` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `phone_contacts`;
CREATE TABLE `phone_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `barbershop`;
CREATE TABLE `barbershop` (
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

DROP TABLE IF EXISTS `benefactor`;
CREATE TABLE `benefactor` (
  `vehicle` varchar(50) NOT NULL,
  `estoque` int(11) NOT NULL DEFAULT -1,
  PRIMARY KEY (`vehicle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Sobre: Tabela aonde é definido o estoque dos veiculos\r\nColunas: \r\n• vehicle = Nome de Spawn do Veiculo;\r\n• estoque = Quantidade disponivel em estoque (-1 para estoque infinito);\r\n';

DROP TABLE IF EXISTS `chests`;
CREATE TABLE `chests` (
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

DROP TABLE IF EXISTS `fines`;
CREATE TABLE `fines` (
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

DROP TABLE IF EXISTS `homes`;
CREATE TABLE `homes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `home` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL,
  `owner` int(1) NOT NULL DEFAULT 0,
  `vault` int(5) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`home`,`user_id`) USING BTREE,
  KEY `home` (`home`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `houses`;
CREATE TABLE `houses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `coords` text DEFAULT NULL,
  `owned` tinyint(2) DEFAULT 0,
  `price` int(11) DEFAULT NULL,
  `tier` tinyint(2) DEFAULT NULL,
  `garage` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 CHECKSUM=1;

DROP TABLE IF EXISTS `infos`;
CREATE TABLE `infos` (
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

DROP TABLE IF EXISTS `invoice`;
CREATE TABLE `invoice` (
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

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 1,
  `permiss` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `player_houses`;
CREATE TABLE `player_houses` (
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

DROP TABLE IF EXISTS `races`;
CREATE TABLE `races` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `vehicle` varchar(250) NOT NULL,
  `raceid` int(11) NOT NULL DEFAULT 0,
  `points` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `salary`;
CREATE TABLE `salary` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `date` varchar(25) DEFAULT NULL,
  `price` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `srv_data`;
CREATE TABLE `srv_data` (
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`dkey`),
  KEY `dkey` (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `user_data`;
CREATE TABLE `user_data` (
  `user_id` int(11) NOT NULL,
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`user_id`,`dkey`),
  KEY `user_id` (`user_id`),
  KEY `dkey` (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(100) DEFAULT NULL,
  `registration` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `name` varchar(50) DEFAULT 'Lucas',
  `name2` varchar(50) DEFAULT 'Hen',
  `bank` int(12) NOT NULL DEFAULT 4500,
  `garage` int(3) NOT NULL DEFAULT 2,
  `prison` int(6) NOT NULL DEFAULT 0,
  `locate` int(1) NOT NULL DEFAULT 1,
  `deleted` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE `vehicles` (
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

DROP TABLE IF EXISTS `weapons`;
CREATE TABLE `weapons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `weapon` text NOT NULL,
  `ammo` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;