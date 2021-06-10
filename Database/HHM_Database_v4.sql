-- MySQL dump 10.13  Distrib 5.7.34, for Linux (x86_64)
--
-- Host: localhost    Database: hhm_db
-- ------------------------------------------------------
-- Server version	5.7.34-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `config_key` text,
  `config_value` text,
  `comment` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document`
--

DROP TABLE IF EXISTS `document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document` (
  `case_num` int(10) NOT NULL COMMENT 'case number',
  `filepath` text CHARACTER SET utf8 COMMENT 'filepath where the document is stored in server',
  `s_id` int(10) DEFAULT NULL COMMENT 'user_id sender',
  `r_ids` text COMMENT 'receivers user ids in csv format',
  `date` datetime DEFAULT NULL,
  `s_name` varchar(90) CHARACTER SET utf8 DEFAULT NULL COMMENT 'firstname sender',
  `status` int(11) DEFAULT '2' COMMENT 'Document status:\nSuccess(1)\nPending(2)\nFailed(3)\n',
  `subject` text CHARACTER SET utf8,
  `table_data1` text CHARACTER SET utf8 COMMENT 'موضوع الکتاب',
  `table_data2` text CHARACTER SET utf8 COMMENT 'مضمون الکتاب',
  `table_data3` int(10) DEFAULT NULL COMMENT 'عدد الصادر\n',
  `table_data4` text CHARACTER SET utf8 COMMENT 'تاریخ الصادر',
  `table_data5` int(10) DEFAULT NULL COMMENT 'عدد الوارد',
  `table_data6` text COMMENT 'تاریخ الوارد',
  PRIMARY KEY (`case_num`),
  KEY `send_ind` (`s_id`) COMMENT 'sender index',
  CONSTRAINT `send_key` FOREIGN KEY (`s_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email`
--

DROP TABLE IF EXISTS `email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `flag` tinyint(1) DEFAULT '0',
  `opened` tinyint(1) DEFAULT '0',
  `open_time` datetime DEFAULT NULL,
  `s_email` tinyint(1) DEFAULT '0' COMMENT 'reference for send email',
  `r_email` tinyint(1) DEFAULT '0' COMMENT 'reference for receive email',
  `d_case_number` int(11) DEFAULT NULL COMMENT 'document case number\nreference to document table',
  PRIMARY KEY (`id`),
  KEY `doc_id_key_idx` (`d_case_number`),
  CONSTRAINT `doc_id_key` FOREIGN KEY (`d_case_number`) REFERENCES `document` (`case_num`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text,
  `content` text,
  `date` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(90) CHARACTER SET utf8 DEFAULT NULL,
  `lastname` varchar(90) CHARACTER SET utf8 DEFAULT NULL,
  `username` varchar(90) DEFAULT NULL,
  `lastlogin` datetime DEFAULT NULL,
  `online` tinyint(1) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `bio` longtext,
  `image` text,
  `password` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_email`
--

DROP TABLE IF EXISTS `user_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_email` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `date` int(11) DEFAULT NULL COMMENT 'save number of month(0-120)',
  `sent_emails` text COMMENT 'Save sent emails from user_id in csv format.\nreference to emails.id',
  `received_emails` text COMMENT 'Save received emails id to user_id in csv format.\nreference to emails.id',
  PRIMARY KEY (`id`),
  KEY `user_key_idx` (`user_id`),
  CONSTRAINT `user_key` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-10 20:02:11
