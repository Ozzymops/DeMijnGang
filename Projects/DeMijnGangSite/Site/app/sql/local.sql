-- MySQL dump 10.13  Distrib 8.0.16, for Win64 (x86_64)
--
-- Host: ::1    Database: local
-- ------------------------------------------------------
-- Server version	8.0.16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `wp_commentmeta`
--

DROP TABLE IF EXISTS `wp_commentmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_commentmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `comment_id` (`comment_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_commentmeta`
--

LOCK TABLES `wp_commentmeta` WRITE;
/*!40000 ALTER TABLE `wp_commentmeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_commentmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_comments`
--

DROP TABLE IF EXISTS `wp_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_comments` (
  `comment_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_post_ID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `comment_author` tinytext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_author_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_url` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_IP` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_content` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_karma` int(11) NOT NULL DEFAULT '0',
  `comment_approved` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '1',
  `comment_agent` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'comment',
  `comment_parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_ID`),
  KEY `comment_post_ID` (`comment_post_ID`),
  KEY `comment_approved_date_gmt` (`comment_approved`,`comment_date_gmt`),
  KEY `comment_date_gmt` (`comment_date_gmt`),
  KEY `comment_parent` (`comment_parent`),
  KEY `comment_author_email` (`comment_author_email`(10))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_comments`
--

LOCK TABLES `wp_comments` WRITE;
/*!40000 ALTER TABLE `wp_comments` DISABLE KEYS */;
INSERT INTO `wp_comments` VALUES (1,1,'A WordPress Commenter','wapuu@wordpress.example','https://wordpress.org/','','2024-05-17 10:27:19','2024-05-17 10:27:19','Hi, this is a comment.\nTo get started with moderating, editing, and deleting comments, please visit the Comments screen in the dashboard.\nCommenter avatars come from <a href=\"https://en.gravatar.com/\">Gravatar</a>.',0,'post-trashed','','comment',0,0);
/*!40000 ALTER TABLE `wp_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_em_automation`
--

DROP TABLE IF EXISTS `wp_em_automation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_em_automation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int(1) unsigned NOT NULL DEFAULT '0',
  `trigger_data` longtext COLLATE utf8mb4_unicode_ci,
  `action_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `ts` timestamp NULL DEFAULT NULL,
  `doing_cron` int(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `object_id` (`object_id`),
  KEY `type` (`type`),
  KEY `ts` (`ts`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_em_automation`
--

