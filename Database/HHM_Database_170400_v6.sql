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
-- Table structure for table `department_group`
--

DROP TABLE IF EXISTS `department_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department_group` (
  `id` int(11) NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_department_group_1_idx` (`department_id`),
  KEY `fk_department_group_2_idx` (`group_id`),
  CONSTRAINT `fk_department_group_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_department_group_2` FOREIGN KEY (`group_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(90) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
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
  `file_ids` varchar(45) DEFAULT NULL COMMENT 'files ids in csv format',
  PRIMARY KEY (`case_num`),
  KEY `send_ind` (`s_id`) COMMENT 'sender index',
  CONSTRAINT `send_key` FOREIGN KEY (`s_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_files`
--

DROP TABLE IF EXISTS `document_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) DEFAULT '',
  `sender_id` int(11) DEFAULT NULL,
  `to_ids` varchar(45) DEFAULT NULL,
  `cc_ids` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` text NOT NULL,
  `message_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_files_1` (`message_id`),
  CONSTRAINT `fk_files_1` FOREIGN KEY (`message_id`) REFERENCES `message` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `join_department_message`
--

DROP TABLE IF EXISTS `join_department_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `join_department_message` (
  `department_id` int(11) NOT NULL,
  `message_id` bigint(20) NOT NULL,
  `to_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'The department with this message is the receiver(To)',
  `cc_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'The department with this message is the receiver(Cc)',
  PRIMARY KEY (`department_id`,`message_id`,`to_flag`,`cc_flag`),
  KEY `fk_join_department_message_2_idx` (`message_id`),
  CONSTRAINT `fk_join_department_message_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_join_department_message_2` FOREIGN KEY (`message_id`) REFERENCES `message` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `join_department_user_message`
--

DROP TABLE IF EXISTS `join_department_user_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `join_department_user_message` (
  `department_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message_id` bigint(20) NOT NULL,
  `read_flag` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`department_id`,`user_id`,`message_id`),
  KEY `fk_join_department_user_message_2_idx` (`user_id`),
  KEY `fk_join_department_user_message_3_idx` (`message_id`),
  CONSTRAINT `fk_join_department_user_message_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_join_department_user_message_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_join_department_user_message_3` FOREIGN KEY (`message_id`) REFERENCES `message` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `join_user_message`
--

DROP TABLE IF EXISTS `join_user_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `join_user_message` (
  `user_id` int(11) NOT NULL,
  `message_id` bigint(20) NOT NULL,
  `sender_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'The user with this message is the sender',
  `to_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'The user with this message is the receiver(To)',
  `cc_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'The user with this message is the receiver(Cc)',
  `read_flag` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`user_id`,`message_id`,`sender_flag`,`to_flag`,`cc_flag`),
  KEY `fk_join_user_message_2_idx` (`message_id`),
  CONSTRAINT `fk_join_user_message_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_join_user_message_2` FOREIGN KEY (`message_id`) REFERENCES `message` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message` (
  `id` bigint(20) NOT NULL COMMENT 'Create base on current epoch in millisecond',
  `subject` text CHARACTER SET utf8,
  `content` text CHARACTER SET utf8,
  `send_date` datetime DEFAULT NULL,
  `number_sources` int(11) DEFAULT '0' COMMENT 'Number of source for this group of messages',
  `source_message_id` bigint(20) DEFAULT NULL,
  `source_flag` tinyint(1) DEFAULT '0' COMMENT 'Flag to indicate this message is a source or not',
  PRIMARY KEY (`id`),
  KEY `fk_message_1_idx` (`source_message_id`),
  CONSTRAINT `fk_message_1` FOREIGN KEY (`source_message_id`) REFERENCES `message` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(90) NOT NULL,
  `permission_1` tinyint(1) DEFAULT NULL,
  `permission_2` tinyint(1) DEFAULT NULL,
  `permission_3` tinyint(1) DEFAULT NULL,
  `permission_4` tinyint(1) DEFAULT NULL,
  `permission_5` tinyint(1) DEFAULT NULL,
  `permission_6` tinyint(1) DEFAULT NULL,
  `permission_7` tinyint(1) DEFAULT NULL,
  `permission_8` tinyint(1) DEFAULT NULL,
  `permission_9` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
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
  `department_id` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_user_1_idx` (`department_id`),
  CONSTRAINT `fk_user_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_role_1_idx` (`user_id`),
  KEY `fk_user_role_2_idx` (`role_id`),
  CONSTRAINT `fk_user_role_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_role_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-07-08 17:39:58
