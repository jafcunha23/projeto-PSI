-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Tempo de geração: 13-Nov-2020 às 15:47
-- Versão do servidor: 5.7.31
-- versão do PHP: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `bdprojetogamerlinkup`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `admins`
--

DROP TABLE IF EXISTS `admins`;
CREATE TABLE IF NOT EXISTS `admins` (
  `idUtilizador` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idUtilizador`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `disponibilidades`
--

DROP TABLE IF EXISTS `disponibilidades`;
CREATE TABLE IF NOT EXISTS `disponibilidades` (
  `idDisponibilidade` int(11) NOT NULL AUTO_INCREMENT,
  `horaInicio` datetime NOT NULL,
  `horaFim` datetime NOT NULL,
  PRIMARY KEY (`idDisponibilidade`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `formularios`
--

DROP TABLE IF EXISTS `formularios`;
CREATE TABLE IF NOT EXISTS `formularios` (
  `idFormulario` int(11) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(20) COLLATE utf8_bin NOT NULL,
  `nivel` int(11) NOT NULL,
  `idServidor` int(11) NOT NULL,
  `idRank` int(11) NOT NULL,
  `idJogo` int(11) NOT NULL,
  PRIMARY KEY (`idFormulario`),
  KEY `idServidor` (`idServidor`),
  KEY `idJogo` (`idJogo`),
  KEY `idRank` (`idRank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `generojogo`
--

DROP TABLE IF EXISTS `generojogo`;
CREATE TABLE IF NOT EXISTS `generojogo` (
  `idGeneroJogo` int(11) NOT NULL AUTO_INCREMENT,
  `tipoJogo` int(11) NOT NULL,
  `sigla` int(11) NOT NULL,
  PRIMARY KEY (`idGeneroJogo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `jogadores`
--

DROP TABLE IF EXISTS `jogadores`;
CREATE TABLE IF NOT EXISTS `jogadores` (
  `idUtilizador` int(11) NOT NULL AUTO_INCREMENT,
  `avatar` longblob NOT NULL,
  `paisOrigem` varchar(30) COLLATE utf8_bin NOT NULL,
  `dataNascimento` date NOT NULL,
  `rating` int(5) NOT NULL,
  `genero` enum('Masculino','Feminino') COLLATE utf8_bin NOT NULL,
  `idDisponibilidade` int(11) NOT NULL,
  `idPlataforma` int(11) NOT NULL,
  `idLingua` int(11) NOT NULL,
  `idFormulario` int(11) NOT NULL,
  PRIMARY KEY (`idUtilizador`),
  KEY `idDisponibilidade` (`idDisponibilidade`),
  KEY `idPlataforma` (`idPlataforma`),
  KEY `idLingua` (`idLingua`),
  KEY `idFormulario` (`idFormulario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `jogos`
--

DROP TABLE IF EXISTS `jogos`;
CREATE TABLE IF NOT EXISTS `jogos` (
  `idJogo` int(11) NOT NULL AUTO_INCREMENT,
  `nomeJogo` varchar(50) COLLATE utf8_bin NOT NULL,
  `logoJogo` longblob NOT NULL,
  `estado` enum('Aprovado','Reprovado','Em Espera') COLLATE utf8_bin NOT NULL,
  `idRank` int(11) NOT NULL,
  `idGeneroJogo` int(11) NOT NULL,
  PRIMARY KEY (`idJogo`),
  KEY `idRank` (`idRank`),
  KEY `idGeneroJogo` (`idGeneroJogo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `linguas`
--

DROP TABLE IF EXISTS `linguas`;
CREATE TABLE IF NOT EXISTS `linguas` (
  `idLingua` int(11) NOT NULL AUTO_INCREMENT,
  `lingua` varchar(30) COLLATE utf8_bin NOT NULL,
  `sigla` varchar(5) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`idLingua`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `plataformas`
--

DROP TABLE IF EXISTS `plataformas`;
CREATE TABLE IF NOT EXISTS `plataformas` (
  `idPlataforma` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) COLLATE utf8_bin NOT NULL,
  `logo` longblob NOT NULL,
  PRIMARY KEY (`idPlataforma`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `ranks`
--

DROP TABLE IF EXISTS `ranks`;
CREATE TABLE IF NOT EXISTS `ranks` (
  `idRank` int(11) NOT NULL AUTO_INCREMENT,
  `nomeRank` varchar(20) COLLATE utf8_bin NOT NULL,
  `logoRank` longblob NOT NULL,
  PRIMARY KEY (`idRank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `servidores`
--

DROP TABLE IF EXISTS `servidores`;
CREATE TABLE IF NOT EXISTS `servidores` (
  `idServidor` int(11) NOT NULL AUTO_INCREMENT,
  `regiaoServidor` varchar(20) COLLATE utf8_bin NOT NULL,
  `idJogo` int(11) NOT NULL,
  PRIMARY KEY (`idServidor`),
  KEY `idJogo` (`idJogo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `utilizadores`
--

DROP TABLE IF EXISTS `utilizadores`;
CREATE TABLE IF NOT EXISTS `utilizadores` (
  `idUtilizador` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) COLLATE utf8_bin NOT NULL,
  `email` varchar(80) COLLATE utf8_bin NOT NULL,
  `password` varchar(20) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`idUtilizador`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `admins`
--
ALTER TABLE `admins`
  ADD CONSTRAINT `admins_ibfk_1` FOREIGN KEY (`idUtilizador`) REFERENCES `utilizadores` (`idUtilizador`);

--
-- Limitadores para a tabela `formularios`
--
ALTER TABLE `formularios`
  ADD CONSTRAINT `formularios_ibfk_1` FOREIGN KEY (`idServidor`) REFERENCES `servidores` (`idServidor`),
  ADD CONSTRAINT `formularios_ibfk_2` FOREIGN KEY (`idJogo`) REFERENCES `jogos` (`idJogo`),
  ADD CONSTRAINT `formularios_ibfk_3` FOREIGN KEY (`idRank`) REFERENCES `ranks` (`idRank`);

--
-- Limitadores para a tabela `jogadores`
--
ALTER TABLE `jogadores`
  ADD CONSTRAINT `jogadores_ibfk_1` FOREIGN KEY (`idUtilizador`) REFERENCES `utilizadores` (`idUtilizador`),
  ADD CONSTRAINT `jogadores_ibfk_2` FOREIGN KEY (`idDisponibilidade`) REFERENCES `disponibilidades` (`idDisponibilidade`),
  ADD CONSTRAINT `jogadores_ibfk_3` FOREIGN KEY (`idPlataforma`) REFERENCES `plataformas` (`idPlataforma`),
  ADD CONSTRAINT `jogadores_ibfk_4` FOREIGN KEY (`idLingua`) REFERENCES `linguas` (`idLingua`),
  ADD CONSTRAINT `jogadores_ibfk_5` FOREIGN KEY (`idFormulario`) REFERENCES `formularios` (`idFormulario`);

--
-- Limitadores para a tabela `jogos`
--
ALTER TABLE `jogos`
  ADD CONSTRAINT `jogos_ibfk_1` FOREIGN KEY (`idRank`) REFERENCES `ranks` (`idRank`),
  ADD CONSTRAINT `jogos_ibfk_2` FOREIGN KEY (`idGeneroJogo`) REFERENCES `generojogo` (`idGeneroJogo`);

--
-- Limitadores para a tabela `servidores`
--
ALTER TABLE `servidores`
  ADD CONSTRAINT `servidores_ibfk_1` FOREIGN KEY (`idJogo`) REFERENCES `jogos` (`idJogo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
