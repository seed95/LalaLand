-- MySQL dump 10.13  Distrib 5.7.33, for Linux (x86_64)
--
-- Host: localhost    Database: hhm_db
-- ------------------------------------------------------
-- Server version	5.7.33-0ubuntu0.16.04.1

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
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (1,'ftp_server','ftp://192.168.1.122/../../srv/ftp/hhm/',NULL),(2,'ftp_username','bijan',NULL),(3,'ftp_password','betoche',NULL),(4,'domain','lolo.com',NULL),(5,'doc_base_id','2000','Base case number for documents'),(6,'news_timer','30000','timer for update news. unit: ms');
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

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
  PRIMARY KEY (`case_num`),
  KEY `send_ind` (`s_id`) COMMENT 'sender index',
  CONSTRAINT `send_key` FOREIGN KEY (`s_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document`
--

LOCK TABLES `document` WRITE;
/*!40000 ALTER TABLE `document` DISABLE KEYS */;
/*!40000 ALTER TABLE `document` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email`
--

LOCK TABLES `email` WRITE;
/*!40000 ALTER TABLE `email` DISABLE KEYS */;
/*!40000 ALTER TABLE `email` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES (1,'روحانی','هفته سختی در پیش رو داریم! باید سبک زندگی عوض شود 1','سه شنبه، ۲۸ فروردین، ۱۴۰۰'),(2,'روحانی','هفته سختی در پیش رو داریم! باید سبک زندگی عوض شود 2','سه شنبه، ۲۸ فروردین، ۱۴۰۰'),(3,'روحانی','هفته سختی در پیش رو داریم! باید سبک زندگی عوض شود 3','سه شنبه، ۲۸ فروردین، ۱۴۰۰'),(4,'روحانی','هفته سختی در پیش رو داریم! باید سبک زندگی عوض شود 4','سه شنبه، ۲۸ فروردین، ۱۴۰۰'),(80,'روحانی','هفته سختی در پیش رو داریم! باید سبک زندگی عوض شود 7','سه شنبه، ۲۸ فروردین، ۱۴۰۰'),(90,'روحانی','هفته سختی در پیش رو داریم! باید سبک زندگی عوض شود 5','سه شنبه، ۲۸ فروردین، ۱۴۰۰'),(100,'روحانی','هفته سختی در پیش رو داریم! باید سبک زندگی عوض شود 6','سه شنبه، ۲۸ فروردین، ۱۴۰۰');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (2,'Cassie','Hicks','Admin',NULL,NULL,NULL,NULL,NULL,'a'),(55,'صالح','هایری','saleh',NULL,NULL,NULL,NULL,NULL,'s'),(76,'عمو','علیرضا','alireza',NULL,NULL,NULL,NULL,NULL,'a'),(102,'John','Nash','User',NULL,NULL,NULL,NULL,NULL,'u');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_email`
--

LOCK TABLES `user_email` WRITE;
/*!40000 ALTER TABLE `user_email` DISABLE KEYS */;
INSERT INTO `user_email` VALUES (4,2,NULL,'',''),(5,102,NULL,'',''),(12,55,NULL,'',''),(13,76,NULL,'','');
/*!40000 ALTER TABLE `user_email` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-19 17:08:31
