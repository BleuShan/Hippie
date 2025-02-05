-- MySQL dump 10.13  Distrib 5.7.9, for osx10.9 (x86_64)
--
-- Host: localhost    Database: yolaine_hipdev
-- ------------------------------------------------------
-- Server version	5.5.44-MariaDB-cll-lve

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
-- Table structure for table `adresse`
--

DROP TABLE IF EXISTS `adresse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adresse` (
  `adresse_id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'Numéro unique pour chaque adresse.',
  `no_civique` varchar(10) DEFAULT NULL COMMENT 'Numéro civique pour chaque adresse.',
  `type_rue` int(10) DEFAULT NULL COMMENT 'Nombre correspondant au type_rue de la table type_rue.',
  `nom` varchar(30) DEFAULT NULL COMMENT 'Nom de la localisation complétant type_rue.',
  `app` varchar(10) DEFAULT NULL COMMENT 'Numéro d''appartiement pour la localisation.',
  `ville` varchar(50) DEFAULT NULL COMMENT 'Nom de la ville.',
  `province` varchar(25) DEFAULT NULL COMMENT 'Nom de la province.',
  `code_postal` varchar(6) DEFAULT NULL,
  `pays` varchar(30) DEFAULT NULL COMMENT 'Pays où se situe l''adresse.',
  PRIMARY KEY (`adresse_id`),
  UNIQUE KEY `adresse_id_UNIQUE` (`adresse_id`),
  KEY `fk_type_rue$adresse` (`type_rue`),
  CONSTRAINT `fk_type_rue$adresse` FOREIGN KEY (`type_rue`) REFERENCES `type_rue` (`type_rue_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='Table permettant d''identifier l''adresse du donneur ou de l''organisme.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adresse`
--

LOCK TABLES `adresse` WRITE;
/*!40000 ALTER TABLE `adresse` DISABLE KEYS */;
INSERT INTO `adresse` (`adresse_id`, `no_civique`, `type_rue`, `nom`, `app`, `ville`, `province`, `code_postal`, `pays`) VALUES (19,'2193',1,'avenue Saint-Marc',NULL,'Shawinigan','Qc','G9N2J4','Canada'),(20,'2',2,'Promenade_2',NULL,'Shawinigan','Qc','XXXXXX','Canada'),(21,'3',3,'Montee 9',NULL,'Shawinigan','Qc','XXXXXX','Canada'),(22,'4',4,'Place 4',NULL,'Shawinigan','Qc','XXXXXX','Canada'),(23,'5',5,'Rang 5',NULL,'Shawinigan','Qc','XXXXXX','Canada'),(24,'6',6,'Route 6',NULL,'Shawinigan','Qc','XXXXXX','Canada'),(25,'7',7,'Avenue 7',NULL,'Shawinigan','Qc','XXXXXX','Canada'),(26,'8',2,'Boulevard 8',NULL,'Shawinigan','Qc','XXXXXX','Canada');
/*!40000 ALTER TABLE `adresse` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-01-13 11:28:25
