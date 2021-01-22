-- MySQL dump 10.13  Distrib 5.7.32, for Linux (x86_64)
--
-- Host: localhost    Database: hhm_db
-- ------------------------------------------------------
-- Server version	5.7.32-0ubuntu0.16.04.1

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
  `id` varchar(45) NOT NULL,
  `config_key` text,
  `config_value` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES ('1','ftp_server','ftp://192.168.1.122/../../srv/ftp/hhm/'),('2','ftp_username','bijan'),('3','ftp_password','betoche');
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document`
--

DROP TABLE IF EXISTS `document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filepath` text COMMENT 'filepath where the document is stored in server',
  `s_id` int(10) DEFAULT NULL COMMENT 'user_id sender',
  `r_ids` text COMMENT 'receivers user ids in csv format',
  `date` datetime DEFAULT NULL,
  `s_name` varchar(90) DEFAULT NULL COMMENT 'firstname sender',
  `status` int(11) DEFAULT '2' COMMENT 'Document status:\nSuccess(1)\nPending(2)\nFailed(3)\n',
  `subject` text,
  `case_num` int(10) NOT NULL COMMENT 'case number',
  PRIMARY KEY (`id`),
  KEY `send_ind` (`s_id`) COMMENT 'sender index',
  CONSTRAINT `send_key` FOREIGN KEY (`s_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document`
--

LOCK TABLES `document` WRITE;
/*!40000 ALTER TABLE `document` DISABLE KEYS */;
INSERT INTO `document` VALUES (4,'/home/bijan/Projects/DeadZone/HHM/HHM',101,'102','2021-01-17 14:32:20','Cassie Hicks',1,'ad',12),(5,'123_HHM',101,'102','2021-01-17 14:38:49','Cassie Hicks',1,'adsf',123),(6,'9856_Makefile',101,'102','2021-01-17 15:03:42','Cassie Hicks',1,'adfad',9856),(7,'852369_HHM.pro',101,'102','2021-01-22 12:33:20','Cassie Hicks',2,'hhm.pro',852369),(8,'553435_main.qml',101,'102','2021-01-22 16:15:25','Cassie Hicks',1,'test 2',553435);
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
  `d_id` int(10) NOT NULL COMMENT 'document id\nreference to column `id` from table `documents`',
  `flag` tinyint(1) DEFAULT '0',
  `opened` tinyint(1) DEFAULT '0',
  `open_time` datetime DEFAULT NULL,
  `s_email` tinyint(1) DEFAULT '0' COMMENT 'reference for send email',
  `r_email` tinyint(1) DEFAULT '0' COMMENT 'reference for receive email',
  PRIMARY KEY (`id`),
  KEY `doc_key_idx` (`d_id`),
  CONSTRAINT `doc_key` FOREIGN KEY (`d_id`) REFERENCES `document` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email`
--

LOCK TABLES `email` WRITE;
/*!40000 ALTER TABLE `email` DISABLE KEYS */;
INSERT INTO `email` VALUES (7,4,0,1,NULL,1,0),(8,4,0,1,NULL,0,1),(9,5,0,1,NULL,1,0),(10,5,0,0,NULL,0,1),(11,6,0,1,NULL,1,0),(12,6,0,0,NULL,0,1),(13,7,0,1,NULL,1,0),(14,7,0,1,NULL,0,1),(15,8,0,1,NULL,1,0),(16,8,0,1,NULL,0,1);
/*!40000 ALTER TABLE `email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(90) DEFAULT NULL,
  `lastname` varchar(90) DEFAULT NULL,
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
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (101,'Cassie','Hicks','Admin',NULL,NULL,NULL,NULL,NULL,'a'),(102,'John','Nash','User',NULL,NULL,NULL,NULL,NULL,'u');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_email`
--

LOCK TABLES `user_email` WRITE;
/*!40000 ALTER TABLE `user_email` DISABLE KEYS */;
INSERT INTO `user_email` VALUES (4,101,NULL,'7,9,11,13,15',NULL),(5,102,NULL,NULL,'8,10,12,14,16');
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

-- Dump completed on 2021-01-22 16:53:23
