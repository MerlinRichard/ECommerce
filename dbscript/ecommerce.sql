/*
SQLyog Community v13.1.8 (64 bit)
MySQL - 8.0.35 : Database - ecommerce
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ecommerce` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `ecommerce`;

/*Table structure for table `tblcart` */

DROP TABLE IF EXISTS `tblcart`;

CREATE TABLE `tblcart` (
  `fldCart_ID` int NOT NULL AUTO_INCREMENT,
  `fldUserId` int NOT NULL,
  `fldActive` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`fldCart_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tblcart` */

insert  into `tblcart`(`fldCart_ID`,`fldUserId`,`fldActive`) values 
(10,40,0),
(11,40,0),
(12,34,0),
(13,34,0),
(14,34,0),
(15,34,0),
(16,34,0),
(17,34,1),
(18,42,0),
(19,42,0),
(20,42,0),
(21,43,1),
(22,47,1),
(23,49,1),
(24,40,0);

/*Table structure for table `tblorder` */

DROP TABLE IF EXISTS `tblorder`;

CREATE TABLE `tblorder` (
  `fldOrder_ID` int NOT NULL AUTO_INCREMENT,
  `fldUserId` int NOT NULL,
  `fldCartId` int NOT NULL,
  `fldAmount` float NOT NULL,
  `fldStatus` varchar(30) NOT NULL,
  `fldAddress` varchar(100) NOT NULL,
  PRIMARY KEY (`fldOrder_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tblorder` */

insert  into `tblorder`(`fldOrder_ID`,`fldUserId`,`fldCartId`,`fldAmount`,`fldStatus`,`fldAddress`) values 
(18,34,12,135000,'Processing','test address'),
(19,34,15,242000,'Processing','dawfd'),
(20,42,18,119457,'Processing','test'),
(21,40,24,854.18,'Processing','anjana villa');

/*Table structure for table `tblorderitem` */

DROP TABLE IF EXISTS `tblorderitem`;

CREATE TABLE `tblorderitem` (
  `fldOrderItem_ID` int NOT NULL AUTO_INCREMENT,
  `fldUserId` int NOT NULL,
  `fldProductId` int NOT NULL,
  `fldQuantity` int NOT NULL,
  `fldActive` int NOT NULL DEFAULT '1',
  `fldCartId` int NOT NULL,
  KEY `fldCart_ID` (`fldOrderItem_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tblorderitem` */

insert  into `tblorderitem`(`fldOrderItem_ID`,`fldUserId`,`fldProductId`,`fldQuantity`,`fldActive`,`fldCartId`) values 
(33,40,2,7,0,10),
(34,40,3,3,0,10),
(35,40,2,1,0,11),
(36,34,2,3,0,12),
(37,34,11,2,0,13),
(38,34,10,2,0,14),
(39,34,2,2,0,15),
(40,34,4,1,0,15),
(41,34,1,1,0,15),
(42,34,1,1,0,16),
(43,34,2,1,0,16),
(44,34,1,1,1,17),
(45,42,1,1,0,18),
(46,42,11,2,0,18),
(47,42,3,1,0,18),
(48,42,3,1,0,19),
(49,42,6,1,0,20),
(50,42,3,1,0,20),
(51,43,2,1,1,21),
(52,47,3,1,1,22),
(53,49,1,1,1,23),
(54,40,10,2,0,24),
(55,40,12,1,0,24);

/*Table structure for table `tblproduct` */

DROP TABLE IF EXISTS `tblproduct`;

CREATE TABLE `tblproduct` (
  `fldProduct_ID` int NOT NULL AUTO_INCREMENT,
  `fldProductName` varchar(50) NOT NULL,
  `fldFilePath` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fldPrice` float NOT NULL,
  `fldDescription` varchar(200) DEFAULT NULL,
  `fldCategory` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fldStock` int NOT NULL,
  `fldBrand` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fldDiscount` int DEFAULT NULL,
  `fldActive` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`fldProduct_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tblproduct` */

insert  into `tblproduct`(`fldProduct_ID`,`fldProductName`,`fldFilePath`,`fldPrice`,`fldDescription`,`fldCategory`,`fldStock`,`fldBrand`,`fldDiscount`,`fldActive`) values 
(1,'Apple iPhone 15 128GB Black','apple-iphone-15-128gb-black-digital.jpg',70000,'An apple mobile which is nothing like apple','electronics',20,'Apple',5,1),
(2,'Apple iPhone 15 128GB Pink','apple-iphone-15-128gb-blue-digital.jpg',50000,'Apple iPhone 15 128GB Pink','electronics',10,'Apple',10,1),
(3,'Apple iPhone 15 128GB Blue','apple-iphone-15-128gb-green-digital.jpg',79000,'Apple iPhone 15 128GB Blue','electronics',5,'Apple',7,1),
(4,'Realme 8, 128 GB, 6 GB RAM','ecmered-scratch-resistant-matte-tempered-glass-for-realme-x7-pro.jpg',90000,'Samsung Galaxy M14 5G 128 GB, 6 GB RAM, Icy Silver, Mobile Phone','electronics',30,'Apple',5,1),
(5,'Samsung Galaxy M14 5G 128 GB, 6 GB RAM, Smoky Teal','samsung-galaxy-m14-5g-128-gb-6-gb-ram-smoky-teal-smartphone-digital.jpg',60000,'Samsung Galaxy M14 5G 128 GB, 6 GB RAM, Smoky Teal, Mobile Phone','electronics',8,'Apple',2,1),
(6,'OnePlus Nord 3 5G 128 GB 8 GB RAM Misty Green, Mob','oneplus-nord-3-5g-128-gb-8-gb-ram-misty-green-mobile-phone-digital.jpg',50000,'OnePlus Nord 3 5G 128 GB 8 GB RAM Misty Green, Mobile Phone','electronics',19,'Samsung',9,1),
(7,'JioDive 360 VR Headset. Enjoy live cricket ','jiodive-360-vr-headset-live-cricket-entertainment.jpg',4000,NULL,'electronics',12,'Apple',4,1),
(8,'Realme Narzo N53, 4GB RAM, 64GB ROM, Feather Gold,','realme-narzo-n53-4gb-ram-64gb-rom-feather.jpg',2000,NULL,'electronics',100,'Apple',3,1),
(9,'JioPhone Prima 4G Premium Design Phone','jiophone-prima-4g-premium-design-phone.jpg',2599,NULL,'electronics',200,'Jio',2,1),
(10,'RRHR SALES Long Selfie Stick Compatible','rrhr-sales-long-selfie-stick-compatible-with-all-smartphonesjpg',328,NULL,'electronics',300,'Samsung',4,1),
(11,'SwapME Silicone Smart Band Straps','swapme-silicone-smart-band-straps-men-and-women-for-oneplus-and-oppo-smart-band.jpg',246,NULL,'electronics',50,'OnePlus',1,1),
(12,'EPHEMERAL Screen Magnifier 2 for Smartphone','ephemeral-screen-magnifier-2-for-smartphone-mobile.jpg',229,NULL,'electronics',40,'OnePlus',2,1);

/*Table structure for table `tbluser` */

DROP TABLE IF EXISTS `tbluser`;

CREATE TABLE `tbluser` (
  `fldUser_ID` int NOT NULL AUTO_INCREMENT,
  `fldFirstName` varchar(50) NOT NULL,
  `fldLastName` varchar(50) NOT NULL,
  `fldEmail` varchar(50) NOT NULL,
  `fldPassword` varchar(50) NOT NULL,
  PRIMARY KEY (`fldUser_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tbluser` */

insert  into `tbluser`(`fldUser_ID`,`fldFirstName`,`fldLastName`,`fldEmail`,`fldPassword`) values 
(34,'Merlin','Richard','merlin@gmail.com','52D74A022625525529F6B344EA7B738C'),
(37,'Hari','H','hari@gmail.com','C7D43EA9B317EB872E0E86A4E79319E7'),
(38,'Linta','L','Linta@gmail.com','987D71714C7616C50CEDC905FF438D8A'),
(39,'Miya','M','miya@gmail.com','C08351E4EA21298FB38544A0CFA6575C'),
(40,'Anjana','S','anjana@gmail.com','27054DECB8AFF1FB5B9CC299D48FDACC'),
(41,'MMfghdh','EE','mm@gmail.com','D4C73BAAC2D8DC27CC038CBED452C461'),
(42,'Leena','S','leena@gmail.com','600A425BC91E306349FD80E9F046D250'),
(48,'dsgfs','fgfdg','merlin@tech.com','6C5EFA76050618E18D526A55C471EFEF');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