LOCK TABLES `wp_em_automation` WRITE;
/*!40000 ALTER TABLE `wp_em_automation` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_em_automation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_em_bookings`
--

DROP TABLE IF EXISTS `wp_em_bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_em_bookings` (
  `booking_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `booking_uuid` char(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_id` bigint(20) unsigned DEFAULT NULL,
  `person_id` bigint(20) unsigned NOT NULL,
  `booking_spaces` int(5) NOT NULL,
  `booking_comment` mediumtext COLLATE utf8mb4_unicode_ci,
  `booking_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `booking_status` int(2) NOT NULL DEFAULT '1',
  `booking_rsvp_status` int(1) DEFAULT NULL,
  `booking_price` decimal(14,4) unsigned NOT NULL DEFAULT '0.0000',
  `booking_tax_rate` decimal(7,4) DEFAULT NULL,
  `booking_taxes` decimal(14,4) DEFAULT NULL,
  `booking_meta` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`booking_id`),
  KEY `event_id` (`event_id`),
  KEY `person_id` (`person_id`),
  KEY `booking_status` (`booking_status`),
  KEY `booking_rsvp_status` (`booking_rsvp_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_em_bookings`
--

LOCK TABLES `wp_em_bookings` WRITE;
/*!40000 ALTER TABLE `wp_em_bookings` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_em_bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_em_bookings_meta`
--

DROP TABLE IF EXISTS `wp_em_bookings_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_em_bookings_meta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `booking_id` bigint(20) unsigned NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`meta_id`),
  KEY `booking_id` (`booking_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_em_bookings_meta`
--

LOCK TABLES `wp_em_bookings_meta` WRITE;
/*!40000 ALTER TABLE `wp_em_bookings_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_em_bookings_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_em_bookings_relationships`
--

DROP TABLE IF EXISTS `wp_em_bookings_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_em_bookings_relationships` (
  `booking_relationship_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` bigint(20) unsigned DEFAULT NULL,
  `booking_id` bigint(20) unsigned DEFAULT NULL,
  `booking_main_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`booking_relationship_id`),
  KEY `event_id` (`event_id`),
  KEY `booking_id` (`booking_id`),
  KEY `booking_main_id` (`booking_main_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_em_bookings_relationships`
--

LOCK TABLES `wp_em_bookings_relationships` WRITE;
/*!40000 ALTER TABLE `wp_em_bookings_relationships` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_em_bookings_relationships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_em_coupons`
--

DROP TABLE IF EXISTS `wp_em_coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_em_coupons` (
  `coupon_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `coupon_owner` bigint(20) unsigned NOT NULL,
  `blog_id` bigint(20) unsigned DEFAULT NULL,
  `coupon_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `coupon_name` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `coupon_description` mediumtext COLLATE utf8mb4_unicode_ci,
  `coupon_max` int(10) DEFAULT NULL,
  `coupon_start` datetime DEFAULT NULL,
  `coupon_end` datetime DEFAULT NULL,
  `coupon_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coupon_tax` varchar(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coupon_discount` decimal(14,2) NOT NULL,
  `coupon_eventwide` tinyint(1) NOT NULL DEFAULT '0',
  `coupon_sitewide` tinyint(1) NOT NULL DEFAULT '0',
  `coupon_private` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`coupon_id`),
  KEY `coupon_owner` (`coupon_owner`),
  KEY `coupon_code` (`coupon_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_em_coupons`
--

LOCK TABLES `wp_em_coupons` WRITE;
/*!40000 ALTER TABLE `wp_em_coupons` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_em_coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_em_email_queue`
--

DROP TABLE IF EXISTS `wp_em_email_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_em_email_queue` (
  `queue_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` bigint(20) unsigned DEFAULT NULL,
  `booking_id` bigint(20) unsigned DEFAULT NULL,
  `batch_id` bigint(20) unsigned DEFAULT NULL,
  `email` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachment` mediumtext COLLATE utf8mb4_unicode_ci,
  `args` longtext COLLATE utf8mb4_unicode_ci,
  `attempts` int(11) NOT NULL DEFAULT '0',
  `last_error` mediumtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`queue_id`),
  KEY `event_id` (`event_id`),
  KEY `booking_id` (`booking_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_em_email_queue`
--

LOCK TABLES `wp_em_email_queue` WRITE;
/*!40000 ALTER TABLE `wp_em_email_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_em_email_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_em_events`
--

DROP TABLE IF EXISTS `wp_em_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_em_events` (
  `event_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL,
  `event_parent` bigint(20) unsigned DEFAULT NULL,
  `event_slug` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `event_owner` bigint(20) unsigned DEFAULT NULL,
  `event_status` tinyint(1) DEFAULT NULL,
  `event_active_status` tinyint(2) DEFAULT '1',
  `event_name` mediumtext COLLATE utf8mb4_unicode_ci,
  `event_start_date` date DEFAULT NULL,
  `event_end_date` date DEFAULT NULL,
  `event_start_time` time DEFAULT NULL,
  `event_end_time` time DEFAULT NULL,
  `event_all_day` tinyint(1) unsigned DEFAULT NULL,
  `event_start` datetime DEFAULT NULL,
  `event_end` datetime DEFAULT NULL,
  `event_timezone` text COLLATE utf8mb4_unicode_ci,
  `post_content` longtext COLLATE utf8mb4_unicode_ci,
  `event_rsvp` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `event_rsvp_date` date DEFAULT NULL,
  `event_rsvp_time` time DEFAULT NULL,
  `event_rsvp_spaces` int(5) DEFAULT NULL,
  `event_spaces` int(5) DEFAULT '0',
  `event_private` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `location_id` bigint(20) unsigned DEFAULT NULL,
  `event_location_type` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recurrence_id` bigint(20) unsigned DEFAULT NULL,
  `event_date_created` datetime DEFAULT NULL,
  `event_date_modified` datetime DEFAULT NULL,
  `recurrence` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `recurrence_interval` int(4) DEFAULT NULL,
  `recurrence_freq` text COLLATE utf8mb4_unicode_ci,
  `recurrence_byday` text COLLATE utf8mb4_unicode_ci,
  `recurrence_byweekno` int(4) DEFAULT NULL,
  `recurrence_days` int(4) DEFAULT NULL,
  `recurrence_rsvp_days` int(3) DEFAULT NULL,
  `blog_id` bigint(20) unsigned DEFAULT NULL,
  `group_id` bigint(20) unsigned DEFAULT NULL,
  `event_language` varchar(14) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `event_translation` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`event_id`),
  KEY `event_status` (`event_status`),
  KEY `event_active_status` (`event_active_status`),
  KEY `post_id` (`post_id`),
  KEY `blog_id` (`blog_id`),
  KEY `group_id` (`group_id`),
  KEY `location_id` (`location_id`),
  KEY `event_start` (`event_start`),
  KEY `event_end` (`event_end`),
  KEY `event_start_date` (`event_start_date`),
  KEY `event_end_date` (`event_end_date`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_em_events`
--

LOCK TABLES `wp_em_events` WRITE;
/*!40000 ALTER TABLE `wp_em_events` DISABLE KEYS */;
INSERT INTO `wp_em_events` VALUES (1,43,NULL,'uitgelicht-activiteit',1,1,1,'Uitgelicht activiteit','2024-05-17','2024-05-17','00:00:00','23:59:59',1,'2024-05-17 00:00:00','2024-05-17 23:59:59','UTC','Wauw, een super cool uitgelicht activiteit!',0,NULL,NULL,NULL,NULL,0,1,NULL,NULL,'2024-05-17 11:07:17','2024-05-17 11:09:38',0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,'en_US',0);
/*!40000 ALTER TABLE `wp_em_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_em_locations`
--

DROP TABLE IF EXISTS `wp_em_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_em_locations` (
  `location_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL,
  `blog_id` bigint(20) unsigned DEFAULT NULL,
  `location_parent` bigint(20) unsigned DEFAULT NULL,
  `location_slug` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location_name` mediumtext COLLATE utf8mb4_unicode_ci,
  `location_owner` bigint(20) unsigned NOT NULL DEFAULT '0',
  `location_address` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location_town` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location_state` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location_postcode` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location_region` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location_country` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location_latitude` decimal(9,6) DEFAULT NULL,
  `location_longitude` decimal(9,6) DEFAULT NULL,
  `post_content` longtext COLLATE utf8mb4_unicode_ci,
  `location_status` int(1) DEFAULT NULL,
  `location_private` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `location_language` varchar(14) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location_translation` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`location_id`),
  KEY `location_state` (`location_state`(191)),
  KEY `location_region` (`location_region`(191)),
  KEY `location_country` (`location_country`),
  KEY `post_id` (`post_id`),
  KEY `blog_id` (`blog_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_em_locations`
--

LOCK TABLES `wp_em_locations` WRITE;
/*!40000 ALTER TABLE `wp_em_locations` DISABLE KEYS */;
INSERT INTO `wp_em_locations` VALUES (1,44,0,NULL,'stichting-de-mijngang','Stichting De MijnGang',1,'Huskensweg 37','Heerlen','Limburg','6412SB',NULL,'NL',NULL,NULL,NULL,1,0,'en_US',0);
/*!40000 ALTER TABLE `wp_em_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_em_meta`
--

DROP TABLE IF EXISTS `wp_em_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_em_meta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` bigint(20) unsigned NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci,
  `meta_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`meta_id`),
  KEY `object_id` (`object_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_em_meta`
--

LOCK TABLES `wp_em_meta` WRITE;
/*!40000 ALTER TABLE `wp_em_meta` DISABLE KEYS */;
INSERT INTO `wp_em_meta` VALUES (1,0,'booking-form','a:2:{s:4:\"name\";s:7:\"Default\";s:4:\"form\";a:10:{s:4:\"name\";a:4:{s:5:\"label\";s:4:\"Name\";s:4:\"type\";s:4:\"name\";s:7:\"fieldid\";s:9:\"user_name\";s:8:\"required\";i:1;}s:10:\"user_email\";a:4:{s:5:\"label\";s:5:\"Email\";s:4:\"type\";s:10:\"user_email\";s:7:\"fieldid\";s:10:\"user_email\";s:8:\"required\";i:1;}s:12:\"dbem_address\";a:4:{s:5:\"label\";s:7:\"Address\";s:4:\"type\";s:12:\"dbem_address\";s:7:\"fieldid\";s:12:\"dbem_address\";s:8:\"required\";i:1;}s:9:\"dbem_city\";a:4:{s:5:\"label\";s:9:\"City/Town\";s:4:\"type\";s:9:\"dbem_city\";s:7:\"fieldid\";s:9:\"dbem_city\";s:8:\"required\";i:1;}s:10:\"dbem_state\";a:4:{s:5:\"label\";s:12:\"State/County\";s:4:\"type\";s:10:\"dbem_state\";s:7:\"fieldid\";s:10:\"dbem_state\";s:8:\"required\";i:1;}s:8:\"dbem_zip\";a:4:{s:5:\"label\";s:13:\"Zip/Post Code\";s:4:\"type\";s:8:\"dbem_zip\";s:7:\"fieldid\";s:8:\"dbem_zip\";s:8:\"required\";i:1;}s:12:\"dbem_country\";a:4:{s:5:\"label\";s:7:\"Country\";s:4:\"type\";s:12:\"dbem_country\";s:7:\"fieldid\";s:12:\"dbem_country\";s:8:\"required\";i:1;}s:10:\"dbem_phone\";a:3:{s:5:\"label\";s:5:\"Phone\";s:4:\"type\";s:10:\"dbem_phone\";s:7:\"fieldid\";s:10:\"dbem_phone\";}s:8:\"dbem_fax\";a:3:{s:5:\"label\";s:3:\"Fax\";s:4:\"type\";s:8:\"dbem_fax\";s:7:\"fieldid\";s:8:\"dbem_fax\";}s:15:\"booking_comment\";a:3:{s:5:\"label\";s:7:\"Comment\";s:4:\"type\";s:8:\"textarea\";s:7:\"fieldid\";s:15:\"booking_comment\";}}}','2024-05-17 10:40:38');
INSERT INTO `wp_em_meta` VALUES (2,0,'booking-form','a:2:{s:4:\"name\";s:7:\"Default\";s:4:\"form\";a:10:{s:4:\"name\";a:4:{s:5:\"label\";s:4:\"Name\";s:4:\"type\";s:4:\"name\";s:7:\"fieldid\";s:9:\"user_name\";s:8:\"required\";i:1;}s:10:\"user_email\";a:4:{s:5:\"label\";s:5:\"Email\";s:4:\"type\";s:10:\"user_email\";s:7:\"fieldid\";s:10:\"user_email\";s:8:\"required\";i:1;}s:12:\"dbem_address\";a:4:{s:5:\"label\";s:7:\"Address\";s:4:\"type\";s:12:\"dbem_address\";s:7:\"fieldid\";s:12:\"dbem_address\";s:8:\"required\";i:1;}s:9:\"dbem_city\";a:4:{s:5:\"label\";s:9:\"City/Town\";s:4:\"type\";s:9:\"dbem_city\";s:7:\"fieldid\";s:9:\"dbem_city\";s:8:\"required\";i:1;}s:10:\"dbem_state\";a:4:{s:5:\"label\";s:12:\"State/County\";s:4:\"type\";s:10:\"dbem_state\";s:7:\"fieldid\";s:10:\"dbem_state\";s:8:\"required\";i:1;}s:8:\"dbem_zip\";a:4:{s:5:\"label\";s:13:\"Zip/Post Code\";s:4:\"type\";s:8:\"dbem_zip\";s:7:\"fieldid\";s:8:\"dbem_zip\";s:8:\"required\";i:1;}s:12:\"dbem_country\";a:4:{s:5:\"label\";s:7:\"Country\";s:4:\"type\";s:12:\"dbem_country\";s:7:\"fieldid\";s:12:\"dbem_country\";s:8:\"required\";i:1;}s:10:\"dbem_phone\";a:3:{s:5:\"label\";s:5:\"Phone\";s:4:\"type\";s:10:\"dbem_phone\";s:7:\"fieldid\";s:10:\"dbem_phone\";}s:8:\"dbem_fax\";a:3:{s:5:\"label\";s:3:\"Fax\";s:4:\"type\";s:8:\"dbem_fax\";s:7:\"fieldid\";s:8:\"dbem_fax\";}s:15:\"booking_comment\";a:3:{s:5:\"label\";s:7:\"Comment\";s:4:\"type\";s:8:\"textarea\";s:7:\"fieldid\";s:15:\"booking_comment\";}}}','2024-05-17 10:40:38');
/*!40000 ALTER TABLE `wp_em_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_em_tickets`
--

DROP TABLE IF EXISTS `wp_em_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_em_tickets` (
  `ticket_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` bigint(20) unsigned NOT NULL,
  `ticket_name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `ticket_description` mediumtext COLLATE utf8mb4_unicode_ci,
  `ticket_price` decimal(14,4) DEFAULT NULL,
  `ticket_start` datetime DEFAULT NULL,
  `ticket_end` datetime DEFAULT NULL,
  `ticket_min` int(10) DEFAULT NULL,
  `ticket_max` int(10) DEFAULT NULL,
  `ticket_spaces` int(11) DEFAULT NULL,
  `ticket_members` int(1) DEFAULT NULL,
  `ticket_members_roles` longtext COLLATE utf8mb4_unicode_ci,
  `ticket_guests` int(1) DEFAULT NULL,
  `ticket_required` int(1) DEFAULT NULL,
  `ticket_parent` bigint(20) unsigned DEFAULT NULL,
  `ticket_order` int(2) unsigned DEFAULT NULL,
  `ticket_meta` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`ticket_id`),
  KEY `event_id` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_em_tickets`
--

LOCK TABLES `wp_em_tickets` WRITE;
/*!40000 ALTER TABLE `wp_em_tickets` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_em_tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_em_tickets_bookings`
--

DROP TABLE IF EXISTS `wp_em_tickets_bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_em_tickets_bookings` (
  `ticket_booking_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_uuid` char(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `booking_id` bigint(20) unsigned NOT NULL,
  `ticket_id` bigint(20) unsigned NOT NULL,
  `ticket_booking_spaces` int(6) NOT NULL,
  `ticket_booking_price` decimal(14,4) NOT NULL,
  `ticket_booking_order` int(2) DEFAULT NULL,
  PRIMARY KEY (`ticket_booking_id`),
  KEY `ticket_uuid` (`ticket_uuid`),
  KEY `booking_id` (`booking_id`),
  KEY `ticket_id` (`ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_em_tickets_bookings`
--

LOCK TABLES `wp_em_tickets_bookings` WRITE;
/*!40000 ALTER TABLE `wp_em_tickets_bookings` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_em_tickets_bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_em_tickets_bookings_checkins`
--

DROP TABLE IF EXISTS `wp_em_tickets_bookings_checkins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_em_tickets_bookings_checkins` (
  `checkin_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_booking_id` bigint(20) unsigned NOT NULL,
  `checkin_status` int(1) unsigned NOT NULL,
  `checkin_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`checkin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_em_tickets_bookings_checkins`
--

LOCK TABLES `wp_em_tickets_bookings_checkins` WRITE;
/*!40000 ALTER TABLE `wp_em_tickets_bookings_checkins` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_em_tickets_bookings_checkins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_em_tickets_bookings_meta`
--

DROP TABLE IF EXISTS `wp_em_tickets_bookings_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_em_tickets_bookings_meta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_booking_id` bigint(20) unsigned NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`meta_id`),
  KEY `ticket_booking_id` (`ticket_booking_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_em_tickets_bookings_meta`
--

LOCK TABLES `wp_em_tickets_bookings_meta` WRITE;
/*!40000 ALTER TABLE `wp_em_tickets_bookings_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_em_tickets_bookings_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_em_transactions`
--

DROP TABLE IF EXISTS `wp_em_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_em_transactions` (
  `transaction_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `booking_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `transaction_gateway_id` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_payment_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_timestamp` datetime NOT NULL,
  `transaction_total_amount` decimal(14,2) DEFAULT NULL,
  `transaction_currency` varchar(35) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_status` varchar(35) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_duedate` date DEFAULT NULL,
  `transaction_gateway` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_note` mediumtext COLLATE utf8mb4_unicode_ci,
  `transaction_expires` datetime DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `transaction_gateway` (`transaction_gateway`),
  KEY `booking_id` (`booking_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_em_transactions`
--

LOCK TABLES `wp_em_transactions` WRITE;
/*!40000 ALTER TABLE `wp_em_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_em_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_links`
--

DROP TABLE IF EXISTS `wp_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_links` (
  `link_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `link_url` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_image` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_target` varchar(25) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_description` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_visible` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'Y',
  `link_owner` bigint(20) unsigned NOT NULL DEFAULT '1',
  `link_rating` int(11) NOT NULL DEFAULT '0',
  `link_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_rel` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_notes` mediumtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `link_rss` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`link_id`),
  KEY `link_visible` (`link_visible`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_links`
--

LOCK TABLES `wp_links` WRITE;
/*!40000 ALTER TABLE `wp_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_options`
--

DROP TABLE IF EXISTS `wp_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_options` (
  `option_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(191) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `option_value` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `autoload` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_name` (`option_name`),
  KEY `autoload` (`autoload`)
) ENGINE=InnoDB AUTO_INCREMENT=978 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_options`
--

LOCK TABLES `wp_options` WRITE;
/*!40000 ALTER TABLE `wp_options` DISABLE KEYS */;
INSERT INTO `wp_options` VALUES (1,'siteurl','http://de-mijngang.local','yes');
INSERT INTO `wp_options` VALUES (2,'home','http://de-mijngang.local','yes');
INSERT INTO `wp_options` VALUES (3,'blogname','De MijnGang','yes');
INSERT INTO `wp_options` VALUES (4,'blogdescription','Van O.V.S. naar De MijnGang','yes');
INSERT INTO `wp_options` VALUES (5,'users_can_register','0','yes');
INSERT INTO `wp_options` VALUES (6,'admin_email','dev-email@wpengine.local','yes');
INSERT INTO `wp_options` VALUES (7,'start_of_week','1','yes');
INSERT INTO `wp_options` VALUES (8,'use_balanceTags','0','yes');
INSERT INTO `wp_options` VALUES (9,'use_smilies','1','yes');
INSERT INTO `wp_options` VALUES (10,'require_name_email','1','yes');
INSERT INTO `wp_options` VALUES (11,'comments_notify','1','yes');
INSERT INTO `wp_options` VALUES (12,'posts_per_rss','10','yes');
INSERT INTO `wp_options` VALUES (13,'rss_use_excerpt','0','yes');
INSERT INTO `wp_options` VALUES (14,'mailserver_url','mail.example.com','yes');
INSERT INTO `wp_options` VALUES (15,'mailserver_login','login@example.com','yes');
INSERT INTO `wp_options` VALUES (16,'mailserver_pass','password','yes');
INSERT INTO `wp_options` VALUES (17,'mailserver_port','110','yes');
INSERT INTO `wp_options` VALUES (18,'default_category','1','yes');
INSERT INTO `wp_options` VALUES (19,'default_comment_status','open','yes');
INSERT INTO `wp_options` VALUES (20,'default_ping_status','open','yes');
INSERT INTO `wp_options` VALUES (21,'default_pingback_flag','1','yes');
INSERT INTO `wp_options` VALUES (22,'posts_per_page','10','yes');
INSERT INTO `wp_options` VALUES (23,'date_format','F j, Y','yes');
INSERT INTO `wp_options` VALUES (24,'time_format','g:i a','yes');
INSERT INTO `wp_options` VALUES (25,'links_updated_date_format','F j, Y g:i a','yes');
INSERT INTO `wp_options` VALUES (26,'comment_moderation','0','yes');
INSERT INTO `wp_options` VALUES (27,'moderation_notify','1','yes');
INSERT INTO `wp_options` VALUES (28,'permalink_structure','/%postname%/','yes');
INSERT INTO `wp_options` VALUES (29,'rewrite_rules','a:183:{s:27:\"events/(\\d{4}-\\d{2}-\\d{2})$\";s:50:\"index.php?pagename=events&calendar_day=$matches[1]\";s:13:\"events/rss/?$\";s:35:\"index.php?post_type=event&feed=feed\";s:14:\"events/feed/?$\";s:35:\"index.php?post_type=event&feed=feed\";s:19:\"events/locations/?$\";s:20:\"index.php?page_id=22\";s:20:\"events/categories/?$\";s:20:\"index.php?page_id=23\";s:14:\"events/tags/?$\";s:20:\"index.php?page_id=24\";s:21:\"events/my-bookings/?$\";s:20:\"index.php?page_id=25\";s:18:\"events/event/(.+)$\";s:62:\"index.php?pagename=events&em_redirect=1&event_slug=$matches[1]\";s:21:\"events/location/(.+)$\";s:65:\"index.php?pagename=events&em_redirect=1&location_slug=$matches[1]\";s:21:\"events/category/(.+)$\";s:65:\"index.php?pagename=events&em_redirect=1&category_slug=$matches[1]\";s:9:\"events/?$\";s:25:\"index.php?pagename=events\";s:19:\"events/(.+)/ical/?$\";s:34:\"index.php?event=$matches[1]&ical=1\";s:25:\"locations/([^/]+)/ical/?$\";s:37:\"index.php?location=$matches[1]&ical=1\";s:30:\"events/categories/(.+)/ical/?$\";s:45:\"index.php?event-categories=$matches[1]&ical=1\";s:24:\"events/tags/(.+)/ical/?$\";s:39:\"index.php?event-tags=$matches[1]&ical=1\";s:24:\"locations/([^/]+)/rss/?$\";s:36:\"index.php?location=$matches[1]&rss=1\";s:12:\"locations/?$\";s:28:\"index.php?post_type=location\";s:42:\"locations/feed/(feed|rdf|rss|rss2|atom)/?$\";s:45:\"index.php?post_type=location&feed=$matches[1]\";s:37:\"locations/(feed|rdf|rss|rss2|atom)/?$\";s:45:\"index.php?post_type=location&feed=$matches[1]\";s:29:\"locations/page/([0-9]{1,})/?$\";s:46:\"index.php?post_type=location&paged=$matches[1]\";s:39:\"events/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?post_type=event&feed=$matches[1]\";s:34:\"events/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?post_type=event&feed=$matches[1]\";s:26:\"events/page/([0-9]{1,})/?$\";s:43:\"index.php?post_type=event&paged=$matches[1]\";s:11:\"^wp-json/?$\";s:22:\"index.php?rest_route=/\";s:14:\"^wp-json/(.*)?\";s:33:\"index.php?rest_route=/$matches[1]\";s:21:\"^index.php/wp-json/?$\";s:22:\"index.php?rest_route=/\";s:24:\"^index.php/wp-json/(.*)?\";s:33:\"index.php?rest_route=/$matches[1]\";s:17:\"^wp-sitemap\\.xml$\";s:23:\"index.php?sitemap=index\";s:17:\"^wp-sitemap\\.xsl$\";s:36:\"index.php?sitemap-stylesheet=sitemap\";s:23:\"^wp-sitemap-index\\.xsl$\";s:34:\"index.php?sitemap-stylesheet=index\";s:48:\"^wp-sitemap-([a-z]+?)-([a-z\\d_-]+?)-(\\d+?)\\.xml$\";s:75:\"index.php?sitemap=$matches[1]&sitemap-subtype=$matches[2]&paged=$matches[3]\";s:34:\"^wp-sitemap-([a-z]+?)-(\\d+?)\\.xml$\";s:47:\"index.php?sitemap=$matches[1]&paged=$matches[2]\";s:47:\"category/(.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?category_name=$matches[1]&feed=$matches[2]\";s:42:\"category/(.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?category_name=$matches[1]&feed=$matches[2]\";s:23:\"category/(.+?)/embed/?$\";s:46:\"index.php?category_name=$matches[1]&embed=true\";s:35:\"category/(.+?)/page/?([0-9]{1,})/?$\";s:53:\"index.php?category_name=$matches[1]&paged=$matches[2]\";s:17:\"category/(.+?)/?$\";s:35:\"index.php?category_name=$matches[1]\";s:44:\"tag/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?tag=$matches[1]&feed=$matches[2]\";s:39:\"tag/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?tag=$matches[1]&feed=$matches[2]\";s:20:\"tag/([^/]+)/embed/?$\";s:36:\"index.php?tag=$matches[1]&embed=true\";s:32:\"tag/([^/]+)/page/?([0-9]{1,})/?$\";s:43:\"index.php?tag=$matches[1]&paged=$matches[2]\";s:14:\"tag/([^/]+)/?$\";s:25:\"index.php?tag=$matches[1]\";s:45:\"type/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?post_format=$matches[1]&feed=$matches[2]\";s:40:\"type/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?post_format=$matches[1]&feed=$matches[2]\";s:21:\"type/([^/]+)/embed/?$\";s:44:\"index.php?post_format=$matches[1]&embed=true\";s:33:\"type/([^/]+)/page/?([0-9]{1,})/?$\";s:51:\"index.php?post_format=$matches[1]&paged=$matches[2]\";s:15:\"type/([^/]+)/?$\";s:33:\"index.php?post_format=$matches[1]\";s:52:\"events/tags/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?event-tags=$matches[1]&feed=$matches[2]\";s:47:\"events/tags/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?event-tags=$matches[1]&feed=$matches[2]\";s:28:\"events/tags/([^/]+)/embed/?$\";s:43:\"index.php?event-tags=$matches[1]&embed=true\";s:40:\"events/tags/([^/]+)/page/?([0-9]{1,})/?$\";s:50:\"index.php?event-tags=$matches[1]&paged=$matches[2]\";s:22:\"events/tags/([^/]+)/?$\";s:32:\"index.php?event-tags=$matches[1]\";s:56:\"events/categories/(.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:55:\"index.php?event-categories=$matches[1]&feed=$matches[2]\";s:51:\"events/categories/(.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:55:\"index.php?event-categories=$matches[1]&feed=$matches[2]\";s:32:\"events/categories/(.+?)/embed/?$\";s:49:\"index.php?event-categories=$matches[1]&embed=true\";s:44:\"events/categories/(.+?)/page/?([0-9]{1,})/?$\";s:56:\"index.php?event-categories=$matches[1]&paged=$matches[2]\";s:26:\"events/categories/(.+?)/?$\";s:38:\"index.php?event-categories=$matches[1]\";s:37:\"locations/[^/]+/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:47:\"locations/[^/]+/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:67:\"locations/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:62:\"locations/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:62:\"locations/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:43:\"locations/[^/]+/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:26:\"locations/([^/]+)/embed/?$\";s:41:\"index.php?location=$matches[1]&embed=true\";s:30:\"locations/([^/]+)/trackback/?$\";s:35:\"index.php?location=$matches[1]&tb=1\";s:50:\"locations/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?location=$matches[1]&feed=$matches[2]\";s:45:\"locations/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?location=$matches[1]&feed=$matches[2]\";s:38:\"locations/([^/]+)/page/?([0-9]{1,})/?$\";s:48:\"index.php?location=$matches[1]&paged=$matches[2]\";s:45:\"locations/([^/]+)/comment-page-([0-9]{1,})/?$\";s:48:\"index.php?location=$matches[1]&cpage=$matches[2]\";s:34:\"locations/([^/]+)(?:/([0-9]+))?/?$\";s:47:\"index.php?location=$matches[1]&page=$matches[2]\";s:26:\"locations/[^/]+/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:36:\"locations/[^/]+/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:56:\"locations/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:51:\"locations/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:51:\"locations/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:32:\"locations/[^/]+/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:34:\"events/[^/]+/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:44:\"events/[^/]+/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:64:\"events/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:59:\"events/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:59:\"events/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:40:\"events/[^/]+/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:23:\"events/([^/]+)/embed/?$\";s:38:\"index.php?event=$matches[1]&embed=true\";s:27:\"events/([^/]+)/trackback/?$\";s:32:\"index.php?event=$matches[1]&tb=1\";s:47:\"events/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:44:\"index.php?event=$matches[1]&feed=$matches[2]\";s:42:\"events/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:44:\"index.php?event=$matches[1]&feed=$matches[2]\";s:35:\"events/([^/]+)/page/?([0-9]{1,})/?$\";s:45:\"index.php?event=$matches[1]&paged=$matches[2]\";s:42:\"events/([^/]+)/comment-page-([0-9]{1,})/?$\";s:45:\"index.php?event=$matches[1]&cpage=$matches[2]\";s:31:\"events/([^/]+)(?:/([0-9]+))?/?$\";s:44:\"index.php?event=$matches[1]&page=$matches[2]\";s:23:\"events/[^/]+/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:33:\"events/[^/]+/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:53:\"events/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:48:\"events/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:48:\"events/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:29:\"events/[^/]+/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:44:\"events-recurring/[^/]+/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:54:\"events-recurring/[^/]+/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:74:\"events-recurring/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:69:\"events-recurring/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:69:\"events-recurring/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:50:\"events-recurring/[^/]+/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:33:\"events-recurring/([^/]+)/embed/?$\";s:48:\"index.php?event-recurring=$matches[1]&embed=true\";s:37:\"events-recurring/([^/]+)/trackback/?$\";s:42:\"index.php?event-recurring=$matches[1]&tb=1\";s:45:\"events-recurring/([^/]+)/page/?([0-9]{1,})/?$\";s:55:\"index.php?event-recurring=$matches[1]&paged=$matches[2]\";s:52:\"events-recurring/([^/]+)/comment-page-([0-9]{1,})/?$\";s:55:\"index.php?event-recurring=$matches[1]&cpage=$matches[2]\";s:41:\"events-recurring/([^/]+)(?:/([0-9]+))?/?$\";s:54:\"index.php?event-recurring=$matches[1]&page=$matches[2]\";s:33:\"events-recurring/[^/]+/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:43:\"events-recurring/[^/]+/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:63:\"events-recurring/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:58:\"events-recurring/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:58:\"events-recurring/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:39:\"events-recurring/[^/]+/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:12:\"robots\\.txt$\";s:18:\"index.php?robots=1\";s:13:\"favicon\\.ico$\";s:19:\"index.php?favicon=1\";s:48:\".*wp-(atom|rdf|rss|rss2|feed|commentsrss2)\\.php$\";s:18:\"index.php?feed=old\";s:20:\".*wp-app\\.php(/.*)?$\";s:19:\"index.php?error=403\";s:18:\".*wp-register.php$\";s:23:\"index.php?register=true\";s:32:\"feed/(feed|rdf|rss|rss2|atom)/?$\";s:27:\"index.php?&feed=$matches[1]\";s:27:\"(feed|rdf|rss|rss2|atom)/?$\";s:27:\"index.php?&feed=$matches[1]\";s:8:\"embed/?$\";s:21:\"index.php?&embed=true\";s:20:\"page/?([0-9]{1,})/?$\";s:28:\"index.php?&paged=$matches[1]\";s:27:\"comment-page-([0-9]{1,})/?$\";s:38:\"index.php?&page_id=6&cpage=$matches[1]\";s:27:\"bookings-manager(/(.*))?/?$\";s:39:\"index.php?&bookings-manager=$matches[2]\";s:41:\"comments/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?&feed=$matches[1]&withcomments=1\";s:36:\"comments/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?&feed=$matches[1]&withcomments=1\";s:17:\"comments/embed/?$\";s:21:\"index.php?&embed=true\";s:44:\"search/(.+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:40:\"index.php?s=$matches[1]&feed=$matches[2]\";s:39:\"search/(.+)/(feed|rdf|rss|rss2|atom)/?$\";s:40:\"index.php?s=$matches[1]&feed=$matches[2]\";s:20:\"search/(.+)/embed/?$\";s:34:\"index.php?s=$matches[1]&embed=true\";s:32:\"search/(.+)/page/?([0-9]{1,})/?$\";s:41:\"index.php?s=$matches[1]&paged=$matches[2]\";s:14:\"search/(.+)/?$\";s:23:\"index.php?s=$matches[1]\";s:47:\"author/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?author_name=$matches[1]&feed=$matches[2]\";s:42:\"author/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?author_name=$matches[1]&feed=$matches[2]\";s:23:\"author/([^/]+)/embed/?$\";s:44:\"index.php?author_name=$matches[1]&embed=true\";s:35:\"author/([^/]+)/page/?([0-9]{1,})/?$\";s:51:\"index.php?author_name=$matches[1]&paged=$matches[2]\";s:17:\"author/([^/]+)/?$\";s:33:\"index.php?author_name=$matches[1]\";s:69:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:64:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:45:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/embed/?$\";s:74:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&embed=true\";s:57:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:81:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&paged=$matches[4]\";s:39:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/?$\";s:63:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]\";s:56:\"([0-9]{4})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:51:\"([0-9]{4})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:32:\"([0-9]{4})/([0-9]{1,2})/embed/?$\";s:58:\"index.php?year=$matches[1]&monthnum=$matches[2]&embed=true\";s:44:\"([0-9]{4})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:65:\"index.php?year=$matches[1]&monthnum=$matches[2]&paged=$matches[3]\";s:26:\"([0-9]{4})/([0-9]{1,2})/?$\";s:47:\"index.php?year=$matches[1]&monthnum=$matches[2]\";s:43:\"([0-9]{4})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:38:\"([0-9]{4})/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:19:\"([0-9]{4})/embed/?$\";s:37:\"index.php?year=$matches[1]&embed=true\";s:31:\"([0-9]{4})/page/?([0-9]{1,})/?$\";s:44:\"index.php?year=$matches[1]&paged=$matches[2]\";s:13:\"([0-9]{4})/?$\";s:26:\"index.php?year=$matches[1]\";s:27:\".?.+?/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:37:\".?.+?/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:57:\".?.+?/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\".?.+?/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\".?.+?/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:33:\".?.+?/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:16:\"(.?.+?)/embed/?$\";s:41:\"index.php?pagename=$matches[1]&embed=true\";s:20:\"(.?.+?)/trackback/?$\";s:35:\"index.php?pagename=$matches[1]&tb=1\";s:40:\"(.?.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:35:\"(.?.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:28:\"(.?.+?)/page/?([0-9]{1,})/?$\";s:48:\"index.php?pagename=$matches[1]&paged=$matches[2]\";s:35:\"(.?.+?)/comment-page-([0-9]{1,})/?$\";s:48:\"index.php?pagename=$matches[1]&cpage=$matches[2]\";s:24:\"(.?.+?)(?:/([0-9]+))?/?$\";s:47:\"index.php?pagename=$matches[1]&page=$matches[2]\";s:27:\"[^/]+/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:37:\"[^/]+/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:57:\"[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\"[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\"[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:33:\"[^/]+/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:16:\"([^/]+)/embed/?$\";s:37:\"index.php?name=$matches[1]&embed=true\";s:20:\"([^/]+)/trackback/?$\";s:31:\"index.php?name=$matches[1]&tb=1\";s:40:\"([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?name=$matches[1]&feed=$matches[2]\";s:35:\"([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?name=$matches[1]&feed=$matches[2]\";s:28:\"([^/]+)/page/?([0-9]{1,})/?$\";s:44:\"index.php?name=$matches[1]&paged=$matches[2]\";s:35:\"([^/]+)/comment-page-([0-9]{1,})/?$\";s:44:\"index.php?name=$matches[1]&cpage=$matches[2]\";s:24:\"([^/]+)(?:/([0-9]+))?/?$\";s:43:\"index.php?name=$matches[1]&page=$matches[2]\";s:16:\"[^/]+/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:26:\"[^/]+/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:46:\"[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:41:\"[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:41:\"[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:22:\"[^/]+/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";}','yes');
INSERT INTO `wp_options` VALUES (30,'hack_file','0','yes');
INSERT INTO `wp_options` VALUES (31,'blog_charset','UTF-8','yes');
INSERT INTO `wp_options` VALUES (32,'moderation_keys','','no');
INSERT INTO `wp_options` VALUES (33,'active_plugins','a:2:{i:0;s:41:\"events-manager-pro/events-manager-pro.php\";i:1;s:33:\"events-manager/events-manager.php\";}','yes');
INSERT INTO `wp_options` VALUES (34,'category_base','','yes');
INSERT INTO `wp_options` VALUES (35,'ping_sites','http://rpc.pingomatic.com/','yes');
INSERT INTO `wp_options` VALUES (36,'comment_max_links','2','yes');
INSERT INTO `wp_options` VALUES (37,'gmt_offset','0','yes');
INSERT INTO `wp_options` VALUES (38,'default_email_category','1','yes');
INSERT INTO `wp_options` VALUES (39,'recently_edited','','no');
INSERT INTO `wp_options` VALUES (40,'template','understrap','yes');
INSERT INTO `wp_options` VALUES (41,'stylesheet','demijngang','yes');
INSERT INTO `wp_options` VALUES (42,'comment_registration','0','yes');
INSERT INTO `wp_options` VALUES (43,'html_type','text/html','yes');
INSERT INTO `wp_options` VALUES (44,'use_trackback','0','yes');
INSERT INTO `wp_options` VALUES (45,'default_role','subscriber','yes');
INSERT INTO `wp_options` VALUES (46,'db_version','57155','yes');
INSERT INTO `wp_options` VALUES (47,'uploads_use_yearmonth_folders','1','yes');
INSERT INTO `wp_options` VALUES (48,'upload_path','','yes');
INSERT INTO `wp_options` VALUES (49,'blog_public','1','yes');
INSERT INTO `wp_options` VALUES (50,'default_link_category','2','yes');
INSERT INTO `wp_options` VALUES (51,'show_on_front','page','yes');
INSERT INTO `wp_options` VALUES (52,'tag_base','','yes');
INSERT INTO `wp_options` VALUES (53,'show_avatars','1','yes');
INSERT INTO `wp_options` VALUES (54,'avatar_rating','G','yes');
INSERT INTO `wp_options` VALUES (55,'upload_url_path','','yes');
INSERT INTO `wp_options` VALUES (56,'thumbnail_size_w','150','yes');
INSERT INTO `wp_options` VALUES (57,'thumbnail_size_h','150','yes');
INSERT INTO `wp_options` VALUES (58,'thumbnail_crop','1','yes');
INSERT INTO `wp_options` VALUES (59,'medium_size_w','300','yes');
INSERT INTO `wp_options` VALUES (60,'medium_size_h','300','yes');
INSERT INTO `wp_options` VALUES (61,'avatar_default','mystery','yes');
INSERT INTO `wp_options` VALUES (62,'large_size_w','1024','yes');
INSERT INTO `wp_options` VALUES (63,'large_size_h','1024','yes');
INSERT INTO `wp_options` VALUES (64,'image_default_link_type','none','yes');
INSERT INTO `wp_options` VALUES (65,'image_default_size','','yes');
INSERT INTO `wp_options` VALUES (66,'image_default_align','','yes');
INSERT INTO `wp_options` VALUES (67,'close_comments_for_old_posts','0','yes');
INSERT INTO `wp_options` VALUES (68,'close_comments_days_old','14','yes');
INSERT INTO `wp_options` VALUES (69,'thread_comments','1','yes');
INSERT INTO `wp_options` VALUES (70,'thread_comments_depth','5','yes');
INSERT INTO `wp_options` VALUES (71,'page_comments','0','yes');
INSERT INTO `wp_options` VALUES (72,'comments_per_page','50','yes');
INSERT INTO `wp_options` VALUES (73,'default_comments_page','newest','yes');
INSERT INTO `wp_options` VALUES (74,'comment_order','asc','yes');
INSERT INTO `wp_options` VALUES (75,'sticky_posts','a:0:{}','yes');
INSERT INTO `wp_options` VALUES (76,'widget_categories','a:2:{i:1;a:0:{}s:12:\"_multiwidget\";i:1;}','yes');
INSERT INTO `wp_options` VALUES (77,'widget_text','a:2:{i:1;a:0:{}s:12:\"_multiwidget\";i:1;}','yes');
INSERT INTO `wp_options` VALUES (78,'widget_rss','a:2:{i:1;a:0:{}s:12:\"_multiwidget\";i:1;}','yes');
INSERT INTO `wp_options` VALUES (79,'uninstall_plugins','a:0:{}','no');
INSERT INTO `wp_options` VALUES (80,'timezone_string','','yes');
INSERT INTO `wp_options` VALUES (81,'page_for_posts','0','yes');
INSERT INTO `wp_options` VALUES (82,'page_on_front','6','yes');
INSERT INTO `wp_options` VALUES (83,'default_post_format','0','yes');
INSERT INTO `wp_options` VALUES (84,'link_manager_enabled','0','yes');
INSERT INTO `wp_options` VALUES (85,'finished_splitting_shared_terms','1','yes');
INSERT INTO `wp_options` VALUES (86,'site_icon','0','yes');
INSERT INTO `wp_options` VALUES (87,'medium_large_size_w','768','yes');
INSERT INTO `wp_options` VALUES (88,'medium_large_size_h','0','yes');
INSERT INTO `wp_options` VALUES (89,'wp_page_for_privacy_policy','3','yes');
INSERT INTO `wp_options` VALUES (90,'show_comments_cookies_opt_in','1','yes');
INSERT INTO `wp_options` VALUES (91,'admin_email_lifespan','1731493638','yes');
INSERT INTO `wp_options` VALUES (92,'disallowed_keys','','no');
INSERT INTO `wp_options` VALUES (93,'comment_previously_approved','1','yes');
INSERT INTO `wp_options` VALUES (94,'auto_plugin_theme_update_emails','a:0:{}','no');
INSERT INTO `wp_options` VALUES (95,'auto_update_core_dev','enabled','yes');
INSERT INTO `wp_options` VALUES (96,'auto_update_core_minor','enabled','yes');
INSERT INTO `wp_options` VALUES (97,'auto_update_core_major','enabled','yes');
INSERT INTO `wp_options` VALUES (98,'wp_force_deactivated_plugins','a:0:{}','yes');
INSERT INTO `wp_options` VALUES (99,'wp_attachment_pages_enabled','0','yes');
INSERT INTO `wp_options` VALUES (100,'initial_db_version','57155','yes');
INSERT INTO `wp_options` VALUES (101,'wp_user_roles','a:5:{s:13:\"administrator\";a:2:{s:4:\"name\";s:13:\"Administrator\";s:12:\"capabilities\";a:84:{s:13:\"switch_themes\";b:1;s:11:\"edit_themes\";b:1;s:16:\"activate_plugins\";b:1;s:12:\"edit_plugins\";b:1;s:10:\"edit_users\";b:1;s:10:\"edit_files\";b:1;s:14:\"manage_options\";b:1;s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:6:\"import\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:8:\"level_10\";b:1;s:7:\"level_9\";b:1;s:7:\"level_8\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;s:12:\"delete_users\";b:1;s:12:\"create_users\";b:1;s:17:\"unfiltered_upload\";b:1;s:14:\"edit_dashboard\";b:1;s:14:\"update_plugins\";b:1;s:14:\"delete_plugins\";b:1;s:15:\"install_plugins\";b:1;s:13:\"update_themes\";b:1;s:14:\"install_themes\";b:1;s:11:\"update_core\";b:1;s:10:\"list_users\";b:1;s:12:\"remove_users\";b:1;s:13:\"promote_users\";b:1;s:18:\"edit_theme_options\";b:1;s:13:\"delete_themes\";b:1;s:6:\"export\";b:1;s:14:\"publish_events\";b:1;s:20:\"delete_others_events\";b:1;s:18:\"edit_others_events\";b:1;s:22:\"manage_others_bookings\";b:1;s:24:\"publish_recurring_events\";b:1;s:30:\"delete_others_recurring_events\";b:1;s:28:\"edit_others_recurring_events\";b:1;s:17:\"publish_locations\";b:1;s:23:\"delete_others_locations\";b:1;s:16:\"delete_locations\";b:1;s:21:\"edit_others_locations\";b:1;s:23:\"delete_event_categories\";b:1;s:21:\"edit_event_categories\";b:1;s:15:\"manage_bookings\";b:1;s:19:\"upload_event_images\";b:1;s:13:\"delete_events\";b:1;s:11:\"edit_events\";b:1;s:19:\"read_private_events\";b:1;s:23:\"delete_recurring_events\";b:1;s:21:\"edit_recurring_events\";b:1;s:14:\"edit_locations\";b:1;s:22:\"read_private_locations\";b:1;s:21:\"read_others_locations\";b:1;}}s:6:\"editor\";a:2:{s:4:\"name\";s:6:\"Editor\";s:12:\"capabilities\";a:57:{s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;s:14:\"publish_events\";b:1;s:20:\"delete_others_events\";b:1;s:18:\"edit_others_events\";b:1;s:22:\"manage_others_bookings\";b:1;s:24:\"publish_recurring_events\";b:1;s:30:\"delete_others_recurring_events\";b:1;s:28:\"edit_others_recurring_events\";b:1;s:17:\"publish_locations\";b:1;s:23:\"delete_others_locations\";b:1;s:16:\"delete_locations\";b:1;s:21:\"edit_others_locations\";b:1;s:23:\"delete_event_categories\";b:1;s:21:\"edit_event_categories\";b:1;s:15:\"manage_bookings\";b:1;s:19:\"upload_event_images\";b:1;s:13:\"delete_events\";b:1;s:11:\"edit_events\";b:1;s:19:\"read_private_events\";b:1;s:23:\"delete_recurring_events\";b:1;s:21:\"edit_recurring_events\";b:1;s:14:\"edit_locations\";b:1;s:22:\"read_private_locations\";b:1;s:21:\"read_others_locations\";b:1;}}s:6:\"author\";a:2:{s:4:\"name\";s:6:\"Author\";s:12:\"capabilities\";a:20:{s:12:\"upload_files\";b:1;s:10:\"edit_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:15:\"manage_bookings\";b:1;s:19:\"upload_event_images\";b:1;s:13:\"delete_events\";b:1;s:11:\"edit_events\";b:1;s:19:\"read_private_events\";b:1;s:23:\"delete_recurring_events\";b:1;s:21:\"edit_recurring_events\";b:1;s:14:\"edit_locations\";b:1;s:22:\"read_private_locations\";b:1;s:21:\"read_others_locations\";b:1;}}s:11:\"contributor\";a:2:{s:4:\"name\";s:11:\"Contributor\";s:12:\"capabilities\";a:15:{s:10:\"edit_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;s:15:\"manage_bookings\";b:1;s:19:\"upload_event_images\";b:1;s:13:\"delete_events\";b:1;s:11:\"edit_events\";b:1;s:19:\"read_private_events\";b:1;s:23:\"delete_recurring_events\";b:1;s:21:\"edit_recurring_events\";b:1;s:14:\"edit_locations\";b:1;s:22:\"read_private_locations\";b:1;s:21:\"read_others_locations\";b:1;}}s:10:\"subscriber\";a:2:{s:4:\"name\";s:10:\"Subscriber\";s:12:\"capabilities\";a:4:{s:4:\"read\";b:1;s:7:\"level_0\";b:1;s:22:\"read_private_locations\";b:1;s:19:\"read_private_events\";b:1;}}}','yes');
INSERT INTO `wp_options` VALUES (102,'fresh_site','0','yes');
INSERT INTO `wp_options` VALUES (103,'user_count','1','no');
INSERT INTO `wp_options` VALUES (104,'widget_block','a:8:{i:5;a:1:{s:7:\"content\";s:146:\"<!-- wp:group --><div class=\"wp-block-group\"><!-- wp:heading --><h2>Archives</h2><!-- /wp:heading --><!-- wp:archives /--></div><!-- /wp:group -->\";}i:6;a:1:{s:7:\"content\";s:150:\"<!-- wp:group --><div class=\"wp-block-group\"><!-- wp:heading --><h2>Categories</h2><!-- /wp:heading --><!-- wp:categories /--></div><!-- /wp:group -->\";}i:7;a:1:{s:7:\"content\";s:362:\"<!-- wp:group {\"layout\":{\"type\":\"flex\",\"orientation\":\"vertical\",\"justifyContent\":\"center\"}} -->\n<div class=\"wp-block-group\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Soep voor DD-MM-YYYY</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Overheerlijke X soep!</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:group -->\";}i:8;a:1:{s:7:\"content\";s:299:\"<!-- wp:group {\"layout\":{\"type\":\"flex\",\"orientation\":\"vertical\"}} -->\n<div class=\"wp-block-group\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Nieuws</h2>\n<!-- /wp:heading -->\n\n<!-- wp:latest-posts {\"displayPostDate\":true} /--></div>\n<!-- /wp:group -->\";}i:9;a:1:{s:7:\"content\";s:157:\"<!-- wp:group {\"layout\":{\"type\":\"constrained\"}} -->\n<div class=\"wp-block-group\"><!-- wp:html -->\n[events_calendar]\n<!-- /wp:html --></div>\n<!-- /wp:group -->\";}i:10;a:1:{s:7:\"content\";s:103:\"<!-- wp:separator -->\n<hr class=\"wp-block-separator has-alpha-channel-opacity\"/>\n<!-- /wp:separator -->\";}i:11;a:1:{s:7:\"content\";s:103:\"<!-- wp:separator -->\n<hr class=\"wp-block-separator has-alpha-channel-opacity\"/>\n<!-- /wp:separator -->\";}s:12:\"_multiwidget\";i:1;}','yes');
INSERT INTO `wp_options` VALUES (105,'sidebars_widgets','a:8:{s:19:\"wp_inactive_widgets\";a:0:{}s:13:\"right-sidebar\";a:5:{i:0;s:7:\"block-7\";i:1;s:8:\"block-10\";i:2;s:7:\"block-8\";i:3;s:8:\"block-11\";i:4;s:7:\"block-9\";}s:12:\"left-sidebar\";a:2:{i:0;s:7:\"block-5\";i:1;s:7:\"block-6\";}s:4:\"hero\";a:0:{}s:10:\"herocanvas\";a:0:{}s:10:\"statichero\";a:0:{}s:10:\"footerfull\";a:0:{}s:13:\"array_version\";i:3;}','yes');
INSERT INTO `wp_options` VALUES (106,'cron','a:11:{i:1716549574;a:1:{s:16:\"em_gateways_cron\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:9:\"em_minute\";s:4:\"args\";a:0:{}s:8:\"interval\";i:60;}}}i:1716549578;a:1:{s:29:\"emp_cron_emails_process_queue\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:9:\"em_minute\";s:4:\"args\";a:0:{}s:8:\"interval\";i:60;}}}i:1716550041;a:1:{s:34:\"wp_privacy_delete_old_export_files\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"hourly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:3600;}}}i:1716589641;a:3:{s:16:\"wp_version_check\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}s:17:\"wp_update_plugins\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}s:16:\"wp_update_themes\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}}i:1716589847;a:1:{s:21:\"wp_update_user_counts\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}}i:1716595200;a:1:{s:34:\"emp_cron_emails_attachment_cleanup\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1716632841;a:2:{s:30:\"wp_site_health_scheduled_check\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"weekly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:604800;}}s:32:\"recovery_mode_clean_expired_keys\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1716633047;a:2:{s:19:\"wp_scheduled_delete\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}s:25:\"delete_expired_transients\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1716633048;a:1:{s:30:\"wp_scheduled_auto_draft_delete\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1717151455;a:1:{s:30:\"wp_delete_temp_updater_backups\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"weekly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:604800;}}}s:7:\"version\";i:2;}','yes');
INSERT INTO `wp_options` VALUES (107,'widget_pages','a:1:{s:12:\"_multiwidget\";i:1;}','yes');
INSERT INTO `wp_options` VALUES (108,'widget_calendar','a:1:{s:12:\"_multiwidget\";i:1;}','yes');
INSERT INTO `wp_options` VALUES (109,'widget_archives','a:1:{s:12:\"_multiwidget\";i:1;}','yes');
INSERT INTO `wp_options` VALUES (110,'widget_media_audio','a:1:{s:12:\"_multiwidget\";i:1;}','yes');
INSERT INTO `wp_options` VALUES (111,'widget_media_image','a:1:{s:12:\"_multiwidget\";i:1;}','yes');
INSERT INTO `wp_options` VALUES (112,'widget_media_gallery','a:1:{s:12:\"_multiwidget\";i:1;}','yes');
INSERT INTO `wp_options` VALUES (113,'widget_media_video','a:1:{s:12:\"_multiwidget\";i:1;}','yes');
INSERT INTO `wp_options` VALUES (114,'widget_meta','a:1:{s:12:\"_multiwidget\";i:1;}','yes');
INSERT INTO `wp_options` VALUES (115,'widget_search','a:1:{s:12:\"_multiwidget\";i:1;}','yes');
INSERT INTO `wp_options` VALUES (116,'widget_recent-posts','a:1:{s:12:\"_multiwidget\";i:1;}','yes');
INSERT INTO `wp_options` VALUES (117,'widget_recent-comments','a:1:{s:12:\"_multiwidget\";i:1;}','yes');
INSERT INTO `wp_options` VALUES (118,'widget_tag_cloud','a:1:{s:12:\"_multiwidget\";i:1;}','yes');
INSERT INTO `wp_options` VALUES (119,'widget_nav_menu','a:1:{s:12:\"_multiwidget\";i:1;}','yes');
INSERT INTO `wp_options` VALUES (120,'widget_custom_html','a:1:{s:12:\"_multiwidget\";i:1;}','yes');
INSERT INTO `wp_options` VALUES (121,'_transient_wp_core_block_css_files','a:2:{s:7:\"version\";s:5:\"6.5.3\";s:5:\"files\";a:500:{i:0;s:23:\"archives/editor-rtl.css\";i:1;s:27:\"archives/editor-rtl.min.css\";i:2;s:19:\"archives/editor.css\";i:3;s:23:\"archives/editor.min.css\";i:4;s:22:\"archives/style-rtl.css\";i:5;s:26:\"archives/style-rtl.min.css\";i:6;s:18:\"archives/style.css\";i:7;s:22:\"archives/style.min.css\";i:8;s:20:\"audio/editor-rtl.css\";i:9;s:24:\"audio/editor-rtl.min.css\";i:10;s:16:\"audio/editor.css\";i:11;s:20:\"audio/editor.min.css\";i:12;s:19:\"audio/style-rtl.css\";i:13;s:23:\"audio/style-rtl.min.css\";i:14;s:15:\"audio/style.css\";i:15;s:19:\"audio/style.min.css\";i:16;s:19:\"audio/theme-rtl.css\";i:17;s:23:\"audio/theme-rtl.min.css\";i:18;s:15:\"audio/theme.css\";i:19;s:19:\"audio/theme.min.css\";i:20;s:21:\"avatar/editor-rtl.css\";i:21;s:25:\"avatar/editor-rtl.min.css\";i:22;s:17:\"avatar/editor.css\";i:23;s:21:\"avatar/editor.min.css\";i:24;s:20:\"avatar/style-rtl.css\";i:25;s:24:\"avatar/style-rtl.min.css\";i:26;s:16:\"avatar/style.css\";i:27;s:20:\"avatar/style.min.css\";i:28;s:20:\"block/editor-rtl.css\";i:29;s:24:\"block/editor-rtl.min.css\";i:30;s:16:\"block/editor.css\";i:31;s:20:\"block/editor.min.css\";i:32;s:21:\"button/editor-rtl.css\";i:33;s:25:\"button/editor-rtl.min.css\";i:34;s:17:\"button/editor.css\";i:35;s:21:\"button/editor.min.css\";i:36;s:20:\"button/style-rtl.css\";i:37;s:24:\"button/style-rtl.min.css\";i:38;s:16:\"button/style.css\";i:39;s:20:\"button/style.min.css\";i:40;s:22:\"buttons/editor-rtl.css\";i:41;s:26:\"buttons/editor-rtl.min.css\";i:42;s:18:\"buttons/editor.css\";i:43;s:22:\"buttons/editor.min.css\";i:44;s:21:\"buttons/style-rtl.css\";i:45;s:25:\"buttons/style-rtl.min.css\";i:46;s:17:\"buttons/style.css\";i:47;s:21:\"buttons/style.min.css\";i:48;s:22:\"calendar/style-rtl.css\";i:49;s:26:\"calendar/style-rtl.min.css\";i:50;s:18:\"calendar/style.css\";i:51;s:22:\"calendar/style.min.css\";i:52;s:25:\"categories/editor-rtl.css\";i:53;s:29:\"categories/editor-rtl.min.css\";i:54;s:21:\"categories/editor.css\";i:55;s:25:\"categories/editor.min.css\";i:56;s:24:\"categories/style-rtl.css\";i:57;s:28:\"categories/style-rtl.min.css\";i:58;s:20:\"categories/style.css\";i:59;s:24:\"categories/style.min.css\";i:60;s:19:\"code/editor-rtl.css\";i:61;s:23:\"code/editor-rtl.min.css\";i:62;s:15:\"code/editor.css\";i:63;s:19:\"code/editor.min.css\";i:64;s:18:\"code/style-rtl.css\";i:65;s:22:\"code/style-rtl.min.css\";i:66;s:14:\"code/style.css\";i:67;s:18:\"code/style.min.css\";i:68;s:18:\"code/theme-rtl.css\";i:69;s:22:\"code/theme-rtl.min.css\";i:70;s:14:\"code/theme.css\";i:71;s:18:\"code/theme.min.css\";i:72;s:22:\"columns/editor-rtl.css\";i:73;s:26:\"columns/editor-rtl.min.css\";i:74;s:18:\"columns/editor.css\";i:75;s:22:\"columns/editor.min.css\";i:76;s:21:\"columns/style-rtl.css\";i:77;s:25:\"columns/style-rtl.min.css\";i:78;s:17:\"columns/style.css\";i:79;s:21:\"columns/style.min.css\";i:80;s:29:\"comment-content/style-rtl.css\";i:81;s:33:\"comment-content/style-rtl.min.css\";i:82;s:25:\"comment-content/style.css\";i:83;s:29:\"comment-content/style.min.css\";i:84;s:30:\"comment-template/style-rtl.css\";i:85;s:34:\"comment-template/style-rtl.min.css\";i:86;s:26:\"comment-template/style.css\";i:87;s:30:\"comment-template/style.min.css\";i:88;s:42:\"comments-pagination-numbers/editor-rtl.css\";i:89;s:46:\"comments-pagination-numbers/editor-rtl.min.css\";i:90;s:38:\"comments-pagination-numbers/editor.css\";i:91;s:42:\"comments-pagination-numbers/editor.min.css\";i:92;s:34:\"comments-pagination/editor-rtl.css\";i:93;s:38:\"comments-pagination/editor-rtl.min.css\";i:94;s:30:\"comments-pagination/editor.css\";i:95;s:34:\"comments-pagination/editor.min.css\";i:96;s:33:\"comments-pagination/style-rtl.css\";i:97;s:37:\"comments-pagination/style-rtl.min.css\";i:98;s:29:\"comments-pagination/style.css\";i:99;s:33:\"comments-pagination/style.min.css\";i:100;s:29:\"comments-title/editor-rtl.css\";i:101;s:33:\"comments-title/editor-rtl.min.css\";i:102;s:25:\"comments-title/editor.css\";i:103;s:29:\"comments-title/editor.min.css\";i:104;s:23:\"comments/editor-rtl.css\";i:105;s:27:\"comments/editor-rtl.min.css\";i:106;s:19:\"comments/editor.css\";i:107;s:23:\"comments/editor.min.css\";i:108;s:22:\"comments/style-rtl.css\";i:109;s:26:\"comments/style-rtl.min.css\";i:110;s:18:\"comments/style.css\";i:111;s:22:\"comments/style.min.css\";i:112;s:20:\"cover/editor-rtl.css\";i:113;s:24:\"cover/editor-rtl.min.css\";i:114;s:16:\"cover/editor.css\";i:115;s:20:\"cover/editor.min.css\";i:116;s:19:\"cover/style-rtl.css\";i:117;s:23:\"cover/style-rtl.min.css\";i:118;s:15:\"cover/style.css\";i:119;s:19:\"cover/style.min.css\";i:120;s:22:\"details/editor-rtl.css\";i:121;s:26:\"details/editor-rtl.min.css\";i:122;s:18:\"details/editor.css\";i:123;s:22:\"details/editor.min.css\";i:124;s:21:\"details/style-rtl.css\";i:125;s:25:\"details/style-rtl.min.css\";i:126;s:17:\"details/style.css\";i:127;s:21:\"details/style.min.css\";i:128;s:20:\"embed/editor-rtl.css\";i:129;s:24:\"embed/editor-rtl.min.css\";i:130;s:16:\"embed/editor.css\";i:131;s:20:\"embed/editor.min.css\";i:132;s:19:\"embed/style-rtl.css\";i:133;s:23:\"embed/style-rtl.min.css\";i:134;s:15:\"embed/style.css\";i:135;s:19:\"embed/style.min.css\";i:136;s:19:\"embed/theme-rtl.css\";i:137;s:23:\"embed/theme-rtl.min.css\";i:138;s:15:\"embed/theme.css\";i:139;s:19:\"embed/theme.min.css\";i:140;s:19:\"file/editor-rtl.css\";i:141;s:23:\"file/editor-rtl.min.css\";i:142;s:15:\"file/editor.css\";i:143;s:19:\"file/editor.min.css\";i:144;s:18:\"file/style-rtl.css\";i:145;s:22:\"file/style-rtl.min.css\";i:146;s:14:\"file/style.css\";i:147;s:18:\"file/style.min.css\";i:148;s:23:\"footnotes/style-rtl.css\";i:149;s:27:\"footnotes/style-rtl.min.css\";i:150;s:19:\"footnotes/style.css\";i:151;s:23:\"footnotes/style.min.css\";i:152;s:23:\"freeform/editor-rtl.css\";i:153;s:27:\"freeform/editor-rtl.min.css\";i:154;s:19:\"freeform/editor.css\";i:155;s:23:\"freeform/editor.min.css\";i:156;s:22:\"gallery/editor-rtl.css\";i:157;s:26:\"gallery/editor-rtl.min.css\";i:158;s:18:\"gallery/editor.css\";i:159;s:22:\"gallery/editor.min.css\";i:160;s:21:\"gallery/style-rtl.css\";i:161;s:25:\"gallery/style-rtl.min.css\";i:162;s:17:\"gallery/style.css\";i:163;s:21:\"gallery/style.min.css\";i:164;s:21:\"gallery/theme-rtl.css\";i:165;s:25:\"gallery/theme-rtl.min.css\";i:166;s:17:\"gallery/theme.css\";i:167;s:21:\"gallery/theme.min.css\";i:168;s:20:\"group/editor-rtl.css\";i:169;s:24:\"group/editor-rtl.min.css\";i:170;s:16:\"group/editor.css\";i:171;s:20:\"group/editor.min.css\";i:172;s:19:\"group/style-rtl.css\";i:173;s:23:\"group/style-rtl.min.css\";i:174;s:15:\"group/style.css\";i:175;s:19:\"group/style.min.css\";i:176;s:19:\"group/theme-rtl.css\";i:177;s:23:\"group/theme-rtl.min.css\";i:178;s:15:\"group/theme.css\";i:179;s:19:\"group/theme.min.css\";i:180;s:21:\"heading/style-rtl.css\";i:181;s:25:\"heading/style-rtl.min.css\";i:182;s:17:\"heading/style.css\";i:183;s:21:\"heading/style.min.css\";i:184;s:19:\"html/editor-rtl.css\";i:185;s:23:\"html/editor-rtl.min.css\";i:186;s:15:\"html/editor.css\";i:187;s:19:\"html/editor.min.css\";i:188;s:20:\"image/editor-rtl.css\";i:189;s:24:\"image/editor-rtl.min.css\";i:190;s:16:\"image/editor.css\";i:191;s:20:\"image/editor.min.css\";i:192;s:19:\"image/style-rtl.css\";i:193;s:23:\"image/style-rtl.min.css\";i:194;s:15:\"image/style.css\";i:195;s:19:\"image/style.min.css\";i:196;s:19:\"image/theme-rtl.css\";i:197;s:23:\"image/theme-rtl.min.css\";i:198;s:15:\"image/theme.css\";i:199;s:19:\"image/theme.min.css\";i:200;s:29:\"latest-comments/style-rtl.css\";i:201;s:33:\"latest-comments/style-rtl.min.css\";i:202;s:25:\"latest-comments/style.css\";i:203;s:29:\"latest-comments/style.min.css\";i:204;s:27:\"latest-posts/editor-rtl.css\";i:205;s:31:\"latest-posts/editor-rtl.min.css\";i:206;s:23:\"latest-posts/editor.css\";i:207;s:27:\"latest-posts/editor.min.css\";i:208;s:26:\"latest-posts/style-rtl.css\";i:209;s:30:\"latest-posts/style-rtl.min.css\";i:210;s:22:\"latest-posts/style.css\";i:211;s:26:\"latest-posts/style.min.css\";i:212;s:18:\"list/style-rtl.css\";i:213;s:22:\"list/style-rtl.min.css\";i:214;s:14:\"list/style.css\";i:215;s:18:\"list/style.min.css\";i:216;s:25:\"media-text/editor-rtl.css\";i:217;s:29:\"media-text/editor-rtl.min.css\";i:218;s:21:\"media-text/editor.css\";i:219;s:25:\"media-text/editor.min.css\";i:220;s:24:\"media-text/style-rtl.css\";i:221;s:28:\"media-text/style-rtl.min.css\";i:222;s:20:\"media-text/style.css\";i:223;s:24:\"media-text/style.min.css\";i:224;s:19:\"more/editor-rtl.css\";i:225;s:23:\"more/editor-rtl.min.css\";i:226;s:15:\"more/editor.css\";i:227;s:19:\"more/editor.min.css\";i:228;s:30:\"navigation-link/editor-rtl.css\";i:229;s:34:\"navigation-link/editor-rtl.min.css\";i:230;s:26:\"navigation-link/editor.css\";i:231;s:30:\"navigation-link/editor.min.css\";i:232;s:29:\"navigation-link/style-rtl.css\";i:233;s:33:\"navigation-link/style-rtl.min.css\";i:234;s:25:\"navigation-link/style.css\";i:235;s:29:\"navigation-link/style.min.css\";i:236;s:33:\"navigation-submenu/editor-rtl.css\";i:237;s:37:\"navigation-submenu/editor-rtl.min.css\";i:238;s:29:\"navigation-submenu/editor.css\";i:239;s:33:\"navigation-submenu/editor.min.css\";i:240;s:25:\"navigation/editor-rtl.css\";i:241;s:29:\"navigation/editor-rtl.min.css\";i:242;s:21:\"navigation/editor.css\";i:243;s:25:\"navigation/editor.min.css\";i:244;s:24:\"navigation/style-rtl.css\";i:245;s:28:\"navigation/style-rtl.min.css\";i:246;s:20:\"navigation/style.css\";i:247;s:24:\"navigation/style.min.css\";i:248;s:23:\"nextpage/editor-rtl.css\";i:249;s:27:\"nextpage/editor-rtl.min.css\";i:250;s:19:\"nextpage/editor.css\";i:251;s:23:\"nextpage/editor.min.css\";i:252;s:24:\"page-list/editor-rtl.css\";i:253;s:28:\"page-list/editor-rtl.min.css\";i:254;s:20:\"page-list/editor.css\";i:255;s:24:\"page-list/editor.min.css\";i:256;s:23:\"page-list/style-rtl.css\";i:257;s:27:\"page-list/style-rtl.min.css\";i:258;s:19:\"page-list/style.css\";i:259;s:23:\"page-list/style.min.css\";i:260;s:24:\"paragraph/editor-rtl.css\";i:261;s:28:\"paragraph/editor-rtl.min.css\";i:262;s:20:\"paragraph/editor.css\";i:263;s:24:\"paragraph/editor.min.css\";i:264;s:23:\"paragraph/style-rtl.css\";i:265;s:27:\"paragraph/style-rtl.min.css\";i:266;s:19:\"paragraph/style.css\";i:267;s:23:\"paragraph/style.min.css\";i:268;s:25:\"post-author/style-rtl.css\";i:269;s:29:\"post-author/style-rtl.min.css\";i:270;s:21:\"post-author/style.css\";i:271;s:25:\"post-author/style.min.css\";i:272;s:33:\"post-comments-form/editor-rtl.css\";i:273;s:37:\"post-comments-form/editor-rtl.min.css\";i:274;s:29:\"post-comments-form/editor.css\";i:275;s:33:\"post-comments-form/editor.min.css\";i:276;s:32:\"post-comments-form/style-rtl.css\";i:277;s:36:\"post-comments-form/style-rtl.min.css\";i:278;s:28:\"post-comments-form/style.css\";i:279;s:32:\"post-comments-form/style.min.css\";i:280;s:27:\"post-content/editor-rtl.css\";i:281;s:31:\"post-content/editor-rtl.min.css\";i:282;s:23:\"post-content/editor.css\";i:283;s:27:\"post-content/editor.min.css\";i:284;s:23:\"post-date/style-rtl.css\";i:285;s:27:\"post-date/style-rtl.min.css\";i:286;s:19:\"post-date/style.css\";i:287;s:23:\"post-date/style.min.css\";i:288;s:27:\"post-excerpt/editor-rtl.css\";i:289;s:31:\"post-excerpt/editor-rtl.min.css\";i:290;s:23:\"post-excerpt/editor.css\";i:291;s:27:\"post-excerpt/editor.min.css\";i:292;s:26:\"post-excerpt/style-rtl.css\";i:293;s:30:\"post-excerpt/style-rtl.min.css\";i:294;s:22:\"post-excerpt/style.css\";i:295;s:26:\"post-excerpt/style.min.css\";i:296;s:34:\"post-featured-image/editor-rtl.css\";i:297;s:38:\"post-featured-image/editor-rtl.min.css\";i:298;s:30:\"post-featured-image/editor.css\";i:299;s:34:\"post-featured-image/editor.min.css\";i:300;s:33:\"post-featured-image/style-rtl.css\";i:301;s:37:\"post-featured-image/style-rtl.min.css\";i:302;s:29:\"post-featured-image/style.css\";i:303;s:33:\"post-featured-image/style.min.css\";i:304;s:34:\"post-navigation-link/style-rtl.css\";i:305;s:38:\"post-navigation-link/style-rtl.min.css\";i:306;s:30:\"post-navigation-link/style.css\";i:307;s:34:\"post-navigation-link/style.min.css\";i:308;s:28:\"post-template/editor-rtl.css\";i:309;s:32:\"post-template/editor-rtl.min.css\";i:310;s:24:\"post-template/editor.css\";i:311;s:28:\"post-template/editor.min.css\";i:312;s:27:\"post-template/style-rtl.css\";i:313;s:31:\"post-template/style-rtl.min.css\";i:314;s:23:\"post-template/style.css\";i:315;s:27:\"post-template/style.min.css\";i:316;s:24:\"post-terms/style-rtl.css\";i:317;s:28:\"post-terms/style-rtl.min.css\";i:318;s:20:\"post-terms/style.css\";i:319;s:24:\"post-terms/style.min.css\";i:320;s:24:\"post-title/style-rtl.css\";i:321;s:28:\"post-title/style-rtl.min.css\";i:322;s:20:\"post-title/style.css\";i:323;s:24:\"post-title/style.min.css\";i:324;s:26:\"preformatted/style-rtl.css\";i:325;s:30:\"preformatted/style-rtl.min.css\";i:326;s:22:\"preformatted/style.css\";i:327;s:26:\"preformatted/style.min.css\";i:328;s:24:\"pullquote/editor-rtl.css\";i:329;s:28:\"pullquote/editor-rtl.min.css\";i:330;s:20:\"pullquote/editor.css\";i:331;s:24:\"pullquote/editor.min.css\";i:332;s:23:\"pullquote/style-rtl.css\";i:333;s:27:\"pullquote/style-rtl.min.css\";i:334;s:19:\"pullquote/style.css\";i:335;s:23:\"pullquote/style.min.css\";i:336;s:23:\"pullquote/theme-rtl.css\";i:337;s:27:\"pullquote/theme-rtl.min.css\";i:338;s:19:\"pullquote/theme.css\";i:339;s:23:\"pullquote/theme.min.css\";i:340;s:39:\"query-pagination-numbers/editor-rtl.css\";i:341;s:43:\"query-pagination-numbers/editor-rtl.min.css\";i:342;s:35:\"query-pagination-numbers/editor.css\";i:343;s:39:\"query-pagination-numbers/editor.min.css\";i:344;s:31:\"query-pagination/editor-rtl.css\";i:345;s:35:\"query-pagination/editor-rtl.min.css\";i:346;s:27:\"query-pagination/editor.css\";i:347;s:31:\"query-pagination/editor.min.css\";i:348;s:30:\"query-pagination/style-rtl.css\";i:349;s:34:\"query-pagination/style-rtl.min.css\";i:350;s:26:\"query-pagination/style.css\";i:351;s:30:\"query-pagination/style.min.css\";i:352;s:25:\"query-title/style-rtl.css\";i:353;s:29:\"query-title/style-rtl.min.css\";i:354;s:21:\"query-title/style.css\";i:355;s:25:\"query-title/style.min.css\";i:356;s:20:\"query/editor-rtl.css\";i:357;s:24:\"query/editor-rtl.min.css\";i:358;s:16:\"query/editor.css\";i:359;s:20:\"query/editor.min.css\";i:360;s:19:\"quote/style-rtl.css\";i:361;s:23:\"quote/style-rtl.min.css\";i:362;s:15:\"quote/style.css\";i:363;s:19:\"quote/style.min.css\";i:364;s:19:\"quote/theme-rtl.css\";i:365;s:23:\"quote/theme-rtl.min.css\";i:366;s:15:\"quote/theme.css\";i:367;s:19:\"quote/theme.min.css\";i:368;s:23:\"read-more/style-rtl.css\";i:369;s:27:\"read-more/style-rtl.min.css\";i:370;s:19:\"read-more/style.css\";i:371;s:23:\"read-more/style.min.css\";i:372;s:18:\"rss/editor-rtl.css\";i:373;s:22:\"rss/editor-rtl.min.css\";i:374;s:14:\"rss/editor.css\";i:375;s:18:\"rss/editor.min.css\";i:376;s:17:\"rss/style-rtl.css\";i:377;s:21:\"rss/style-rtl.min.css\";i:378;s:13:\"rss/style.css\";i:379;s:17:\"rss/style.min.css\";i:380;s:21:\"search/editor-rtl.css\";i:381;s:25:\"search/editor-rtl.min.css\";i:382;s:17:\"search/editor.css\";i:383;s:21:\"search/editor.min.css\";i:384;s:20:\"search/style-rtl.css\";i:385;s:24:\"search/style-rtl.min.css\";i:386;s:16:\"search/style.css\";i:387;s:20:\"search/style.min.css\";i:388;s:20:\"search/theme-rtl.css\";i:389;s:24:\"search/theme-rtl.min.css\";i:390;s:16:\"search/theme.css\";i:391;s:20:\"search/theme.min.css\";i:392;s:24:\"separator/editor-rtl.css\";i:393;s:28:\"separator/editor-rtl.min.css\";i:394;s:20:\"separator/editor.css\";i:395;s:24:\"separator/editor.min.css\";i:396;s:23:\"separator/style-rtl.css\";i:397;s:27:\"separator/style-rtl.min.css\";i:398;s:19:\"separator/style.css\";i:399;s:23:\"separator/style.min.css\";i:400;s:23:\"separator/theme-rtl.css\";i:401;s:27:\"separator/theme-rtl.min.css\";i:402;s:19:\"separator/theme.css\";i:403;s:23:\"separator/theme.min.css\";i:404;s:24:\"shortcode/editor-rtl.css\";i:405;s:28:\"shortcode/editor-rtl.min.css\";i:406;s:20:\"shortcode/editor.css\";i:407;s:24:\"shortcode/editor.min.css\";i:408;s:24:\"site-logo/editor-rtl.css\";i:409;s:28:\"site-logo/editor-rtl.min.css\";i:410;s:20:\"site-logo/editor.css\";i:411;s:24:\"site-logo/editor.min.css\";i:412;s:23:\"site-logo/style-rtl.css\";i:413;s:27:\"site-logo/style-rtl.min.css\";i:414;s:19:\"site-logo/style.css\";i:415;s:23:\"site-logo/style.min.css\";i:416;s:27:\"site-tagline/editor-rtl.css\";i:417;s:31:\"site-tagline/editor-rtl.min.css\";i:418;s:23:\"site-tagline/editor.css\";i:419;s:27:\"site-tagline/editor.min.css\";i:420;s:25:\"site-title/editor-rtl.css\";i:421;s:29:\"site-title/editor-rtl.min.css\";i:422;s:21:\"site-title/editor.css\";i:423;s:25:\"site-title/editor.min.css\";i:424;s:24:\"site-title/style-rtl.css\";i:425;s:28:\"site-title/style-rtl.min.css\";i:426;s:20:\"site-title/style.css\";i:427;s:24:\"site-title/style.min.css\";i:428;s:26:\"social-link/editor-rtl.css\";i:429;s:30:\"social-link/editor-rtl.min.css\";i:430;s:22:\"social-link/editor.css\";i:431;s:26:\"social-link/editor.min.css\";i:432;s:27:\"social-links/editor-rtl.css\";i:433;s:31:\"social-links/editor-rtl.min.css\";i:434;s:23:\"social-links/editor.css\";i:435;s:27:\"social-links/editor.min.css\";i:436;s:26:\"social-links/style-rtl.css\";i:437;s:30:\"social-links/style-rtl.min.css\";i:438;s:22:\"social-links/style.css\";i:439;s:26:\"social-links/style.min.css\";i:440;s:21:\"spacer/editor-rtl.css\";i:441;s:25:\"spacer/editor-rtl.min.css\";i:442;s:17:\"spacer/editor.css\";i:443;s:21:\"spacer/editor.min.css\";i:444;s:20:\"spacer/style-rtl.css\";i:445;s:24:\"spacer/style-rtl.min.css\";i:446;s:16:\"spacer/style.css\";i:447;s:20:\"spacer/style.min.css\";i:448;s:20:\"table/editor-rtl.css\";i:449;s:24:\"table/editor-rtl.min.css\";i:450;s:16:\"table/editor.css\";i:451;s:20:\"table/editor.min.css\";i:452;s:19:\"table/style-rtl.css\";i:453;s:23:\"table/style-rtl.min.css\";i:454;s:15:\"table/style.css\";i:455;s:19:\"table/style.min.css\";i:456;s:19:\"table/theme-rtl.css\";i:457;s:23:\"table/theme-rtl.min.css\";i:458;s:15:\"table/theme.css\";i:459;s:19:\"table/theme.min.css\";i:460;s:23:\"tag-cloud/style-rtl.css\";i:461;s:27:\"tag-cloud/style-rtl.min.css\";i:462;s:19:\"tag-cloud/style.css\";i:463;s:23:\"tag-cloud/style.min.css\";i:464;s:28:\"template-part/editor-rtl.css\";i:465;s:32:\"template-part/editor-rtl.min.css\";i:466;s:24:\"template-part/editor.css\";i:467;s:28:\"template-part/editor.min.css\";i:468;s:27:\"template-part/theme-rtl.css\";i:469;s:31:\"template-part/theme-rtl.min.css\";i:470;s:23:\"template-part/theme.css\";i:471;s:27:\"template-part/theme.min.css\";i:472;s:30:\"term-description/style-rtl.css\";i:473;s:34:\"term-description/style-rtl.min.css\";i:474;s:26:\"term-description/style.css\";i:475;s:30:\"term-description/style.min.css\";i:476;s:27:\"text-columns/editor-rtl.css\";i:477;s:31:\"text-columns/editor-rtl.min.css\";i:478;s:23:\"text-columns/editor.css\";i:479;s:27:\"text-columns/editor.min.css\";i:480;s:26:\"text-columns/style-rtl.css\";i:481;s:30:\"text-columns/style-rtl.min.css\";i:482;s:22:\"text-columns/style.css\";i:483;s:26:\"text-columns/style.min.css\";i:484;s:19:\"verse/style-rtl.css\";i:485;s:23:\"verse/style-rtl.min.css\";i:486;s:15:\"verse/style.css\";i:487;s:19:\"verse/style.min.css\";i:488;s:20:\"video/editor-rtl.css\";i:489;s:24:\"video/editor-rtl.min.css\";i:490;s:16:\"video/editor.css\";i:491;s:20:\"video/editor.min.css\";i:492;s:19:\"video/style-rtl.css\";i:493;s:23:\"video/style-rtl.min.css\";i:494;s:15:\"video/style.css\";i:495;s:19:\"video/style.min.css\";i:496;s:19:\"video/theme-rtl.css\";i:497;s:23:\"video/theme-rtl.min.css\";i:498;s:15:\"video/theme.css\";i:499;s:19:\"video/theme.min.css\";}}','yes');
INSERT INTO `wp_options` VALUES (123,'recovery_keys','a:0:{}','yes');
INSERT INTO `wp_options` VALUES (124,'_site_transient_update_core','O:8:\"stdClass\":4:{s:7:\"updates\";a:1:{i:0;O:8:\"stdClass\":10:{s:8:\"response\";s:6:\"latest\";s:8:\"download\";s:59:\"https://downloads.wordpress.org/release/wordpress-6.5.3.zip\";s:6:\"locale\";s:5:\"en_US\";s:8:\"packages\";O:8:\"stdClass\":5:{s:4:\"full\";s:59:\"https://downloads.wordpress.org/release/wordpress-6.5.3.zip\";s:10:\"no_content\";s:70:\"https://downloads.wordpress.org/release/wordpress-6.5.3-no-content.zip\";s:11:\"new_bundled\";s:71:\"https://downloads.wordpress.org/release/wordpress-6.5.3-new-bundled.zip\";s:7:\"partial\";s:0:\"\";s:8:\"rollback\";s:0:\"\";}s:7:\"current\";s:5:\"6.5.3\";s:7:\"version\";s:5:\"6.5.3\";s:11:\"php_version\";s:5:\"7.0.0\";s:13:\"mysql_version\";s:3:\"5.0\";s:11:\"new_bundled\";s:3:\"6.4\";s:15:\"partial_version\";s:0:\"\";}}s:12:\"last_checked\";i:1716546523;s:15:\"version_checked\";s:5:\"6.5.3\";s:12:\"translations\";a:0:{}}','no');
INSERT INTO `wp_options` VALUES (129,'_site_transient_update_themes','O:8:\"stdClass\":5:{s:12:\"last_checked\";i:1716545619;s:7:\"checked\";a:5:{s:10:\"demijngang\";s:5:\"1.0.0\";s:16:\"twentytwentyfour\";s:3:\"1.1\";s:17:\"twentytwentythree\";s:3:\"1.4\";s:15:\"twentytwentytwo\";s:3:\"1.7\";s:10:\"understrap\";s:5:\"1.2.4\";}s:8:\"response\";a:0:{}s:9:\"no_update\";a:4:{s:16:\"twentytwentyfour\";a:6:{s:5:\"theme\";s:16:\"twentytwentyfour\";s:11:\"new_version\";s:3:\"1.1\";s:3:\"url\";s:46:\"https://wordpress.org/themes/twentytwentyfour/\";s:7:\"package\";s:62:\"https://downloads.wordpress.org/theme/twentytwentyfour.1.1.zip\";s:8:\"requires\";s:3:\"6.4\";s:12:\"requires_php\";s:3:\"7.0\";}s:17:\"twentytwentythree\";a:6:{s:5:\"theme\";s:17:\"twentytwentythree\";s:11:\"new_version\";s:3:\"1.4\";s:3:\"url\";s:47:\"https://wordpress.org/themes/twentytwentythree/\";s:7:\"package\";s:63:\"https://downloads.wordpress.org/theme/twentytwentythree.1.4.zip\";s:8:\"requires\";s:3:\"6.1\";s:12:\"requires_php\";s:3:\"5.6\";}s:15:\"twentytwentytwo\";a:6:{s:5:\"theme\";s:15:\"twentytwentytwo\";s:11:\"new_version\";s:3:\"1.7\";s:3:\"url\";s:45:\"https://wordpress.org/themes/twentytwentytwo/\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/theme/twentytwentytwo.1.7.zip\";s:8:\"requires\";s:3:\"5.9\";s:12:\"requires_php\";s:3:\"5.6\";}s:10:\"understrap\";a:6:{s:5:\"theme\";s:10:\"understrap\";s:11:\"new_version\";s:5:\"1.2.4\";s:3:\"url\";s:40:\"https://wordpress.org/themes/understrap/\";s:7:\"package\";s:58:\"https://downloads.wordpress.org/theme/understrap.1.2.4.zip\";s:8:\"requires\";s:3:\"5.0\";s:12:\"requires_php\";s:3:\"5.2\";}}s:12:\"translations\";a:0:{}}','no');
INSERT INTO `wp_options` VALUES (130,'theme_mods_twentytwentyfour','a:2:{s:18:\"custom_css_post_id\";i:-1;s:16:\"sidebars_widgets\";a:2:{s:4:\"time\";i:1715941901;s:4:\"data\";a:3:{s:19:\"wp_inactive_widgets\";a:0:{}s:9:\"sidebar-1\";a:3:{i:0;s:7:\"block-2\";i:1;s:7:\"block-3\";i:2;s:7:\"block-4\";}s:9:\"sidebar-2\";a:2:{i:0;s:7:\"block-5\";i:1;s:7:\"block-6\";}}}}','no');
INSERT INTO `wp_options` VALUES (148,'can_compress_scripts','1','yes');
INSERT INTO `wp_options` VALUES (152,'WPLANG','','yes');
INSERT INTO `wp_options` VALUES (153,'new_admin_email','dev-email@wpengine.local','yes');
INSERT INTO `wp_options` VALUES (158,'current_theme','De MijnGang','yes');
INSERT INTO `wp_options` VALUES (159,'theme_mods_demijngang','a:6:{i:0;b:0;s:28:\"understrap_posts_index_style\";s:7:\"default\";s:27:\"understrap_sidebar_position\";s:5:\"right\";s:25:\"understrap_container_type\";s:9:\"container\";s:18:\"nav_menu_locations\";a:1:{s:7:\"primary\";i:2;}s:18:\"custom_css_post_id\";i:-1;}','yes');
INSERT INTO `wp_options` VALUES (160,'theme_switched','','yes');
INSERT INTO `wp_options` VALUES (164,'finished_updating_comment_type','1','yes');
INSERT INTO `wp_options` VALUES (172,'wp_calendar_block_has_published_posts','','yes');
INSERT INTO `wp_options` VALUES (174,'nav_menu_options','a:2:{i:0;b:0;s:8:\"auto_add\";a:0:{}}','yes');
INSERT INTO `wp_options` VALUES (179,'_site_transient_wp_plugin_dependencies_plugin_data','a:0:{}','no');
INSERT INTO `wp_options` VALUES (180,'recently_activated','a:0:{}','yes');
INSERT INTO `wp_options` VALUES (186,'_site_transient_update_plugins','O:8:\"stdClass\":5:{s:12:\"last_checked\";i:1716545619;s:8:\"response\";a:0:{}s:12:\"translations\";a:0:{}s:9:\"no_update\";a:2:{s:33:\"events-manager/events-manager.php\";O:8:\"stdClass\":10:{s:2:\"id\";s:28:\"w.org/plugins/events-manager\";s:4:\"slug\";s:14:\"events-manager\";s:6:\"plugin\";s:33:\"events-manager/events-manager.php\";s:11:\"new_version\";s:7:\"6.4.7.3\";s:3:\"url\";s:45:\"https://wordpress.org/plugins/events-manager/\";s:7:\"package\";s:65:\"https://downloads.wordpress.org/plugin/events-manager.6.4.7.3.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:67:\"https://ps.w.org/events-manager/assets/icon-256x256.png?rev=1039078\";s:2:\"1x\";s:67:\"https://ps.w.org/events-manager/assets/icon-128x128.png?rev=1039078\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:70:\"https://ps.w.org/events-manager/assets/banner-1544x500.png?rev=1039078\";s:2:\"1x\";s:69:\"https://ps.w.org/events-manager/assets/banner-772x250.png?rev=1039078\";}s:11:\"banners_rtl\";a:0:{}s:8:\"requires\";s:3:\"5.2\";}s:41:\"events-manager-pro/events-manager-pro.php\";O:8:\"stdClass\":7:{s:4:\"slug\";s:18:\"events-manager-pro\";s:11:\"new_version\";s:7:\"3.2.8.1\";s:3:\"url\";s:28:\"https://eventsmanagerpro.com\";s:8:\"requires\";s:3:\"4.8\";s:12:\"requires_php\";s:3:\"5.3\";s:7:\"package\";s:105:\"https://eventsmanagerpro.com/api/events-manager-pro/?action=download&key=77CD967C32F34BAB8FAB5FD24D8029C5\";s:4:\"site\";s:24:\"http://de-mijngang.local\";}}s:7:\"checked\";a:2:{s:33:\"events-manager/events-manager.php\";s:7:\"6.4.7.3\";s:41:\"events-manager-pro/events-manager-pro.php\";s:7:\"3.2.8.1\";}}','no');
INSERT INTO `wp_options` VALUES (187,'dbem_flush_needed','0','yes');
INSERT INTO `wp_options` VALUES (188,'widget_em_widget','a:1:{s:12:\"_multiwidget\";i:1;}','yes');
INSERT INTO `wp_options` VALUES (189,'widget_em_calendar','a:1:{s:12:\"_multiwidget\";i:1;}','yes');
INSERT INTO `wp_options` VALUES (190,'dbem_events_page','21','yes');
INSERT INTO `wp_options` VALUES (191,'dbem_locations_page','22','yes');
INSERT INTO `wp_options` VALUES (192,'dbem_categories_page','23','yes');
INSERT INTO `wp_options` VALUES (193,'dbem_tags_page','24','yes');
INSERT INTO `wp_options` VALUES (194,'dbem_my_bookings_page','25','yes');
INSERT INTO `wp_options` VALUES (195,'dbem_hello_to_user','1','yes');
INSERT INTO `wp_options` VALUES (196,'dbem_data','a:2:{s:13:\"admin_notices\";a:2:{s:5:\"hello\";i:0;s:15:\"pxl-dev-license\";i:0;}s:12:\"admin-modals\";a:1:{s:12:\"review-nudge\";i:1717152012;}}','no');
INSERT INTO `wp_options` VALUES (197,'dbem_admin_notices','a:1:{s:5:\"hello\";a:4:{s:4:\"name\";s:5:\"hello\";s:4:\"what\";s:7:\"success\";s:5:\"where\";s:3:\"all\";s:7:\"message\";s:424:\"<p>Events Manager is ready to go! It is highly recommended you read the <a href=\'https://wp-events-plugin.com/documentation/getting-started-guide/?utm_source=em&utm_medium=plugin&utm_content=installationlink&utm_campaign=plugin_links\'>Getting Started</a> guide on our site, as well as checking out the <a href=\'http://de-mijngang.local/wp-admin/edit.php?post_type=event&amp;page=events-manager-options\'>Settings Page</a></p>\";}}','no');
INSERT INTO `wp_options` VALUES (198,'dbem_time_format','g:i a','yes');
INSERT INTO `wp_options` VALUES (199,'dbem_date_format','F j, Y','yes');
INSERT INTO `wp_options` VALUES (200,'dbem_date_format_js','dd/mm/yy','yes');
INSERT INTO `wp_options` VALUES (201,'dbem_datepicker_format','Y-m-d','yes');
INSERT INTO `wp_options` VALUES (202,'dbem_dates_separator',' - ','yes');
INSERT INTO `wp_options` VALUES (203,'dbem_dates_range_double_inputs','0','yes');
INSERT INTO `wp_options` VALUES (204,'dbem_times_separator',' - ','yes');
INSERT INTO `wp_options` VALUES (205,'dbem_default_category','0','yes');
INSERT INTO `wp_options` VALUES (206,'dbem_default_location','0','yes');
INSERT INTO `wp_options` VALUES (207,'dbem_events_default_orderby','event_start_date,event_start_time,event_name','yes');
INSERT INTO `wp_options` VALUES (208,'dbem_events_default_order','ASC','yes');
INSERT INTO `wp_options` VALUES (209,'dbem_events_default_limit','10','yes');
INSERT INTO `wp_options` VALUES (210,'dbem_search_form_main','1','yes');
INSERT INTO `wp_options` VALUES (211,'dbem_search_form_responsive','multi-line','yes');
INSERT INTO `wp_options` VALUES (212,'dbem_search_form_sorting','1','yes');
INSERT INTO `wp_options` VALUES (213,'dbem_search_form_cookies','','yes');
INSERT INTO `wp_options` VALUES (214,'dbem_search_form_submit','Search','yes');
INSERT INTO `wp_options` VALUES (215,'dbem_search_form_views','a:5:{i:0;s:4:\"list\";i:1;s:12:\"list-grouped\";i:2;s:4:\"grid\";i:3;s:3:\"map\";i:4;s:8:\"calendar\";}','yes');
INSERT INTO `wp_options` VALUES (216,'dbem_search_form_view','list','yes');
INSERT INTO `wp_options` VALUES (217,'dbem_search_form_saved_searches','1','yes');
INSERT INTO `wp_options` VALUES (218,'dbem_search_form_advanced','1','yes');
INSERT INTO `wp_options` VALUES (219,'dbem_search_form_advanced_mode','modal','yes');
INSERT INTO `wp_options` VALUES (220,'dbem_search_form_advanced_style','headings','yes');
INSERT INTO `wp_options` VALUES (221,'dbem_search_form_advanced_hidden','1','yes');
INSERT INTO `wp_options` VALUES (222,'dbem_search_form_advanced_trigger','1','yes');
INSERT INTO `wp_options` VALUES (223,'dbem_search_form_advanced_show','Show Advanced Search','yes');
INSERT INTO `wp_options` VALUES (224,'dbem_search_form_advanced_hide','Hide Advanced Search','yes');
INSERT INTO `wp_options` VALUES (225,'dbem_search_form_text','1','yes');
INSERT INTO `wp_options` VALUES (226,'dbem_search_form_text_label','Search','yes');
INSERT INTO `wp_options` VALUES (227,'dbem_search_form_text_advanced','1','yes');
INSERT INTO `wp_options` VALUES (228,'dbem_search_form_text_label_advanced','Search','yes');
INSERT INTO `wp_options` VALUES (229,'dbem_search_form_text_hide_s','','yes');
INSERT INTO `wp_options` VALUES (230,'dbem_search_form_text_hide_m','','yes');
INSERT INTO `wp_options` VALUES (231,'dbem_search_form_geo','1','yes');
INSERT INTO `wp_options` VALUES (232,'dbem_search_form_geo_label','Near...','yes');
INSERT INTO `wp_options` VALUES (233,'dbem_search_form_geo_hide_s','','yes');
INSERT INTO `wp_options` VALUES (234,'dbem_search_form_geo_hide_m','','yes');
INSERT INTO `wp_options` VALUES (235,'dbem_search_form_geo_advanced','1','yes');
INSERT INTO `wp_options` VALUES (236,'dbem_search_form_geo_label_advanced','Near...','yes');
INSERT INTO `wp_options` VALUES (237,'dbem_search_form_geo_units','1','yes');
INSERT INTO `wp_options` VALUES (238,'dbem_search_form_geo_units_label','Within','yes');
INSERT INTO `wp_options` VALUES (239,'dbem_search_form_geo_unit_default','mi','yes');
INSERT INTO `wp_options` VALUES (240,'dbem_search_form_geo_distance_default','25','yes');
INSERT INTO `wp_options` VALUES (241,'dbem_search_form_geo_distance_options','5,10,25,50,100','yes');
INSERT INTO `wp_options` VALUES (242,'dbem_search_form_dates','1','yes');
INSERT INTO `wp_options` VALUES (243,'dbem_search_form_dates_label','Dates','yes');
INSERT INTO `wp_options` VALUES (244,'dbem_search_form_dates_hide_s','','yes');
INSERT INTO `wp_options` VALUES (245,'dbem_search_form_dates_hide_m','','yes');
INSERT INTO `wp_options` VALUES (246,'dbem_search_form_dates_separator','and','yes');
INSERT INTO `wp_options` VALUES (247,'dbem_search_form_dates_format','M j','yes');
INSERT INTO `wp_options` VALUES (248,'dbem_search_form_dates_advanced','1','yes');
INSERT INTO `wp_options` VALUES (249,'dbem_search_form_dates_label_advanced','Dates','yes');
INSERT INTO `wp_options` VALUES (250,'dbem_search_form_dates_separator_advanced','and','yes');
INSERT INTO `wp_options` VALUES (251,'dbem_search_form_dates_format_advanced','M j','yes');
INSERT INTO `wp_options` VALUES (252,'dbem_search_form_categories','1','yes');
INSERT INTO `wp_options` VALUES (253,'dbem_search_form_categories_label','All Categories','yes');
INSERT INTO `wp_options` VALUES (254,'dbem_search_form_category_label','Categories','yes');
INSERT INTO `wp_options` VALUES (255,'dbem_search_form_categories_placeholder','Search Categories...','yes');
INSERT INTO `wp_options` VALUES (256,'dbem_search_form_categories_include','','yes');
INSERT INTO `wp_options` VALUES (257,'dbem_search_form_categories_exclude','','yes');
INSERT INTO `wp_options` VALUES (258,'dbem_search_form_tags','1','yes');
INSERT INTO `wp_options` VALUES (259,'dbem_search_form_tags_label','All Tags','yes');
INSERT INTO `wp_options` VALUES (260,'dbem_search_form_tag_label','Tags','yes');
INSERT INTO `wp_options` VALUES (261,'dbem_search_form_tags_placeholder','Search Tags...','yes');
INSERT INTO `wp_options` VALUES (262,'dbem_search_form_tags_include','','yes');
INSERT INTO `wp_options` VALUES (263,'dbem_search_form_tags_exclude','','yes');
INSERT INTO `wp_options` VALUES (264,'dbem_search_form_countries','1','yes');
INSERT INTO `wp_options` VALUES (265,'dbem_search_form_default_country','','yes');
INSERT INTO `wp_options` VALUES (266,'dbem_search_form_countries_label','All Countries','yes');
INSERT INTO `wp_options` VALUES (267,'dbem_search_form_country_label','Country','yes');
INSERT INTO `wp_options` VALUES (268,'dbem_search_form_regions','1','yes');
INSERT INTO `wp_options` VALUES (269,'dbem_search_form_regions_label','All Regions','yes');
INSERT INTO `wp_options` VALUES (270,'dbem_search_form_region_label','Region','yes');
INSERT INTO `wp_options` VALUES (271,'dbem_search_form_states','1','yes');
INSERT INTO `wp_options` VALUES (272,'dbem_search_form_states_label','All States','yes');
INSERT INTO `wp_options` VALUES (273,'dbem_search_form_state_label','State/County','yes');
INSERT INTO `wp_options` VALUES (274,'dbem_search_form_towns','0','yes');
INSERT INTO `wp_options` VALUES (275,'dbem_search_form_towns_label','All Cities/Towns','yes');
INSERT INTO `wp_options` VALUES (276,'dbem_search_form_town_label','City/Town','yes');
INSERT INTO `wp_options` VALUES (277,'dbem_events_form_editor','1','yes');
INSERT INTO `wp_options` VALUES (278,'dbem_events_form_reshow','1','yes');
INSERT INTO `wp_options` VALUES (279,'dbem_events_form_result_success','You have successfully submitted your event, which will be published pending approval.','yes');
INSERT INTO `wp_options` VALUES (280,'dbem_events_form_result_success_updated','You have successfully updated your event, which will be republished pending approval.','yes');
INSERT INTO `wp_options` VALUES (281,'dbem_events_anonymous_submissions','0','yes');
INSERT INTO `wp_options` VALUES (282,'dbem_events_anonymous_user','0','yes');
INSERT INTO `wp_options` VALUES (283,'dbem_events_anonymous_result_success','You have successfully submitted your event, which will be published pending approval.','yes');
INSERT INTO `wp_options` VALUES (284,'dbem_event_submitted_email_admin','','yes');
INSERT INTO `wp_options` VALUES (285,'dbem_event_submitted_email_subject','Submitted Event Awaiting Approval','yes');
INSERT INTO `wp_options` VALUES (286,'dbem_event_submitted_email_body','A new event has been submitted by #_CONTACTNAME.\n\rName : #_EVENTNAME \n\rDate : #_EVENTDATES \n\rTime : #_EVENTTIMES \n\rPlease visit http://de-mijngang.local/wp-admin/post.php?action=edit&post=#_EVENTPOSTID to review this event for approval.\n\r\n\r-------------------------------\n\rPowered by Events Manager - http://wp-events-plugin.com','yes');
INSERT INTO `wp_options` VALUES (287,'dbem_event_resubmitted_email_subject','Re-Submitted Event Awaiting Approval','yes');
INSERT INTO `wp_options` VALUES (288,'dbem_event_resubmitted_email_body','A previously published event has been modified by #_CONTACTNAME, and this event is now unpublished and pending your approval.\n\rName : #_EVENTNAME \n\rDate : #_EVENTDATES \n\rTime : #_EVENTTIMES \n\rPlease visit http://de-mijngang.local/wp-admin/post.php?action=edit&post=#_EVENTPOSTID to review this event for approval.\n\r\n\r-------------------------------\n\rPowered by Events Manager - http://wp-events-plugin.com','yes');
INSERT INTO `wp_options` VALUES (289,'dbem_event_published_email_subject','Published Event - #_EVENTNAME','yes');
INSERT INTO `wp_options` VALUES (290,'dbem_event_published_email_body','A new event has been published by #_CONTACTNAME.\n\rName : #_EVENTNAME \n\rDate : #_EVENTDATES \n\rTime : #_EVENTTIMES \n\rEdit this event - http://de-mijngang.local/wp-admin/post.php?action=edit&post=#_EVENTPOSTID \n\r View this event - #_EVENTURL\n\r\n\r-------------------------------\n\rPowered by Events Manager - http://wp-events-plugin.com','yes');
INSERT INTO `wp_options` VALUES (291,'dbem_event_approved_email_subject','Event Approved - #_EVENTNAME','yes');
INSERT INTO `wp_options` VALUES (292,'dbem_event_approved_email_body','Dear #_CONTACTNAME\n\nYour event #_EVENTNAME on #_EVENTDATES has been approved.\n\n{not_recurring}You can view your event here: #_EVENTURL{/not_recurring}\n\r\n\r-------------------------------\n\rPowered by Events Manager - http://wp-events-plugin.com','yes');
INSERT INTO `wp_options` VALUES (293,'dbem_event_reapproved_email_subject','Event Approved - #_EVENTNAME','yes');
INSERT INTO `wp_options` VALUES (294,'dbem_event_reapproved_email_body','Dear #_CONTACTNAME\n\nYour event #_EVENTNAME on #_EVENTDATES has been approved.\n\n{not_recurring}You can view your event here: #_EVENTURL{/not_recurring}\n\r\n\r-------------------------------\n\rPowered by Events Manager - http://wp-events-plugin.com','yes');
INSERT INTO `wp_options` VALUES (295,'dbem_events_page_title','Events','yes');
INSERT INTO `wp_options` VALUES (296,'dbem_events_page_scope','future','yes');
INSERT INTO `wp_options` VALUES (297,'dbem_events_page_search_form','1','yes');
INSERT INTO `wp_options` VALUES (298,'dbem_event_list_item_format_header','','yes');
INSERT INTO `wp_options` VALUES (299,'dbem_event_list_item_format','<div class=\"em-event em-item {is_cancelled}em-event-cancelled{/is_cancelled}\" style=\"--default-border:#_CATEGORYCOLOR;\">\n	<div class=\"em-item-image {no_image}has-placeholder{/no_image}\">\n		{has_image}\n		#_EVENTIMAGE{medium}\n		{/has_image}\n		{no_image}\n		<div class=\"em-item-image-placeholder\">\n			<div class=\"date\">\n				<span class=\"day\">#d</span>\n				<span class=\"month\">#M</span>\n			</div>\n		</div>\n		{/no_image}\n	</div>\n	<div class=\"em-item-info\">\n		<h3 class=\"em-item-title\">#_EVENTLINK</h3>\n		{is_cancelled}\n		<div class=\"em-event-cancelled em-notice em-notice-error em-notice-thin em-notice-icon\">\n			<span class=\"em-icon em-icon-cross-circle\"></span>\n			This event has been cancelled.		</div>\n		{/is_cancelled}\n		<div class=\"em-event-meta em-item-meta\">\n			<div class=\"em-item-meta-line em-event-date em-event-meta-datetime\">\n				<span class=\"em-icon-calendar em-icon\"></span>\n				#_EVENTDATES&nbsp;&nbsp;&nbsp;&nbsp;\n			</div>\n			<div class=\"em-item-meta-line em-event-time em-event-meta-datetime\">\n				<span class=\"em-icon-clock em-icon\"></span>\n				#_EVENTTIMES\n			</div>\n			{bookings_open}\n			<div class=\"em-item-meta-line em-event-prices\">\n				<span class=\"em-icon-ticket em-icon\"></span>\n				#_EVENTPRICERANGE\n			</div>\n			{/bookings_open}\n			{has_location_venue}\n			<div class=\"em-item-meta-line em-event-location\">\n				<span class=\"em-icon-location em-icon\"></span>\n				#_LOCATIONLINK\n			</div>\n			{/has_location_venue}\n			{has_event_location}\n			<div class=\"em-item-meta-line em-event-location\">\n				<span class=\"em-icon-at em-icon\"></span>\n				#_EVENTLOCATION\n			</div>\n			{/has_event_location}\n			{has_category}\n			<div class=\"em-item-meta-line em-item-taxonomy em-event-categories\">\n				<span class=\"em-icon-category em-icon\"></span>\n				<div>#_EVENTCATEGORIES</div>\n			</div>\n			{/has_category}\n			{has_tag}\n			<div class=\"em-item-meta-line em-item-taxonomy em-event-tags\">\n				<span class=\"em-icon-tag em-icon\"></span>\n				<div>#_EVENTTAGS</div>\n			</div>\n			{/has_tag}\n		</div>\n		<div class=\"em-item-desc\">\n			#_EVENTEXCERPT{25}\n		</div>\n		<div class=\"em-item-actions input\">\n			<a class=\"em-item-read-more button\" href=\"#_EVENTURL\">More Info</a>\n			{bookings_open}\n			<a class=\"em-event-book-now button\" href=\"#_EVENTURL#em-event-booking-form\">\n				<span class=\"em-icon em-icon-ticket\"></span>\n				Book Now!			</a>\n			{/bookings_open}\n		</div>\n	</div>\n</div>','yes');
INSERT INTO `wp_options` VALUES (300,'dbem_event_list_item_format_footer','','yes');
INSERT INTO `wp_options` VALUES (301,'dbem_event_grid_item_format_header','','yes');
INSERT INTO `wp_options` VALUES (302,'dbem_event_grid_item_format','<div class=\"em-event em-item\" data-href=\"#_EVENTURL\" style=\"--default-border:#_CATEGORYCOLOR;\">\n	<div class=\"em-item-image {no_image}has-placeholder{/no_image}\">\n		<div class=\"em-item-image-wrapper\">\n			{has_image}\n			#_EVENTIMAGE{medium}\n			{/has_image}\n			{no_image}\n			<div class=\"em-item-image-placeholder\">\n				<div class=\"date\">\n					<span class=\"day\">#d</span>\n					<span class=\"month\">#M</span>\n				</div>\n			</div>\n			{/no_image}\n		</div>\n	</div>\n	<div class=\"em-item-info\">\n		<h3 class=\"em-item-title\">#_EVENTLINK</h3>\n		<div class=\"em-event-meta em-item-meta\">\n			<div class=\"em-item-meta-line em-event-date em-event-meta-datetime\">\n				<span class=\"em-icon-calendar em-icon\"></span>\n				#_EVENTDATES\n			</div>\n			<div class=\"em-item-meta-line em-event-time em-event-meta-datetime\">\n				<span class=\"em-icon-clock em-icon\"></span>\n				#_EVENTTIMES\n			</div>\n			{bookings_open}\n			<div class=\"em-item-meta-line em-event-prices\">\n				<span class=\"em-icon-ticket em-icon\"></span>\n				#_EVENTPRICERANGE\n			</div>\n			{/bookings_open}\n			{has_location_venue}\n			<div class=\"em-item-meta-line em-event-location\">\n				<span class=\"em-icon-location em-icon\"></span>\n				#_LOCATIONLINK\n			</div>\n			{/has_location_venue}\n			{has_event_location}\n			<div class=\"em-item-meta-line em-event-location\">\n				<span class=\"em-icon-at em-icon\"></span>\n				#_EVENTLOCATION\n			</div>\n			{/has_event_location}\n		</div>\n	</div>\n</div>','yes');
INSERT INTO `wp_options` VALUES (303,'dbem_event_grid_item_format_footer','','yes');
INSERT INTO `wp_options` VALUES (304,'dbem_event_grid_item_width','250','yes');
INSERT INTO `wp_options` VALUES (305,'dbem_event_list_groupby','monthly','yes');
INSERT INTO `wp_options` VALUES (306,'dbem_event_list_groupby_format','F Y','yes');
INSERT INTO `wp_options` VALUES (307,'dbem_event_list_groupby_header_format','<h2>#s</h2>','yes');
INSERT INTO `wp_options` VALUES (308,'dbem_display_calendar_in_events_page','0','yes');
INSERT INTO `wp_options` VALUES (309,'dbem_single_event_format','<section class=\"em-item-header\"  style=\"--default-border:#_CATEGORYCOLOR;\">\n	{has_image}\n	<div class=\"em-item-image {no_image}has-placeholder{/no_image}\">\n		#_EVENTIMAGE{medium}\n	</div>\n	{/has_image}\n	{is_cancelled}\n	<div class=\"em-event-cancelled em-notice em-notice-error em-notice-icon\">\n		<span class=\"em-icon em-icon-cross-circle\"></span>\n		This event has been cancelled.	</div>\n	{/is_cancelled}\n	<div class=\"em-item-meta\">\n		<section class=\"em-item-meta-column\">\n			<section class=\"em-event-when\">\n				<h3>When</h3>\n				<div class=\"em-item-meta-line em-event-date em-event-meta-datetime\">\n					<span class=\"em-icon-calendar em-icon\"></span>\n					#_EVENTDATES&nbsp;&nbsp;&nbsp;&nbsp;\n				</div>\n				<div class=\"em-item-meta-line em-event-time em-event-meta-datetime\">\n					<span class=\"em-icon-clock em-icon\"></span>\n					#_EVENTTIMES\n				</div>\n				#_EVENTADDTOCALENDAR\n			</section>\n	\n			{has_bookings}\n			<section class=\"em-event-bookings-meta\">\n				<h3>Bookings</h3>\n				{bookings_open}\n				<div class=\"em-item-meta-line em-event-prices\">\n					<span class=\"em-icon-ticket em-icon\"></span>\n					#_EVENTPRICERANGE\n				</div>\n				<a href=\"#em-event-booking-form\" class=\"button input with-icon-right\">\n										<span class=\"em-icon-ticket em-icon\"></span>\n				</a>\n				{/bookings_open}\n				{bookings_closed}\n				<div class=\"em-item-meta-line em-event-prices\">\n					<span class=\"em-icon-ticket em-icon\"></span>\n					Bookings closed				</div>\n				{/bookings_closed}\n			</section>\n			{/has_bookings}\n		</section>\n\n		<section class=\"em-item-meta-column\">\n			{has_location_venue}\n			<section class=\"em-event-where\">\n				<h3>Where</h3>\n				<div class=\"em-item-meta-line em-event-location\">\n					<span class=\"em-icon-location em-icon\"></span>\n					<div>\n						#_LOCATIONLINK<br>\n						#_LOCATIONFULLLINE\n					</div>\n				</div>\n			</section>\n			{/has_location_venue}\n			{has_event_location}\n			<section class=\"em-event-where\">\n				<h3>Where</h3>\n				<div class=\"em-item-meta-line em-event-location\">\n					<span class=\"em-icon-at em-icon\"></span>\n					#_EVENTLOCATION\n				</div>\n			</section>\n			{/has_event_location}\n			\n			{has_taxonomy}\n			<section class=\"em-item-taxonomies\">\n				<h3>Event Type</h3>\n				{has_category}\n				<div class=\"em-item-meta-line em-item-taxonomy em-event-categories\">\n					<span class=\"em-icon-category em-icon\"></span>\n					<div>#_EVENTCATEGORIES</div>\n				</div>\n				{/has_category}\n				{has_tag}\n				<div class=\"em-item-meta-line em-item-taxonomy em-event-tags\">\n					<span class=\"em-icon-tag em-icon\"></span>\n					<div>#_EVENTTAGS</div>\n				</div>\n				{/has_tag}\n			</section>\n			{/has_taxonomy}\n		</section>\n	</div>\n</section>\n{has_location_venue}\n<section class=\"em-event-location\">\n	#_LOCATIONMAP{100%,0}\n</section>\n{/has_location_venue}\n<section class=\"em-event-content\">\n	#_EVENTNOTES\n</section>\n{has_bookings}\n<section class=\"em-event-bookings\">\n	<a name=\"em-event-booking-form\"></a>\n	<h2>Bookings</h2>\n	#_BOOKINGFORM\n</section>\n{/has_bookings}','yes');
INSERT INTO `wp_options` VALUES (310,'dbem_event_excerpt_format','#_EVENTDATES @ #_EVENTTIMES - #_EVENTEXCERPT','yes');
INSERT INTO `wp_options` VALUES (311,'dbem_event_excerpt_alt_format','#_EVENTDATES @ #_EVENTTIMES - #_EVENTEXCERPT{55}','yes');
INSERT INTO `wp_options` VALUES (312,'dbem_event_page_title_format','#_EVENTNAME','yes');
INSERT INTO `wp_options` VALUES (313,'dbem_event_all_day_message','All Day','yes');
INSERT INTO `wp_options` VALUES (314,'dbem_no_events_message','No Events','yes');
INSERT INTO `wp_options` VALUES (315,'dbem_locations_default_orderby','location_name','yes');
INSERT INTO `wp_options` VALUES (316,'dbem_locations_default_order','ASC','yes');
INSERT INTO `wp_options` VALUES (317,'dbem_locations_default_limit','10','yes');
INSERT INTO `wp_options` VALUES (318,'dbem_locations_page_title','Event Locations','yes');
INSERT INTO `wp_options` VALUES (319,'dbem_locations_page_search_form','1','yes');
INSERT INTO `wp_options` VALUES (320,'dbem_no_locations_message','No Locations','yes');
INSERT INTO `wp_options` VALUES (321,'dbem_location_default_country','','yes');
INSERT INTO `wp_options` VALUES (322,'dbem_location_list_item_format_header','','yes');
INSERT INTO `wp_options` VALUES (323,'dbem_location_list_item_format','<div class=\"em-location em-item\">\n	<div class=\"em-item-image {no_loc_image}has-placeholder{/no_loc_image}\">\n		{has_loc_image}\n		<a href=\"#_LOCATIONURL\">#_LOCATIONIMAGE{medium}</a>\n		{/has_loc_image}\n		{no_loc_image}\n		<a href=\"#_LOCATIONURL\" class=\"em-item-image-placeholder\"></a>\n		{/no_loc_image}\n	</div>\n	<div class=\"em-item-info\">\n		<h3 class=\"em-item-title\">#_LOCATIONLINK</h3>\n		<div class=\"em-event-meta em-item-meta\">\n			<div class=\"em-item-meta-line em-location-address\">\n				<span class=\"em-icon-location em-icon\"></span>\n				#_LOCATIONFULLBR\n			</div>\n			{has_events}\n			<div class=\"em-item-meta-line em-location-events\">\n				<span class=\"em-icon-calendar em-icon\"></span>\n				<div>\n					<p>Next Event</p>\n					<p>#_LOCATIONNEXTEVENT</p>\n					<p><a href=\"#_LOCATIONURL\">See All</a></p>\n				</div>\n			</div>\n			{/has_events}\n			{no_events}\n			<div class=\"em-item-meta-line em-location-no-events\">\n				<span class=\"em-icon-calendar em-icon\"></span>\n				<div>No upcoming events</p></div>\n			</div>\n			{/no_events}\n		</div>\n		<div class=\"em-item-desc\">\n			#_LOCATIONEXCERPT{25}\n		</div>\n		<div class=\"em-item-actions input\">\n			<a class=\"em-item-read-more button\" href=\"#_LOCATIONURL\">More Info</a>\n		</div>\n	</div>\n</div>','yes');
INSERT INTO `wp_options` VALUES (324,'dbem_location_list_item_format_footer','','yes');
INSERT INTO `wp_options` VALUES (325,'dbem_location_grid_item_format_header','','yes');
INSERT INTO `wp_options` VALUES (326,'dbem_location_grid_item_format','<div class=\"em-location em-item\" data-href=\"#_LOCATIONURL\">\n	<div class=\"em-item-image {no_loc_image}has-placeholder{/no_loc_image}\">\n		<div class=\"em-item-image-wrapper\">\n			{has_loc_image}\n			#_LOCATIONIMAGE{medium}\n			{/has_loc_image}\n			{no_loc_image}\n			<div class=\"em-item-image-placeholder\"></div>\n			{/no_loc_image}\n		</div>\n	</div>\n	<div class=\"em-item-info\">\n		<h3 class=\"em-item-title\">#_LOCATIONLINK</h3>\n		<div class=\"em-event-meta em-item-meta\">\n			<div class=\"em-item-meta-line em-location-address\">\n				<span class=\"em-icon-location em-icon\"></span>\n				#_LOCATIONFULLBR\n			</div>\n			{has_events}\n			<div class=\"em-item-meta-line em-location-events\">\n				<span class=\"em-icon-calendar em-icon\"></span>\n				<div>\n					<p>Next Event</p>\n					<p>#_LOCATIONNEXTEVENT</p>\n					<p><a href=\"#_LOCATIONURL\">See All</a></p>\n				</div>\n			</div>\n			{/has_events}\n			{no_events}\n			<div class=\"em-item-meta-line em-location-no-events\">\n				<span class=\"em-icon-calendar em-icon\"></span>\n				<div>No upcoming events</p></div>\n			</div>\n			{/no_events}\n		</div>\n	</div>\n</div>','yes');
INSERT INTO `wp_options` VALUES (327,'dbem_location_grid_item_format_footer','','yes');
INSERT INTO `wp_options` VALUES (328,'dbem_location_grid_item_width','250','yes');
INSERT INTO `wp_options` VALUES (329,'dbem_location_page_title_format','#_LOCATIONNAME','yes');
INSERT INTO `wp_options` VALUES (330,'dbem_single_location_format','<section class=\"em-item-header\">\n	{has_loc_image}\n	<div class=\"em-item-image\">\n		#_LOCATIONIMAGE{medium}\n	</div>\n	{/has_loc_image}\n	<div class=\"em-item-meta\">\n		<section class=\"em-item-meta-column\">\n			<section class=\"em-location-where\">\n				<h3>Location</h3>\n				<div class=\"em-item-meta-line em-location-address\">\n					<span class=\"em-icon-location em-icon\"></span>\n					#_LOCATIONFULLBR\n				</div>\n			</section>\n			{no_loc_image}\n		</section>\n		<section class=\"em-item-meta-column\">\n			{/no_loc_image}\n			<section class=\"em-location-next-event\">\n				<h3>Next Event</h3>\n				{has_events}\n				<div class=\"em-item-meta-line em-location-events\">\n					<span class=\"em-icon-calendar em-icon\"></span>\n					<div>#_LOCATIONNEXTEVENT</div>\n				</div>\n				{/has_events}\n				{no_events}\n				<div class=\"em-item-meta-line em-location-no-events\">\n					<span class=\"em-icon-calendar em-icon\"></span>\n					<div>No upcoming events</div>\n				</div>\n				{/no_events}\n			</section>\n		</section>\n	</div>\n</section>\n<section class=\"em-location-section-map\">\n	#_LOCATIONMAP{100%,0}\n</section>\n<section class=\"em-location-content\">\n	#_LOCATIONNOTES\n</section>\n<section class=\"em-location-events\">\n	<a name=\"upcoming-events\"></a>\n	<h3>Upcoming Events</h3>\n	#_LOCATIONNEXTEVENTS\n</section>','yes');
INSERT INTO `wp_options` VALUES (331,'dbem_location_excerpt_format','#_LOCATIONEXCERPT','yes');
INSERT INTO `wp_options` VALUES (332,'dbem_location_excerpt_alt_format','#_LOCATIONEXCERPT{55}','yes');
INSERT INTO `wp_options` VALUES (333,'dbem_location_no_events_message','No events in this location','yes');
INSERT INTO `wp_options` VALUES (334,'dbem_location_event_list_item_header_format','<ul>','yes');
INSERT INTO `wp_options` VALUES (335,'dbem_location_event_list_item_format','<li>#_EVENTLINK - #_EVENTDATES - #_EVENTTIMES</li>','yes');
INSERT INTO `wp_options` VALUES (336,'dbem_location_event_list_item_footer_format','</ul>','yes');
INSERT INTO `wp_options` VALUES (337,'dbem_location_event_list_limit','20','yes');
INSERT INTO `wp_options` VALUES (338,'dbem_location_event_list_orderby','event_start_date,event_start_time,event_name','yes');
INSERT INTO `wp_options` VALUES (339,'dbem_location_event_list_order','ASC','yes');
INSERT INTO `wp_options` VALUES (340,'dbem_location_event_single_format','#_EVENTLINK - #_EVENTDATES - #_EVENTTIMES','yes');
INSERT INTO `wp_options` VALUES (341,'dbem_location_no_event_message','No events in this location','yes');
INSERT INTO `wp_options` VALUES (342,'dbem_categories_default_limit','10','yes');
INSERT INTO `wp_options` VALUES (343,'dbem_categories_default_orderby','name','yes');
INSERT INTO `wp_options` VALUES (344,'dbem_categories_default_order','ASC','yes');
INSERT INTO `wp_options` VALUES (345,'dbem_categories_list_item_format_header','','yes');
INSERT INTO `wp_options` VALUES (346,'dbem_categories_list_item_format','<div class=\"em-item em-taxonomy em-category\" style=\"--default-border:#_CATEGORYCOLOR;\">\n	<div class=\"em-item-image {no_image}has-placeholder{/no_image}\">\n		{has_image}\n		#_CATEGORYIMAGE{medium}\n		{/has_image}\n		{no_image}\n		<div class=\"em-item-image-placeholder\"></div>\n		{/no_image}\n	</div>\n	<div class=\"em-item-info\">\n		<h3 class=\"em-item-title\">#_CATEGORYLINK</h3>\n		<div class=\"em-event-meta em-item-meta\">\n			{has_events}\n			<div class=\"em-item-meta-line em-taxonomy-events em-category-events\">\n				<span class=\"em-icon-calendar em-icon\"></span>\n				<div>\n					<p>Next Event</p>\n					<p>#_CATEGORYNEXTEVENT</p>\n					<p><a href=\"#_CATEGORYURL\">See All</a></p>\n				</div>\n			</div>\n			{/has_events}\n			{no_events}\n			<div class=\"em-item-meta-line em-taxonomy-no-events em-category-no-events\">\n				<span class=\"em-icon-calendar em-icon\"></span>\n				<div>No upcoming events</div>\n			</div>\n			{/no_events}\n		</div>\n		<div class=\"em-item-desc\">\n			#_CATEGORYEXCERPT{25}\n		</div>\n		<div class=\"em-item-actions input\">\n			<a class=\"em-item-read-more button\" href=\"#_CATEGORYURL\">More Info</a>\n		</div>\n	</div>\n</div>','yes');
INSERT INTO `wp_options` VALUES (347,'dbem_categories_list_item_format_footer','','yes');
INSERT INTO `wp_options` VALUES (348,'dbem_no_categories_message','No Categories','yes');
INSERT INTO `wp_options` VALUES (349,'dbem_category_page_title_format','#_CATEGORYNAME','yes');
INSERT INTO `wp_options` VALUES (350,'dbem_category_page_format','<section class=\"em-item-header\" style=\"--default-border:#_CATEGORYCOLOR;\">\n	{has_image}\n	<div class=\"em-item-image\">\n		#_CATEGORYIMAGE{medium}\n	</div>\n	{/has_image}\n	<div class=\"em-item-meta\">\n		<section class=\"em-item-meta-column\">\n			<section class=\"em-location-next-event\">\n				<h3>Next Event</h3>\n				{has_events}\n				<div class=\"em-item-meta-line em-taxonomy-events em-category-events\">\n					<span class=\"em-icon-calendar em-icon\"></span>\n					<div>\n						<p>#_CATEGORYNEXTEVENT</p>\n						<p><a href=\"#upcoming-events\">See All</a></p>\n					</div>\n				</div>\n				{/has_events}\n				{no_events}\n				<div class=\"em-item-meta-line em-taxonomy-no-events em-category-no-events\">\n					<span class=\"em-icon-calendar em-icon\"></span>\n					<div>No upcoming events</p></div>\n				</div>\n				{/no_events}\n			</section>\n			{no_loc_image}\n		</section>\n		<section class=\"em-item-meta-column\">\n			{/no_loc_image}\n			<section class=\"em-taxonomy-description\">\n				<h3>Description</h3>\n				#_CATEGORYDESCRIPTION\n			</section>\n		</section>\n	</div>\n</section>\n<section class=\"em-taxonomy-events\">\n	<a name=\"upcoming-events\"></a>\n	<h3>Upcoming Events</h3>\n	#_CATEGORYNEXTEVENTS\n</section>','yes');
INSERT INTO `wp_options` VALUES (351,'dbem_category_no_events_message','No events in this category','yes');
INSERT INTO `wp_options` VALUES (352,'dbem_category_event_list_item_header_format','<ul>','yes');
INSERT INTO `wp_options` VALUES (353,'dbem_category_event_list_item_format','<li>#_EVENTLINK - #_EVENTDATES - #_EVENTTIMES</li>','yes');
INSERT INTO `wp_options` VALUES (354,'dbem_category_event_list_item_footer_format','</ul>','yes');
INSERT INTO `wp_options` VALUES (355,'dbem_category_event_list_limit','20','yes');
INSERT INTO `wp_options` VALUES (356,'dbem_category_event_list_orderby','event_start_date,event_start_time,event_name','yes');
INSERT INTO `wp_options` VALUES (357,'dbem_category_event_list_order','ASC','yes');
INSERT INTO `wp_options` VALUES (358,'dbem_category_event_single_format','#_EVENTLINK - #_EVENTDATES - #_EVENTTIMES','yes');
INSERT INTO `wp_options` VALUES (359,'dbem_category_no_event_message','No events in this category','yes');
INSERT INTO `wp_options` VALUES (360,'dbem_category_default_color','#a8d144','yes');
INSERT INTO `wp_options` VALUES (361,'dbem_tags_default_limit','10','yes');
INSERT INTO `wp_options` VALUES (362,'dbem_tags_default_orderby','name','yes');
INSERT INTO `wp_options` VALUES (363,'dbem_tags_default_order','ASC','yes');
INSERT INTO `wp_options` VALUES (364,'dbem_event_cancelled_email','1','yes');
INSERT INTO `wp_options` VALUES (365,'dbem_event_cancelled_email_subject','Cancelled - #_EVENTNAME','yes');
INSERT INTO `wp_options` VALUES (366,'dbem_event_cancelled_email_body','Dear Guest, \n\rWe regret to inform you that #_EVENTNAME on #_EVENTDATES has been cancelled.\n\rYours faithfully,\n\r#_CONTACTNAME\n\r\n\r-------------------------------\n\rPowered by Events Manager - http://wp-events-plugin.com','yes');
INSERT INTO `wp_options` VALUES (367,'dbem_event_cancelled_bookings','1','yes');
INSERT INTO `wp_options` VALUES (368,'dbem_event_cancelled_bookings_email','1','yes');
INSERT INTO `wp_options` VALUES (369,'dbem_tags_list_item_format_header','','yes');
INSERT INTO `wp_options` VALUES (370,'dbem_tags_list_item_format','<div class=\"em-item em-taxonomy em-tag\" style=\"--default-border:#_TAGCOLOR;\">\n	<div class=\"em-item-image {no_image}has-placeholder{/no_image}\">\n		{has_image}\n		#_TAGIMAGE{medium}\n		{/has_image}\n		{no_image}\n		<div class=\"em-item-image-placeholder\"></div>\n		{/no_image}\n	</div>\n	<div class=\"em-item-info\">\n		<h3 class=\"em-item-title\">#_TAGLINK</h3>\n		<div class=\"em-event-meta em-item-meta\">\n			{has_events}\n			<div class=\"em-item-meta-line em-taxonomy-events em-tag-events\">\n				<span class=\"em-icon-calendar em-icon\"></span>\n				<div>\n					<p>Next Event</p>\n					<p>#_TAGNEXTEVENT</p>\n					<p><a href=\"#_TAGURL\">See All</a></p>\n				</div>\n			</div>\n			{/has_events}\n			{no_events}\n			<div class=\"em-item-meta-line em-taxonomy-no-events em-tag-no-events\">\n				<span class=\"em-icon-calendar em-icon\"></span>\n				<div>No upcoming events</p></div>\n			</div>\n			{/no_events}\n		</div>\n		<div class=\"em-item-desc\">\n			#_TAGEXCERPT{25}\n		</div>\n		<div class=\"em-item-actions input\">\n			<a class=\"em-item-read-more button\" href=\"#_TAGURL\">More Info</a>\n		</div>\n	</div>\n</div>','yes');
INSERT INTO `wp_options` VALUES (371,'dbem_tags_list_item_format_footer','','yes');
INSERT INTO `wp_options` VALUES (372,'dbem_no_tags_message','No Tags','yes');
INSERT INTO `wp_options` VALUES (373,'dbem_tag_page_title_format','#_TAGNAME','yes');
INSERT INTO `wp_options` VALUES (374,'dbem_tag_page_format','<section class=\"em-item-header\" style=\"--default-border:#_TAGCOLOR;\">\n	{has_image}\n	<div class=\"em-item-image\">\n		#_TAGIMAGE{medium}\n	</div>\n	{/has_image}\n	<div class=\"em-item-meta\">\n		<section class=\"em-item-meta-column\">\n			<section class=\"em-location-next-event\">\n				<h3>Next Event</h3>\n				{has_events}\n				<div class=\"em-item-meta-line em-taxonomy-events em-tag-events\">\n					<span class=\"em-icon-calendar em-icon\"></span>\n					<div>\n						<p>#_TAGNEXTEVENT</p>\n						<p><a href=\"#upcoming-events\">See All</a></p>\n					</div>\n				</div>\n				{/has_events}\n				{no_events}\n				<div class=\"em-item-meta-line em-taxonomy-no-events em-tag-no-events\">\n					<span class=\"em-icon-calendar em-icon\"></span>\n					<div>No upcoming events</p></div>\n				</div>\n				{/no_events}\n			</section>\n			{no_loc_image}\n		</section>\n		<section class=\"em-item-meta-column\">\n			{/no_loc_image}\n			<section class=\"em-taxonomy-description\">\n				<h3>Description</h3>\n				#_TAGDESCRIPTION\n			</section>\n		</section>\n	</div>\n</section>\n<section class=\"em-taxonomy-events\">\n	<a name=\"upcoming-events\"></a>\n	<h3>Upcoming Events</h3>\n	#_TAGNEXTEVENTS\n</section>','yes');
INSERT INTO `wp_options` VALUES (375,'dbem_tag_no_events_message','No events with this tag','yes');
INSERT INTO `wp_options` VALUES (376,'dbem_tag_event_list_item_header_format','<ul class=\"em-tags-list\">','yes');
INSERT INTO `wp_options` VALUES (377,'dbem_tag_event_list_item_format','<li>#_EVENTLINK - #_EVENTDATES - #_EVENTTIMES</li>','yes');
INSERT INTO `wp_options` VALUES (378,'dbem_tag_event_list_item_footer_format','</ul>','yes');
INSERT INTO `wp_options` VALUES (379,'dbem_tag_event_single_format','#_EVENTLINK - #_EVENTDATES - #_EVENTTIMES','yes');
INSERT INTO `wp_options` VALUES (380,'dbem_tag_no_event_message','No events with this tag','yes');
INSERT INTO `wp_options` VALUES (381,'dbem_tag_event_list_limit','20','yes');
INSERT INTO `wp_options` VALUES (382,'dbem_tag_event_list_orderby','event_start_date,event_start_time,event_name','yes');
INSERT INTO `wp_options` VALUES (383,'dbem_tag_event_list_order','ASC','yes');
INSERT INTO `wp_options` VALUES (384,'dbem_tag_default_color','#a8d145','yes');
INSERT INTO `wp_options` VALUES (385,'dbem_rss_limit','50','yes');
INSERT INTO `wp_options` VALUES (386,'dbem_rss_scope','future','yes');
INSERT INTO `wp_options` VALUES (387,'dbem_rss_main_title','De MijnGang - Events','yes');
INSERT INTO `wp_options` VALUES (388,'dbem_rss_main_description','Van O.V.S. naar De MijnGang - Events','yes');
INSERT INTO `wp_options` VALUES (389,'dbem_rss_description_format','#_EVENTDATES - #_EVENTTIMES <br/>#_LOCATIONNAME <br/>#_LOCATIONADDRESS <br/>#_LOCATIONTOWN','yes');
INSERT INTO `wp_options` VALUES (390,'dbem_rss_title_format','#_EVENTNAME','yes');
INSERT INTO `wp_options` VALUES (391,'dbem_rss_order','ASC','yes');
INSERT INTO `wp_options` VALUES (392,'dbem_rss_orderby','event_start_date,event_start_time,event_name','yes');
INSERT INTO `wp_options` VALUES (393,'em_rss_pubdate','Fri, 17 May 2024 10:40:07 +0000','yes');
INSERT INTO `wp_options` VALUES (394,'dbem_ical_limit','50','yes');
INSERT INTO `wp_options` VALUES (395,'dbem_ical_scope','future','yes');
INSERT INTO `wp_options` VALUES (396,'dbem_ical_description_format','#_EVENTNAME','yes');
INSERT INTO `wp_options` VALUES (397,'dbem_ical_real_description_format','#_EVENTEXCERPT','yes');
INSERT INTO `wp_options` VALUES (398,'dbem_ical_location_format','#_LOCATIONNAME, #_LOCATIONFULLLINE, #_LOCATIONCOUNTRY','yes');
INSERT INTO `wp_options` VALUES (399,'dbem_gmap_is_active','1','yes');
INSERT INTO `wp_options` VALUES (400,'dbem_google_maps_browser_key','','yes');
INSERT INTO `wp_options` VALUES (401,'dbem_map_default_width','400px','yes');
INSERT INTO `wp_options` VALUES (402,'dbem_map_default_height','300px','yes');
INSERT INTO `wp_options` VALUES (403,'dbem_location_baloon_format','<strong>#_LOCATIONNAME</strong><br/>#_LOCATIONADDRESS - #_LOCATIONTOWN<br/><a href=\"#_LOCATIONPAGEURL\">Events</a>','yes');
INSERT INTO `wp_options` VALUES (404,'dbem_map_text_format','<strong>#_LOCATIONNAME</strong><p>#_LOCATIONADDRESS</p><p>#_LOCATIONTOWN</p>','yes');
INSERT INTO `wp_options` VALUES (405,'dbem_email_disable_registration','0','yes');
INSERT INTO `wp_options` VALUES (406,'dbem_rsvp_mail_port','465','yes');
INSERT INTO `wp_options` VALUES (407,'dbem_smtp_host','localhost','yes');
INSERT INTO `wp_options` VALUES (408,'dbem_mail_sender_name','','yes');
INSERT INTO `wp_options` VALUES (409,'dbem_rsvp_mail_send_method','wp_mail','yes');
INSERT INTO `wp_options` VALUES (410,'dbem_rsvp_mail_SMTPAuth','1','yes');
INSERT INTO `wp_options` VALUES (411,'dbem_smtp_html','1','yes');
INSERT INTO `wp_options` VALUES (412,'dbem_smtp_html_br','1','yes');
INSERT INTO `wp_options` VALUES (413,'dbem_smtp_encryption','tls','yes');
INSERT INTO `wp_options` VALUES (414,'dbem_smtp_autotls','1','yes');
INSERT INTO `wp_options` VALUES (415,'dbem_image_max_width','700','yes');
INSERT INTO `wp_options` VALUES (416,'dbem_image_max_height','700','yes');
INSERT INTO `wp_options` VALUES (417,'dbem_image_min_width','50','yes');
INSERT INTO `wp_options` VALUES (418,'dbem_image_min_height','50','yes');
INSERT INTO `wp_options` VALUES (419,'dbem_image_max_size','204800','yes');
INSERT INTO `wp_options` VALUES (420,'dbem_list_date_title','Events - #j #M #y','yes');
INSERT INTO `wp_options` VALUES (421,'dbem_full_calendar_month_format','M Y','yes');
INSERT INTO `wp_options` VALUES (422,'dbem_full_calendar_long_events','0','yes');
INSERT INTO `wp_options` VALUES (423,'dbem_full_calendar_initials_length','0','yes');
INSERT INTO `wp_options` VALUES (424,'dbem_full_calendar_abbreviated_weekdays','1','yes');
INSERT INTO `wp_options` VALUES (425,'dbem_display_calendar_day_single_yes','1','yes');
INSERT INTO `wp_options` VALUES (426,'dbem_small_calendar_initials_length','1','yes');
INSERT INTO `wp_options` VALUES (427,'dbem_small_calendar_abbreviated_weekdays','','yes');
INSERT INTO `wp_options` VALUES (428,'dbem_small_calendar_long_events','0','yes');
INSERT INTO `wp_options` VALUES (429,'dbem_display_calendar_order','ASC','yes');
INSERT INTO `wp_options` VALUES (430,'dbem_display_calendar_orderby','event_name,event_start_time','yes');
INSERT INTO `wp_options` VALUES (431,'dbem_display_calendar_events_limit','3','yes');
INSERT INTO `wp_options` VALUES (432,'dbem_display_calendar_events_limit_msg','more...','yes');
INSERT INTO `wp_options` VALUES (433,'dbem_calendar_direct_links','1','yes');
INSERT INTO `wp_options` VALUES (434,'dbem_calendar_preview_mode','modal','yes');
INSERT INTO `wp_options` VALUES (435,'dbem_calendar_preview_mode_date','modal','yes');
INSERT INTO `wp_options` VALUES (436,'dbem_calendar_preview_modal_date_format','<div class=\"em-item em-event\" style=\"--default-border:#_CATEGORYCOLOR;\">\n	<div class=\"em-item-image {no_image}has-placeholder{/no_image}\" style=\"max-width:150px\">\n		{has_image}\n		#_EVENTIMAGE{150,150}\n		{/has_image}\n		{no_image}\n		<div class=\"em-item-image-placeholder\">\n			<div class=\"date\">\n				<span class=\"day\">#d</span>\n				<span class=\"month\">#M</span>\n			</div>\n		</div>\n		{/no_image}\n	</div>\n	<div class=\"em-item-info\">\n		<div class=\"em-item-name\">#_EVENTLINK</div>\n		<div class=\"em-item-meta\">\n			<div class=\"em-item-meta-line em-event-date em-event-meta-datetime\">\n				<span class=\"em-icon em-icon-calendar\"></span>\n				<span>#j #M #y</span>\n			</div>\n			<div class=\"em-item-meta-line em-event-location em-event-meta-location\">\n				<span class=\"em-icon em-icon-location\"></span>\n				<span>#_TOWN</span>\n			</div>\n		</div>\n	</div>\n</div>','yes');
INSERT INTO `wp_options` VALUES (437,'dbem_calendar_preview_modal_event_format','<div class=\"em pixelbones em-calendar-preview em-list em-events-list\">\n	<div class=\"em-event em-item\" style=\"--default-border:#_CATEGORYCOLOR;\">\n		<div class=\"em-item-image {no_image}has-placeholder{/no_image}\">\n			{has_image}\n			#_EVENTIMAGE{medium}\n			{/has_image}\n			{no_image}\n			<div class=\"em-item-image-placeholder\">\n				<div class=\"date\">\n					<span class=\"day\">#d</span>\n					<span class=\"month\">#M</span>\n				</div>\n			</div>\n			{/no_image}\n		</div>\n		<div class=\"em-item-info\">\n			<div class=\"em-event-meta em-item-meta\">\n				<div class=\"em-item-meta-line em-event-date em-event-meta-datetime\">\n					<span class=\"em-icon-calendar em-icon\"></span>\n					#_EVENTDATES&nbsp;&nbsp;&nbsp;&nbsp;\n				</div>\n				<div class=\"em-item-meta-line em-event-time em-event-meta-datetime\">\n					<span class=\"em-icon-clock em-icon\"></span>\n					#_EVENTTIMES\n				</div>\n				{bookings_open}\n				<div class=\"em-item-meta-line em-event-prices\">\n					<span class=\"em-icon-ticket em-icon\"></span>\n					#_EVENTPRICERANGE\n				</div>\n				{/bookings_open}\n				{has_location_venue}\n				<div class=\"em-item-meta-line em-event-location\">\n					<span class=\"em-icon-location em-icon\"></span>\n					#_LOCATIONLINK\n				</div>\n				{/has_location_venue}\n				{has_event_location}\n				<div class=\"em-item-meta-line em-event-location\">\n					<span class=\"em-icon-at em-icon\"></span>\n					#_EVENTLOCATION\n				</div>\n				{/has_event_location}\n				{has_category}\n				<div class=\"em-item-meta-line em-item-taxonomy em-event-categories\">\n					<span class=\"em-icon-category em-icon\"></span>\n					<div>#_EVENTCATEGORIES</div>\n				</div>\n				{/has_category}\n				{has_tag}\n				<div class=\"em-item-meta-line em-item-taxonomy em-event-tags\">\n					<span class=\"em-icon-tag em-icon\"></span>\n					<div>#_EVENTTAGS</div>\n				</div>\n				{/has_tag}\n			</div>\n			<div class=\"em-item-desc\">\n				#_EVENTEXCERPT{25}\n			</div>\n			<div class=\"em-item-actions input\">\n				<a class=\"em-item-read-more button\" href=\"#_EVENTURL\">More Info</a>\n				{bookings_open}\n				<a class=\"em-event-book-now button\" href=\"#_EVENTURL#em-event-booking-form\">\n					<span class=\"em-icon em-icon-ticket\"></span>\n					Book Now!				</a>\n				{/bookings_open}\n			</div>\n		</div>\n	</div>\n</div>','yes');
INSERT INTO `wp_options` VALUES (438,'dbem_calendar_preview_tooltip_event_format','{has_image}\n<div class=\"em-item-meta em-event-image\">\n	#_EVENTIMAGE{300}\n</div>\n{/has_image}\n<div class=\"em-item-info\">\n	<div class=\"em-item-title em-event-title\">#_EVENTLINK</div>\n	<div class=\"em-event-meta em-item-meta\">\n		<div class=\"em-item-meta-line em-event-date em-event-meta-datetime\">\n			<span class=\"em-icon-calendar em-icon\"></span>\n			#_EVENTDATES&nbsp;&nbsp;&nbsp;&nbsp;\n		</div>\n		<div class=\"em-item-meta-line em-event-time em-event-meta-datetime\">\n			<span class=\"em-icon-clock em-icon\"></span>\n			#_EVENTTIMES\n		</div>\n		{bookings_open}\n		<div class=\"em-item-meta-line em-event-prices\">\n			<span class=\"em-icon-ticket em-icon\"></span>\n			#_EVENTPRICERANGE\n		</div>\n		{/bookings_open}\n		{has_location_venue}\n		<div class=\"em-item-meta-line em-event-location\">\n			<span class=\"em-icon-location em-icon\"></span>\n			#_LOCATIONLINK\n		</div>\n		{/has_location_venue}\n		{has_event_location}\n		<div class=\"em-item-meta-line em-event-location\">\n			<span class=\"em-icon-at em-icon\"></span>\n			#_EVENTLOCATION\n		</div>\n		{/has_event_location}\n		{has_category}\n		<div class=\"em-item-meta-line em-item-taxonomy em-event-categories\">\n			<span class=\"em-icon-category em-icon\"></span>\n			#_EVENTCATEGORIES\n		</div>\n		{/has_category}\n		{has_tag}\n		<div class=\"em-item-meta-line em-item-taxonomy em-event-tags\">\n			<span class=\"em-icon-tag em-icon\"></span>\n			<div>#_EVENTTAGS</div>\n		</div>\n		{/has_tag}\n	</div>\n</div>\n<div class=\"em-item-desc\">#_EVENTEXCERPT{25,...}</div>\n<div class=\"em-item-actions input\">\n	<a class=\"em-event-read-more button\" href=\"#_EVENTURL\">More Info</a>\n	{bookings_open}\n	<a class=\"em-event-book-now button\" href=\"#_EVENTURL#em-booking\">Book Now!</a>\n	{/bookings_open}\n</div>','yes');
INSERT INTO `wp_options` VALUES (439,'dbem_calendar_large_pill_format','#_12HSTARTTIME - #_EVENTLINK','yes');
INSERT INTO `wp_options` VALUES (440,'dbem_timezone_enabled','1','yes');
INSERT INTO `wp_options` VALUES (441,'dbem_timezone_default','UTC','yes');
INSERT INTO `wp_options` VALUES (442,'dbem_require_location','0','yes');
INSERT INTO `wp_options` VALUES (443,'dbem_locations_enabled','1','yes');
INSERT INTO `wp_options` VALUES (444,'dbem_location_types','a:2:{s:8:\"location\";i:1;s:3:\"url\";i:1;}','yes');
INSERT INTO `wp_options` VALUES (445,'dbem_use_select_for_locations','0','yes');
INSERT INTO `wp_options` VALUES (446,'dbem_attributes_enabled','1','yes');
INSERT INTO `wp_options` VALUES (447,'dbem_recurrence_enabled','1','yes');
INSERT INTO `wp_options` VALUES (448,'dbem_rsvp_enabled','1','yes');
INSERT INTO `wp_options` VALUES (449,'dbem_categories_enabled','1','yes');
INSERT INTO `wp_options` VALUES (450,'dbem_tags_enabled','1','yes');
INSERT INTO `wp_options` VALUES (451,'dbem_placeholders_custom','','yes');
INSERT INTO `wp_options` VALUES (452,'dbem_location_attributes_enabled','1','yes');
INSERT INTO `wp_options` VALUES (453,'dbem_location_placeholders_custom','','yes');
INSERT INTO `wp_options` VALUES (454,'dbem_bookings_registration_disable','0','yes');
INSERT INTO `wp_options` VALUES (455,'dbem_bookings_registration_disable_user_emails','0','yes');
INSERT INTO `wp_options` VALUES (456,'dbem_bookings_approval','1','yes');
INSERT INTO `wp_options` VALUES (457,'dbem_bookings_approval_reserved','0','yes');
INSERT INTO `wp_options` VALUES (458,'dbem_bookings_approval_overbooking','0','yes');
INSERT INTO `wp_options` VALUES (459,'dbem_bookings_double','0','yes');
INSERT INTO `wp_options` VALUES (460,'dbem_bookings_user_cancellation','1','yes');
INSERT INTO `wp_options` VALUES (461,'dbem_bookings_user_cancellation_time','','yes');
INSERT INTO `wp_options` VALUES (462,'dbem_bookings_currency','USD','yes');
INSERT INTO `wp_options` VALUES (463,'dbem_bookings_currency_decimal_point','.','yes');
INSERT INTO `wp_options` VALUES (464,'dbem_bookings_currency_thousands_sep',',','yes');
INSERT INTO `wp_options` VALUES (465,'dbem_bookings_currency_format','@#','yes');
INSERT INTO `wp_options` VALUES (466,'dbem_bookings_tax','0','yes');
INSERT INTO `wp_options` VALUES (467,'dbem_bookings_tax_auto_add','0','yes');
INSERT INTO `wp_options` VALUES (468,'dbem_bookings_submit_button','Submit Booking','yes');
INSERT INTO `wp_options` VALUES (469,'dbem_bookings_submit_button_paid','Submit Booking - %s','yes');
INSERT INTO `wp_options` VALUES (470,'dbem_bookings_submit_button_processing','Processing ...','yes');
INSERT INTO `wp_options` VALUES (471,'dbem_bookings_login_form','1','yes');
INSERT INTO `wp_options` VALUES (472,'dbem_bookings_form_hide_dynamic','1','yes');
INSERT INTO `wp_options` VALUES (473,'dbem_bookings_summary','1','yes');
INSERT INTO `wp_options` VALUES (474,'dbem_bookings_summary_taxes_itemized','1','yes');
INSERT INTO `wp_options` VALUES (475,'dbem_bookings_summary_free','1','yes');
INSERT INTO `wp_options` VALUES (476,'dbem_bookings_summary_message','Please select at least one space to proceed with your booking.','yes');
INSERT INTO `wp_options` VALUES (477,'dbem_bookings_anonymous','1','yes');
INSERT INTO `wp_options` VALUES (478,'dbem_bookings_form_max','20','yes');
INSERT INTO `wp_options` VALUES (479,'dbem_bookings_header_tickets','Tickets','yes');
INSERT INTO `wp_options` VALUES (480,'dbem_bookings_header_reg_info','Registration Information','yes');
INSERT INTO `wp_options` VALUES (481,'dbem_bookings_header_summary','Booking Summary','yes');
INSERT INTO `wp_options` VALUES (482,'dbem_bookings_header_confirm','','yes');
INSERT INTO `wp_options` VALUES (483,'dbem_bookings_header_confirm_free','','yes');
INSERT INTO `wp_options` VALUES (484,'dbem_bookings_form_msg_disabled','Online bookings are not available for this event.','yes');
INSERT INTO `wp_options` VALUES (485,'dbem_bookings_form_msg_closed','Bookings are closed for this event.','yes');
INSERT INTO `wp_options` VALUES (486,'dbem_bookings_form_msg_cancelled','This event has been cancelled. Bookings are closed for this event.','yes');
INSERT INTO `wp_options` VALUES (487,'dbem_bookings_form_msg_full','This event is fully booked.','yes');
INSERT INTO `wp_options` VALUES (488,'dbem_bookings_form_msg_attending','You are currently attending this event.','yes');
INSERT INTO `wp_options` VALUES (489,'dbem_bookings_form_msg_bookings_link','Manage my bookings','yes');
INSERT INTO `wp_options` VALUES (490,'dbem_booking_warning_cancel','Are you sure you want to cancel your booking?','yes');
INSERT INTO `wp_options` VALUES (491,'dbem_booking_feedback_cancelled','Booking Cancelled','yes');
INSERT INTO `wp_options` VALUES (492,'dbem_booking_feedback_pending','Booking successful, pending confirmation (you will also receive an email once confirmed).','yes');
INSERT INTO `wp_options` VALUES (493,'dbem_booking_feedback','Booking successful.','yes');
INSERT INTO `wp_options` VALUES (494,'dbem_booking_feedback_full','Booking cannot be made, not enough spaces available!','yes');
INSERT INTO `wp_options` VALUES (495,'dbem_booking_feedback_log_in','You must log in or register to make a booking.','yes');
INSERT INTO `wp_options` VALUES (496,'dbem_booking_feedback_nomail','However, there were some problems whilst sending confirmation emails to you and/or the event contact person. You may want to contact them directly and letting them know of this error.','yes');
INSERT INTO `wp_options` VALUES (497,'dbem_booking_feedback_error','Booking could not be created:','yes');
INSERT INTO `wp_options` VALUES (498,'dbem_booking_feedback_email_exists','This email already exists in our system, please log in to register to proceed with your booking.','yes');
INSERT INTO `wp_options` VALUES (499,'dbem_booking_feedback_new_user','A new user account has been created for you. Please check your email for access details.','yes');
INSERT INTO `wp_options` VALUES (500,'dbem_booking_feedback_reg_error','There was a problem creating a user account, please contact a website administrator.','yes');
INSERT INTO `wp_options` VALUES (501,'dbem_booking_feedback_already_booked','You already have booked a seat at this event.','yes');
INSERT INTO `wp_options` VALUES (502,'dbem_booking_feedback_min_space','You must request at least one space to book an event.','yes');
INSERT INTO `wp_options` VALUES (503,'dbem_booking_feedback_spaces_limit','You cannot book more than %d spaces for this event.','yes');
INSERT INTO `wp_options` VALUES (504,'dbem_booking_button_msg_book','Book Now','yes');
INSERT INTO `wp_options` VALUES (505,'dbem_booking_button_msg_booking','Booking...','yes');
INSERT INTO `wp_options` VALUES (506,'dbem_booking_button_msg_booked','Booking Submitted','yes');
INSERT INTO `wp_options` VALUES (507,'dbem_booking_button_msg_already_booked','Already Booked','yes');
INSERT INTO `wp_options` VALUES (508,'dbem_booking_button_msg_error','Booking Error. Try again?','yes');
INSERT INTO `wp_options` VALUES (509,'dbem_booking_button_msg_full','Sold Out','yes');
INSERT INTO `wp_options` VALUES (510,'dbem_booking_button_msg_closed','Bookings Closed','yes');
INSERT INTO `wp_options` VALUES (511,'dbem_booking_button_msg_event_cancelled','Event Cancelled','yes');
INSERT INTO `wp_options` VALUES (512,'dbem_booking_button_msg_cancel','Cancel','yes');
INSERT INTO `wp_options` VALUES (513,'dbem_booking_button_msg_canceling','Canceling...','yes');
INSERT INTO `wp_options` VALUES (514,'dbem_booking_button_msg_cancelled','Cancelled','yes');
INSERT INTO `wp_options` VALUES (515,'dbem_booking_button_msg_cancel_error','Cancellation Error. Try again?','yes');
INSERT INTO `wp_options` VALUES (516,'dbem_bookings_notify_admin','0','yes');
INSERT INTO `wp_options` VALUES (517,'dbem_bookings_contact_email','1','yes');
INSERT INTO `wp_options` VALUES (518,'dbem_bookings_replyto_owner_admins','0','yes');
INSERT INTO `wp_options` VALUES (519,'dbem_bookings_replyto_owner','0','yes');
INSERT INTO `wp_options` VALUES (520,'dbem_bookings_contact_email_pending_subject','Booking Pending','yes');
INSERT INTO `wp_options` VALUES (521,'dbem_bookings_contact_email_pending_body','The following booking is pending :\n\r#_EVENTNAME - #_EVENTDATES @ #_EVENTTIMES\n\rNow there are #_BOOKEDSPACES spaces reserved, #_AVAILABLESPACES are still available.\n\rBOOKING DETAILS\n\rName : #_BOOKINGNAME\n\rEmail : #_BOOKINGEMAIL\n\r#_BOOKINGSUMMARY\n\r\n\rPowered by Events Manager - http://wp-events-plugin.com','yes');
INSERT INTO `wp_options` VALUES (522,'dbem_bookings_contact_email_confirmed_subject','Booking Confirmed','yes');
INSERT INTO `wp_options` VALUES (523,'dbem_bookings_contact_email_confirmed_body','The following booking is confirmed :\n\r#_EVENTNAME - #_EVENTDATES @ #_EVENTTIMES\n\rNow there are #_BOOKEDSPACES spaces reserved, #_AVAILABLESPACES are still available.\n\rBOOKING DETAILS\n\rName : #_BOOKINGNAME\n\rEmail : #_BOOKINGEMAIL\n\r#_BOOKINGSUMMARY\n\r\n\rPowered by Events Manager - http://wp-events-plugin.com','yes');
INSERT INTO `wp_options` VALUES (524,'dbem_bookings_contact_email_rejected_subject','Booking Rejected','yes');
INSERT INTO `wp_options` VALUES (525,'dbem_bookings_contact_email_rejected_body','The following booking is rejected :\n\r#_EVENTNAME - #_EVENTDATES @ #_EVENTTIMES\n\rNow there are #_BOOKEDSPACES spaces reserved, #_AVAILABLESPACES are still available.\n\rBOOKING DETAILS\n\rName : #_BOOKINGNAME\n\rEmail : #_BOOKINGEMAIL\n\r#_BOOKINGSUMMARY\n\r\n\rPowered by Events Manager - http://wp-events-plugin.com','yes');
INSERT INTO `wp_options` VALUES (526,'dbem_bookings_contact_email_cancelled_subject','Booking Cancelled','yes');
INSERT INTO `wp_options` VALUES (527,'dbem_bookings_contact_email_cancelled_body','The following booking is cancelled :\n\r#_EVENTNAME - #_EVENTDATES @ #_EVENTTIMES\n\rNow there are #_BOOKEDSPACES spaces reserved, #_AVAILABLESPACES are still available.\n\rBOOKING DETAILS\n\rName : #_BOOKINGNAME\n\rEmail : #_BOOKINGEMAIL\n\r#_BOOKINGSUMMARY\n\r\n\rPowered by Events Manager - http://wp-events-plugin.com','yes');
INSERT INTO `wp_options` VALUES (528,'dbem_bookings_email_pending_subject','Booking Pending','yes');
INSERT INTO `wp_options` VALUES (529,'dbem_bookings_email_pending_body','Dear #_BOOKINGNAME, \n\rYou have requested #_BOOKINGSPACES space/spaces for #_EVENTNAME.\n\rWhen : #_EVENTDATES @ #_EVENTTIMES\n\rWhere : #_LOCATIONNAME - #_LOCATIONFULLLINE\n\rYour booking is currently pending approval by our administrators. Once approved you will receive an automatic confirmation.\n\rYours faithfully,\n\r#_CONTACTNAME\n\r\n\r-------------------------------\n\rPowered by Events Manager - http://wp-events-plugin.com','yes');
INSERT INTO `wp_options` VALUES (530,'dbem_bookings_email_rejected_subject','Booking Rejected','yes');
INSERT INTO `wp_options` VALUES (531,'dbem_bookings_email_rejected_body','Dear #_BOOKINGNAME, \n\rYour requested booking for #_BOOKINGSPACES spaces at #_EVENTNAME on #_EVENTDATES has been rejected.\n\rYours faithfully,\n\r#_CONTACTNAME\n\r\n\r-------------------------------\n\rPowered by Events Manager - http://wp-events-plugin.com','yes');
INSERT INTO `wp_options` VALUES (532,'dbem_bookings_email_confirmed_subject','Booking Confirmed','yes');
INSERT INTO `wp_options` VALUES (533,'dbem_bookings_email_confirmed_body','Dear #_BOOKINGNAME, \n\rYou have successfully reserved #_BOOKINGSPACES space/spaces for #_EVENTNAME.\n\rWhen : #_EVENTDATES @ #_EVENTTIMES\n\rWhere : #_LOCATIONNAME - #_LOCATIONFULLLINE\n\rYours faithfully,\n\r#_CONTACTNAME\n\r\n\r-------------------------------\n\rPowered by Events Manager - http://wp-events-plugin.com','yes');
INSERT INTO `wp_options` VALUES (534,'dbem_bookings_email_cancelled_subject','Booking Cancelled','yes');
INSERT INTO `wp_options` VALUES (535,'dbem_bookings_email_cancelled_body','Dear #_BOOKINGNAME, \n\rYour requested booking for #_BOOKINGSPACES spaces at #_EVENTNAME on #_EVENTDATES has been cancelled.\n\rYours faithfully,\n\r#_CONTACTNAME\n\r\n\r-------------------------------\n\rPowered by Events Manager - http://wp-events-plugin.com','yes');
INSERT INTO `wp_options` VALUES (536,'dbem_bookings_email_registration_subject','[De MijnGang] Your username and password','yes');
INSERT INTO `wp_options` VALUES (537,'dbem_bookings_email_registration_body','You have successfully created an account at De MijnGang\n\rYou can log into our site here : http://de-mijngang.local/wp-login.php\n\rUsername : %username%\n\rPassword : %password%\n\rTo view your bookings, please visit http://de-mijngang.local/events/my-bookings/ after logging in.','yes');
INSERT INTO `wp_options` VALUES (538,'dbem_bookings_tickets_ordering','1','yes');
INSERT INTO `wp_options` VALUES (539,'dbem_bookings_tickets_orderby','ticket_price DESC, ticket_name ASC','yes');
INSERT INTO `wp_options` VALUES (540,'dbem_bookings_tickets_priority','0','yes');
INSERT INTO `wp_options` VALUES (541,'dbem_bookings_tickets_show_unavailable','0','yes');
INSERT INTO `wp_options` VALUES (542,'dbem_bookings_tickets_show_loggedout','1','yes');
INSERT INTO `wp_options` VALUES (543,'dbem_bookings_tickets_single','0','yes');
INSERT INTO `wp_options` VALUES (544,'dbem_bookings_tickets_single_form','0','yes');
INSERT INTO `wp_options` VALUES (545,'dbem_bookings_my_title_format','My Bookings','yes');
INSERT INTO `wp_options` VALUES (546,'dbem_booking_charts_wpdashboard','1','yes');
INSERT INTO `wp_options` VALUES (547,'dbem_booking_charts_dashboard','1','yes');
INSERT INTO `wp_options` VALUES (548,'dbem_booking_charts_event','1','yes');
INSERT INTO `wp_options` VALUES (549,'dbem_bp_events_list_format_header','<ul class=\"em-events-list\">','yes');
INSERT INTO `wp_options` VALUES (550,'dbem_bp_events_list_format','<li>#_EVENTLINK - #_EVENTDATES - #_EVENTTIMES<ul><li>#_LOCATIONLINK - #_LOCATIONADDRESS, #_LOCATIONTOWN</li></ul></li>','yes');
INSERT INTO `wp_options` VALUES (551,'dbem_bp_events_list_format_footer','</ul>','yes');
INSERT INTO `wp_options` VALUES (552,'dbem_bp_events_list_none_format','<p class=\"em-events-list\">No Events</p>','yes');
INSERT INTO `wp_options` VALUES (553,'dbem_css','1','yes');
INSERT INTO `wp_options` VALUES (554,'dbem_css_theme','1','yes');
INSERT INTO `wp_options` VALUES (555,'dbem_css_theme_font_family','0','yes');
INSERT INTO `wp_options` VALUES (556,'dbem_css_theme_font_size','0','yes');
INSERT INTO `wp_options` VALUES (557,'dbem_css_theme_font_weight','0','yes');
INSERT INTO `wp_options` VALUES (558,'dbem_css_theme_line_height','0','yes');
INSERT INTO `wp_options` VALUES (559,'dbem_css_calendar','1','yes');
INSERT INTO `wp_options` VALUES (560,'dbem_css_editors','1','yes');
INSERT INTO `wp_options` VALUES (561,'dbem_css_rsvp','1','yes');
INSERT INTO `wp_options` VALUES (562,'dbem_css_rsvpadmin','1','yes');
INSERT INTO `wp_options` VALUES (563,'dbem_css_evlist','1','yes');
INSERT INTO `wp_options` VALUES (564,'dbem_css_search','1','yes');
INSERT INTO `wp_options` VALUES (565,'dbem_css_loclist','1','yes');
INSERT INTO `wp_options` VALUES (566,'dbem_css_catlist','1','yes');
INSERT INTO `wp_options` VALUES (567,'dbem_css_taglist','1','yes');
INSERT INTO `wp_options` VALUES (568,'dbem_css_events','1','yes');
INSERT INTO `wp_options` VALUES (569,'dbem_css_locations','1','yes');
INSERT INTO `wp_options` VALUES (570,'dbem_css_categories','1','yes');
INSERT INTO `wp_options` VALUES (571,'dbem_css_tags','1','yes');
INSERT INTO `wp_options` VALUES (572,'dbem_css_myrsvp','1','yes');
INSERT INTO `wp_options` VALUES (573,'dbem_cp_events_slug','events','yes');
INSERT INTO `wp_options` VALUES (574,'dbem_cp_locations_slug','locations','yes');
INSERT INTO `wp_options` VALUES (575,'dbem_taxonomy_category_slug','events/categories','yes');
INSERT INTO `wp_options` VALUES (576,'dbem_taxonomy_tag_slug','events/tags','yes');
INSERT INTO `wp_options` VALUES (577,'dbem_cp_events_template','page','yes');
INSERT INTO `wp_options` VALUES (578,'dbem_cp_events_body_class','','yes');
INSERT INTO `wp_options` VALUES (579,'dbem_cp_events_post_class','','yes');
INSERT INTO `wp_options` VALUES (580,'dbem_cp_events_formats','1','yes');
INSERT INTO `wp_options` VALUES (581,'dbem_cp_events_has_archive','1','yes');
INSERT INTO `wp_options` VALUES (582,'dbem_events_default_archive_orderby','_event_start','yes');
INSERT INTO `wp_options` VALUES (583,'dbem_events_default_archive_order','ASC','yes');
INSERT INTO `wp_options` VALUES (584,'dbem_events_archive_scope','past','yes');
INSERT INTO `wp_options` VALUES (585,'dbem_cp_events_archive_formats','1','yes');
INSERT INTO `wp_options` VALUES (586,'dbem_cp_events_excerpt_formats','1','yes');
INSERT INTO `wp_options` VALUES (587,'dbem_cp_events_search_results','0','yes');
INSERT INTO `wp_options` VALUES (588,'dbem_cp_events_custom_fields','0','yes');
INSERT INTO `wp_options` VALUES (589,'dbem_cp_events_comments','1','yes');
INSERT INTO `wp_options` VALUES (590,'dbem_cp_locations_template','','yes');
INSERT INTO `wp_options` VALUES (591,'dbem_cp_locations_body_class','','yes');
INSERT INTO `wp_options` VALUES (592,'dbem_cp_locations_post_class','','yes');
INSERT INTO `wp_options` VALUES (593,'dbem_cp_locations_formats','1','yes');
INSERT INTO `wp_options` VALUES (594,'dbem_cp_locations_has_archive','1','yes');
INSERT INTO `wp_options` VALUES (595,'dbem_locations_default_archive_orderby','title','yes');
INSERT INTO `wp_options` VALUES (596,'dbem_locations_default_archive_order','ASC','yes');
INSERT INTO `wp_options` VALUES (597,'dbem_cp_locations_archive_formats','1','yes');
INSERT INTO `wp_options` VALUES (598,'dbem_cp_locations_excerpt_formats','1','yes');
INSERT INTO `wp_options` VALUES (599,'dbem_cp_locations_search_results','0','yes');
INSERT INTO `wp_options` VALUES (600,'dbem_cp_locations_custom_fields','0','yes');
INSERT INTO `wp_options` VALUES (601,'dbem_cp_locations_comments','1','yes');
INSERT INTO `wp_options` VALUES (602,'dbem_cp_categories_formats','1','yes');
INSERT INTO `wp_options` VALUES (603,'dbem_categories_default_archive_orderby','event_start_date,event_start_time,event_name','yes');
INSERT INTO `wp_options` VALUES (604,'dbem_categories_default_archive_order','ASC','yes');
INSERT INTO `wp_options` VALUES (605,'dbem_cp_tags_formats','1','yes');
INSERT INTO `wp_options` VALUES (606,'dbem_tags_default_archive_orderby','event_start_date,event_start_time,event_name','yes');
INSERT INTO `wp_options` VALUES (607,'dbem_tags_default_archive_order','ASC','yes');
INSERT INTO `wp_options` VALUES (608,'dbem_disable_thumbnails','','yes');
INSERT INTO `wp_options` VALUES (609,'dbem_feedback_reminder','1715942407','yes');
INSERT INTO `wp_options` VALUES (610,'dbem_events_page_ajax','0','yes');
INSERT INTO `wp_options` VALUES (611,'dbem_conditional_recursions','2','yes');
INSERT INTO `wp_options` VALUES (612,'dbem_data_privacy_consent_text','I consent to my submitted data being collected and stored as outlined by the site %s.','yes');
INSERT INTO `wp_options` VALUES (613,'dbem_data_privacy_consent_remember','1','yes');
INSERT INTO `wp_options` VALUES (614,'dbem_data_privacy_consent_events','1','yes');
INSERT INTO `wp_options` VALUES (615,'dbem_data_privacy_consent_locations','1','yes');
INSERT INTO `wp_options` VALUES (616,'dbem_data_privacy_consent_bookings','1','yes');
INSERT INTO `wp_options` VALUES (617,'dbem_data_privacy_export_events','1','yes');
INSERT INTO `wp_options` VALUES (618,'dbem_data_privacy_export_locations','1','yes');
INSERT INTO `wp_options` VALUES (619,'dbem_data_privacy_export_bookings','1','yes');
INSERT INTO `wp_options` VALUES (620,'dbem_data_privacy_erase_events','1','yes');
INSERT INTO `wp_options` VALUES (621,'dbem_data_privacy_erase_locations','1','yes');
INSERT INTO `wp_options` VALUES (622,'dbem_data_privacy_erase_bookings','1','yes');
INSERT INTO `wp_options` VALUES (623,'dbem_advanced_formatting','0','yes');
INSERT INTO `wp_options` VALUES (624,'dbem_version','6.4.7.3','yes');
INSERT INTO `wp_options` VALUES (625,'widget_em_locations_widget','a:1:{s:12:\"_multiwidget\";i:1;}','yes');
INSERT INTO `wp_options` VALUES (626,'dbem_pro_api_key','a:9:{s:3:\"key\";s:32:\"77CD967C32F34BAB8FAB5FD24D8029C5\";s:9:\"activated\";b:1;s:11:\"deactivated\";b:0;s:5:\"valid\";b:1;s:5:\"error\";b:0;s:14:\"error_response\";b:0;s:5:\"until\";i:1728282739;s:3:\"dev\";b:1;s:4:\"site\";s:24:\"http://de-mijngang.local\";}','yes');
INSERT INTO `wp_options` VALUES (627,'dbem_disable_css','','yes');
INSERT INTO `wp_options` VALUES (628,'dbem_bookings_manual','1','yes');
INSERT INTO `wp_options` VALUES (629,'dbem_bookings_manager','1','yes');
INSERT INTO `wp_options` VALUES (630,'dbem_bookings_manager_endpoint','bookings-manager','yes');
INSERT INTO `wp_options` VALUES (631,'dbem_bookings_qr','1','yes');
INSERT INTO `wp_options` VALUES (632,'dbem_automation_enabled','','yes');
INSERT INTO `wp_options` VALUES (633,'dbem_waitlists','','yes');
INSERT INTO `wp_options` VALUES (634,'dbem_waitlists_guests','1','yes');
INSERT INTO `wp_options` VALUES (635,'dbem_waitlists_booking_limit','1','yes');
INSERT INTO `wp_options` VALUES (636,'dbem_waitlists_limit','25','yes');
INSERT INTO `wp_options` VALUES (637,'dbem_waitlists_expiry','48','yes');
INSERT INTO `wp_options` VALUES (638,'dbem_waitlists_events','1','yes');
INSERT INTO `wp_options` VALUES (639,'dbem_waitlists_events_default','1','yes');
INSERT INTO `wp_options` VALUES (640,'dbem_waitlists_events_tickets','1','yes');
INSERT INTO `wp_options` VALUES (641,'dbem_waitlists_submit_button','Join Waitlist','yes');
INSERT INTO `wp_options` VALUES (642,'dbem_waitlists_login_text','Please log in to access the waitlist.','yes');
INSERT INTO `wp_options` VALUES (643,'dbem_waitlists_text_already_waiting','<p>\n	#_EVENTNAME is fully booked. You have already joined the waiting list for this event.	\n</p>\n<p>\n	You will be notified when a space becomes available for you to book.	\n</p>\n<p>\n	You are number #_WAITLIST_BOOKING_POSITION in line.	\n</p>\n<p>\n	<strong>Waitlist Reservation Details:</strong>\n\n</p>\n<p>\n	<strong>Event :</strong> #_EVENTNAME<br>\n	<strong>Date/Time :</strong> #_EVENTDATES @ #_EVENTTIMES<br>\n	<strong>Reserved Spaces :</strong> #_BOOKINGSPACES\n</p>\n<p>\n	If you do not want to attend this event anymore, please cancel your reservation so others can have an opportunity to attend this event.	\n</p>','yes');
INSERT INTO `wp_options` VALUES (644,'dbem_waitlists_text_booking_form','<p>\n	You are currently on a waiting list and are now elegible to book the following event:	\n</p>\n<p>\n	<strong>Waitlist Reservation Details:</strong>\n\n</p>\n<p>\n	<strong>Event :</strong> #_EVENTNAME<br>\n	<strong>Date/Time :</strong> #_EVENTDATES @ #_EVENTTIMES<br>\n	<strong>Reserved Spaces :</strong> #_BOOKINGSPACES\n</p>\n{has_waitlist_expiry}\n<p>\n	Your requested spaces will be reserved for #_WAITLIST_BOOKING_EXPIRY.	\n</p>\n{/has_waitlist_expiry}\n<p>\n	If you do not want to attend this event anymore, please cancel your reservation so others can have an opportunity to attend this event.	You can also cancel your booking by clicking the button below.	\n</p>','yes');
INSERT INTO `wp_options` VALUES (645,'dbem_waitlists_text_form','<p>\n	This event is fully booked. You can join a waitlist and if an elegible ticket becomes available, you will be notified by email to make a booking.	\n</p>\n{has_waitlist_limit}\n<p>\n	There are #_WAITLIST_AVAILABLE spaces left on the waitlist.\n</p>\n{/has_waitlist_limit}\n{has_waitlist_booking_limit}\n<p>\n	You can book up to #_WAITLIST_BOOKING_LIMIT spaces on this waitlist.\n</p>\n{/has_waitlist_booking_limit}\n{has_waitlist_expiry}\n<p>\n	Please remember that you have #_WAITLIST_EXPIRY hours to book reserved spaces once they become available, you will be notified immediately when an elegible ticket becomes available.\n</p>\n{/has_waitlist_expiry}','yes');
INSERT INTO `wp_options` VALUES (646,'dbem_waitlists_text_cancelled','<p>\n	You have cancelled your waitlist reservation for this event.	\n</p>\n<p>\n	Thank you for cancelling your waitlist reservation, so that others can have an opportunity to attend the event!	\n</p>\n<p>\n	<strong>Waitlist Reservation Details:</strong>\n	\n</p>\n<p>\n	<strong>Event :</strong> #_EVENTNAME<br>\n	<strong>Date/Time :</strong> #_EVENTDATES @ #_EVENTTIMES<br>\n	<strong>Reserved Spaces :</strong> #_BOOKINGSPACES\n</p>','yes');
INSERT INTO `wp_options` VALUES (647,'dbem_waitlists_text_expired','<p>\n	Your wait-listed reservation for #_EVENTNAME expired #_WAITLIST_BOOKING_EXPIRED ago. You will need to re-apply for the waiting lists if you wish to book again.	\n</p>\n<p>\n	<strong>Waitlist Reservation Details:</strong>\n\n</p>\n<p>\n	<strong>Event :</strong> #_EVENTNAME<br>\n	<strong>Date/Time :</strong> #_EVENTDATES @ #_EVENTTIMES<br>\n	<strong>Reserved Spaces :</strong> #_BOOKINGSPACES\n</p>','yes');
INSERT INTO `wp_options` VALUES (648,'dbem_waitlists_text_full','<p>\n	This event is fully booked. You can join a waitlist and if an elegible ticket becomes available, you will be notified by email to make a booking.\n</p>\n<p>\n	There are no more spaces left available on the waitlist. Please check back later, as spaces may become available.	\n</p>','yes');
INSERT INTO `wp_options` VALUES (649,'dbem_waitlists_feedback_confirmed','You have been added to the waitlist. You are #_WAITLIST_BOOKING_POSITION in line. You will be emailed if a ticket becomes available for booking, you will have #_WAITLIST_EXPIRY hours to make a booking before it is released to the next person in the list.','yes');
INSERT INTO `wp_options` VALUES (650,'dbem_waitlists_feedback_already_waiting','You are already on the waitlist, you are position #_WAITLIST_BOOKING_POSITION out of #_WAITLIST_WAITING. You will be notified by email if a space becomes available.','yes');
INSERT INTO `wp_options` VALUES (651,'dbem_waitlists_feedback_already_waiting_guest','You are already on the waitlist, You will be notified by email if a space becomes available.','yes');
INSERT INTO `wp_options` VALUES (652,'dbem_waitlists_feedback_full','There are no more spaces left available on the waitlist. Please check back later, as spaces may become available.','yes');
INSERT INTO `wp_options` VALUES (653,'dbem_waitlists_feedback_booking_limit','You cannot reserve more than #_WAITLIST_BOOKING_LIMIT spaces on the waitlist.','yes');
INSERT INTO `wp_options` VALUES (654,'dbem_waitlists_feedback_spaces_limit','There are not enough available spaces on the waitlist, only #_WAITLIST_AVAILABLE space(s) available.','yes');
INSERT INTO `wp_options` VALUES (655,'dbem_waitlists_feedback_log_in','You must log in or register to make a booking.','yes');
INSERT INTO `wp_options` VALUES (656,'dbem_waitlists_feedback_cancelled','You have cancelled your waitlist reservation for this event. Thank you for cancelling your waitlist reservation, so that others can have an opportunity to attend the event!','yes');
INSERT INTO `wp_options` VALUES (657,'dbem_bookings_user_cancellation_event','0','yes');
INSERT INTO `wp_options` VALUES (658,'dbem_event_submission_limits_enabled','0','yes');
INSERT INTO `wp_options` VALUES (659,'dbem_waitlists_emails_confirmed_subject','Waitlist Confirmation - #_EVENTNAME','yes');
INSERT INTO `wp_options` VALUES (660,'dbem_waitlists_emails_confirmed_message','Hello #_BOOKINGNAME\n\nYou have successfully reserved #_BOOKINGSPACES spaces for #_EVENTNAME on #_EVENTDATES at #_EVENTTIMES.\n\nYou are number #_WAITLIST_BOOKING_POSITION in line.\n{has_waitlist_expiry}\nPlease remember that you have #_WAITLIST_EXPIRY hours to book reserved spaces once they become available, you will be notified immediately when an elegible ticket becomes available.\n{/has_waitlist_expiry}\n{no_waitlist_expiry}\nYou will be notified immediately when an elegible ticket becomes available\n{/no_waitlist_expiry}\n\nIf you do not want to attend this event anymore, please cancel your reservation so others can have an opportunity to attend this event. You can view all the information about your reservation and cancel by following this link:\n\n#_WAITLIST_BOOKING_URL\n\nBest Regards,\n\n#_CONTACTNAME','yes');
INSERT INTO `wp_options` VALUES (661,'dbem_waitlists_emails_approved_subject','Waitlist Approved, Book Now! - #_EVENTNAME','yes');
INSERT INTO `wp_options` VALUES (662,'dbem_waitlists_emails_approved_message','Hello #_BOOKINGNAME\n\nGreat news! You are now able to book up to #_BOOKINGSPACES spaces for #_EVENTNAME on #_EVENTDATES at #_EVENTTIMES.\n\nIf you do not want to attend this event anymore, please cancel your reservation so others can have an opportunity to attend this event.\n\nPlease follow the following link to complete or cancel your booking:\n\n#_WAITLIST_BOOKING_URL\n\n{has_waitlist_expiry}\nPlease remember that you have #_WAITLIST_EXPIRY hours to complete this booking, otherwise your reservation will be cancelled and these spaces will be made available to the next person in line.{/has_waitlist_expiry}\n\nBest Regards,\n\n#_CONTACTNAME','yes');
INSERT INTO `wp_options` VALUES (663,'dbem_waitlists_emails_expired_subject','Waitlist Booking Expired - #_EVENTNAME','yes');
INSERT INTO `wp_options` VALUES (664,'dbem_waitlists_emails_expired_message','Hello #_BOOKINGNAME\n\nYour wait-listed reservation for #_EVENTNAME has expired. You will need to re-apply for the waiting lists if you wish to book again.\n\nPlease remember that you have #_WAITLIST_EXPIRY hours to book reserved spaces once they become available, you will be notified when that happens.\n\nBest Regards,\n\n#_CONTACTNAME','yes');
INSERT INTO `wp_options` VALUES (665,'dbem_waitlists_emails_cancelled_subject','Waitlist Booking Cancelled - #_EVENTNAME','yes');
INSERT INTO `wp_options` VALUES (666,'dbem_waitlists_emails_cancelled_message','Hello #_BOOKINGNAME\n\nYour waitlist reservation of #_BOOKINGSPACES spaces for #_EVENTNAME on #_EVENTDATES at #_EVENTTIMES has been cancelled.\n\nBest Regards,\n\n#_CONTACTNAME\n','yes');
INSERT INTO `wp_options` VALUES (667,'dbem_emp_booking_form_error_required','Please fill in the field: %s','yes');
INSERT INTO `wp_options` VALUES (668,'em_user_fields','a:9:{s:12:\"dbem_address\";a:4:{s:5:\"label\";s:7:\"Address\";s:4:\"type\";s:4:\"text\";s:7:\"fieldid\";s:12:\"dbem_address\";s:8:\"required\";i:1;}s:14:\"dbem_address_2\";a:3:{s:5:\"label\";s:14:\"Address Line 2\";s:4:\"type\";s:4:\"text\";s:7:\"fieldid\";s:14:\"dbem_address_2\";}s:9:\"dbem_city\";a:4:{s:5:\"label\";s:9:\"City/Town\";s:4:\"type\";s:4:\"text\";s:7:\"fieldid\";s:9:\"dbem_city\";s:8:\"required\";i:1;}s:10:\"dbem_state\";a:4:{s:5:\"label\";s:12:\"State/County\";s:4:\"type\";s:4:\"text\";s:7:\"fieldid\";s:10:\"dbem_state\";s:8:\"required\";i:1;}s:8:\"dbem_zip\";a:4:{s:5:\"label\";s:13:\"Zip/Post Code\";s:4:\"type\";s:4:\"text\";s:7:\"fieldid\";s:8:\"dbem_zip\";s:8:\"required\";i:1;}s:12:\"dbem_country\";a:4:{s:5:\"label\";s:7:\"Country\";s:4:\"type\";s:7:\"country\";s:7:\"fieldid\";s:12:\"dbem_country\";s:8:\"required\";i:1;}s:10:\"dbem_phone\";a:3:{s:5:\"label\";s:5:\"Phone\";s:4:\"type\";s:4:\"text\";s:7:\"fieldid\";s:10:\"dbem_phone\";}s:8:\"dbem_fax\";a:3:{s:5:\"label\";s:3:\"Fax\";s:4:\"type\";s:4:\"text\";s:7:\"fieldid\";s:8:\"dbem_fax\";}s:12:\"dbem_company\";a:3:{s:5:\"label\";s:7:\"Company\";s:4:\"type\";s:4:\"text\";s:7:\"fieldid\";s:12:\"dbem_company\";}}','yes');
INSERT INTO `wp_options` VALUES (669,'emp_gateway_customer_fields','a:9:{s:7:\"address\";s:12:\"dbem_address\";s:9:\"address_2\";s:14:\"dbem_address_2\";s:4:\"city\";s:9:\"dbem_city\";s:5:\"state\";s:10:\"dbem_state\";s:3:\"zip\";s:8:\"dbem_zip\";s:7:\"country\";s:12:\"dbem_country\";s:5:\"phone\";s:10:\"dbem_phone\";s:3:\"fax\";s:8:\"dbem_fax\";s:7:\"company\";s:12:\"dbem_company\";}','yes');
INSERT INTO `wp_options` VALUES (670,'em_attendee_fields_enabled','','yes');
INSERT INTO `wp_options` VALUES (671,'dbem_emp_booking_form_reg_input','1','yes');
INSERT INTO `wp_options` VALUES (672,'dbem_emp_booking_form_reg_show','1','yes');
INSERT INTO `wp_options` VALUES (673,'dbem_emp_booking_form_reg_show_username','0','yes');
INSERT INTO `wp_options` VALUES (674,'dbem_emp_booking_form_reg_show_email','0','yes');
INSERT INTO `wp_options` VALUES (675,'dbem_emp_booking_form_reg_show_name','1','yes');
INSERT INTO `wp_options` VALUES (676,'dbem_gateway_use_buttons','0','yes');
INSERT INTO `wp_options` VALUES (677,'dbem_gateway_label','Pay With','yes');
INSERT INTO `wp_options` VALUES (678,'dbem_gateway_payment_timeout','0','yes');
INSERT INTO `wp_options` VALUES (679,'em_paypal_option_name','PayPal','yes');
INSERT INTO `wp_options` VALUES (680,'em_paypal_form','<img src=\"http://de-mijngang.local/wp-content/plugins/events-manager-pro/includes/images/paypal/paypal_info.png\" width=\"228\" height=\"61\" />','yes');
INSERT INTO `wp_options` VALUES (681,'em_paypal_booking_feedback','Please wait whilst you are redirected to PayPal to proceed with payment.','yes');
INSERT INTO `wp_options` VALUES (682,'em_paypal_booking_feedback_free','Booking successful.','yes');
INSERT INTO `wp_options` VALUES (683,'em_paypal_booking_feedback_cancelled','Your booking payment has been cancelled, please try again.','yes');
INSERT INTO `wp_options` VALUES (684,'em_paypal_button','http://www.paypal.com/en_US/i/btn/btn_xpressCheckout.gif','yes');
INSERT INTO `wp_options` VALUES (685,'em_paypal_booking_feedback_completed','Thank you for your payment. Your transaction has been completed, and a receipt for your purchase has been emailed to you along with a separate email containing account details to access your booking information on this site. You may log into your account at www.paypal.com to view details of this transaction.','yes');
INSERT INTO `wp_options` VALUES (686,'em_paypal_inc_tax','1','yes');
INSERT INTO `wp_options` VALUES (687,'em_paypal_reserve_pending','1','yes');
INSERT INTO `wp_options` VALUES (688,'em_offline_option_name','Pay Offline','yes');
INSERT INTO `wp_options` VALUES (689,'em_offline_booking_feedback','Booking successful.','yes');
INSERT INTO `wp_options` VALUES (690,'em_offline_button','Pay Offline','yes');
INSERT INTO `wp_options` VALUES (691,'em_authorize_aim_option_name','Credit Card','yes');
INSERT INTO `wp_options` VALUES (692,'em_authorize_aim_booking_feedback','Booking successful.','yes');
INSERT INTO `wp_options` VALUES (693,'em_authorize_aim_booking_feedback_free','Booking successful. You have not been charged for this booking.','yes');
INSERT INTO `wp_options` VALUES (694,'dbem_bookings_ical_attachments','1','yes');
INSERT INTO `wp_options` VALUES (695,'dbem_multiple_bookings_ical_attachments','1','yes');
INSERT INTO `wp_options` VALUES (696,'dbem_bookings_pdf','','yes');
INSERT INTO `wp_options` VALUES (697,'dbem_bookings_pdf_logo','','yes');
INSERT INTO `wp_options` VALUES (698,'dbem_bookings_pdf_logo_id','','yes');
INSERT INTO `wp_options` VALUES (700,'dbem_bookings_pdf_font','dejavusans','yes');
INSERT INTO `wp_options` VALUES (703,'dbem_bookings_pdf_font_subset','','yes');
INSERT INTO `wp_options` VALUES (705,'dbem_bookings_pdf_invoice_format','EVENT-#_BOOKINGID','yes');
INSERT INTO `wp_options` VALUES (707,'dbem_bookings_pdf_logo_alt','De MijnGang','yes');
INSERT INTO `wp_options` VALUES (709,'dbem_bookings_pdf_billing_details','#_BOOKINGFORMCUSTOMREG{user_name}\n#_BOOKINGFORMCUSTOMREG{dbem_address}\n#_BOOKINGFORMCUSTOMREG{dbem_city}\n#_BOOKINGFORMCUSTOMREG{dbem_state}\n#_BOOKINGFORMCUSTOMREG{dbem_zip}\n#_BOOKINGFORMCUSTOMREG{dbem_country}','yes');
INSERT INTO `wp_options` VALUES (711,'dbem_bookings_pdf_business_details','','yes');
INSERT INTO `wp_options` VALUES (713,'dbem_bookings_pdf_email_invoice','1','yes');
INSERT INTO `wp_options` VALUES (715,'dbem_bookings_pdf_email_tickets','1','yes');
INSERT INTO `wp_options` VALUES (717,'dbem_bookings_attendance','1','yes');
INSERT INTO `wp_options` VALUES (719,'dbem_cron_emails','0','yes');
INSERT INTO `wp_options` VALUES (721,'dbem_cron_emails_limit','100','yes');
INSERT INTO `wp_options` VALUES (723,'dbem_emp_emails_reminder_subject','Reminder - #_EVENTNAME','yes');
INSERT INTO `wp_options` VALUES (725,'dbem_emp_emails_reminder_body','Dear #_BOOKINGNAME, \n\rThis is a reminder about your #_BOOKINGSPACES space/spaces reserved for #_EVENTNAME.\n\rWhen : #_EVENTDATES @ #_EVENTTIMES\n\rWhere : #_LOCATIONNAME - #_LOCATIONFULLLINE\n\rWe look forward to seeing you there!\n\rYours faithfully,\n\r#_CONTACTNAME\n\r\n\r-------------------------------\n\rPowered by Events Manager - http://wp-events-plugin.com','yes');
INSERT INTO `wp_options` VALUES (727,'dbem_emp_emails_reminder_time','12:00 AM','yes');
INSERT INTO `wp_options` VALUES (729,'dbem_emp_emails_reminder_days','1','yes');
INSERT INTO `wp_options` VALUES (731,'dbem_emp_emails_reminder_ical','1','yes');
INSERT INTO `wp_options` VALUES (733,'dbem_custom_emails','0','yes');
INSERT INTO `wp_options` VALUES (735,'dbem_custom_emails_events','1','yes');
INSERT INTO `wp_options` VALUES (737,'dbem_custom_emails_events_admins','1','yes');
INSERT INTO `wp_options` VALUES (739,'dbem_custom_emails_gateways','1','yes');
INSERT INTO `wp_options` VALUES (741,'dbem_custom_emails_gateways_admins','1','yes');
INSERT INTO `wp_options` VALUES (743,'dbem_email_bookings','0','yes');
INSERT INTO `wp_options` VALUES (745,'dbem_email_bookings_default_subject','','no');
INSERT INTO `wp_options` VALUES (747,'dbem_email_bookings_default_body','','no');
INSERT INTO `wp_options` VALUES (749,'dbem_multiple_bookings_feedback_added','Your booking was added to your shopping cart.','yes');
INSERT INTO `wp_options` VALUES (751,'dbem_multiple_bookings_feedback_already_added','You have already booked a spot at this event in your cart, please modify or delete your current booking.','yes');
INSERT INTO `wp_options` VALUES (753,'dbem_multiple_bookings_feedback_no_bookings','You have not booked any events yet. Your cart is empty.','yes');
INSERT INTO `wp_options` VALUES (755,'dbem_multiple_bookings_feedback_loading_cart','Loading Cart Contents...','yes');
INSERT INTO `wp_options` VALUES (757,'dbem_multiple_bookings_feedback_empty_cart','Are you sure you want to empty your cart?','yes');
INSERT INTO `wp_options` VALUES (759,'dbem_multiple_bookings_submit_button','Place Order','yes');
INSERT INTO `wp_options` VALUES (761,'dbem_bookings_notify_admin_mb','0','yes');
INSERT INTO `wp_options` VALUES (763,'dbem_multiple_bookings_contact_email','','yes');
INSERT INTO `wp_options` VALUES (765,'dbem_multiple_bookings_contact_email_user','','yes');
INSERT INTO `wp_options` VALUES (767,'dbem_multiple_bookings_contact_email_confirmed_subject','Booking Confirmed','yes');
INSERT INTO `wp_options` VALUES (769,'dbem_multiple_bookings_contact_email_confirmed_body','The following booking is confirmed :\n\rBOOKING DETAILS\n\rName : #_BOOKINGNAME\n\rEmail : #_BOOKINGEMAIL\n\r#_BOOKINGSUMMARY','yes');
INSERT INTO `wp_options` VALUES (771,'dbem_multiple_bookings_contact_email_pending_subject','Booking Pending','yes');
INSERT INTO `wp_options` VALUES (773,'dbem_multiple_bookings_contact_email_pending_body','The following booking is pending :\n\rBOOKING DETAILS\n\rName : #_BOOKINGNAME\n\rEmail : #_BOOKINGEMAIL\n\r#_BOOKINGSUMMARY','yes');
INSERT INTO `wp_options` VALUES (775,'dbem_multiple_bookings_contact_email_cancelled_subject','Booking Cancelled','yes');
INSERT INTO `wp_options` VALUES (777,'dbem_multiple_bookings_contact_email_cancelled_body','The following booking is cancelled :\n\rBOOKING DETAILS\n\rName : #_BOOKINGNAME\n\rEmail : #_BOOKINGEMAIL\n\r#_BOOKINGSUMMARY','yes');
INSERT INTO `wp_options` VALUES (779,'dbem_multiple_bookings_email_confirmed_subject','Booking Confirmed','yes');
INSERT INTO `wp_options` VALUES (781,'dbem_multiple_bookings_email_confirmed_body','Dear #_BOOKINGNAME, \n\rYour booking has been confirmed. \n\rBelow is a summary of your booking: \n\r#_BOOKINGSUMMARY \n\rWe look forward to seeing you there!\n\r\n\r-------------------------------\n\rPowered by Events Manager - http://wp-events-plugin.com','yes');
INSERT INTO `wp_options` VALUES (783,'dbem_multiple_bookings_email_pending_subject','Booking Pending','yes');
INSERT INTO `wp_options` VALUES (785,'dbem_multiple_bookings_email_pending_body','Dear #_BOOKINGNAME, \n\rYour booking is currently pending approval by our administrators. Once approved you will receive another confirmation email. \n\rBelow is a summary of your booking: \n\r#_BOOKINGSUMMARY\n\r\n\r-------------------------------\n\rPowered by Events Manager - http://wp-events-plugin.com','yes');
INSERT INTO `wp_options` VALUES (787,'dbem_multiple_bookings_email_rejected_subject','Booking Rejected','yes');
INSERT INTO `wp_options` VALUES (789,'dbem_multiple_bookings_email_rejected_body','Dear #_BOOKINGNAME, \n\rYour requested booking has been rejected. \n\rBelow is a summary of your booking: \n\r#_BOOKINGSUMMARY\n\r\n\r-------------------------------\n\rPowered by Events Manager - http://wp-events-plugin.com','yes');
INSERT INTO `wp_options` VALUES (791,'dbem_multiple_bookings_email_cancelled_subject','Booking Cancelled','yes');
INSERT INTO `wp_options` VALUES (793,'dbem_multiple_bookings_email_cancelled_body','Dear #_BOOKINGNAME, \n\rYour requested booking has been cancelled. \n\rBelow is a summary of your booking: \n\r#_BOOKINGSUMMARY\n\r\n\r-------------------------------\n\rPowered by Events Manager - http://wp-events-plugin.com','yes');
INSERT INTO `wp_options` VALUES (795,'dbem_bookings_dependent_events','1','yes');
INSERT INTO `wp_options` VALUES (797,'dbem_booking_feedback_dependent_guest','You must have previously booked &#039;#_EVENTLINK&#039; in order to attend this event. Please log in so we can verify your previous bookings.','yes');
INSERT INTO `wp_options` VALUES (799,'dbem_booking_feedback_dependent','You must have previously booked &#039;#_EVENTLINK&#039; in order to attend this event.','yes');
INSERT INTO `wp_options` VALUES (801,'em_booking_form_fields','2','yes');
INSERT INTO `wp_options` VALUES (803,'em_pro_version','3.2.8.1','yes');
INSERT INTO `wp_options` VALUES (807,'em_cron_doing_emails','0','yes');
INSERT INTO `wp_options` VALUES (852,'em_last_modified','1715944179','yes');
INSERT INTO `wp_options` VALUES (859,'event-categories_children','a:0:{}','yes');
INSERT INTO `wp_options` VALUES (876,'_transient_is_multi_author','0','yes');
INSERT INTO `wp_options` VALUES (937,'_site_transient_timeout_theme_roots','1716547419','no');
INSERT INTO `wp_options` VALUES (938,'_site_transient_theme_roots','a:5:{s:10:\"demijngang\";s:7:\"/themes\";s:16:\"twentytwentyfour\";s:7:\"/themes\";s:17:\"twentytwentythree\";s:7:\"/themes\";s:15:\"twentytwentytwo\";s:7:\"/themes\";s:10:\"understrap\";s:7:\"/themes\";}','no');
INSERT INTO `wp_options` VALUES (939,'_transient_health-check-site-status-result','{\"good\":16,\"recommended\":3,\"critical\":1}','yes');
INSERT INTO `wp_options` VALUES (941,'category_children','a:0:{}','yes');
INSERT INTO `wp_options` VALUES (942,'_transient_understrap_categories','0','yes');
/*!40000 ALTER TABLE `wp_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_postmeta`
--

DROP TABLE IF EXISTS `wp_postmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_postmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `post_id` (`post_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_postmeta`
--

LOCK TABLES `wp_postmeta` WRITE;
/*!40000 ALTER TABLE `wp_postmeta` DISABLE KEYS */;
INSERT INTO `wp_postmeta` VALUES (1,2,'_wp_page_template','default');
INSERT INTO `wp_postmeta` VALUES (2,3,'_wp_page_template','default');
INSERT INTO `wp_postmeta` VALUES (3,6,'_edit_lock','1715948868:1');
INSERT INTO `wp_postmeta` VALUES (4,8,'_menu_item_type','post_type');
INSERT INTO `wp_postmeta` VALUES (5,8,'_menu_item_menu_item_parent','0');
INSERT INTO `wp_postmeta` VALUES (6,8,'_menu_item_object_id','6');
INSERT INTO `wp_postmeta` VALUES (7,8,'_menu_item_object','page');
INSERT INTO `wp_postmeta` VALUES (8,8,'_menu_item_target','');
INSERT INTO `wp_postmeta` VALUES (9,8,'_menu_item_classes','a:1:{i:0;s:0:\"\";}');
INSERT INTO `wp_postmeta` VALUES (10,8,'_menu_item_xfn','');
INSERT INTO `wp_postmeta` VALUES (11,8,'_menu_item_url','');
INSERT INTO `wp_postmeta` VALUES (12,8,'_menu_item_orphaned','1715942194');
INSERT INTO `wp_postmeta` VALUES (13,9,'_menu_item_type','post_type');
INSERT INTO `wp_postmeta` VALUES (14,9,'_menu_item_menu_item_parent','0');
INSERT INTO `wp_postmeta` VALUES (15,9,'_menu_item_object_id','2');
INSERT INTO `wp_postmeta` VALUES (16,9,'_menu_item_object','page');
INSERT INTO `wp_postmeta` VALUES (17,9,'_menu_item_target','');
INSERT INTO `wp_postmeta` VALUES (18,9,'_menu_item_classes','a:1:{i:0;s:0:\"\";}');
INSERT INTO `wp_postmeta` VALUES (19,9,'_menu_item_xfn','');
INSERT INTO `wp_postmeta` VALUES (20,9,'_menu_item_url','');
INSERT INTO `wp_postmeta` VALUES (21,9,'_menu_item_orphaned','1715942194');
INSERT INTO `wp_postmeta` VALUES (22,2,'_wp_trash_meta_status','publish');
INSERT INTO `wp_postmeta` VALUES (23,2,'_wp_trash_meta_time','1715942214');
INSERT INTO `wp_postmeta` VALUES (24,2,'_wp_desired_post_slug','sample-page');
INSERT INTO `wp_postmeta` VALUES (25,11,'_menu_item_type','post_type');
INSERT INTO `wp_postmeta` VALUES (26,11,'_menu_item_menu_item_parent','0');
INSERT INTO `wp_postmeta` VALUES (27,11,'_menu_item_object_id','6');
INSERT INTO `wp_postmeta` VALUES (28,11,'_menu_item_object','page');
INSERT INTO `wp_postmeta` VALUES (29,11,'_menu_item_target','');
INSERT INTO `wp_postmeta` VALUES (30,11,'_menu_item_classes','a:1:{i:0;s:0:\"\";}');
INSERT INTO `wp_postmeta` VALUES (31,11,'_menu_item_xfn','');
INSERT INTO `wp_postmeta` VALUES (32,11,'_menu_item_url','');
INSERT INTO `wp_postmeta` VALUES (34,12,'_menu_item_type','custom');
INSERT INTO `wp_postmeta` VALUES (35,12,'_menu_item_menu_item_parent','0');
INSERT INTO `wp_postmeta` VALUES (36,12,'_menu_item_object_id','12');
INSERT INTO `wp_postmeta` VALUES (37,12,'_menu_item_object','custom');
INSERT INTO `wp_postmeta` VALUES (38,12,'_menu_item_target','');
INSERT INTO `wp_postmeta` VALUES (39,12,'_menu_item_classes','a:1:{i:0;s:0:\"\";}');
INSERT INTO `wp_postmeta` VALUES (40,12,'_menu_item_xfn','');
INSERT INTO `wp_postmeta` VALUES (41,12,'_menu_item_url','#');
INSERT INTO `wp_postmeta` VALUES (43,13,'_menu_item_type','custom');
INSERT INTO `wp_postmeta` VALUES (44,13,'_menu_item_menu_item_parent','0');
INSERT INTO `wp_postmeta` VALUES (45,13,'_menu_item_object_id','13');
INSERT INTO `wp_postmeta` VALUES (46,13,'_menu_item_object','custom');
INSERT INTO `wp_postmeta` VALUES (47,13,'_menu_item_target','');
INSERT INTO `wp_postmeta` VALUES (48,13,'_menu_item_classes','a:1:{i:0;s:0:\"\";}');
INSERT INTO `wp_postmeta` VALUES (49,13,'_menu_item_xfn','');
INSERT INTO `wp_postmeta` VALUES (50,13,'_menu_item_url','#');
INSERT INTO `wp_postmeta` VALUES (52,14,'_menu_item_type','custom');
INSERT INTO `wp_postmeta` VALUES (53,14,'_menu_item_menu_item_parent','0');
INSERT INTO `wp_postmeta` VALUES (54,14,'_menu_item_object_id','14');
INSERT INTO `wp_postmeta` VALUES (55,14,'_menu_item_object','custom');
INSERT INTO `wp_postmeta` VALUES (56,14,'_menu_item_target','');
INSERT INTO `wp_postmeta` VALUES (57,14,'_menu_item_classes','a:1:{i:0;s:0:\"\";}');
INSERT INTO `wp_postmeta` VALUES (58,14,'_menu_item_xfn','');
INSERT INTO `wp_postmeta` VALUES (59,14,'_menu_item_url','#');
INSERT INTO `wp_postmeta` VALUES (61,15,'_menu_item_type','custom');
INSERT INTO `wp_postmeta` VALUES (62,15,'_menu_item_menu_item_parent','0');
INSERT INTO `wp_postmeta` VALUES (63,15,'_menu_item_object_id','15');
INSERT INTO `wp_postmeta` VALUES (64,15,'_menu_item_object','custom');
INSERT INTO `wp_postmeta` VALUES (65,15,'_menu_item_target','');
INSERT INTO `wp_postmeta` VALUES (66,15,'_menu_item_classes','a:1:{i:0;s:0:\"\";}');
INSERT INTO `wp_postmeta` VALUES (67,15,'_menu_item_xfn','');
INSERT INTO `wp_postmeta` VALUES (68,15,'_menu_item_url','#');
INSERT INTO `wp_postmeta` VALUES (79,17,'_menu_item_type','custom');
INSERT INTO `wp_postmeta` VALUES (80,17,'_menu_item_menu_item_parent','0');
INSERT INTO `wp_postmeta` VALUES (81,17,'_menu_item_object_id','17');
INSERT INTO `wp_postmeta` VALUES (82,17,'_menu_item_object','custom');
INSERT INTO `wp_postmeta` VALUES (83,17,'_menu_item_target','');
INSERT INTO `wp_postmeta` VALUES (84,17,'_menu_item_classes','a:1:{i:0;s:0:\"\";}');
INSERT INTO `wp_postmeta` VALUES (85,17,'_menu_item_xfn','');
INSERT INTO `wp_postmeta` VALUES (86,17,'_menu_item_url','#');
INSERT INTO `wp_postmeta` VALUES (88,18,'_menu_item_type','custom');
INSERT INTO `wp_postmeta` VALUES (89,18,'_menu_item_menu_item_parent','0');
INSERT INTO `wp_postmeta` VALUES (90,18,'_menu_item_object_id','18');
INSERT INTO `wp_postmeta` VALUES (91,18,'_menu_item_object','custom');
INSERT INTO `wp_postmeta` VALUES (92,18,'_menu_item_target','');
INSERT INTO `wp_postmeta` VALUES (93,18,'_menu_item_classes','a:1:{i:0;s:0:\"\";}');
INSERT INTO `wp_postmeta` VALUES (94,18,'_menu_item_xfn','');
INSERT INTO `wp_postmeta` VALUES (95,18,'_menu_item_url','#');
INSERT INTO `wp_postmeta` VALUES (97,19,'_wp_trash_meta_status','publish');
INSERT INTO `wp_postmeta` VALUES (98,19,'_wp_trash_meta_time','1715942327');
INSERT INTO `wp_postmeta` VALUES (102,27,'_wp_attached_file','2024/05/Placeholder.png');
INSERT INTO `wp_postmeta` VALUES (103,27,'_wp_attachment_metadata','a:6:{s:5:\"width\";i:512;s:6:\"height\";i:512;s:4:\"file\";s:23:\"2024/05/Placeholder.png\";s:8:\"filesize\";i:16631;s:5:\"sizes\";a:2:{s:6:\"medium\";a:5:{s:4:\"file\";s:23:\"Placeholder-300x300.png\";s:5:\"width\";i:300;s:6:\"height\";i:300;s:9:\"mime-type\";s:9:\"image/png\";s:8:\"filesize\";i:6232;}s:9:\"thumbnail\";a:5:{s:4:\"file\";s:23:\"Placeholder-150x150.png\";s:5:\"width\";i:150;s:6:\"height\";i:150;s:9:\"mime-type\";s:9:\"image/png\";s:8:\"filesize\";i:2780;}}s:10:\"image_meta\";a:12:{s:8:\"aperture\";s:1:\"0\";s:6:\"credit\";s:0:\"\";s:6:\"camera\";s:0:\"\";s:7:\"caption\";s:0:\"\";s:17:\"created_timestamp\";s:1:\"0\";s:9:\"copyright\";s:0:\"\";s:12:\"focal_length\";s:1:\"0\";s:3:\"iso\";s:1:\"0\";s:13:\"shutter_speed\";s:1:\"0\";s:5:\"title\";s:0:\"\";s:11:\"orientation\";s:1:\"0\";s:8:\"keywords\";a:0:{}}}');
INSERT INTO `wp_postmeta` VALUES (104,21,'_edit_lock','1715943915:1');
INSERT INTO `wp_postmeta` VALUES (105,21,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (106,21,'_wp_page_template','default');
INSERT INTO `wp_postmeta` VALUES (107,23,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (108,23,'_wp_page_template','default');
INSERT INTO `wp_postmeta` VALUES (109,23,'_edit_lock','1715943921:1');
INSERT INTO `wp_postmeta` VALUES (110,22,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (111,22,'_wp_page_template','default');
INSERT INTO `wp_postmeta` VALUES (112,22,'_edit_lock','1715943924:1');
INSERT INTO `wp_postmeta` VALUES (113,25,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (114,25,'_wp_page_template','default');
INSERT INTO `wp_postmeta` VALUES (115,25,'_edit_lock','1715943927:1');
INSERT INTO `wp_postmeta` VALUES (116,24,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (117,24,'_wp_page_template','default');
INSERT INTO `wp_postmeta` VALUES (118,24,'_edit_lock','1715943930:1');
INSERT INTO `wp_postmeta` VALUES (119,42,'_menu_item_type','post_type');
INSERT INTO `wp_postmeta` VALUES (120,42,'_menu_item_menu_item_parent','0');
INSERT INTO `wp_postmeta` VALUES (121,42,'_menu_item_object_id','21');
INSERT INTO `wp_postmeta` VALUES (122,42,'_menu_item_object','page');
INSERT INTO `wp_postmeta` VALUES (123,42,'_menu_item_target','');
INSERT INTO `wp_postmeta` VALUES (124,42,'_menu_item_classes','a:1:{i:0;s:0:\"\";}');
INSERT INTO `wp_postmeta` VALUES (125,42,'_menu_item_xfn','');
INSERT INTO `wp_postmeta` VALUES (126,42,'_menu_item_url','');
INSERT INTO `wp_postmeta` VALUES (128,43,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (129,43,'_edit_lock','1715944054:1');
INSERT INTO `wp_postmeta` VALUES (130,44,'_location_address','Huskensweg 37');
INSERT INTO `wp_postmeta` VALUES (131,44,'_location_town','Heerlen');
INSERT INTO `wp_postmeta` VALUES (132,44,'_location_state','Limburg');
INSERT INTO `wp_postmeta` VALUES (133,44,'_location_postcode','6412SB');
INSERT INTO `wp_postmeta` VALUES (134,44,'_location_country','NL');
INSERT INTO `wp_postmeta` VALUES (135,44,'_location_id','1');
INSERT INTO `wp_postmeta` VALUES (136,43,'_event_id','1');
INSERT INTO `wp_postmeta` VALUES (137,43,'_event_timezone','UTC');
INSERT INTO `wp_postmeta` VALUES (138,43,'_event_start_time','00:00:00');
INSERT INTO `wp_postmeta` VALUES (139,43,'_event_end_time','23:59:59');
INSERT INTO `wp_postmeta` VALUES (140,43,'_event_start','2024-05-17 00:00:00');
INSERT INTO `wp_postmeta` VALUES (141,43,'_event_end','2024-05-17 23:59:59');
INSERT INTO `wp_postmeta` VALUES (142,43,'_event_all_day','1');
INSERT INTO `wp_postmeta` VALUES (143,43,'_event_start_date','2024-05-17');
INSERT INTO `wp_postmeta` VALUES (144,43,'_event_end_date','2024-05-17');
INSERT INTO `wp_postmeta` VALUES (145,43,'_location_id','1');
INSERT INTO `wp_postmeta` VALUES (146,43,'_event_location_type',NULL);
INSERT INTO `wp_postmeta` VALUES (147,43,'_event_active_status','1');
INSERT INTO `wp_postmeta` VALUES (148,43,'_event_start_local','2024-05-17 00:00:00');
INSERT INTO `wp_postmeta` VALUES (149,43,'_event_end_local','2024-05-17 23:59:59');
INSERT INTO `wp_postmeta` VALUES (150,1,'_edit_lock','1715944057:1');
INSERT INTO `wp_postmeta` VALUES (151,1,'_wp_trash_meta_status','publish');
INSERT INTO `wp_postmeta` VALUES (152,1,'_wp_trash_meta_time','1715944203');
INSERT INTO `wp_postmeta` VALUES (153,1,'_wp_desired_post_slug','hello-world');
INSERT INTO `wp_postmeta` VALUES (154,1,'_wp_trash_meta_comments_status','a:1:{i:1;s:1:\"1\";}');
/*!40000 ALTER TABLE `wp_postmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_posts`
--

DROP TABLE IF EXISTS `wp_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_posts` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_author` bigint(20) unsigned NOT NULL DEFAULT '0',
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_title` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_excerpt` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `post_password` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `post_name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `to_ping` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `pinged` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `guid` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `menu_order` int(11) NOT NULL DEFAULT '0',
  `post_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `post_name` (`post_name`(191)),
  KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  KEY `post_parent` (`post_parent`),
  KEY `post_author` (`post_author`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_posts`
--

LOCK TABLES `wp_posts` WRITE;
/*!40000 ALTER TABLE `wp_posts` DISABLE KEYS */;
INSERT INTO `wp_posts` VALUES (1,1,'2024-05-17 10:27:19','2024-05-17 10:27:19','<!-- wp:paragraph -->\n<p>Welcome to WordPress. This is your first post. Edit or delete it, then start writing!</p>\n<!-- /wp:paragraph -->','Hello world!','','trash','open','open','','hello-world__trashed','','','2024-05-17 11:10:03','2024-05-17 11:10:03','',0,'http://de-mijngang.local/?p=1',0,'post','',1);
INSERT INTO `wp_posts` VALUES (2,1,'2024-05-17 10:27:19','2024-05-17 10:27:19','<!-- wp:paragraph -->\n<p>This is an example page. It\'s different from a blog post because it will stay in one place and will show up in your site navigation (in most themes). Most people start with an About page that introduces them to potential site visitors. It might say something like this:</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:quote -->\n<blockquote class=\"wp-block-quote\"><p>Hi there! I\'m a bike messenger by day, aspiring actor by night, and this is my website. I live in Los Angeles, have a great dog named Jack, and I like pi&#241;a coladas. (And gettin\' caught in the rain.)</p></blockquote>\n<!-- /wp:quote -->\n\n<!-- wp:paragraph -->\n<p>...or something like this:</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:quote -->\n<blockquote class=\"wp-block-quote\"><p>The XYZ Doohickey Company was founded in 1971, and has been providing quality doohickeys to the public ever since. Located in Gotham City, XYZ employs over 2,000 people and does all kinds of awesome things for the Gotham community.</p></blockquote>\n<!-- /wp:quote -->\n\n<!-- wp:paragraph -->\n<p>As a new WordPress user, you should go to <a href=\"http://de-mijngang.local/wp-admin/\">your dashboard</a> to delete this page and create new pages for your content. Have fun!</p>\n<!-- /wp:paragraph -->','Sample Page','','trash','closed','open','','sample-page__trashed','','','2024-05-17 10:36:54','2024-05-17 10:36:54','',0,'http://de-mijngang.local/?page_id=2',0,'page','',0);
INSERT INTO `wp_posts` VALUES (3,1,'2024-05-17 10:27:19','2024-05-17 10:27:19','<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Who we are</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>Our website address is: http://de-mijngang.local.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Comments</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>When visitors leave comments on the site we collect the data shown in the comments form, and also the visitor&#8217;s IP address and browser user agent string to help spam detection.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>An anonymized string created from your email address (also called a hash) may be provided to the Gravatar service to see if you are using it. The Gravatar service privacy policy is available here: https://automattic.com/privacy/. After approval of your comment, your profile picture is visible to the public in the context of your comment.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Media</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you upload images to the website, you should avoid uploading images with embedded location data (EXIF GPS) included. Visitors to the website can download and extract any location data from images on the website.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Cookies</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you leave a comment on our site you may opt-in to saving your name, email address and website in cookies. These are for your convenience so that you do not have to fill in your details again when you leave another comment. These cookies will last for one year.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>If you visit our login page, we will set a temporary cookie to determine if your browser accepts cookies. This cookie contains no personal data and is discarded when you close your browser.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>When you log in, we will also set up several cookies to save your login information and your screen display choices. Login cookies last for two days, and screen options cookies last for a year. If you select &quot;Remember Me&quot;, your login will persist for two weeks. If you log out of your account, the login cookies will be removed.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>If you edit or publish an article, an additional cookie will be saved in your browser. This cookie includes no personal data and simply indicates the post ID of the article you just edited. It expires after 1 day.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Embedded content from other websites</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>Articles on this site may include embedded content (e.g. videos, images, articles, etc.). Embedded content from other websites behaves in the exact same way as if the visitor has visited the other website.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>These websites may collect data about you, use cookies, embed additional third-party tracking, and monitor your interaction with that embedded content, including tracking your interaction with the embedded content if you have an account and are logged in to that website.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Who we share your data with</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you request a password reset, your IP address will be included in the reset email.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">How long we retain your data</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you leave a comment, the comment and its metadata are retained indefinitely. This is so we can recognize and approve any follow-up comments automatically instead of holding them in a moderation queue.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>For users that register on our website (if any), we also store the personal information they provide in their user profile. All users can see, edit, or delete their personal information at any time (except they cannot change their username). Website administrators can also see and edit that information.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">What rights you have over your data</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you have an account on this site, or have left comments, you can request to receive an exported file of the personal data we hold about you, including any data you have provided to us. You can also request that we erase any personal data we hold about you. This does not include any data we are obliged to keep for administrative, legal, or security purposes.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Where your data is sent</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>Visitor comments may be checked through an automated spam detection service.</p>\n<!-- /wp:paragraph -->\n','Privacy Policy','','draft','closed','open','','privacy-policy','','','2024-05-17 10:27:19','2024-05-17 10:27:19','',0,'http://de-mijngang.local/?page_id=3',0,'page','',0);
INSERT INTO `wp_posts` VALUES (4,0,'2024-05-17 10:28:22','2024-05-17 10:28:22','<!-- wp:page-list /-->','Navigation','','publish','closed','closed','','navigation','','','2024-05-17 10:28:22','2024-05-17 10:28:22','',0,'http://de-mijngang.local/navigation/',0,'wp_navigation','',0);
INSERT INTO `wp_posts` VALUES (6,1,'2024-05-17 10:32:48','2024-05-17 10:32:48','<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">Welkom!</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Op de site van De MijnGang</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column -->\n\n<!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">&nbsp;</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">&nbsp;</h2>\n<!-- /wp:heading -->\n\n<!-- wp:image {\"id\":27,\"width\":\"512px\",\"aspectRatio\":\"16/9\",\"scale\":\"cover\",\"sizeSlug\":\"thumbnail\",\"linkDestination\":\"none\",\"className\":\"is-style-default\"} -->\n<figure class=\"wp-block-image size-thumbnail is-resized is-style-default\"><img src=\"http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder-150x150.png\" alt=\"Placeholder\" class=\"wp-image-27\" style=\"aspect-ratio:16/9;object-fit:cover;width:512px\"/></figure>\n<!-- /wp:image --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns -->\n\n<!-- wp:separator -->\n<hr class=\"wp-block-separator has-alpha-channel-opacity\"/>\n<!-- /wp:separator -->\n\n<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column {\"width\":\"66.66%\"} -->\n<div class=\"wp-block-column\" style=\"flex-basis:66.66%\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Uitgelicht</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">Activiteit #1</h2>\n<!-- /wp:heading -->\n\n<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:image {\"id\":27,\"sizeSlug\":\"full\",\"linkDestination\":\"none\"} -->\n<figure class=\"wp-block-image size-full\"><img src=\"http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder.png\" alt=\"Activiteit foto\" class=\"wp-image-27\"/></figure>\n<!-- /wp:image --></div>\n<!-- /wp:column -->\n\n<!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:paragraph -->\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns --></div>\n<!-- /wp:column -->\n\n<!-- wp:column {\"width\":\"33.33%\"} -->\n<div class=\"wp-block-column\" style=\"flex-basis:33.33%\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Binnenkort</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">&nbsp;</h2>\n<!-- /wp:heading -->\n\n<!-- wp:html -->\n<div class=\"em-customlist\">a</div>\n<!-- /wp:html --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns -->','Home','','publish','closed','closed','','home','','','2024-05-17 11:23:07','2024-05-17 11:23:07','',0,'http://de-mijngang.local/?page_id=6',0,'page','',0);
INSERT INTO `wp_posts` VALUES (7,1,'2024-05-17 10:32:48','2024-05-17 10:32:48','<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Welkom!</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"level\":4} -->\n<h4 class=\"wp-block-heading\">Op de site van De MijnGang</h4>\n<!-- /wp:heading -->','Home','','inherit','closed','closed','','6-revision-v1','','','2024-05-17 10:32:48','2024-05-17 10:32:48','',6,'http://de-mijngang.local/?p=7',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (8,1,'2024-05-17 10:36:34','0000-00-00 00:00:00',' ','','','draft','closed','closed','','','','','2024-05-17 10:36:34','0000-00-00 00:00:00','',0,'http://de-mijngang.local/?p=8',1,'nav_menu_item','',0);
INSERT INTO `wp_posts` VALUES (9,1,'2024-05-17 10:36:34','0000-00-00 00:00:00',' ','','','draft','closed','closed','','','','','2024-05-17 10:36:34','0000-00-00 00:00:00','',0,'http://de-mijngang.local/?p=9',1,'nav_menu_item','',0);
INSERT INTO `wp_posts` VALUES (10,1,'2024-05-17 10:36:54','2024-05-17 10:36:54','<!-- wp:paragraph -->\n<p>This is an example page. It\'s different from a blog post because it will stay in one place and will show up in your site navigation (in most themes). Most people start with an About page that introduces them to potential site visitors. It might say something like this:</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:quote -->\n<blockquote class=\"wp-block-quote\"><p>Hi there! I\'m a bike messenger by day, aspiring actor by night, and this is my website. I live in Los Angeles, have a great dog named Jack, and I like pi&#241;a coladas. (And gettin\' caught in the rain.)</p></blockquote>\n<!-- /wp:quote -->\n\n<!-- wp:paragraph -->\n<p>...or something like this:</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:quote -->\n<blockquote class=\"wp-block-quote\"><p>The XYZ Doohickey Company was founded in 1971, and has been providing quality doohickeys to the public ever since. Located in Gotham City, XYZ employs over 2,000 people and does all kinds of awesome things for the Gotham community.</p></blockquote>\n<!-- /wp:quote -->\n\n<!-- wp:paragraph -->\n<p>As a new WordPress user, you should go to <a href=\"http://de-mijngang.local/wp-admin/\">your dashboard</a> to delete this page and create new pages for your content. Have fun!</p>\n<!-- /wp:paragraph -->','Sample Page','','inherit','closed','closed','','2-revision-v1','','','2024-05-17 10:36:54','2024-05-17 10:36:54','',2,'http://de-mijngang.local/?p=10',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (11,1,'2024-05-17 11:05:51','2024-05-17 10:37:08',' ','','','publish','closed','closed','','11','','','2024-05-17 11:05:51','2024-05-17 11:05:51','',0,'http://de-mijngang.local/?p=11',1,'nav_menu_item','',0);
INSERT INTO `wp_posts` VALUES (12,1,'2024-05-17 11:05:51','2024-05-17 10:38:32','','Nieuws','','publish','closed','closed','','nieuws','','','2024-05-17 11:05:51','2024-05-17 11:05:51','',0,'http://de-mijngang.local/?p=12',2,'nav_menu_item','',0);
INSERT INTO `wp_posts` VALUES (13,1,'2024-05-17 11:05:51','2024-05-17 10:38:32','','Stichting De MijnGang','','publish','closed','closed','','stichting-de-mijngang','','','2024-05-17 11:05:51','2024-05-17 11:05:51','',0,'http://de-mijngang.local/?p=13',3,'nav_menu_item','',0);
INSERT INTO `wp_posts` VALUES (14,1,'2024-05-17 11:05:51','2024-05-17 10:38:32','','In ons gebouw','','publish','closed','closed','','in-ons-gebouw','','','2024-05-17 11:05:51','2024-05-17 11:05:51','',0,'http://de-mijngang.local/?p=14',4,'nav_menu_item','',0);
INSERT INTO `wp_posts` VALUES (15,1,'2024-05-17 11:05:51','2024-05-17 10:38:32','','Achter de schermen','','publish','closed','closed','','achter-de-schermen','','','2024-05-17 11:05:51','2024-05-17 11:05:51','',0,'http://de-mijngang.local/?p=15',5,'nav_menu_item','',0);
INSERT INTO `wp_posts` VALUES (17,1,'2024-05-17 11:05:51','2024-05-17 10:38:32','','Foto\'s','','publish','closed','closed','','fotos','','','2024-05-17 11:05:51','2024-05-17 11:05:51','',0,'http://de-mijngang.local/?p=17',7,'nav_menu_item','',0);
INSERT INTO `wp_posts` VALUES (18,1,'2024-05-17 11:05:51','2024-05-17 10:38:32','','Contact','','publish','closed','closed','','contact','','','2024-05-17 11:05:51','2024-05-17 11:05:51','',0,'http://de-mijngang.local/?p=18',8,'nav_menu_item','',0);
INSERT INTO `wp_posts` VALUES (19,1,'2024-05-17 10:38:47','2024-05-17 10:38:47','{\n    \"demijngang::nav_menu_locations[primary]\": {\n        \"value\": 2,\n        \"type\": \"theme_mod\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2024-05-17 10:38:47\"\n    }\n}','','','trash','closed','closed','','9cc72e35-957a-43dc-a07b-f0c4cebf0e44','','','2024-05-17 10:38:47','2024-05-17 10:38:47','',0,'http://de-mijngang.local/9cc72e35-957a-43dc-a07b-f0c4cebf0e44/',0,'customize_changeset','',0);
INSERT INTO `wp_posts` VALUES (21,1,'2024-05-17 10:40:06','2024-05-17 10:40:06','CONTENTS','Activiteiten','CONTENTS','publish','closed','closed','','events','','','2024-05-17 11:05:15','2024-05-17 11:05:15','',0,'http://de-mijngang.local/events/',0,'page','',0);
INSERT INTO `wp_posts` VALUES (22,1,'2024-05-17 10:40:06','2024-05-17 10:40:06','CONTENTS','Locations','','private','closed','closed','','locations','','','2024-05-17 11:05:24','2024-05-17 11:05:24','',21,'http://de-mijngang.local/events/locations/',0,'page','',0);
INSERT INTO `wp_posts` VALUES (23,1,'2024-05-17 10:40:06','2024-05-17 10:40:06','CONTENTS','Categories','','private','closed','closed','','categories','','','2024-05-17 11:05:21','2024-05-17 11:05:21','',21,'http://de-mijngang.local/events/categories/',0,'page','',0);
INSERT INTO `wp_posts` VALUES (24,1,'2024-05-17 10:40:06','2024-05-17 10:40:06','CONTENTS','Tags','','private','closed','closed','','tags','','','2024-05-17 11:05:30','2024-05-17 11:05:30','',21,'http://de-mijngang.local/events/tags/',0,'page','',0);
INSERT INTO `wp_posts` VALUES (25,1,'2024-05-17 10:40:06','2024-05-17 10:40:06','CONTENTS','My Bookings','','private','closed','closed','','my-bookings','','','2024-05-17 11:05:27','2024-05-17 11:05:27','',21,'http://de-mijngang.local/events/my-bookings/',0,'page','',0);
INSERT INTO `wp_posts` VALUES (27,1,'2024-05-17 10:45:08','2024-05-17 10:45:08','','Placeholder','','inherit','open','closed','','placeholder','','','2024-05-17 10:45:08','2024-05-17 10:45:08','',6,'http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder.png',0,'attachment','image/png',0);
INSERT INTO `wp_posts` VALUES (28,1,'2024-05-17 10:46:23','2024-05-17 10:46:23','<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">Welkom!</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Op de site van De MijnGang</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column -->\n\n<!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:image {\"id\":27,\"width\":\"512px\",\"height\":\"256px\",\"scale\":\"cover\",\"sizeSlug\":\"thumbnail\",\"linkDestination\":\"none\",\"className\":\"is-style-default\"} -->\n<figure class=\"wp-block-image size-thumbnail is-resized is-style-default\"><img src=\"http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder-150x150.png\" alt=\"Placeholder\" class=\"wp-image-27\" style=\"object-fit:cover;width:512px;height:256px\"/></figure>\n<!-- /wp:image --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns -->\n\n<!-- wp:paragraph -->\n<p></p>\n<!-- /wp:paragraph -->','Home','','inherit','closed','closed','','6-revision-v1','','','2024-05-17 10:46:23','2024-05-17 10:46:23','',6,'http://de-mijngang.local/?p=28',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (29,1,'2024-05-17 10:49:52','2024-05-17 10:49:52','<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">Welkom!</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Op de site van De MijnGang</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column -->\n\n<!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:image {\"id\":27,\"width\":\"512px\",\"height\":\"256px\",\"scale\":\"cover\",\"sizeSlug\":\"thumbnail\",\"linkDestination\":\"none\",\"className\":\"is-style-default\"} -->\n<figure class=\"wp-block-image size-thumbnail is-resized is-style-default\"><img src=\"http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder-150x150.png\" alt=\"Placeholder\" class=\"wp-image-27\" style=\"object-fit:cover;width:512px;height:256px\"/></figure>\n<!-- /wp:image --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns -->\n\n<!-- wp:separator -->\n<hr class=\"wp-block-separator has-alpha-channel-opacity\"/>\n<!-- /wp:separator -->\n\n<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column {\"width\":\"66.66%\"} -->\n<div class=\"wp-block-column\" style=\"flex-basis:66.66%\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Uitgelicht</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">Activiteit #1</h2>\n<!-- /wp:heading -->\n\n<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:image {\"id\":27,\"sizeSlug\":\"full\",\"linkDestination\":\"none\"} -->\n<figure class=\"wp-block-image size-full\"><img src=\"http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder.png\" alt=\"Activiteit foto\" class=\"wp-image-27\"/></figure>\n<!-- /wp:image --></div>\n<!-- /wp:column -->\n\n<!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:paragraph -->\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns --></div>\n<!-- /wp:column -->\n\n<!-- wp:column {\"width\":\"33.33%\"} -->\n<div class=\"wp-block-column\" style=\"flex-basis:33.33%\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Binnenkort</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\"></h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>&lt;events manager list></p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns -->','Home','','inherit','closed','closed','','6-revision-v1','','','2024-05-17 10:49:52','2024-05-17 10:49:52','',6,'http://de-mijngang.local/?p=29',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (30,1,'2024-05-17 10:50:20','2024-05-17 10:50:20','<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">Welkom!</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Op de site van De MijnGang</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column -->\n\n<!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:heading -->\n<h2 class=\"wp-block-heading\"></h2>\n<!-- /wp:heading -->\n\n<!-- wp:image {\"id\":27,\"width\":\"512px\",\"height\":\"256px\",\"scale\":\"cover\",\"sizeSlug\":\"thumbnail\",\"linkDestination\":\"none\",\"className\":\"is-style-default\"} -->\n<figure class=\"wp-block-image size-thumbnail is-resized is-style-default\"><img src=\"http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder-150x150.png\" alt=\"Placeholder\" class=\"wp-image-27\" style=\"object-fit:cover;width:512px;height:256px\"/></figure>\n<!-- /wp:image --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns -->\n\n<!-- wp:separator -->\n<hr class=\"wp-block-separator has-alpha-channel-opacity\"/>\n<!-- /wp:separator -->\n\n<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column {\"width\":\"66.66%\"} -->\n<div class=\"wp-block-column\" style=\"flex-basis:66.66%\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Uitgelicht</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">Activiteit #1</h2>\n<!-- /wp:heading -->\n\n<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:image {\"id\":27,\"sizeSlug\":\"full\",\"linkDestination\":\"none\"} -->\n<figure class=\"wp-block-image size-full\"><img src=\"http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder.png\" alt=\"Activiteit foto\" class=\"wp-image-27\"/></figure>\n<!-- /wp:image --></div>\n<!-- /wp:column -->\n\n<!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:paragraph -->\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns --></div>\n<!-- /wp:column -->\n\n<!-- wp:column {\"width\":\"33.33%\"} -->\n<div class=\"wp-block-column\" style=\"flex-basis:33.33%\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Binnenkort</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\"></h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>&lt;events manager list></p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns -->','Home','','inherit','closed','closed','','6-revision-v1','','','2024-05-17 10:50:20','2024-05-17 10:50:20','',6,'http://de-mijngang.local/?p=30',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (31,1,'2024-05-17 10:50:45','2024-05-17 10:50:45','<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">Welkom!</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Op de site van De MijnGang</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column -->\n\n<!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\"></h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\"></h2>\n<!-- /wp:heading -->\n\n<!-- wp:image {\"id\":27,\"width\":\"512px\",\"height\":\"256px\",\"scale\":\"cover\",\"sizeSlug\":\"thumbnail\",\"linkDestination\":\"none\",\"className\":\"is-style-default\"} -->\n<figure class=\"wp-block-image size-thumbnail is-resized is-style-default\"><img src=\"http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder-150x150.png\" alt=\"Placeholder\" class=\"wp-image-27\" style=\"object-fit:cover;width:512px;height:256px\"/></figure>\n<!-- /wp:image --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns -->\n\n<!-- wp:separator -->\n<hr class=\"wp-block-separator has-alpha-channel-opacity\"/>\n<!-- /wp:separator -->\n\n<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column {\"width\":\"66.66%\"} -->\n<div class=\"wp-block-column\" style=\"flex-basis:66.66%\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Uitgelicht</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">Activiteit #1</h2>\n<!-- /wp:heading -->\n\n<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:image {\"id\":27,\"sizeSlug\":\"full\",\"linkDestination\":\"none\"} -->\n<figure class=\"wp-block-image size-full\"><img src=\"http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder.png\" alt=\"Activiteit foto\" class=\"wp-image-27\"/></figure>\n<!-- /wp:image --></div>\n<!-- /wp:column -->\n\n<!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:paragraph -->\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns --></div>\n<!-- /wp:column -->\n\n<!-- wp:column {\"width\":\"33.33%\"} -->\n<div class=\"wp-block-column\" style=\"flex-basis:33.33%\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Binnenkort</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\"></h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>&lt;events manager list></p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns -->','Home','','inherit','closed','closed','','6-revision-v1','','','2024-05-17 10:50:45','2024-05-17 10:50:45','',6,'http://de-mijngang.local/?p=31',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (32,1,'2024-05-17 10:51:26','2024-05-17 10:51:26','<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">Welkom!</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Op de site van De MijnGang</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column -->\n\n<!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\"></h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\"></h2>\n<!-- /wp:heading -->\n\n<!-- wp:image {\"id\":27,\"width\":\"343px\",\"height\":\"auto\",\"aspectRatio\":\"1.7777777777777777\",\"scale\":\"cover\",\"sizeSlug\":\"thumbnail\",\"linkDestination\":\"none\",\"className\":\"is-style-default\"} -->\n<figure class=\"wp-block-image size-thumbnail is-resized is-style-default\"><img src=\"http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder-150x150.png\" alt=\"Placeholder\" class=\"wp-image-27\" style=\"aspect-ratio:1.7777777777777777;object-fit:cover;width:343px;height:auto\"/></figure>\n<!-- /wp:image --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns -->\n\n<!-- wp:separator -->\n<hr class=\"wp-block-separator has-alpha-channel-opacity\"/>\n<!-- /wp:separator -->\n\n<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column {\"width\":\"66.66%\"} -->\n<div class=\"wp-block-column\" style=\"flex-basis:66.66%\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Uitgelicht</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">Activiteit #1</h2>\n<!-- /wp:heading -->\n\n<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:image {\"id\":27,\"sizeSlug\":\"full\",\"linkDestination\":\"none\"} -->\n<figure class=\"wp-block-image size-full\"><img src=\"http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder.png\" alt=\"Activiteit foto\" class=\"wp-image-27\"/></figure>\n<!-- /wp:image --></div>\n<!-- /wp:column -->\n\n<!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:paragraph -->\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns --></div>\n<!-- /wp:column -->\n\n<!-- wp:column {\"width\":\"33.33%\"} -->\n<div class=\"wp-block-column\" style=\"flex-basis:33.33%\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Binnenkort</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\"></h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>&lt;events manager list></p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns -->','Home','','inherit','closed','closed','','6-revision-v1','','','2024-05-17 10:51:26','2024-05-17 10:51:26','',6,'http://de-mijngang.local/?p=32',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (33,1,'2024-05-17 10:51:36','2024-05-17 10:51:36','<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">Welkom!</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Op de site van De MijnGang</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column -->\n\n<!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\"></h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\"></h2>\n<!-- /wp:heading -->\n\n<!-- wp:image {\"id\":27,\"width\":\"512px\",\"aspectRatio\":\"16/9\",\"scale\":\"cover\",\"sizeSlug\":\"thumbnail\",\"linkDestination\":\"none\",\"className\":\"is-style-default\"} -->\n<figure class=\"wp-block-image size-thumbnail is-resized is-style-default\"><img src=\"http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder-150x150.png\" alt=\"Placeholder\" class=\"wp-image-27\" style=\"aspect-ratio:16/9;object-fit:cover;width:512px\"/></figure>\n<!-- /wp:image --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns -->\n\n<!-- wp:separator -->\n<hr class=\"wp-block-separator has-alpha-channel-opacity\"/>\n<!-- /wp:separator -->\n\n<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column {\"width\":\"66.66%\"} -->\n<div class=\"wp-block-column\" style=\"flex-basis:66.66%\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Uitgelicht</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">Activiteit #1</h2>\n<!-- /wp:heading -->\n\n<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:image {\"id\":27,\"sizeSlug\":\"full\",\"linkDestination\":\"none\"} -->\n<figure class=\"wp-block-image size-full\"><img src=\"http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder.png\" alt=\"Activiteit foto\" class=\"wp-image-27\"/></figure>\n<!-- /wp:image --></div>\n<!-- /wp:column -->\n\n<!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:paragraph -->\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns --></div>\n<!-- /wp:column -->\n\n<!-- wp:column {\"width\":\"33.33%\"} -->\n<div class=\"wp-block-column\" style=\"flex-basis:33.33%\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Binnenkort</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\"></h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>&lt;events manager list></p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns -->','Home','','inherit','closed','closed','','6-revision-v1','','','2024-05-17 10:51:36','2024-05-17 10:51:36','',6,'http://de-mijngang.local/?p=33',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (34,1,'2024-05-17 10:52:53','2024-05-17 10:52:53','<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">Welkom!</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Op de site van De MijnGang</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column -->\n\n<!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\"> </h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\"> </h2>\n<!-- /wp:heading -->\n\n<!-- wp:image {\"id\":27,\"width\":\"512px\",\"aspectRatio\":\"16/9\",\"scale\":\"cover\",\"sizeSlug\":\"thumbnail\",\"linkDestination\":\"none\",\"className\":\"is-style-default\"} -->\n<figure class=\"wp-block-image size-thumbnail is-resized is-style-default\"><img src=\"http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder-150x150.png\" alt=\"Placeholder\" class=\"wp-image-27\" style=\"aspect-ratio:16/9;object-fit:cover;width:512px\"/></figure>\n<!-- /wp:image --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns -->\n\n<!-- wp:separator -->\n<hr class=\"wp-block-separator has-alpha-channel-opacity\"/>\n<!-- /wp:separator -->\n\n<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column {\"width\":\"66.66%\"} -->\n<div class=\"wp-block-column\" style=\"flex-basis:66.66%\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Uitgelicht</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">Activiteit #1</h2>\n<!-- /wp:heading -->\n\n<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:image {\"id\":27,\"sizeSlug\":\"full\",\"linkDestination\":\"none\"} -->\n<figure class=\"wp-block-image size-full\"><img src=\"http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder.png\" alt=\"Activiteit foto\" class=\"wp-image-27\"/></figure>\n<!-- /wp:image --></div>\n<!-- /wp:column -->\n\n<!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:paragraph -->\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns --></div>\n<!-- /wp:column -->\n\n<!-- wp:column {\"width\":\"33.33%\"} -->\n<div class=\"wp-block-column\" style=\"flex-basis:33.33%\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Binnenkort</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\"> </h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>&lt;events manager list></p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns -->','Home','','inherit','closed','closed','','6-revision-v1','','','2024-05-17 10:52:53','2024-05-17 10:52:53','',6,'http://de-mijngang.local/?p=34',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (35,1,'2024-05-17 10:53:16','2024-05-17 10:53:16','<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">Welkom!</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Op de site van De MijnGang</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column -->\n\n<!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\"> </h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\"> </h2>\n<!-- /wp:heading -->\n\n<!-- wp:image {\"id\":27,\"width\":\"490px\",\"aspectRatio\":\"16/9\",\"scale\":\"cover\",\"sizeSlug\":\"thumbnail\",\"linkDestination\":\"none\",\"className\":\"is-style-default\"} -->\n<figure class=\"wp-block-image size-thumbnail is-resized is-style-default\"><img src=\"http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder-150x150.png\" alt=\"Placeholder\" class=\"wp-image-27\" style=\"aspect-ratio:16/9;object-fit:cover;width:490px\"/></figure>\n<!-- /wp:image --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns -->\n\n<!-- wp:separator -->\n<hr class=\"wp-block-separator has-alpha-channel-opacity\"/>\n<!-- /wp:separator -->\n\n<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column {\"width\":\"66.66%\"} -->\n<div class=\"wp-block-column\" style=\"flex-basis:66.66%\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Uitgelicht</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">Activiteit #1</h2>\n<!-- /wp:heading -->\n\n<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:image {\"id\":27,\"sizeSlug\":\"full\",\"linkDestination\":\"none\"} -->\n<figure class=\"wp-block-image size-full\"><img src=\"http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder.png\" alt=\"Activiteit foto\" class=\"wp-image-27\"/></figure>\n<!-- /wp:image --></div>\n<!-- /wp:column -->\n\n<!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:paragraph -->\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns --></div>\n<!-- /wp:column -->\n\n<!-- wp:column {\"width\":\"33.33%\"} -->\n<div class=\"wp-block-column\" style=\"flex-basis:33.33%\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Binnenkort</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\"> </h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>&lt;events manager list></p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns -->','Home','','inherit','closed','closed','','6-revision-v1','','','2024-05-17 10:53:16','2024-05-17 10:53:16','',6,'http://de-mijngang.local/?p=35',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (36,1,'2024-05-17 10:53:22','2024-05-17 10:53:22','<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">Welkom!</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Op de site van De MijnGang</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column -->\n\n<!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\"> </h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\"> </h2>\n<!-- /wp:heading -->\n\n<!-- wp:image {\"id\":27,\"width\":\"512px\",\"aspectRatio\":\"16/9\",\"scale\":\"cover\",\"sizeSlug\":\"thumbnail\",\"linkDestination\":\"none\",\"className\":\"is-style-default\"} -->\n<figure class=\"wp-block-image size-thumbnail is-resized is-style-default\"><img src=\"http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder-150x150.png\" alt=\"Placeholder\" class=\"wp-image-27\" style=\"aspect-ratio:16/9;object-fit:cover;width:512px\"/></figure>\n<!-- /wp:image --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns -->\n\n<!-- wp:separator -->\n<hr class=\"wp-block-separator has-alpha-channel-opacity\"/>\n<!-- /wp:separator -->\n\n<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column {\"width\":\"66.66%\"} -->\n<div class=\"wp-block-column\" style=\"flex-basis:66.66%\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Uitgelicht</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">Activiteit #1</h2>\n<!-- /wp:heading -->\n\n<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:image {\"id\":27,\"sizeSlug\":\"full\",\"linkDestination\":\"none\"} -->\n<figure class=\"wp-block-image size-full\"><img src=\"http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder.png\" alt=\"Activiteit foto\" class=\"wp-image-27\"/></figure>\n<!-- /wp:image --></div>\n<!-- /wp:column -->\n\n<!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:paragraph -->\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns --></div>\n<!-- /wp:column -->\n\n<!-- wp:column {\"width\":\"33.33%\"} -->\n<div class=\"wp-block-column\" style=\"flex-basis:33.33%\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Binnenkort</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\"> </h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>&lt;events manager list></p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns -->','Home','','inherit','closed','closed','','6-revision-v1','','','2024-05-17 10:53:22','2024-05-17 10:53:22','',6,'http://de-mijngang.local/?p=36',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (37,1,'2024-05-17 11:05:15','2024-05-17 11:05:15','CONTENTS','Activiteiten','CONTENTS','inherit','closed','closed','','21-revision-v1','','','2024-05-17 11:05:15','2024-05-17 11:05:15','',21,'http://de-mijngang.local/?p=37',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (38,1,'2024-05-17 11:05:21','2024-05-17 11:05:21','CONTENTS','Categories','','inherit','closed','closed','','23-revision-v1','','','2024-05-17 11:05:21','2024-05-17 11:05:21','',23,'http://de-mijngang.local/?p=38',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (39,1,'2024-05-17 11:05:24','2024-05-17 11:05:24','CONTENTS','Locations','','inherit','closed','closed','','22-revision-v1','','','2024-05-17 11:05:24','2024-05-17 11:05:24','',22,'http://de-mijngang.local/?p=39',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (40,1,'2024-05-17 11:05:27','2024-05-17 11:05:27','CONTENTS','My Bookings','','inherit','closed','closed','','25-revision-v1','','','2024-05-17 11:05:27','2024-05-17 11:05:27','',25,'http://de-mijngang.local/?p=40',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (41,1,'2024-05-17 11:05:30','2024-05-17 11:05:30','CONTENTS','Tags','','inherit','closed','closed','','24-revision-v1','','','2024-05-17 11:05:30','2024-05-17 11:05:30','',24,'http://de-mijngang.local/?p=41',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (42,1,'2024-05-17 11:05:51','2024-05-17 11:05:51',' ','','','publish','closed','closed','','42','','','2024-05-17 11:05:51','2024-05-17 11:05:51','',0,'http://de-mijngang.local/?p=42',6,'nav_menu_item','',0);
INSERT INTO `wp_posts` VALUES (43,1,'2024-05-17 11:07:17','2024-05-17 11:07:17','Wauw, een super cool uitgelicht activiteit!','Uitgelicht activiteit','','publish','closed','closed','','uitgelicht-activiteit','','','2024-05-17 11:09:38','2024-05-17 11:09:38','',0,'http://de-mijngang.local/?post_type=event&#038;p=43',0,'event','',0);
INSERT INTO `wp_posts` VALUES (44,1,'2024-05-17 11:07:17','2024-05-17 11:07:17','','Stichting De MijnGang','','publish','open','closed','','stichting-de-mijngang','','','2024-05-17 11:07:17','2024-05-17 11:07:17','',0,'http://de-mijngang.local/locations/stichting-de-mijngang/',0,'location','',0);
INSERT INTO `wp_posts` VALUES (45,1,'2024-05-17 11:10:03','2024-05-17 11:10:03','<!-- wp:paragraph -->\n<p>Welcome to WordPress. This is your first post. Edit or delete it, then start writing!</p>\n<!-- /wp:paragraph -->','Hello world!','','inherit','closed','closed','','1-revision-v1','','','2024-05-17 11:10:03','2024-05-17 11:10:03','',1,'http://de-mijngang.local/?p=45',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (46,1,'2024-05-17 11:10:38','2024-05-17 11:10:38','<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">Welkom!</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Op de site van De MijnGang</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column -->\n\n<!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">&nbsp;</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">&nbsp;</h2>\n<!-- /wp:heading -->\n\n<!-- wp:image {\"id\":27,\"width\":\"512px\",\"aspectRatio\":\"16/9\",\"scale\":\"cover\",\"sizeSlug\":\"thumbnail\",\"linkDestination\":\"none\",\"className\":\"is-style-default\"} -->\n<figure class=\"wp-block-image size-thumbnail is-resized is-style-default\"><img src=\"http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder-150x150.png\" alt=\"Placeholder\" class=\"wp-image-27\" style=\"aspect-ratio:16/9;object-fit:cover;width:512px\"/></figure>\n<!-- /wp:image --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns -->\n\n<!-- wp:separator -->\n<hr class=\"wp-block-separator has-alpha-channel-opacity\"/>\n<!-- /wp:separator -->\n\n<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column {\"width\":\"66.66%\"} -->\n<div class=\"wp-block-column\" style=\"flex-basis:66.66%\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Uitgelicht</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">Activiteit #1</h2>\n<!-- /wp:heading -->\n\n<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:image {\"id\":27,\"sizeSlug\":\"full\",\"linkDestination\":\"none\"} -->\n<figure class=\"wp-block-image size-full\"><img src=\"http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder.png\" alt=\"Activiteit foto\" class=\"wp-image-27\"/></figure>\n<!-- /wp:image --></div>\n<!-- /wp:column -->\n\n<!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:paragraph -->\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns --></div>\n<!-- /wp:column -->\n\n<!-- wp:column {\"width\":\"33.33%\"} -->\n<div class=\"wp-block-column\" style=\"flex-basis:33.33%\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Binnenkort</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">&nbsp;</h2>\n<!-- /wp:heading -->\n\n<!-- wp:html -->\n<div class=\"em-list\"></div>\n<!-- /wp:html --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns -->','Home','','inherit','closed','closed','','6-revision-v1','','','2024-05-17 11:10:38','2024-05-17 11:10:38','',6,'http://de-mijngang.local/?p=46',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (47,1,'2024-05-17 11:16:01','2024-05-17 11:16:01','<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">Welkom!</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Op de site van De MijnGang</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column -->\n\n<!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">&nbsp;</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">&nbsp;</h2>\n<!-- /wp:heading -->\n\n<!-- wp:image {\"id\":27,\"width\":\"512px\",\"aspectRatio\":\"16/9\",\"scale\":\"cover\",\"sizeSlug\":\"thumbnail\",\"linkDestination\":\"none\",\"className\":\"is-style-default\"} -->\n<figure class=\"wp-block-image size-thumbnail is-resized is-style-default\"><img src=\"http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder-150x150.png\" alt=\"Placeholder\" class=\"wp-image-27\" style=\"aspect-ratio:16/9;object-fit:cover;width:512px\"/></figure>\n<!-- /wp:image --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns -->\n\n<!-- wp:separator -->\n<hr class=\"wp-block-separator has-alpha-channel-opacity\"/>\n<!-- /wp:separator -->\n\n<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column {\"width\":\"66.66%\"} -->\n<div class=\"wp-block-column\" style=\"flex-basis:66.66%\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Uitgelicht</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">Activiteit #1</h2>\n<!-- /wp:heading -->\n\n<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:image {\"id\":27,\"sizeSlug\":\"full\",\"linkDestination\":\"none\"} -->\n<figure class=\"wp-block-image size-full\"><img src=\"http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder.png\" alt=\"Activiteit foto\" class=\"wp-image-27\"/></figure>\n<!-- /wp:image --></div>\n<!-- /wp:column -->\n\n<!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:paragraph -->\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns --></div>\n<!-- /wp:column -->\n\n<!-- wp:column {\"width\":\"33.33%\"} -->\n<div class=\"wp-block-column\" style=\"flex-basis:33.33%\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Binnenkort</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">&nbsp;</h2>\n<!-- /wp:heading -->\n\n<!-- wp:html -->\n<div class=\"em-list\">a</div>\n<!-- /wp:html --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns -->','Home','','inherit','closed','closed','','6-revision-v1','','','2024-05-17 11:16:01','2024-05-17 11:16:01','',6,'http://de-mijngang.local/?p=47',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (48,1,'2024-05-17 11:23:07','2024-05-17 11:23:07','<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">Welkom!</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Op de site van De MijnGang</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column -->\n\n<!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">&nbsp;</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">&nbsp;</h2>\n<!-- /wp:heading -->\n\n<!-- wp:image {\"id\":27,\"width\":\"512px\",\"aspectRatio\":\"16/9\",\"scale\":\"cover\",\"sizeSlug\":\"thumbnail\",\"linkDestination\":\"none\",\"className\":\"is-style-default\"} -->\n<figure class=\"wp-block-image size-thumbnail is-resized is-style-default\"><img src=\"http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder-150x150.png\" alt=\"Placeholder\" class=\"wp-image-27\" style=\"aspect-ratio:16/9;object-fit:cover;width:512px\"/></figure>\n<!-- /wp:image --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns -->\n\n<!-- wp:separator -->\n<hr class=\"wp-block-separator has-alpha-channel-opacity\"/>\n<!-- /wp:separator -->\n\n<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column {\"width\":\"66.66%\"} -->\n<div class=\"wp-block-column\" style=\"flex-basis:66.66%\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Uitgelicht</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading {\"fontSize\":\"large\"} -->\n<h2 class=\"wp-block-heading has-large-font-size\">Activiteit #1</h2>\n<!-- /wp:heading -->\n\n<!-- wp:columns -->\n<div class=\"wp-block-columns\"><!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:image {\"id\":27,\"sizeSlug\":\"full\",\"linkDestination\":\"none\"} -->\n<figure class=\"wp-block-image size-full\"><img src=\"http://de-mijngang.local/wp-content/uploads/2024/05/Placeholder.png\" alt=\"Activiteit foto\" class=\"wp-image-27\"/></figure>\n<!-- /wp:image --></div>\n<!-- /wp:column -->\n\n<!-- wp:column -->\n<div class=\"wp-block-column\"><!-- wp:paragraph -->\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns --></div>\n<!-- /wp:column -->\n\n<!-- wp:column {\"width\":\"33.33%\"} -->\n<div class=\"wp-block-column\" style=\"flex-basis:33.33%\"><!-- wp:heading {\"fontSize\":\"medium\"} -->\n<h2 class=\"wp-block-heading has-medium-font-size\">Binnenkort</h2>\n<!-- /wp:heading -->\n\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">&nbsp;</h2>\n<!-- /wp:heading -->\n\n<!-- wp:html -->\n<div class=\"em-customlist\">a</div>\n<!-- /wp:html --></div>\n<!-- /wp:column --></div>\n<!-- /wp:columns -->','Home','','inherit','closed','closed','','6-revision-v1','','','2024-05-17 11:23:07','2024-05-17 11:23:07','',6,'http://de-mijngang.local/?p=48',0,'revision','',0);
/*!40000 ALTER TABLE `wp_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_term_relationships`
--

DROP TABLE IF EXISTS `wp_term_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_term_relationships` (
  `object_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `term_taxonomy_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `term_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`,`term_taxonomy_id`),
  KEY `term_taxonomy_id` (`term_taxonomy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_term_relationships`
--

LOCK TABLES `wp_term_relationships` WRITE;
/*!40000 ALTER TABLE `wp_term_relationships` DISABLE KEYS */;
INSERT INTO `wp_term_relationships` VALUES (1,1,0);
INSERT INTO `wp_term_relationships` VALUES (11,2,0);
INSERT INTO `wp_term_relationships` VALUES (12,2,0);
INSERT INTO `wp_term_relationships` VALUES (13,2,0);
INSERT INTO `wp_term_relationships` VALUES (14,2,0);
INSERT INTO `wp_term_relationships` VALUES (15,2,0);
INSERT INTO `wp_term_relationships` VALUES (17,2,0);
INSERT INTO `wp_term_relationships` VALUES (18,2,0);
INSERT INTO `wp_term_relationships` VALUES (42,2,0);
INSERT INTO `wp_term_relationships` VALUES (43,3,0);
/*!40000 ALTER TABLE `wp_term_relationships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_term_taxonomy`
--

DROP TABLE IF EXISTS `wp_term_taxonomy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_term_taxonomy` (
  `term_taxonomy_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `taxonomy` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `description` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_taxonomy_id`),
  UNIQUE KEY `term_id_taxonomy` (`term_id`,`taxonomy`),
  KEY `taxonomy` (`taxonomy`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_term_taxonomy`
--

LOCK TABLES `wp_term_taxonomy` WRITE;
/*!40000 ALTER TABLE `wp_term_taxonomy` DISABLE KEYS */;
INSERT INTO `wp_term_taxonomy` VALUES (1,1,'category','',0,0);
INSERT INTO `wp_term_taxonomy` VALUES (2,2,'nav_menu','',0,8);
INSERT INTO `wp_term_taxonomy` VALUES (3,3,'event-tags','',0,1);
/*!40000 ALTER TABLE `wp_term_taxonomy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_termmeta`
--

DROP TABLE IF EXISTS `wp_termmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_termmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `term_id` (`term_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_termmeta`
--

LOCK TABLES `wp_termmeta` WRITE;
/*!40000 ALTER TABLE `wp_termmeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_termmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_terms`
--

DROP TABLE IF EXISTS `wp_terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_terms` (
  `term_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `slug` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `term_group` bigint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_id`),
  KEY `slug` (`slug`(191)),
  KEY `name` (`name`(191))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_terms`
--

LOCK TABLES `wp_terms` WRITE;
/*!40000 ALTER TABLE `wp_terms` DISABLE KEYS */;
INSERT INTO `wp_terms` VALUES (1,'Uncategorized','uncategorized',0);
INSERT INTO `wp_terms` VALUES (2,'Primary Menu','primary-menu',0);
INSERT INTO `wp_terms` VALUES (3,'featured','featured',0);
/*!40000 ALTER TABLE `wp_terms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_usermeta`
--

DROP TABLE IF EXISTS `wp_usermeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_usermeta` (
  `umeta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`umeta_id`),
  KEY `user_id` (`user_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_usermeta`
--

LOCK TABLES `wp_usermeta` WRITE;
/*!40000 ALTER TABLE `wp_usermeta` DISABLE KEYS */;
INSERT INTO `wp_usermeta` VALUES (1,1,'nickname','admin');
INSERT INTO `wp_usermeta` VALUES (2,1,'first_name','');
INSERT INTO `wp_usermeta` VALUES (3,1,'last_name','');
INSERT INTO `wp_usermeta` VALUES (4,1,'description','');
INSERT INTO `wp_usermeta` VALUES (5,1,'rich_editing','true');
INSERT INTO `wp_usermeta` VALUES (6,1,'syntax_highlighting','true');
INSERT INTO `wp_usermeta` VALUES (7,1,'comment_shortcuts','false');
INSERT INTO `wp_usermeta` VALUES (8,1,'admin_color','fresh');
INSERT INTO `wp_usermeta` VALUES (9,1,'use_ssl','0');
INSERT INTO `wp_usermeta` VALUES (10,1,'show_admin_bar_front','true');
INSERT INTO `wp_usermeta` VALUES (11,1,'locale','');
INSERT INTO `wp_usermeta` VALUES (12,1,'wp_capabilities','a:1:{s:13:\"administrator\";b:1;}');
INSERT INTO `wp_usermeta` VALUES (13,1,'wp_user_level','10');
INSERT INTO `wp_usermeta` VALUES (14,1,'dismissed_wp_pointers','');
INSERT INTO `wp_usermeta` VALUES (15,1,'show_welcome_panel','1');
INSERT INTO `wp_usermeta` VALUES (16,1,'session_tokens','a:1:{s:64:\"0e36a6d021a97b64e8162580711300dfee85ca7271483987e99cd31091a34e0a\";a:4:{s:10:\"expiration\";i:1716114647;s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:80:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:126.0) Gecko/20100101 Firefox/126.0\";s:5:\"login\";i:1715941847;}}');
INSERT INTO `wp_usermeta` VALUES (17,1,'wp_user-settings','libraryContent=browse');
INSERT INTO `wp_usermeta` VALUES (18,1,'wp_user-settings-time','1715941843');
INSERT INTO `wp_usermeta` VALUES (19,1,'wp_dashboard_quick_press_last_post_id','5');
INSERT INTO `wp_usermeta` VALUES (20,1,'wp_persisted_preferences','a:5:{s:4:\"core\";a:2:{s:29:\"isTemplatePartMoveHintVisible\";b:0;s:10:\"openPanels\";a:3:{i:0;s:11:\"post-status\";i:1;s:15:\"page-attributes\";i:2;s:16:\"discussion-panel\";}}s:9:\"_modified\";s:24:\"2024-05-17T10:59:00.185Z\";s:17:\"core/edit-widgets\";a:2:{s:26:\"isComplementaryAreaVisible\";b:1;s:12:\"welcomeGuide\";b:0;}s:14:\"core/edit-post\";a:2:{s:26:\"isComplementaryAreaVisible\";b:1;s:12:\"welcomeGuide\";b:0;}s:22:\"core/customize-widgets\";a:1:{s:12:\"welcomeGuide\";b:0;}}');
INSERT INTO `wp_usermeta` VALUES (21,1,'managenav-menuscolumnshidden','a:5:{i:0;s:11:\"link-target\";i:1;s:11:\"css-classes\";i:2;s:3:\"xfn\";i:3;s:11:\"description\";i:4;s:15:\"title-attribute\";}');
INSERT INTO `wp_usermeta` VALUES (22,1,'metaboxhidden_nav-menus','a:2:{i:0;s:12:\"add-post_tag\";i:1;s:15:\"add-post_format\";}');
INSERT INTO `wp_usermeta` VALUES (23,1,'manageedit-eventcolumnshidden','a:1:{i:0;s:8:\"event-id\";}');
INSERT INTO `wp_usermeta` VALUES (24,1,'nav_menu_recently_edited','2');
INSERT INTO `wp_usermeta` VALUES (25,1,'meta-box-order_event','a:3:{s:4:\"side\";s:75:\"em-event-when,submitdiv,tagsdiv-event-tags,event-categoriesdiv,postimagediv\";s:6:\"normal\";s:111:\"em-event-where,em-event-bookings,postexcerpt,commentstatusdiv,commentsdiv,slugdiv,authordiv,em-event-attributes\";s:8:\"advanced\";s:0:\"\";}');
INSERT INTO `wp_usermeta` VALUES (26,1,'screen_layout_event','2');
/*!40000 ALTER TABLE `wp_usermeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_users`
--

DROP TABLE IF EXISTS `wp_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wp_users` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_login` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_pass` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_nicename` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_url` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_status` int(11) NOT NULL DEFAULT '0',
  `display_name` varchar(250) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `user_login_key` (`user_login`),
  KEY `user_nicename` (`user_nicename`),
  KEY `user_email` (`user_email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_users`
--

LOCK TABLES `wp_users` WRITE;
/*!40000 ALTER TABLE `wp_users` DISABLE KEYS */;
INSERT INTO `wp_users` VALUES (1,'admin','$P$BYPocE/eNQOEpJjZDOcVHYAmFM9vnt.','admin','dev-email@wpengine.local','http://de-mijngang.local','2024-05-17 10:27:19','',0,'admin');
/*!40000 ALTER TABLE `wp_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-24 14:52:44
