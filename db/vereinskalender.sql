-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 13. Jul 2024 um 18:47
-- Server-Version: 10.4.32-MariaDB
-- PHP-Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `vereinskalender`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `club_events`
--

CREATE TABLE `club_events` (
  `Club_EventID` int(11) NOT NULL,
  `Name` text NOT NULL,
  `Date` text NOT NULL,
  `Time_Period` text NOT NULL,
  `Place` text NOT NULL,
  `Type` text NOT NULL,
  `Info_Text` text NOT NULL,
  `Notice` text NOT NULL,
  `Changelog` text NOT NULL,
  PRIMARY KEY (`Club_EventID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `match`
--

CREATE TABLE `match` (
  `MatchID` int(11) NOT NULL,
  `Name` text NOT NULL,
  `Date` text NOT NULL,
  `Time_Period` text NOT NULL,
  `Place` text NOT NULL,
  `Type` text NOT NULL,
  `Club0` text NOT NULL,
  `Club1` text NOT NULL,
  `Points0` int(11) DEFAULT NULL,
  `Points1` int(11) DEFAULT NULL,
  `Info_Text` text NOT NULL,
  `Notice` text NOT NULL,
  `Changelog` text NOT NULL,
  PRIMARY KEY (`MatchID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `other_matches`
--

/*CREATE TABLE `other_matches` (
  `Club0` int(11) NOT NULL,
  `Club1` int(11) NOT NULL,
  `Points0` int(11) NOT NULL,
  `Points1` int(11) NOT NULL,
  `Date` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;*/


-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `points_table`
--

CREATE TABLE `points_table` (
  `PointsID` INT(11) NOT NULL AUTO_INCREMENT,
  `Win` INT(11) NOT NULL,
  `Draw` INT(11) NOT NULL,
  `Lost` INT(11) NOT NULL,
  `Points` INT(11) NOT NULL,
  `Club` TEXT NOT NULL,
  `Year` TEXT NOT NULL,
  PRIMARY KEY (`PointsID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `user`
--

CREATE TABLE `user` (
  `UserID` int(11) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(120) NOT NULL,
  `IsAdmin` tinyint(1) NOT NULL,
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
