-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: concitec2.com.mysql.service.one.com:3306
-- Generation Time: Nov 01, 2019 at 01:09 PM
-- Server version: 10.3.17-MariaDB-1:10.3.17+maria~bionic
-- PHP Version: 7.2.24-0ubuntu0.18.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `concitec2_com`
--

-- --------------------------------------------------------

--
-- Table structure for table `localizacao`
--

CREATE TABLE `localizacao` (
  `id` int(11) NOT NULL,
  `lat` varchar(15) NOT NULL,
  `long` varchar(15) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `numero` varchar(15) NOT NULL,
  `cor` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `localizacao`
--

INSERT INTO `localizacao` (`id`, `lat`, `long`, `nome`, `numero`, `cor`) VALUES
(4, '-10.925697', '-37.103192', 'Didática 1', '(79) 3194-6600', 'red'),
(5, '-10.925210', '-37.103197', 'Didática 2', '0', 'red'),
(6, '-10.924749', '-37.103219', 'Didática 3', '0', 'red'),
(7, '-10.924282', '-37.103245', 'Didática 4', '0', 'red'),
(8, '-10.924996', '-37.104055', 'Didática 5', '0', 'red'),
(9, '-10.925655', '-37.104161', 'Didática 6', '(79) 3194-6445', 'red'),
(10, '-10.929343', '-37.102629', 'Didática 7', '0', 'red'),
(13, '-10.924108', '-37.102225', 'ADUFS', '(79) 3259-2021', 'yellow'),
(14, '-10.924099', '-37.102471', 'Auditório ADUFS', '0', 'yellow'),
(15, '-10.924081', '-37.102695', 'DCE', '0', 'yellow'),
(16, '-10.924936', '-37.103921', 'Achados e perdidos', '0', 'yellow'),
(17, '-10.929922', '-37.103165', 'Rádio UFS', '(79) 3194-6912', 'yellow'),
(18, '-10.928413', '-37.102995', 'Parque Aquático', '0', 'yellow'),
(19, '-10.926545', '-37.102021', 'Restaurante Universitário - RESUN', '0', 'yellow'),
(20, '10.927407', '-37.102018', 'Ginásio Poliesportivo DEF', '(79) 3194-6537', 'green'),
(21, '-10.926242', '-37.102856', 'Moura Lanches 1', '0', 'purple'),
(22, '-10.923907', '-37.102617', 'Moura Lanches 2', '0', 'purple'),
(23, '-10.923444', '-37.104601', 'Terminal de ônibus', '0', 'white'),
(24, '-10.921508', '-37.100456', 'Ponto de ônibus', '0', 'white'),
(25, '-10.921283', '-37.100315', 'Ponto de ônibus (alternativa)', '0', 'white'),
(26, '-10.923059', '-37.103499', 'Centro de Vivência', '(79) 3194-6600', 'yellow'),
(27, '-10.923420', '-37.103319', 'Banco do Brasil - Agência', '(79) 3259-1414', 'yellow'),
(28, '-10.922571', '-37.103785', 'Departamento de Computação - DCOMP', '(79) 3194-6678', 'blue'),
(29, '-10.922998', '-37.103877', 'Departamento de Engenharia de Produção - DEPRO', '(79) 3194-6320', 'blue'),
(31, '-10.923877', '-37.103944', 'Departamento de Engenharia Elétrica - DEL', '0', 'blue'),
(32, '-10.922914', '-37.104075', 'Departamento de Engenharia Mecânica - DMEC', '(79) 3194-6310', 'blue'),
(33, '-10.925440', '-37.102484', 'Departamento de Ciência da Informação DCI', '0', 'blue'),
(34, '-10.925419', '-37.102233', 'Departamento de Turismo', '0', 'blue'),
(35, '-10.926560', '-37.100967', 'Biblioteca Central - Bicen', '(79) 3194-6527', 'yellow'),
(36, '-10.927440', '-37.103508', 'Estacionamento', '0', 'violet');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `localizacao`
--
ALTER TABLE `localizacao`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `localizacao`
--
ALTER TABLE `localizacao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
