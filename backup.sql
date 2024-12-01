-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: pdr01
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `eventosmobiliario`
--

DROP TABLE IF EXISTS `eventosmobiliario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eventosmobiliario` (
  `ideventosmobiliario` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int NOT NULL,
  `FechaEvento` datetime NOT NULL,
  `TipoEvento` varchar(20) NOT NULL,
  PRIMARY KEY (`ideventosmobiliario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventosmobiliario`
--

LOCK TABLES `eventosmobiliario` WRITE;
/*!40000 ALTER TABLE `eventosmobiliario` DISABLE KEYS */;
/*!40000 ALTER TABLE `eventosmobiliario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logmobiliario`
--

DROP TABLE IF EXISTS `logmobiliario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logmobiliario` (
  `idLogMobiliario` int NOT NULL AUTO_INCREMENT,
  `idMobiliario` int NOT NULL,
  `idUsuario` int NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `FechaModificacion` date NOT NULL,
  `Accion` varchar(8) NOT NULL,
  `NombreMobiliario` varchar(100) NOT NULL,
  PRIMARY KEY (`idLogMobiliario`),
  KEY `fk_idusuarios_idx` (`Nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logmobiliario`
--

LOCK TABLES `logmobiliario` WRITE;
/*!40000 ALTER TABLE `logmobiliario` DISABLE KEYS */;
/*!40000 ALTER TABLE `logmobiliario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logplantas`
--

DROP TABLE IF EXISTS `logplantas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logplantas` (
  `idLogPlantas` int NOT NULL AUTO_INCREMENT,
  `idplantas` int NOT NULL,
  `idUsuario` int NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `FechaModificacion` date NOT NULL,
  `Accion` varchar(8) NOT NULL,
  `NombrePlanta` varchar(45) NOT NULL,
  PRIMARY KEY (`idLogPlantas`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logplantas`
--

LOCK TABLES `logplantas` WRITE;
/*!40000 ALTER TABLE `logplantas` DISABLE KEYS */;
INSERT INTO `logplantas` VALUES (2,1,3,'Gerardo','2024-11-30','salida','Desconocida'),(3,1,3,'Gerardo','2024-11-30','salida','huisache'),(4,1,3,'Gerardo','2024-11-30','salida','huisache'),(5,1,3,'Gerardo','2024-11-30','salida','Desconocida'),(6,1,3,'Gerardo','2024-11-30','salida','huisache'),(7,1,3,'Gerardo','2024-11-30','salida','huisache');
/*!40000 ALTER TABLE `logplantas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mobiliario`
--

DROP TABLE IF EXISTS `mobiliario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mobiliario` (
  `NoSerieMobiliario` int NOT NULL AUTO_INCREMENT,
  `NoId` varchar(255) NOT NULL,
  `NombreMobiliario` varchar(100) NOT NULL,
  `Costo` decimal(8,2) NOT NULL,
  `FechaAgregacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `EstadoRequerido` varchar(50) DEFAULT 'Funcionando',
  `Cantidad` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`NoSerieMobiliario`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mobiliario`
--

LOCK TABLES `mobiliario` WRITE;
/*!40000 ALTER TABLE `mobiliario` DISABLE KEYS */;
INSERT INTO `mobiliario` VALUES (21,'00001','pala cuadrada',140.00,'2024-11-30 13:12:13','Funcionando','1'),(22,'00001','pala redonda',279.00,'2024-11-30 13:16:35','Funcionando','1'),(23,'00001','trash',145.00,'2024-11-30 16:47:15','Funcionando','1'),(24,'00002','trash',145.00,'2024-11-30 16:47:15','Funcionando','1'),(25,'00003','trash',145.00,'2024-11-30 16:47:15','Funcionando','1'),(26,'00004','trash',145.00,'2024-11-30 16:47:15','Funcionando','1'),(27,'00005','trash',145.00,'2024-11-30 16:47:15','Funcionando','1'),(28,'00011','trash',145.00,'2024-11-30 16:47:15','Funcionando','1'),(29,'00008','trash',145.00,'2024-11-30 16:47:15','Funcionando','1'),(30,'00009','trash',145.00,'2024-11-30 16:47:15','Funcionando','1'),(31,'00007','trash',145.00,'2024-11-30 16:47:15','Funcionando','1'),(32,'00006','trash',145.00,'2024-11-30 16:47:15','Funcionando','1'),(33,'00010','trash',145.00,'2024-11-30 16:47:15','Funcionando','1'),(34,'00012','trash',145.00,'2024-11-30 16:47:15','Funcionando','1'),(35,'00001','Segueta',50.00,'2024-12-01 05:02:11','Funcionando','1');
/*!40000 ALTER TABLE `mobiliario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plantaseventos`
--

DROP TABLE IF EXISTS `plantaseventos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plantaseventos` (
  `idplantaseventos` int NOT NULL AUTO_INCREMENT,
  `NoSeriePlanta` int NOT NULL,
  `idUsuario` int NOT NULL,
  `FechaEvento` datetime NOT NULL,
  `TipoEvento` varchar(20) NOT NULL,
  `NoId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idplantaseventos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plantaseventos`
--

LOCK TABLES `plantaseventos` WRITE;
/*!40000 ALTER TABLE `plantaseventos` DISABLE KEYS */;
/*!40000 ALTER TABLE `plantaseventos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plantasgeneral`
--

DROP TABLE IF EXISTS `plantasgeneral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plantasgeneral` (
  `NoSeriePlanta` int NOT NULL AUTO_INCREMENT,
  `NoId` varchar(255) NOT NULL,
  `NombrePlanta` varchar(100) NOT NULL,
  `FechaAgregacion` datetime NOT NULL,
  `EstadoRequerido` varchar(230) NOT NULL,
  `cantidad` int NOT NULL,
  PRIMARY KEY (`NoSeriePlanta`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plantasgeneral`
--

LOCK TABLES `plantasgeneral` WRITE;
/*!40000 ALTER TABLE `plantasgeneral` DISABLE KEYS */;
INSERT INTO `plantasgeneral` VALUES (25,'00001','huisache','2024-11-26 03:32:19','Plantado',1),(28,'00005','huisache','2024-11-26 03:32:19','Germinando',1),(29,'00002','huisache','2024-11-26 03:32:19','Germinando',1),(30,'00001','peonias','2024-11-26 03:33:57','Plantado',1),(31,'00002','peonias','2024-11-26 03:33:57','Germinando',1),(34,'00005','peonias','2024-11-26 03:33:57','Germinando',1),(35,'00006','peonias','2024-11-26 03:33:57','Germinando',1),(36,'00008','peonias','2024-11-26 03:33:57','Germinando',1),(37,'00009','peonias','2024-11-26 03:33:57','Germinando',1),(38,'00010','peonias','2024-11-26 03:33:57','Germinando',1),(39,'00011','peonias','2024-11-26 03:33:57','Germinando',1),(40,'00012','peonias','2024-11-26 03:33:57','Germinando',1),(41,'00013','peonias','2024-11-26 03:33:57','Germinando',1),(42,'00007','peonias','2024-11-26 03:33:57','Germinando',1),(43,'00001','palo verde','2024-11-30 09:56:12','Germinando',1),(44,'00002','palo verde','2024-11-30 09:56:12','Germinando',1),(45,'00003','palo verde','2024-11-30 09:56:12','Germinando',1),(46,'00004','palo verde','2024-11-30 09:56:12','Germinando',1),(47,'00005','palo verde','2024-11-30 09:56:12','Germinando',1),(48,'00001','mezquite','2024-11-30 22:01:36','Germinando',1),(49,'00003','mezquite','2024-11-30 22:01:36','Germinando',1),(50,'00004','mezquite','2024-11-30 22:01:36','Germinando',1),(51,'00005','mezquite','2024-11-30 22:01:36','Germinando',1),(52,'00006','mezquite','2024-11-30 22:01:36','Germinando',1),(53,'00007','mezquite','2024-11-30 22:01:36','Germinando',1),(54,'00008','mezquite','2024-11-30 22:01:36','Germinando',1),(55,'00009','mezquite','2024-11-30 22:01:36','Germinando',1),(56,'00010','mezquite','2024-11-30 22:01:36','Germinando',1),(57,'00002','mezquite','2024-11-30 22:01:36','Germinando',1);
/*!40000 ALTER TABLE `plantasgeneral` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plantasgerminadas`
--

DROP TABLE IF EXISTS `plantasgerminadas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plantasgerminadas` (
  `idPlantasGerminadas` int NOT NULL AUTO_INCREMENT,
  `NoSeriePlanta` int NOT NULL,
  `NombrePlanta` varchar(45) NOT NULL,
  `FechsGerminacion` varchar(45) NOT NULL,
  `FechaFinalizacion` varchar(45) NOT NULL,
  PRIMARY KEY (`idPlantasGerminadas`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plantasgerminadas`
--

LOCK TABLES `plantasgerminadas` WRITE;
/*!40000 ALTER TABLE `plantasgerminadas` DISABLE KEYS */;
/*!40000 ALTER TABLE `plantasgerminadas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `Usuario` varchar(45) NOT NULL,
  `Cont` varchar(255) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Apellido1` varchar(60) NOT NULL,
  `Apellido2` varchar(60) NOT NULL,
  `FechaCreacion` date NOT NULL,
  `Rol` varchar(45) NOT NULL,
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'juan','jamon','juan','lopez','lopez','2024-11-15','admin'),(2,'juan','$2b$12$4wn5APj506IvBZNZS9R0dunamQoQvLcJ8txcpPIVwHt0lWEjWoBeW','juan','lopez','lopez','2024-11-28','admin'),(3,'gerd','$2b$12$pEgd63/VgxjCyKK7LKCEV.qP2TKrh4jSPBg2bSROt9FhxGXMdYuQC','Gerardo','Estupiñan','Alvarado','2024-11-29','Admin'),(4,'Patty','$2b$12$rnrmbtwaJwHQr4MxaydukuBtBwamjksxyGEqMrmA0cAdn5k2QFQnu','Laura Patricia ','Luis','Arellano','2024-11-29','General'),(5,'patricia','$2b$12$ujApuxiim2mQDLIr0RBW8e7tC/qxenFbvzs02FP2.dhfJX7t8arlS','Laura Patricia ','Luis','Arellano','2024-11-29','General'),(6,'Naranjo','$2b$12$l7Q.hQEtZQP8/o0iBjUxMuX4hYRJixlz6mFRXunHukVcqssD/OnsO','Oscar','Naranjo ','G','2024-11-30','Admin');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-30 16:14:51
