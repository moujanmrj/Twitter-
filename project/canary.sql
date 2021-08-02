-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: canary
-- ------------------------------------------------------
-- Server version	8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `avas`
--

DROP TABLE IF EXISTS `avas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avas` (
  `avacontent` varchar(256) NOT NULL,
  `username` varchar(20) NOT NULL,
  `postagedate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ID` int NOT NULL AUTO_INCREMENT,
  `iscomment` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `username` (`username`),
  CONSTRAINT `avas_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avas`
--

LOCK TABLES `avas` WRITE;
/*!40000 ALTER TABLE `avas` DISABLE KEYS */;
INSERT INTO `avas` VALUES ('sad','moujanmrj','2021-07-13 17:11:38',1,NULL),('hello','dayanamov','2021-07-13 17:11:38',2,NULL),('happy','hastimir','2021-07-13 17:11:38',3,NULL),('games','erfanrmz','2021-07-13 17:11:38',4,NULL),('haha','erfanrmz','2021-07-13 17:11:38',5,NULL),('bye','erfanrmz','2021-07-13 17:11:38',6,NULL),('good','moujanmrj','2021-07-13 17:13:05',7,3),(':))','dayanamov','2021-07-13 17:13:05',8,4),('hi','salehsalehi','2021-07-13 22:44:20',9,NULL),('man saleham','salehsalehi','2021-07-13 23:40:56',10,NULL),('=((','salehsalehi','2021-07-14 01:15:42',11,1),('salam salam','hastimir','2021-07-14 12:54:01',12,1),('bee','hastimir','2021-07-14 16:48:49',19,NULL),('#bee','hastimir','2021-07-14 16:52:03',20,NULL),('bee #bee','hastimir','2021-07-14 16:52:10',21,NULL),('#bee bee','hastimir','2021-07-14 16:52:19',22,NULL),('#salam','hastimir','2021-07-14 16:57:04',25,NULL),('#badii eftezah','hastimir','2021-07-14 16:57:31',26,NULL),('ey baba','hastimir','2021-07-14 17:13:29',27,1),('vay','hastimir','2021-07-14 17:16:19',28,1),('=O','hastimir','2021-07-14 17:17:08',29,2),('ish','hastimir','2021-07-14 17:23:46',30,3);
/*!40000 ALTER TABLE `avas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `avas_log` AFTER INSERT ON `avas` FOR EACH ROW insert into avaslog (username, postagedate, ID) values ((select username from avas order by postagedate desc limit 1), now(), (select ID from avas order by postagedate desc limit 1)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `hashtagtrigger` AFTER INSERT ON `avas` FOR EACH ROW BEGIN
	declare tags varchar(6);
	set @startloc := 1;
	set @startpos := -1;
	set @endpos := -1;
	set @totallen =  LENGTH(NEW.avacontent);
	while @startloc < @totallen
	do
		set @startpos := LOCATE('#', NEW.avacontent, @startloc);
		set @endpos := @startpos + 5 ;
		set @s := SUBSTRING(NEW.avacontent, @endpos+1 , 1);
		if @startpos >= 1 AND @endpos > 0 
        then
			set @len = 6;
			set tags := SUBSTRING(NEW.avacontent, @startpos, @len);
			if @s = ' ' OR @endpos = @totallen then
				insert into hashtags(hashtagContent) values (tags);
				insert into avashashtags(avaId, hashtagContent) values (new.ID, tags);
			end if;
			set @startloc = @endpos+1;
		else
			set @startloc := @totallen+1;
		end if;
	end while;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `avashashtags`
--

DROP TABLE IF EXISTS `avashashtags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avashashtags` (
  `avaId` int NOT NULL,
  `hashtagContent` char(6) NOT NULL,
  KEY `hashtagContent` (`hashtagContent`),
  KEY `avaId` (`avaId`),
  CONSTRAINT `avashashtags_ibfk_1` FOREIGN KEY (`hashtagContent`) REFERENCES `hashtags` (`hashtagContent`),
  CONSTRAINT `avashashtags_ibfk_2` FOREIGN KEY (`avaId`) REFERENCES `avas` (`ID`),
  CONSTRAINT `avashashtags_chk_1` CHECK ((`hashtagContent` like _utf8mb4'#%'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avashashtags`
--

LOCK TABLES `avashashtags` WRITE;
/*!40000 ALTER TABLE `avashashtags` DISABLE KEYS */;
INSERT INTO `avashashtags` VALUES (1,'#hihih'),(25,'#salam'),(26,'#badii');
/*!40000 ALTER TABLE `avashashtags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avaslog`
--

DROP TABLE IF EXISTS `avaslog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avaslog` (
  `username` varchar(20) NOT NULL,
  `postagedate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ID` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `username` (`username`),
  CONSTRAINT `avaslog_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avaslog`
--

LOCK TABLES `avaslog` WRITE;
/*!40000 ALTER TABLE `avaslog` DISABLE KEYS */;
INSERT INTO `avaslog` VALUES ('salehsalehi','2021-07-13 22:44:20',9),('salehsalehi','2021-07-13 23:40:56',10),('salehsalehi','2021-07-14 01:15:42',11),('hastimir','2021-07-14 12:54:01',12),('hastimir','2021-07-14 16:48:49',19),('hastimir','2021-07-14 16:52:03',20),('hastimir','2021-07-14 16:52:10',21),('hastimir','2021-07-14 16:52:19',22),('hastimir','2021-07-14 16:57:04',25),('hastimir','2021-07-14 16:57:31',26),('hastimir','2021-07-14 17:13:29',27),('hastimir','2021-07-14 17:16:19',28),('hastimir','2021-07-14 17:17:08',29),('hastimir','2021-07-14 17:23:46',30);
/*!40000 ALTER TABLE `avaslog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blocks`
--

DROP TABLE IF EXISTS `blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blocks` (
  `username` varchar(20) NOT NULL,
  `blocked` varchar(20) NOT NULL,
  KEY `username` (`username`),
  KEY `blocked` (`blocked`),
  CONSTRAINT `blocks_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`),
  CONSTRAINT `blocks_ibfk_2` FOREIGN KEY (`blocked`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blocks`
--

LOCK TABLES `blocks` WRITE;
/*!40000 ALTER TABLE `blocks` DISABLE KEYS */;
INSERT INTO `blocks` VALUES ('erfanrmz','moujanmrj'),('salehsalehi','hastimir');
/*!40000 ALTER TABLE `blocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `avaId` int NOT NULL,
  `commentcontent` varchar(256) NOT NULL,
  `commenter` varchar(20) NOT NULL,
  `commentId` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`commentId`),
  KEY `commenter` (`commenter`),
  KEY `avaId` (`avaId`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`commenter`) REFERENCES `users` (`username`),
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`avaId`) REFERENCES `avas` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follow`
--

DROP TABLE IF EXISTS `follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follow` (
  `username` varchar(20) NOT NULL,
  `followings` varchar(20) NOT NULL,
  KEY `username` (`username`),
  KEY `followings` (`followings`),
  CONSTRAINT `follow_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`),
  CONSTRAINT `follow_ibfk_2` FOREIGN KEY (`followings`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follow`
--

LOCK TABLES `follow` WRITE;
/*!40000 ALTER TABLE `follow` DISABLE KEYS */;
INSERT INTO `follow` VALUES ('moujanmrj','dayanamov'),('moujanmrj','hastimir'),('hastimir','moujanmrj'),('salehsalehi','moujanmrj');
/*!40000 ALTER TABLE `follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hashtags`
--

DROP TABLE IF EXISTS `hashtags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hashtags` (
  `hashtagContent` char(6) NOT NULL,
  PRIMARY KEY (`hashtagContent`),
  CONSTRAINT `hashtags_chk_1` CHECK ((`hashtagContent` like _utf8mb4'#%'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hashtags`
--

LOCK TABLES `hashtags` WRITE;
/*!40000 ALTER TABLE `hashtags` DISABLE KEYS */;
INSERT INTO `hashtags` VALUES ('#badii'),('#hihih'),('#salam');
/*!40000 ALTER TABLE `hashtags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `username` varchar(20) NOT NULL,
  `avaId` int NOT NULL,
  KEY `username` (`username`),
  KEY `avaId` (`avaId`),
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`),
  CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`avaId`) REFERENCES `avas` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES ('moujanmrj',3),('dayanamov',3),('dayanamov',6),('hastimir',6),('erfanrmz',3),('salehsalehi',1);
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logins`
--

DROP TABLE IF EXISTS `logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logins` (
  `username` varchar(20) NOT NULL,
  `logindate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `username` (`username`),
  CONSTRAINT `logins_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logins`
--

LOCK TABLES `logins` WRITE;
/*!40000 ALTER TABLE `logins` DISABLE KEYS */;
INSERT INTO `logins` VALUES ('moujanmrj','2021-07-12 22:54:32'),('moujanmrj','2021-07-12 22:54:32'),('hastimir','2021-07-12 22:54:32'),('hastimir','2021-07-12 22:54:32'),('dayanamov','2021-07-13 16:55:57'),('salehsalehi','2021-07-13 21:19:23'),('hastimir','2021-07-14 02:16:10'),('salehsalehi','2021-07-14 22:35:35'),('moujanmrj','2021-07-16 19:13:42');
/*!40000 ALTER TABLE `logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `texts`
--

DROP TABLE IF EXISTS `texts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `texts` (
  `textcontent` varchar(256) DEFAULT NULL,
  `sender` varchar(20) NOT NULL,
  `receiver` varchar(20) NOT NULL,
  `sendtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `contenttype` int NOT NULL,
  `avaId` int DEFAULT NULL,
  `ID` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`),
  KEY `avaId` (`avaId`),
  KEY `sender` (`sender`),
  KEY `receiver` (`receiver`),
  CONSTRAINT `texts_ibfk_1` FOREIGN KEY (`avaId`) REFERENCES `avas` (`ID`),
  CONSTRAINT `texts_ibfk_2` FOREIGN KEY (`sender`) REFERENCES `users` (`username`),
  CONSTRAINT `texts_ibfk_3` FOREIGN KEY (`receiver`) REFERENCES `users` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `texts`
--

LOCK TABLES `texts` WRITE;
/*!40000 ALTER TABLE `texts` DISABLE KEYS */;
INSERT INTO `texts` VALUES ('sad','moujanmrj','hastimir','2021-07-13 17:14:21',0,1,1),('hii','moujanmrj','hastimir','2021-07-13 17:14:21',1,NULL,2),('hastiii','dayanamov','hastimir','2021-07-13 17:14:21',1,NULL,3),('salam moujan','salehsalehi','moujanmrj','2021-07-14 01:51:08',1,NULL,4),('sad','hastimir','shayanshayanian','2021-07-14 13:39:32',0,1,5),('salam salam','hastimir','shayanshayanian','2021-07-14 14:00:39',1,NULL,7),('hii','moujanmrj','hastimir','2021-07-16 19:32:40',1,NULL,9),('hi','moujanmrj','dayanamov','2021-07-16 19:36:16',1,NULL,10),('hello','moujanmrj','dayanamov','2021-07-16 19:36:59',0,2,11);
/*!40000 ALTER TABLE `texts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `firstname` varchar(20) NOT NULL,
  `lastname` varchar(20) NOT NULL,
  `username` varchar(20) NOT NULL,
  `userpassword` varchar(128) NOT NULL,
  `birthdate` date DEFAULT NULL,
  `registerdate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `biography` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('ali','aliani','alialiani','7f6f01a930d576dccfdbe51b86f6cd832fcd9b862bb4852fde984bf1a8e63409','2000-11-11','2021-07-13 20:55:26','alie'),('dayana','movaseghi','dayanamov','36bbe50ed96841d10443bcb670d6554f0a34b761be67ec9c4a8ad2c0c44ca42c','2002-08-31','2021-07-12 22:52:19','DAYANA'),('erfan','ramezani','erfanrmz','1dfa4091c79093d1a0be4ce2275a4013aca41a12eccc961c1eaebca01130b0e2','2000-06-15','2021-07-12 22:52:19','ERFAN'),('hasti','mirshams','hastimir','0266720d1e6117f455ed51fc0e9d2d91f90b37dbfa3b30e8356771c9a9b41731','2000-12-09','2021-07-12 22:52:19','HASTI'),('moujan','mirjalili','moujanmrj','5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5','2000-11-16','2021-07-12 22:52:19','MOUJAN'),('saleh','salehi','salehsalehi','a67f71e8bf5a00af2da77e22428714ab34378916ac6accc18d48b4346c31ef85','2000-11-11','2021-07-13 21:10:36','saleham'),('shayan','shayanian','shayanshayanian','7d6600164cd8995c153a2cb56d9a323b3e66d0dc8351446e12909bd2ec8d1428','2002-11-11','2021-07-14 13:18:19','salam salam');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `users_log` AFTER INSERT ON `users` FOR EACH ROW insert into userslog (username, registerdate) values ((select username from users order by registerdate desc limit 1), now()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `userslog`
--

DROP TABLE IF EXISTS `userslog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userslog` (
  `username` varchar(20) NOT NULL,
  `registerdate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userslog`
--

LOCK TABLES `userslog` WRITE;
/*!40000 ALTER TABLE `userslog` DISABLE KEYS */;
INSERT INTO `userslog` VALUES ('alialiani','2021-07-13 20:55:26'),('salehsalehi','2021-07-13 21:10:36'),('shayanshayanian','2021-07-14 13:18:19');
/*!40000 ALTER TABLE `userslog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'canary'
--

--
-- Dumping routines for database 'canary'
--
/*!50003 DROP PROCEDURE IF EXISTS `blocking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `blocking`(
	theblocked varchar(20)
)
BEGIN
	declare lastlogin varchar(20);
    select username into lastlogin from logins order by logindate desc limit 1;

	insert into blocks (username, blocked)
	select lastlogin , theblocked
		where (exists(select lastlogin from users)) and (lastlogin != theblocked)
		and (theblocked not in(select blocked from blocks where username = lastlogin));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `commenting` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `commenting`(
	in avacontent varchar(256),
    in theID int
)
`commentingscope`:
BEGIN
    -- set @lastlogin = (select username from logins order by logindate desc limit 1);
    declare lastlogin varchar(20);
	select username into lastlogin from logins order by logindate desc limit 1;	
    
    if lastlogin not in (select blocked from blocks where username in (select username from avas where ID = theID))
	then
		insert into avas (avacontent, username, postagedate, iscomment) 
		values (avacontent, lastlogin, now(), theID);
        select 'commented successfully' as `status`;
	else
		select 'Ava sender of this ava has blocked you' as `status`;
		leave commentingscope;
	end if;
    
	set @maxavaid = (select max(ID) from avas);
    if (theID > @maxavaid or theID < 0)
    then
        select 'Wrong ava id' as `status`;
        LEAVE commentingscope;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `count_likes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `count_likes`(
	in theID int
)
`countlikesscope`:
BEGIN
	declare lastlogin varchar(20);
	select username into lastlogin from logins order by logindate desc limit 1;	

	select coalesce(count(avaId),0) as likes
	from likes inner join avas on likes.avaId=avas.ID
		where lastlogin not in (select blocked from blocks where username = avas.username) and avas.ID = theID;
        
	set @maxavaid = (select max(ID) from avas);
    if (theID > @maxavaid or theID < 0)
    then
        select 'Wrong ava id' as `status`;
        LEAVE countlikesscope;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_users` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_users`(
	in firstname varchar(20),
    in lastname varchar(20),
    in username varchar(20),
    in userpassword varchar(128),
	in birthdate date,
    in biography varchar(64)
)
BEGIN
	insert into users(firstname, lastname, username, userpassword, birthdate, registerdate, biography)
	value(firstname, lastname, username, sha2(userpassword,256), birthdate, now(), biography);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fetch_avas_comments` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetch_avas_comments`(
	in theID int
)
`fetchavascommentsscope`:
BEGIN
	declare lastlogin varchar(20);
	select username into lastlogin from logins order by logindate desc limit 1;	
	
	select username, avacontent, postagedate 
    from avas
	where (iscomment =  theID and lastlogin not in (select blocked from blocks where username in (select username from avas where ID = theID)));
    
    set @maxavaid = (select max(ID) from avas);
    if (theID > @maxavaid or theID < 0)
    then
        select 'Wrong ava id' as `status`;
        LEAVE fetchavascommentsscope;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fetch_avas_of_hastag` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetch_avas_of_hastag`(
	thehashtagContent char(6)
)
BEGIN
	declare lastlogin varchar(20);
	select username into lastlogin from logins order by logindate desc limit 1;

	select avacontent, username, postagedate
	from avas inner join avashashtags on avas.ID=avashashtags.avaId
    where hashtagContent = thehashtagContent and username not in (select username from blocks where blocked = lastlogin)
	order by postagedate desc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fetch_followings_activity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetch_followings_activity`(
		
)
BEGIN
	declare lastlogin varchar(20);
    select username into lastlogin from logins order by logindate desc limit 1;

	select username, avacontent, postagedate 
	from avas
	where 
		(username in(select followings from follow where follow.username = lastlogin) and username not in(select username from blocks where blocks.blocked = lastlogin))
	order by 
		postagedate desc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fetch_list_of_all_text_senders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetch_list_of_all_text_senders`(
	
)
BEGIN
	declare lastlogin varchar(20);
	select username into lastlogin from logins order by logindate desc limit 1;
    
	select sender, textcontent, sendtime
	from texts 
    where receiver = lastlogin
    order by sendtime desc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fetch_list_of_an_ava_likers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetch_list_of_an_ava_likers`(
	in theID int
)
`fetchlistofanavalikersscope`:
BEGIN
	declare lastlogin varchar(20);
	select username into lastlogin from logins order by logindate desc limit 1;	

	select username from (select likes.username from avas inner join likes on likes.avaId = avas.ID 
	where avas.ID = theID and avas.username not in (select username from blocks where blocked = lastlogin)) as liker
	where liker.username not in (select username from blocks where blocked = lastlogin);

	set @maxavaid = (select max(ID) from avas);
    if (theID > @maxavaid or theID < 0)
    then
        select 'Wrong ava id' as `status`;
        LEAVE fetchlistofanavalikersscope;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fetch_list_of_received_texts_from_a_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetch_list_of_received_texts_from_a_user`(
	in theusername varchar(20)
)
BEGIN
	declare lastlogin varchar(20);
	select username into lastlogin from logins order by logindate desc limit 1;
	
    select textcontent, sendtime
	from texts where(sender = theusername and receiver = lastlogin)
    order by sendtime desc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fetch_trending_avas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetch_trending_avas`()
BEGIN
	declare lastlogin varchar(20);
	select username into lastlogin from logins order by logindate desc limit 1;	
	
    select avacontent, count(likes.avaId) 
	from likes inner join avas on likes.avaId=avas.ID 
	where lastlogin not in (select blocked from blocks where username = avas.username)
	group by likes.avaId order by count(likes.avaId) desc; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fetch_users_activity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetch_users_activity`(
	in theusername varchar(20)
)
BEGIN
	declare lastlogin varchar(20);
    select username into lastlogin from logins order by logindate desc limit 1;
    
	select username, avacontent, postagedate 
	from avas
	where 
		(username = theusername and username not in(select username from blocks where blocks.blocked = lastlogin))
	order by 
		postagedate desc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `followings` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `followings`(
    in thefollowings varchar(20)
)
BEGIN
	declare lastlogin varchar(20);
    select username into lastlogin from logins order by logindate desc limit 1;
	
    insert into follow (username, followings)
	select lastlogin, thefollowings
		where (exists(select lastlogin from users)) and (lastlogin != thefollowings)
        and (thefollowings not in(select followings from follow where username = lastlogin));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `liking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `liking`(
	in theID int
)
`likingscope`:
BEGIN
	declare lastlogin varchar(20);
	select username into lastlogin from logins order by logindate desc limit 1;	
	 
    if lastlogin not in (select blocked from blocks where username in (select username from avas where ID = theID)) 
    and lastlogin not in(select username from likes where avaId = avaId)
	then
		insert into likes (username, avaId) 
		values (lastlogin, theID);
        select 'liked successfully' as `status`;
	else
		select 'liking failed' as `status`;
		leave likingscope;
	end if;
    set @maxavaid = (select max(ID) from avas);
    if (theID > @maxavaid or theID < 0)
    then
        select 'Wrong ava id' as `status`;
        LEAVE likingscope;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `list_user_logins` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_user_logins`(
	in theusername varchar(20)
)
BEGIN
	select 
		username, logindate
	from
		logins
	where 
		username = theusername
	order by 
		logindate desc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `receive_personal_avas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `receive_personal_avas`(

)
BEGIN
	declare lastlogin varchar(20);
	select username into lastlogin from logins order by logindate desc limit 1;	
    
	select avacontent
	from avas
	where username = lastlogin;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `send_avas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `send_avas`(
	in avacontent varchar(256)
)
BEGIN
	insert into avas(username, avacontent, postagedate, iscomment)
    values ((select username from logins order by logindate desc limit 1), avacontent , now(), null);  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `send_ava_message` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `send_ava_message`(
    in receiver varchar(20),
    in theID int
)
`sendtextscope`:
BEGIN
	declare rows1 int; 
	declare rows2 int;
    declare lastlogin varchar(20);
	select count(ID) into rows1 from texts; 
	select username into lastlogin from logins order by logindate desc limit 1;
    
	insert into texts (	sender, receiver, avaId, sendtime, contenttype, textcontent)
	select lastlogin, receiver, theID, now(), 0, (select avacontent from avas where ID = theID) from avas as tmp 
	where  tmp.ID = theID and receiver not in(select blk.blocked from blocks as blk where tmp.username = blk.username)
	and not exists(select * from blocks as blk where (blk.username = lastlogin and blk.blocked = receiver) 
	or (blk.username = receiver and blk.blocked = lastlogin));
    
    set @maxavaid = (select max(ID) from avas);
    if (theID > @maxavaid or theID < 0)
    then
        select 'Wrong ava id' as `status`;
        LEAVE sendtextscope;
	end if;
    
    select count(ID) into rows2 from texts; 
		if rows1 = rows2
		then 
			select 'texting failed' as `status`;
		else 
			select 'texed successfully' as `status`;
			leave sendtextscope;
		end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `send_text` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `send_text`(
	in textcontent varchar(256),
    in receiver varchar(20),
    in contenttype int,
    in theID int
)
`sendtextscope`:
BEGIN
    declare lastlogin varchar(20);
	select username into lastlogin from logins order by logindate desc limit 1;
    
    if (contenttype = 0)
    then
		insert into texts (	sender, receiver, avaId, sendtime, contenttype, textcontent)
		select lastlogin, receiver, theID, now(), 0, (select avacontent from avas where ID = theID) from avas as tmp 
		where  tmp.ID = theID and receiver not in(select blk.blocked from blocks as blk where tmp.username = blk.username)
		and not exists(select * from blocks as blk where (blk.username = lastlogin and blk.blocked = receiver) 
        or (blk.username = receiver and blk.blocked = lastlogin));
	else
		insert into texts (	sender, receiver, avaId, sendtime, contenttype, textcontent)
		select lastlogin, receiver, null, now(), 1, textcontent
		where not exists(select * from blocks as blk where (blk.username = lastlogin and blk.blocked = receiver) 
        or (blk.username = receiver and blk.blocked = lastlogin));
    end if;
    
    set @maxavaid = (select max(ID) from avas);
    if (theID > @maxavaid or theID < 0)
    then
        select 'Wrong ava id' as `status`;
        LEAVE sendtextscope;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `send_text_message` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `send_text_message`(
	in receiver varchar(20),
    in textcontent varchar(256)
)
`sendtextscope`:
BEGIN
		declare lastlogin varchar(20);
		declare rows1 int; 
		declare rows2 int;
        select username into lastlogin from logins order by logindate desc limit 1;
		select count(ID) into rows1 from texts; 
	
		insert into texts (	sender, receiver, avaId, sendtime, contenttype, textcontent)
		select lastlogin, receiver, null, now(), 1, textcontent
		where not exists(select * from blocks as blk where (blk.username = lastlogin and blk.blocked = receiver) 
        or (blk.username = receiver and blk.blocked = lastlogin));
        
  
		select count(ID) into rows2 from texts; 
		if rows1 = rows2
		then 
			select 'texting failed' as `status`;
		else 
			select 'texed successfully' as `status`;
			leave sendtextscope;
		end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stop_blocking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `stop_blocking`(
	theblocked varchar(20)
)
BEGIN
	declare lastlogin varchar(20);
    select username into lastlogin from logins order by logindate desc limit 1;

	delete from blocks 
	where username = lastlogin and blocked = theblocked;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stop_following` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `stop_following`(
	in thefollowings varchar(20)
)
BEGIN
	declare lastlogin varchar(20);
    select username into lastlogin from logins order by logindate desc limit 1;
    
	delete from follow 
	where username = lastlogin and followings = thefollowings;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_logins` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_logins`(
	in username varchar(20),
    in userpassword varchar(128)
)
`scope`:
BEGIN
	declare rows1 int; 
	declare rows2 int; 
    select count(username) into rows1 from logins; 
	insert into logins (username, logindate)
	select username, now() from users where users.userpassword = sha2(userpassword, 256);
    select count(username) into rows2 from logins; 
    if rows1 = rows2
    then 
		select 'login failed' as `status`;
	else 
		select 'loged in successfully' as `status`;
        leave scope;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-07-16 19:41:04
