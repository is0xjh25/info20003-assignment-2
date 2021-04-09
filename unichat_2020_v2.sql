/* If you are running this script on your local host, uncomment the next 3 lines. */
-- drop database if exists unichat;
-- create database unichat /*!40100 DEFAULT CHARACTER SET utf8 */;
-- use unichat;

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
-- Table structure for table `forum`
--

DROP TABLE IF EXISTS `forum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum` (
  `Id` int(11) NOT NULL,
  `Topic` varchar(100),
  `WhenCreated` timestamp,
  `CreatedBy` int(11),
  `WhenClosed` timestamp NULL DEFAULT NULL,
  `ClosedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_Forum_Moderator1_idx` (`CreatedBy`),
  KEY `fk_Forum_Moderator2_idx` (`ClosedBy`),
  CONSTRAINT `fk_Forum_Moderator1` FOREIGN KEY (`CreatedBy`) REFERENCES `lecturer` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Forum_Moderator2` FOREIGN KEY (`ClosedBy`) REFERENCES `lecturer` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum`
--

LOCK TABLES `forum` WRITE;
/*!40000 ALTER TABLE `forum` DISABLE KEYS */;
INSERT INTO `forum` VALUES (1,'Farewell to class of 2017','2017-10-29 22:30:00',5,'2019-12-31 06:00:00',5),(2,'Welcome to class of 2018','2018-01-28 22:00:00',4,NULL,NULL),(3,'About the campus','2018-01-31 22:00:00',5,NULL,NULL),(4,'Buy and sell textbooks','2018-02-14 02:30:00',5,NULL,NULL),(5,'Interesting science facts','2018-03-03 05:45:00',4,NULL,NULL);
/*!40000 ALTER TABLE `forum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friendof`
--

DROP TABLE IF EXISTS `friendof`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friendof` (
  `Student1` int(11) NOT NULL,
  `Student2` int(11) NOT NULL,
  `WhenRequested` timestamp,
  `WhenRejected` timestamp NULL DEFAULT NULL,
  `WhenConfirmed` timestamp NULL DEFAULT NULL,
  `WhenUnfriended` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Student1`,`Student2`),
  KEY `fk_Friendof_EndUser2_idx` (`Student2`),
  CONSTRAINT `fk_Friendof_EndUser1` FOREIGN KEY (`Student1`) REFERENCES `student` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Friendof_EndUser2` FOREIGN KEY (`Student2`) REFERENCES `student` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friendof`
--

LOCK TABLES `friendof` WRITE;
/*!40000 ALTER TABLE `friendof` DISABLE KEYS */;
INSERT INTO `friendof` VALUES (2,6,'2018-03-08 13:00:00',NULL,'2018-12-28 13:00:00','2019-01-06 13:00:00'),(2,8,'2018-05-23 14:00:00',NULL,'2018-08-11 14:00:00',NULL),(2,3,'2018-02-07 13:00:00','2018-07-17 14:00:00',NULL,NULL),(3,7,'2018-01-04 13:00:00',NULL,'2018-08-13 14:00:00',NULL),(3,8,'2018-01-29 13:00:00',NULL,'2018-07-08 14:00:00','2019-01-31 13:00:00'),(6,8,'2018-03-17 13:00:00',NULL,'2018-09-01 14:00:00',NULL),(2,7,'2018-04-30 14:00:00','2018-11-06 13:00:00',NULL,NULL),(6,7,'2018-03-02 13:00:00',NULL,'2018-08-09 14:00:00',NULL),(7,8,'2018-04-23 14:00:00',NULL,'2018-07-01 14:00:00',NULL),(2,10,'2018-02-09 13:00:00',NULL,'2018-09-21 14:00:00',NULL),(3,10,'2018-02-09 13:00:00',NULL,NULL,NULL),(4,10,'2018-02-09 14:00:00',NULL,NULL,NULL);
/*!40000 ALTER TABLE `friendof` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lecturer`
--

DROP TABLE IF EXISTS `lecturer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lecturer` (
  `Id` int(11) NOT NULL,
  `Phone` char(12) NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Moderator_User1` FOREIGN KEY (`Id`) REFERENCES `user` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lecturer`
--

LOCK TABLES `lecturer` WRITE;
/*!40000 ALTER TABLE `lecturer` DISABLE KEYS */;
INSERT INTO `lecturer` VALUES (4,'83441234'),(5,'83444321'),(9,'83444000');
/*!40000 ALTER TABLE `lecturer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likepost`
--

DROP TABLE IF EXISTS `likepost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likepost` (
  `Post` int(11) NOT NULL,
  `User` int(11) NOT NULL,
  `WhenLiked` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Post`,`User`),
  KEY `fk_LikePost_Post1_idx` (`Post`),
  KEY `fk_LikePost_User1_idx` (`User`),
  CONSTRAINT `fk_LikePost_Post1` FOREIGN KEY (`Post`) REFERENCES `post` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_LikePost_User1` FOREIGN KEY (`User`) REFERENCES `user` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likepost`
--

LOCK TABLES `likepost` WRITE;
/*!40000 ALTER TABLE `likepost` DISABLE KEYS */;
INSERT INTO `likepost` VALUES (1,4,'2019-01-30 13:00:00'),(1,5,'2019-03-29 13:00:00'),(1,9,'2019-07-22 14:00:00'),(2,2,'2019-04-02 13:00:00'),(2,9,'2019-03-18 13:00:00'),(3,1,'2019-07-12 14:00:00'),(3,2,'2019-11-03 13:00:00'),(3,8,'2019-08-21 14:00:00'),(3,10,'2019-01-30 13:00:00'),(4,5,'2019-06-19 14:00:00'),(4,7,'2019-05-08 14:00:00'),(5,3,'2019-07-04 14:00:00'),(7,1,'2019-05-10 14:00:00'),(7,4,'2019-11-21 13:00:00'),(7,6,'2019-12-29 13:00:00'),(10,6,'2019-10-28 13:00:00'),(12,6,'2019-09-04 14:00:00'),(15,6,'2019-05-26 14:00:00'),(17,5,'2019-08-10 14:00:00'),(21,5,'2019-08-13 14:00:00'),(23,6,'2019-05-12 14:00:00'),(25,6,'2019-06-10 14:00:00'),(26,3,'2019-03-24 13:00:00'),(30,1,'2019-04-25 14:00:00'),(32,5,'2019-05-11 14:00:00'),(32,7,'2019-01-27 13:00:00'),(38,4,'2019-03-27 13:00:00'),(39,9,'2019-05-28 14:00:00'),(39,10,'2019-09-30 14:00:00'),(41,10,'2019-07-29 14:00:00'),(44,1,'2019-01-25 13:00:00'),(46,4,'2019-03-29 13:00:00'),(47,6,'2019-01-04 13:00:00'),(49,1,'2019-08-07 14:00:00'),(54,10,'2019-07-24 14:00:00'),(55,7,'2019-08-31 14:00:00'),(58,5,'2019-08-21 14:00:00'),(59,10,'2019-11-28 13:00:00'),(60,7,'2019-12-24 13:00:00'),(63,1,'2019-10-28 13:00:00'),(63,5,'2019-06-04 14:00:00'),(64,6,'2019-02-07 13:00:00'),(64,7,'2019-12-07 13:00:00'),(67,7,'2019-07-20 14:00:00'),(71,8,'2019-05-24 14:00:00'),(72,4,'2019-07-20 14:00:00'),(75,8,'2019-11-19 13:00:00'),(77,9,'2019-07-18 14:00:00'),(78,8,'2019-04-01 13:00:00'),(80,6,'2019-06-02 14:00:00');
/*!40000 ALTER TABLE `likepost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `PostedBy` int(11) NOT NULL,
  `Forum` int(11) DEFAULT NULL,
  `Content` text NOT NULL,
  `ParentPost` int(11) DEFAULT NULL,
  `WhenPosted` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  KEY `fk_Post_Forum1_idx` (`Forum`),
  KEY `fk_Post_User1_idx` (`PostedBy`),
  KEY `fk_Post_Forum2_idx` (`ParentPost`),
  CONSTRAINT `fk_Post_Forum1` FOREIGN KEY (`Forum`) REFERENCES `forum` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Post_Forum2` FOREIGN KEY (`ParentPost`) REFERENCES `post` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Post_User1` FOREIGN KEY (`PostedBy`) REFERENCES `user` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,4,NULL,'April is the cruellest month, breeding',4,'2019-06-04 01:00:00' ),(2,4,3,'Lilacs out of the dead land, mixing',NULL,'2019-03-11 00:00:00' ),(3,3,NULL,'Memory and desire, stirring',17,'2018-11-04 00:00:00' ),(4,3,NULL,'Dull roots with spring rain.',68,'2019-06-03 02:00:00' ),(5,3,NULL,'Winter kept us warm, covering',38,'2018-05-01 00:00:00' ),(6,3,NULL,'Earth in forgetful snow, feeding',75,'2019-06-05 00:00:00' ),(7,3,NULL,'A little life with dried tubers.',6,'2019-06-07 00:00:00' ),(8,5,NULL,'Summer surprised us, coming over the Starnbergersee',76,'2019-07-20 00:00:00' ),(9,5,NULL,'With a shower of rain; we stopped in the colonnade,',21,'2019-02-19 00:00:00' ),(10,4,3,'And went on in sunlight, into the Hofgarten,',NULL,'2019-07-21 00:00:00' ),(11,4,1,'And drank coffee, and talked for an hour.',NULL,'2018-12-07 00:00:00' ),(12,6,NULL,'Bin gar keine Russin, stamm\' aus Litauen, echt deutsch.',70,'2019-06-25 00:00:00' ),(13,5,NULL,'And when we were children, staying at the arch-duke\'s,',3,'2019-03-17 00:00:00' ),(14,4,NULL,'My cousin\'s, he took me out on a sled,',49,'2019-08-03 01:00:00' ),(15,4,5,'And I was frightened. He said, Marie,',NULL,'2019-07-04 00:00:00' ),(16,4,NULL,'Marie, hold on tight. And down we went.',94,'2019-03-10 00:00:00' ),(17,4,NULL,'In the mountains, there you feel free.',91,'2018-03-04 00:00:00' ),(18,5,3,'I read, much of the night, and go south in the winter.',NULL,'2019-08-17 00:00:00' ),(19,5,NULL,'What are the roots that clutch, what branches grow',24,'2019-06-02 00:00:00' ),(20,4,NULL,'Out of this stony rubbish\' Son of man,',28,'2019-05-13 00:00:00' ),(21,4,NULL,'You cannot say, or guess, for you know only',37,'2019-02-18 00:00:00' ),(22,5,5,'A heap of broken images, where the sun beats,',NULL,'2019-06-24 00:00:00' ),(23,6,5,'And the dead tree gives no shelter, the cricket no relief,',NULL,'2018-07-11 01:00:00' ),(24,4,NULL,'And the dry stone no sound of water. Only',83,'2019-06-01 00:00:00' ),(25,4,4,'There is shadow under this red rock,',NULL,'2019-07-01 01:00:00' ),(26,4,3,'(Come in under the shadow of this red rock),',NULL,'2019-07-30 00:00:00' ),(27,5,3,'And I will show you something different from either',NULL,'2019-03-22 00:00:00' ),(28,4,4,'Your shadow at morning striding behind you',NULL,'2019-04-29 00:00:00' ),(29,5,NULL,'Or your shadow at evening rising to meet you;',56,'2019-03-26 00:00:00' ),(30,4,1,'I will show you fear in a handful of dust.',NULL,'2018-12-25 00:00:00' ),(31,2,2,'Frisch weht der Wind',NULL,'2019-06-10 00:00:00' ),(32,1,2,'Der Heimat zu',NULL,'2018-02-19 00:00:00' ),(33,2,NULL,'Mein Irisch Kind,',20,'2019-06-18 00:00:00' ),(34,1,NULL,'Wo weilest du?',51,'2019-04-20 00:00:00' ),(35,4,NULL,'\"You gave me hyacinths first a year ago;',71,'2018-11-04 00:00:00' ),(36,4,1,'\"They called me the hyacinth girl.\"',NULL,'2018-12-19 00:00:00' ),(37,6,NULL,'Yet when we came back, late, from the Hyacinth garden,',83,'2019-02-17 00:00:00' ),(38,5,3,'Your arms full, and your hair wet, I could not',NULL,'2018-04-01 00:00:00' ),(39,4,3,'Speak, and my eyes failed, I was neither',NULL,'2019-05-02 00:00:00' ),(40,4,NULL,'Living nor dead, and I knew nothing,',75,'2018-10-06 00:00:00' ),(41,5,1,'Looking into the heart of light, the silence.',NULL,'2018-12-09 00:00:00' ),(42,2,4,'Oed\' und leer das Meer.',NULL,'2019-05-06 01:00:00' ),(43,4,NULL,'Madame Sosostris, famous clairvoyante,',98,'2018-11-09 00:00:00' ),(44,3,NULL,'Had a bad cold, nevertheless',100,'2019-04-15 00:00:00' ),(45,4,1,'Is known to be the wisest woman in Europe,',NULL,'2018-06-09 00:00:00' ),(46,4,1,'With a wicked pack of cards. Here, said she,',NULL,'2018-07-01 00:00:00' ),(47,4,1,'Is your card, the drowned Phoenician Sailor,',NULL,'2018-12-16 00:00:00' ),(48,4,1,'(Those are pearls that were his eyes. Look!)',NULL,'2018-11-21 00:00:00' ),(49,4,NULL,'Here is Belladonna, the Lady of the Rocks,',25,'2019-07-03 01:00:00' ),(50,2,4,'The lady of situations.',NULL,'2019-06-21 00:00:00' ),(51,5,NULL,'Here is the man with three staves, and here the Wheel,',32,'2018-02-20 00:00:00' ),(52,5,NULL,'And here is the one-eyed merchant, and this card,',78,'2019-06-12 00:00:00' ),(53,5,3,'Which is blank, is something he carries on his back,',NULL,'2019-07-16 00:00:00' ),(54,4,NULL,'Which I am forbidden to see. I do not find',90,'2018-11-11 00:00:00' ),(55,4,NULL,'The Hanged Man. Fear death by water.',4,'2019-11-28 00:00:00' ),(56,5,NULL,'I see crowds of people, walking round in a ring.',98,'2019-02-10 00:00:00' ),(57,4,NULL,'Thank you. If you see dear Mrs. Equitone,',40,'2019-08-23 01:00:00' ),(58,4,2,'Tell her I bring the horoscope myself:',NULL,'2019-06-20 00:00:00' ),(59,3,NULL,'One must be so careful these days.',5,'2019-04-17 00:00:00' ),(60,1,NULL,'Unreal City,',42,'2019-07-19 00:00:00' ),(61,4,4,'Under the brown fog of a winter dawn,',NULL,'2018-06-18 00:00:00' ),(62,4,NULL,'A crowd flowed over London Bridge, so many,',90,'2019-03-28 00:00:00' ),(63,4,5,'I had not thought death had undone so many.',NULL,'2019-07-19 01:00:00' ),(64,4,NULL,'Sighs, short and infrequent, were exhaled,',97,'2018-12-22 00:00:00' ),(65,4,5,'And each man fixed his eyes before his feet.',NULL,'2019-06-25 00:00:00' ),(66,5,NULL,'Flowed up the hill and down King William Street,',5,'2018-05-02 00:00:00' ),(67,4,NULL,'To where Saint Mary Woolnoth kept the hours',45,'2018-07-12 00:00:00' ),(68,5,NULL,'With a dead sound on the final stroke of nine.',24,'2019-06-02 03:00:00' ),(69,6,NULL,'There I saw one I knew, and stopped him, crying: \"Stetson!',71,'2019-04-10 00:00:00' ),(70,4,NULL,'You who were with me in the ships at Mylae!',27,'2019-06-16 00:00:00' ),(71,4,NULL,'That corpse you planted last year in your garden,',23,'2018-07-13 02:00:00'), (72,5,NULL,'Has it begun to sprout? Will it bloom this year?',67,'2018-12-31 00:00:00' ),(73,4,NULL,'Or has the sudden frost disturbed its bed?',66,'2018-12-02 00:00:00' ),(74,5,NULL,'Oh keep the Dog far hence, that\'s friend to men,',45,'2019-02-28 00:00:00' ),(75,4,NULL,'Or with his nails he\'ll dig it up again!',51,'2018-03-20 00:00:00' ),(76,5,NULL,'You! hypocrite lecteur! - mon semblable, - mon frere!\"',90,'2019-07-18 00:00:00' ),(77,5,1,'The Chair she sat in, like a burnished throne,',NULL,'2018-11-18 00:00:00' ),(78,4,NULL,'Glowed on the marble, where the glass',13,'2019-03-20 00:00:00' ),(79,5,2,'Held up by standards wrought with fruited vines',NULL,'2019-03-24 00:00:00' ),(80,4,NULL,'From which a golden Cupidon peeped out',1,'2019-06-25 00:00:00' ),(81,4,NULL,'(Another hid his eyes behind his wing)',61,'2018-11-03 00:00:00' ),(82,5,NULL,'Doubled the flames of sevenbranched candelabra',86,'2019-03-08 00:00:00' ),(83,3,NULL,'Reflecting light upon the table as',89,'2019-02-16 00:00:00' ),(84,4,5,'The glitter of her jewels rose to meet it,',NULL,'2019-08-16 01:00:00' ),(85,4,NULL,'From satin cases poured in rich profusion;',58,'2019-09-06 00:00:00' ),(86,4,NULL,'In vials of ivory and coloured glass',40,'2018-11-04 00:00:00' ),(87,5,1,'Unstoppered, lurked her strange synthetic perfumes,',NULL,'2018-12-02 00:00:00' ),(88,5,NULL,'Unguent, powdered, or liquid - troubled, confused',59,'2019-08-20 00:00:00' ),(89,5,2,'And drowned the sense in odours; stirred by the air',NULL,'2019-02-15 00:00:00' ),(90,5,NULL,'That freshened from the window, these ascended',92,'2018-07-03 00:00:00' ),(91,4,4,'In fattening the prolonged candle-flames,',NULL,'2018-02-24 00:00:00' ),(92,4,NULL,'Flung their smoke into the laquearia,',46,'2018-07-02 01:00:00' ),(93,5,NULL,'Stirring the pattern on the coffered ceiling.',27,'2019-06-28 00:00:00' ),(94,3,NULL,'Huge sea-wood fed with copper',74,'2019-03-02 00:00:00' ),(95,5,NULL,'Burned green and orange, framed by the coloured stone,',61,'2019-08-06 00:00:00' ),(96,4,1,'In which sad light a carved dolphin swam.',NULL,'2018-12-27 00:00:00' ),(97,4,NULL,'Above the antique mantel was displayed',66,'2018-12-15 00:00:00' ),(98,5,2,'As though a window gave upon the sylvan scene',NULL,'2018-05-07 00:00:00' ),(99,5,NULL,'The change of Philomel, by the barbarous king',78,'2019-03-23 00:00:00' ),(100,4,NULL,'So rudely forced; yet there the nightingale',91,'2019-03-30 01:00:00' ),(101,4,NULL,'Also That corpse you planted last year in your garden,',31,'2019-06-10 01:00:00');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `Id` int(11) NOT NULL,
  `Degree` char(10) DEFAULT NULL,
  `Karma` int(11),
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_EndUser_User1` FOREIGN KEY (`Id`) REFERENCES `user` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,'MIT',7),(2,'MIT',15),(3,'BSc',4),(6,'PhD',12),(7,'BSc',22),(8,'BSc',3),(10,'MIT',4);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Usertype` char(1) NOT NULL,
  `Username` char(20) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `Firstname` varchar(45) DEFAULT NULL,
  `Lastname` varchar(45) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Username_UNIQUE` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'S','aa','passaa','Alan','Aardvark'),(2,'S','bb','passbb','Betty','Bear'),(3,'S','cc','passcc','Christopher','Cat'),(4,'L','einstein','passai','Albert','Einstein'),(5,'L','curie','passmc','Marie','Curie'),(6,'S','dd','passdd','David','Dolphin'),(7,'S','ee','passee','Eva','Egg'),(8,'S','ff','passff','Fred','Fox'),(9,'L','darwin','passcd','Charles','Darwin'),(10,'S','gg','passgg','Gary','Gull');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-09-09 17:17:29