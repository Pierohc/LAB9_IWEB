-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: lab_9
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `curso`
--

DROP TABLE IF EXISTS `curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curso` (
  `idcurso` int NOT NULL,
  `codigo` varchar(6) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `idfacultad` int NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `fecha_edicion` datetime NOT NULL,
  PRIMARY KEY (`idcurso`),
  KEY `fk_curso_facultad1_idx` (`idfacultad`),
  CONSTRAINT `fk_curso_facultad1` FOREIGN KEY (`idfacultad`) REFERENCES `facultad` (`idfacultad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso`
--

LOCK TABLES `curso` WRITE;
/*!40000 ALTER TABLE `curso` DISABLE KEYS */;
INSERT INTO `curso` VALUES (1,'TEL-1','Química',1,'2023-11-23 11:01:52','2023-11-26 15:49:59'),(2,'TEL-2','Cálculo 1',1,'2023-11-23 11:01:52','2023-11-26 02:57:59'),(3,'TEL-3','Cálculo 2',1,'2023-11-23 11:01:52','2023-11-26 02:58:05'),(6,'TEL-6','Curso 6',2,'2023-11-23 11:01:52','2023-11-23 11:01:52'),(7,'TEL-7','Curso 7',2,'2023-11-23 11:01:52','2023-11-23 11:01:52'),(8,'TEL-8','Curso 8',2,'2023-11-23 11:01:52','2023-11-23 11:01:52'),(9,'TEL-9','Curso 9',2,'2023-11-23 11:01:52','2023-11-23 11:01:52'),(10,'TEL-10','Cálculo 3',1,'2023-11-26 02:46:10','2023-11-26 02:57:52'),(11,'TEL-11','Física',1,'2023-11-26 02:47:15','2023-11-26 02:48:01');
/*!40000 ALTER TABLE `curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curso_has_docente`
--

DROP TABLE IF EXISTS `curso_has_docente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curso_has_docente` (
  `idcurso` int NOT NULL,
  `iddocente` int NOT NULL,
  PRIMARY KEY (`idcurso`,`iddocente`),
  KEY `fk_curso_has_usuario_usuario1_idx` (`iddocente`),
  KEY `fk_curso_has_usuario_curso1_idx` (`idcurso`),
  CONSTRAINT `fk_curso_has_usuario_curso1` FOREIGN KEY (`idcurso`) REFERENCES `curso` (`idcurso`),
  CONSTRAINT `fk_curso_has_usuario_usuario1` FOREIGN KEY (`iddocente`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso_has_docente`
--

LOCK TABLES `curso_has_docente` WRITE;
/*!40000 ALTER TABLE `curso_has_docente` DISABLE KEYS */;
INSERT INTO `curso_has_docente` VALUES (1,11),(2,12),(3,13),(6,16),(7,17),(8,18),(9,19),(11,27),(10,28);
/*!40000 ALTER TABLE `curso_has_docente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evaluaciones`
--

DROP TABLE IF EXISTS `evaluaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evaluaciones` (
  `idevaluaciones` int NOT NULL AUTO_INCREMENT,
  `nombre_estudiantes` varchar(45) NOT NULL,
  `codigo_estudiantes` varchar(45) NOT NULL,
  `correo_estudiantes` varchar(45) NOT NULL,
  `nota` int NOT NULL,
  `idcurso` int NOT NULL,
  `idsemestre` int NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `fecha_edicion` datetime NOT NULL,
  PRIMARY KEY (`idevaluaciones`),
  KEY `fk_evaluaciones_curso1_idx` (`idcurso`),
  KEY `fk_evaluaciones_semestre1_idx` (`idsemestre`),
  CONSTRAINT `fk_evaluaciones_curso1` FOREIGN KEY (`idcurso`) REFERENCES `curso` (`idcurso`),
  CONSTRAINT `fk_evaluaciones_semestre1` FOREIGN KEY (`idsemestre`) REFERENCES `semestre` (`idsemestre`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluaciones`
--

LOCK TABLES `evaluaciones` WRITE;
/*!40000 ALTER TABLE `evaluaciones` DISABLE KEYS */;
INSERT INTO `evaluaciones` VALUES (1,'Juan Perez','20200001','juanperez@gmail.com',10,1,6,'2023-11-23 11:13:08','2023-11-26 02:30:36'),(2,'María Rodriguez','20200002','mariarodriguez@gmail.com',15,1,7,'2023-11-23 11:13:08','2023-11-23 11:13:08'),(3,'Carlos González','20200003','carlosgonzalez@gmail.com',16,1,6,'2023-11-23 11:13:08','2023-11-23 11:13:08'),(4,'Luisa Fernandez','20200007','luisafernandez@gmail.com',11,2,7,'2023-11-23 11:13:08','2023-11-23 11:13:08'),(5,'Javier Lopez','20200008','javierlopez@gmail.com',19,2,7,'2023-11-23 11:13:08','2023-11-23 11:13:08'),(6,'Rosa Ramirez','20200009','rosaramirez@gmail.com',13,2,6,'2023-11-23 11:13:08','2023-11-23 11:13:08'),(7,'Daniel Torres','20200010','danieltorres@gmail.com',17,2,6,'2023-11-23 11:13:08','2023-11-23 11:13:08'),(8,'Fabricio Hernandez','20200011','fabricio@gmail.com',15,1,7,'2023-11-23 11:13:08','2023-11-23 11:13:08'),(9,'Ricardo Roman','20200012','juanr@gmail.com',14,1,7,'2023-11-23 11:13:08','2023-11-26 14:48:24');
/*!40000 ALTER TABLE `evaluaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facultad`
--

DROP TABLE IF EXISTS `facultad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facultad` (
  `idfacultad` int NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `iduniversidad` int NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `fecha_edicion` datetime NOT NULL,
  PRIMARY KEY (`idfacultad`),
  KEY `fk_facultad_universidad_idx` (`iduniversidad`),
  CONSTRAINT `fk_facultad_universidad` FOREIGN KEY (`iduniversidad`) REFERENCES `universidad` (`iduniversidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facultad`
--

LOCK TABLES `facultad` WRITE;
/*!40000 ALTER TABLE `facultad` DISABLE KEYS */;
INSERT INTO `facultad` VALUES (1,'Facultad de Ingeniería',1,'2023-11-23 10:47:30','2023-11-23 10:47:30'),(2,'Facultad de Artes',1,'2023-11-23 10:47:30','2023-11-23 10:47:30'),(3,'Facultad de Derecho',1,'2023-11-23 10:47:30','2023-11-23 10:47:30'),(4,'Facultad de Ciencias Económicas',1,'2023-11-23 10:47:30','2023-11-23 10:47:30');
/*!40000 ALTER TABLE `facultad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facultad_has_decano`
--

DROP TABLE IF EXISTS `facultad_has_decano`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facultad_has_decano` (
  `idfacultad` int NOT NULL,
  `iddecano` int NOT NULL,
  PRIMARY KEY (`idfacultad`,`iddecano`),
  KEY `fk_facultad_has_usuario_usuario1_idx` (`iddecano`),
  KEY `fk_facultad_has_usuario_facultad1_idx` (`idfacultad`),
  CONSTRAINT `fk_facultad_has_usuario_facultad1` FOREIGN KEY (`idfacultad`) REFERENCES `facultad` (`idfacultad`),
  CONSTRAINT `fk_facultad_has_usuario_usuario1` FOREIGN KEY (`iddecano`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facultad_has_decano`
--

LOCK TABLES `facultad_has_decano` WRITE;
/*!40000 ALTER TABLE `facultad_has_decano` DISABLE KEYS */;
INSERT INTO `facultad_has_decano` VALUES (1,3),(2,4),(3,5),(4,6);
/*!40000 ALTER TABLE `facultad_has_decano` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol` (
  `idrol` int NOT NULL,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`idrol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (1,'Administrador'),(2,'Rector'),(3,'Decano'),(4,'Docente');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `semestre`
--

DROP TABLE IF EXISTS `semestre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `semestre` (
  `idsemestre` int NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `idadmistrador` int NOT NULL,
  `habilitado` tinyint NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `fecha_edicion` datetime NOT NULL,
  PRIMARY KEY (`idsemestre`,`idadmistrador`),
  KEY `fk_semestre_usuario1_idx` (`idadmistrador`),
  CONSTRAINT `fk_semestre_usuario1` FOREIGN KEY (`idadmistrador`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semestre`
--

LOCK TABLES `semestre` WRITE;
/*!40000 ALTER TABLE `semestre` DISABLE KEYS */;
INSERT INTO `semestre` VALUES (1,'2021-2',1,0,'2023-11-23 10:36:02','2023-11-23 10:36:02'),(2,'2022-0',1,0,'2023-11-23 10:36:02','2023-11-23 10:36:02'),(3,'2022-1',1,0,'2023-11-23 10:36:02','2023-11-23 10:36:02'),(4,'2022-2',1,0,'2023-11-23 10:36:02','2023-11-23 10:36:02'),(5,'2023-0',1,0,'2023-11-23 10:36:02','2023-11-23 10:36:02'),(6,'2023-1',1,0,'2023-11-23 10:36:02','2023-11-23 10:36:02'),(7,'2023-2',1,1,'2023-11-23 10:36:02','2023-11-23 10:36:02');
/*!40000 ALTER TABLE `semestre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `universidad`
--

DROP TABLE IF EXISTS `universidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `universidad` (
  `iduniversidad` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `logo_url` varchar(45) NOT NULL,
  `idadministrador` int NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `fecha_edicion` datetime NOT NULL,
  PRIMARY KEY (`iduniversidad`),
  KEY `fk_universidad_usuario1_idx` (`idadministrador`),
  CONSTRAINT `fk_universidad_usuario1` FOREIGN KEY (`idadministrador`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `universidad`
--

LOCK TABLES `universidad` WRITE;
/*!40000 ALTER TABLE `universidad` DISABLE KEYS */;
INSERT INTO `universidad` VALUES (1,'Pontificia Universidad Católica del Perú','1',1,'2023-11-23 01:57:37','2023-11-23 01:57:37');
/*!40000 ALTER TABLE `universidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `universidad_has_rector`
--

DROP TABLE IF EXISTS `universidad_has_rector`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `universidad_has_rector` (
  `iduniversidad` int NOT NULL,
  `idrector` int NOT NULL,
  PRIMARY KEY (`iduniversidad`,`idrector`),
  KEY `fk_universidad_has_usuario_usuario1_idx` (`idrector`),
  KEY `fk_universidad_has_usuario_universidad1_idx` (`iduniversidad`),
  CONSTRAINT `fk_universidad_has_usuario_universidad1` FOREIGN KEY (`iduniversidad`) REFERENCES `universidad` (`iduniversidad`),
  CONSTRAINT `fk_universidad_has_usuario_usuario1` FOREIGN KEY (`idrector`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `universidad_has_rector`
--

LOCK TABLES `universidad_has_rector` WRITE;
/*!40000 ALTER TABLE `universidad_has_rector` DISABLE KEYS */;
INSERT INTO `universidad_has_rector` VALUES (1,2);
/*!40000 ALTER TABLE `universidad_has_rector` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `idusuario` int NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `correo` varchar(45) NOT NULL,
  `password` varchar(300) NOT NULL,
  `idrol` int NOT NULL,
  `ultimo_ingreso` datetime DEFAULT NULL,
  `cantidad_ingresos` int NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `fecha_edicion` datetime NOT NULL,
  PRIMARY KEY (`idusuario`),
  KEY `fk_usuario_rol1_idx` (`idrol`),
  CONSTRAINT `fk_usuario_rol1` FOREIGN KEY (`idrol`) REFERENCES `rol` (`idrol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Jenny Hill','jenny.hill@gmail.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',1,'2023-11-23 01:53:39',1,'2023-11-23 01:53:39','2023-11-23 01:53:39'),(2,'Robert Jordan','robert.jordan@gmail.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',2,'2023-11-23 01:53:39',1,'2023-11-23 01:53:39','2023-11-23 01:53:39'),(3,'Marco Smith','decano@gmail.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',3,'2023-11-23 01:53:39',2,'2023-11-23 01:53:39','2023-11-23 01:53:39'),(4,'Laura Garcia','laura.garcia@gmail.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',3,'2023-11-23 01:53:39',1,'2023-11-23 01:53:39','2023-11-23 01:53:39'),(5,'Michael Brown','michael.brown@gmail.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',3,'2023-11-23 01:53:39',1,'2023-11-23 01:53:39','2023-11-23 01:53:39'),(6,'Jessica Martinez','jessica.martinez@gmail.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',3,'2023-11-23 01:53:39',1,'2023-11-23 01:53:39','2023-11-23 01:53:39'),(7,'David Johnson','david.johnson@gmail.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',4,'2023-11-23 01:53:39',1,'2023-11-23 01:53:39','2023-11-23 01:53:39'),(8,'Sarah Anderson','sarah.anderson@gmail.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',4,'2023-11-23 01:53:39',1,'2023-11-23 01:53:39','2023-11-23 01:53:39'),(9,'John Miller','john.miller@gmail.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',4,'2023-11-23 01:53:39',1,'2023-11-23 01:53:39','2023-11-23 01:53:39'),(10,'Emily Wilson','emily.wilson@gmail.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',4,'2023-11-23 01:53:39',1,'2023-11-23 01:53:39','2023-11-23 01:53:39'),(11,'Alexander Reed','docente@gmail.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',4,'2023-11-23 10:51:08',1,'2023-11-23 10:51:08','2023-11-23 10:51:08'),(12,'Samuel Carter','samuel.carter@gmail.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',4,'2023-11-23 10:51:08',1,'2023-11-23 10:51:08','2023-11-23 10:51:08'),(13,'Elena Torres','elena.torres@gmail.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',4,'2023-11-23 10:51:08',1,'2023-11-23 10:51:08','2023-11-23 10:51:08'),(14,'Daniel Hill','daniel.hill@gmail.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',4,'2023-11-23 10:51:08',1,'2023-11-23 10:51:08','2023-11-23 10:51:08'),(15,'Sophia Thompson','sophia.thompson@gmail.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',4,'2023-11-23 10:51:08',1,'2023-11-23 10:51:08','2023-11-23 10:51:08'),(16,'Lucas Evans','lucas.evans@gmail.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',4,'2023-11-23 10:51:08',1,'2023-11-23 10:51:08','2023-11-23 10:51:08'),(17,'Olivia Baker','olivia.baker@gmail.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',4,'2023-11-23 10:51:08',1,'2023-11-23 10:51:08','2023-11-23 10:51:08'),(18,'Aiden Campbell','aiden.campbell@gmail.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',4,'2023-11-23 10:51:08',1,'2023-11-23 10:51:08','2023-11-23 10:51:08'),(19,'Emma Smith','emma.smith@gmail.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',4,'2023-11-23 11:07:21',1,'2023-11-23 11:07:21','2023-11-23 11:07:21'),(20,'Lucas Johnson','lucas.johnson@gmail.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',4,'2023-11-23 11:07:21',1,'2023-11-23 11:07:21','2023-11-23 11:07:21'),(21,'Sophia Williams','sophia.williams@gmail.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',4,'2023-11-23 11:07:21',1,'2023-11-23 11:07:21','2023-11-23 11:07:21'),(22,'Oliver Brown','oliver.brown@gmail.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',4,'2023-11-23 11:07:21',1,'2023-11-23 11:07:21','2023-11-23 11:07:21'),(23,'Ava Miller','ava.miller@gmail.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',4,'2023-11-23 11:07:21',1,'2023-11-23 11:07:21','2023-11-23 11:07:21'),(24,'Noah Davis','noah.davis@gmail.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',4,'2023-11-23 11:07:21',1,'2023-11-23 11:07:21','2023-11-23 11:07:21'),(25,'Lucas Rodríguez','lucas.rodriguez@example.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',4,'2023-11-23 17:26:55',1,'2023-11-23 17:26:55','2023-11-23 17:26:55'),(26,'Marina López','marina.lopez@example.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',4,'2023-11-23 17:26:55',1,'2023-11-23 17:26:55','2023-11-23 17:26:55'),(27,'Santiago Martínez','santiago.martinez@example.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',4,'2023-11-23 17:26:55',1,'2023-11-23 17:26:55','2023-11-23 17:26:55'),(28,'Valentina Pérez','valentina.perez@example.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',4,'2023-11-23 17:26:55',1,'2023-11-23 17:26:55','2023-11-23 17:26:55'),(29,'Mateo Sánchez','mateo.sanchez@example.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',4,'2023-11-23 17:26:55',1,'2023-11-23 17:26:55','2023-11-23 17:26:55'),(30,'Isabelle Hernández','isabelle@gmail.com','40339b5e8eb7e07af2c6536aa78145813d3d9d2266fc1efb92c0ba8e652144b7',4,NULL,0,'2023-11-26 14:45:26','2023-11-26 14:45:26');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-26 16:24:47
