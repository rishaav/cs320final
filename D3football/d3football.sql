-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 14, 2017 at 02:52 AM
-- Server version: 5.7.14
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `d3football`
--

-- --------------------------------------------------------

--
-- Table structure for table `drives`
--

CREATE TABLE `drives` (
  `id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL,
  `location` tinyint(4) NOT NULL,
  `quarter` varchar(4) NOT NULL,
  `starttime` time NOT NULL,
  `points` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `drives`
--

INSERT INTO `drives` (`id`, `game_id`, `team_id`, `location`, `quarter`, `starttime`, `points`) VALUES
(1, 1, 2, 32, '1st', '11:22:00', 0),
(2, 1, 1, 14, '1st', '09:00:00', 0),
(3, 1, 2, 33, '1st', '06:15:00', 7),
(4, 1, 1, 25, '1st', '04:22:00', 0),
(5, 1, 2, 22, '1st', '01:15:00', 0),
(6, 1, 1, 34, '2nd', '14:54:00', 0),
(7, 1, 2, 35, '2nd', '13:48:00', 7),
(8, 1, 1, 34, '2nd', '10:01:00', 7),
(9, 1, 2, 36, '2nd', '06:24:00', 7),
(10, 1, 1, 35, '2nd', '04:14:00', 7),
(11, 1, 2, 25, '2nd', '00:37:00', 0),
(12, 1, 2, 23, '3rd', '15:00:00', 7),
(13, 1, 2, 38, '3rd', '11:00:00', 0),
(14, 1, 1, 19, '3rd', '09:13:00', 0),
(15, 1, 2, 35, '3rd', '07:22:00', 7),
(16, 1, 1, 21, '3rd', '06:04:00', 0),
(17, 1, 2, 1, '3rd', '02:40:00', 0),
(18, 1, 1, 44, '3rd', '00:28:00', 0),
(19, 1, 2, 24, '4th', '13:16:00', 0),
(20, 1, 1, 27, '4th', '11:28:00', 0),
(21, 1, 2, 21, '4th', '09:02:00', 7),
(22, 1, 1, 40, '4th', '05:07:00', 7),
(23, 1, 2, 44, '4th', '03:49:00', 0),
(24, 1, 1, 21, '4th', '02:47:00', 0),
(25, 1, 2, 32, '4th', '01:43:00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `field_goals`
--

CREATE TABLE `field_goals` (
  `play_id` int(11) NOT NULL,
  `distance` tinyint(4) NOT NULL,
  `success` enum('0','1') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `games`
--

CREATE TABLE `games` (
  `id` int(11) NOT NULL,
  `home_id` int(11) NOT NULL,
  `road_id` int(11) NOT NULL,
  `home_score` tinyint(3) UNSIGNED NOT NULL,
  `road_score` tinyint(3) UNSIGNED NOT NULL,
  `date` datetime NOT NULL,
  `gamecode` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `games`
--

INSERT INTO `games` (`id`, `home_id`, `road_id`, `home_score`, `road_score`, `date`, `gamecode`) VALUES
(1, 1, 2, 28, 35, '2016-10-15 00:00:00', 'm72v');

-- --------------------------------------------------------

--
-- Table structure for table `goforit`
--

CREATE TABLE `goforit` (
  `play_id` int(11) NOT NULL,
  `success` enum('0','1') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `plays`
--

CREATE TABLE `plays` (
  `id` int(10) UNSIGNED NOT NULL,
  `drive_id` int(11) NOT NULL,
  `playnum` tinyint(4) NOT NULL,
  `down` enum('1','2','3','4') NOT NULL,
  `distance` tinyint(4) NOT NULL,
  `location` tinyint(4) NOT NULL,
  `quarter` varchar(4) NOT NULL,
  `description` varchar(255) NOT NULL,
  `result` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `plays`
--

INSERT INTO `plays` (`id`, `drive_id`, `playnum`, `down`, `distance`, `location`, `quarter`, `description`, `result`) VALUES
(1, 1, 1, '1', 10, 38, '1st', 'Blake Matson pass complete to Kyle Obertino for 6 yards to the IC38 (E. Economos).', 6),
(2, 1, 1, '2', 4, 40, '1st', 'Blake Matson rush for 2 yards to the IC40 (Be. Gabel).', 2),
(3, 1, 1, '4', 6, 20, '1st', 'Nick Montrey punt 44 yards to the KC20, D. James return 4 yards to the KC24 (Dyllan Bailey), PENALTY KC holding 10 yards to the KC14, 1st and 10, KC ball on KC14.', 44),
(4, 2, 1, '1', 10, 23, '1st', 'N. Edlund rush for 9 yards to the KC23 (Steve Reyna).', 9),
(5, 2, 1, '2', 1, 24, '1st', 'N. Edlund rush for 1 yard to the KC24, 1ST DOWN KC (Ryan Torrance).', 1),
(6, 2, 1, '1', 10, 30, '1st', 'N. Edlund rush for 6 yards to the KC30 (Josh Brooks;Dakotah Jones).', 6),
(7, 2, 1, '2', 4, 33, '1st', 'N. Edlund rush for 3 yards to the KC33 (Matt Graef;JD Roesch).', 3),
(8, 2, 1, '3', 1, 33, '1st', 'N. Edlund rush for no gain to the KC33 (Adam Jackson;Matt Graef).', 0),
(9, 2, 1, '4', 1, 33, '1st', 'M. McCaffrey rush for no gain to the KC33 (T. Washington).', 0),
(10, 3, 1, '1', 10, 30, '1st', 'Bo Davis rush for 3 yards to the KC30 (L. Hollis).', 3),
(11, 3, 1, '2', 7, 26, '1st', 'Bo Davis rush for 4 yards to the KC26 (L. Hollis;I. Smith).', 4),
(12, 3, 1, '3', 3, 23, '1st', 'Greg Cross rush for 3 yards to the KC23, 1ST DOWN IC (Bro. Gabel).', 3),
(13, 3, 1, '1', 10, 5, '1st', 'Blake Matson pass complete to Logan Uyetake for 18 yards to the KC5, 1ST DOWN IC (D. Sommerville).', 18),
(14, 4, 1, '1', 10, 36, '1st', 'M. McCaffrey pass complete to P. Marzolino for 11 yards to the KC36, 1ST DOWN KC (Carlos Lemus;Steve Reyna).', 11),
(15, 4, 1, '1', 10, 41, '1st', 'B. Westfall rush for 5 yards to the KC41 (Michael Garcia).', 5),
(16, 4, 1, '2', 5, 28, '1st', 'B. Westfall rush for 31 yards to the IC28, 1ST DOWN KC (Steve Reyna).', 31),
(17, 4, 1, '1', 10, 28, '1st', 'N. Edlund rush for no gain to the IC28 (JD Roesch).', 0),
(18, 4, 1, '2', 10, 28, '1st', 'J. Auger rush for no gain to the IC28 (Josh Brooks).', 0),
(19, 4, 1, '3', 10, 19, '1st', 'M. McCaffrey pass complete to D. James for 9 yards to the IC19 (Carlos Lemus).', 9),
(20, 5, 1, '2', 10, 39, '1st', 'Blake Matson pass complete to Logan Uyetake for 39 yards to the KC39, 1ST DOWN IC (E. Economos).', 39),
(21, 5, 1, '1', 10, 37, '1st', 'Greg Cross rush for 2 yards to the KC37 (I. Ruelas).', 2),
(22, 5, 1, '3', 8, 34, '1st', 'Blake Matson pass complete to Bo Davis for 3 yards to the KC34, out-of-bounds (E. Economos).', 3),
(23, 6, 1, '2', 10, 40, '2nd', 'M. McCaffrey rush for 6 yards to the KC40 (Matt Graef).', 6),
(24, 6, 1, '3', 4, 49, '2nd', 'M. McCaffrey pass complete to M. Holmes for 11 yards to the IC49, 1ST DOWN KC (Steve Reyna).', 11),
(25, 6, 1, '1', 10, 33, '2nd', 'M. McCaffrey pass complete to D. James for 16 yards to the IC33, fumble forced by Ryan Torrance, fumble by D. James recovered by IC Ryan Torrance at IC35.', 16),
(26, 7, 1, '1', 10, 41, '2nd', 'Jason Barbour rush for 6 yards to the IC41 (L. Hollis).', 6),
(27, 7, 1, '2', 4, 42, '2nd', 'Jason Barbour rush for 1 yard to the IC42 (T. Podwojski).', 1),
(28, 7, 1, '3', 3, 45, '2nd', 'Bo Davis rush for 3 yards to the IC45, 1ST DOWN IC (L. Hollis).', 3),
(29, 7, 1, '1', 10, 48, '2nd', 'Jason Barbour rush for 7 yards to the KC48 (Q. Sharp).', 7),
(30, 7, 1, '2', 3, 45, '2nd', 'Blake Matson pass complete to Logan Uyetake for 3 yards to the KC45, 1ST DOWN IC (I. Smith;N. Truchon).', 3),
(31, 7, 1, '2', 30, 18, '2nd', 'Bo Davis rush for 47 yards to the KC18, 1ST DOWN IC (I. Smith;T. Podwojski).', 47),
(32, 7, 1, '1', 10, 12, '2nd', 'Greg Cross rush for 6 yards to the KC12 (Q. Sharp).', 6),
(33, 7, 1, '2', 4, 5, '2nd', 'Blake Matson pass complete to Logan Uyetake for 7 yards to the KC5, 1ST DOWN IC (M. Whitley).', 7),
(34, 8, 1, '2', 12, 33, '2nd', 'N. Edlund rush for 1 yard to the KC33 (Ryan Torrance).', 1),
(35, 8, 1, '3', 11, 46, '2nd', 'M. McCaffrey pass complete to M. Holmes for 21 yards to the IC46, 1ST DOWN KC (Nick Tadie).', 21),
(36, 8, 1, '1', 10, 40, '2nd', 'M. Hamilton rush for 6 yards to the IC40 (Steve Reyna).', 6),
(37, 8, 1, '2', 4, 12, '2nd', 'N. Edlund rush for 28 yards to the IC12, 1ST DOWN KC (Steve Reyna).', 28),
(38, 8, 1, '2', 12, 0, '2nd', 'M. McCaffrey rush for 14 yards to the IC0, 1ST DOWN KC, TOUCHDOWN, clock 06:30.', 14),
(39, 9, 1, '1', 10, 36, '2nd', 'Greg Cross rush for no gain to the IC36 (T. Paul).', 0),
(40, 9, 1, '2', 10, 47, '2nd', 'Blake Matson pass complete to Andy Webb for 11 yards to the IC47, 1ST DOWN IC (I. Smith).', 11),
(41, 9, 1, '1', 10, 49, '2nd', 'Blake Matson pass complete to Kyle Obertino for 2 yards to the IC49 (E. Economos).', 2),
(42, 9, 1, '2', 8, 47, '2nd', 'Jason Barbour rush for 4 yards to the KC47 (I. Ruelas).', 4),
(43, 9, 1, '3', 4, 0, '2nd', 'Blake Matson pass complete to Logan Uyetake for 47 yards to the KC0, 1ST DOWN IC, TOUCHDOWN, clock 04:22.', 47),
(44, 10, 1, '1', 10, 36, '2nd', 'B. Westfall rush for 1 yard to the KC36 (Austin Buchanan).', 1),
(45, 10, 1, '2', 9, 41, '2nd', 'M. McCaffrey pass complete to M. Hamilton for 23 yards to the IC41, 1ST DOWN KC (David Gideon).', 23),
(46, 10, 1, '1', 10, 38, '2nd', 'B. Westfall rush for 3 yards to the IC38 (Matt Graef).', 3),
(47, 10, 1, '3', 7, 35, '2nd', 'M. McCaffrey rush for 3 yards to the IC35 (Kyle Cronister).', 3),
(48, 10, 1, '4', 4, 23, '2nd', 'B. Westfall rush for 12 yards to the IC23, 1ST DOWN KC (Matt Graef), PENALTY IC encroachment declined.', 12),
(49, 10, 1, '2', 12, 16, '2nd', 'M. McCaffrey pass complete to J. Auger for 9 yards to the IC16, out-of-bounds (Dalton Merry).', 9),
(50, 10, 1, '3', 3, 7, '2nd', 'M. McCaffrey rush for 9 yards to the IC7, 1ST DOWN KC, out-of-bounds (Matt Graef).', 9),
(51, 11, 1, '1', 10, 34, '2nd', 'Bo Davis rush for 9 yards to the IC34 (L. Hollis;Q. Sharp).', 9),
(52, 11, 1, '2', 1, 35, '2nd', 'Bo Davis rush for 1 yard to the IC35, 1ST DOWN IC (J. Anderson).', 1),
(53, 12, 1, '1', 10, 27, '3rd', 'Greg Cross rush for 4 yards to the IC27 (L. Hollis).', 4),
(54, 12, 1, '2', 6, 38, '3rd', 'Greg Cross rush for 11 yards to the IC38, 1ST DOWN IC (C. Hipp).', 11),
(55, 12, 1, '1', 10, 44, '3rd', 'Blake Matson rush for 6 yards to the IC44 (L. Hollis).', 6),
(56, 12, 1, '2', 4, 45, '3rd', 'Greg Cross rush for 1 yard to the IC45 (Q. Sharp).', 1),
(57, 12, 1, '3', 3, 47, '3rd', 'Blake Matson pass complete to Alex Ausmus for 8 yards to the KC47, 1ST DOWN IC (E. Economos).', 8),
(58, 12, 1, '2', 21, 48, '3rd', 'Blake Matson pass complete to Kyle Obertino for 10 yards to the KC48 (E. Economos).', 10),
(59, 12, 1, '4', 16, 8, '3rd', 'Nick Montrey punt 45 yards to the KC8, D. James return 92 yards to the IC0, TOUCHDOWN, clock 11:02.', 45),
(60, 13, 1, '1', 10, 38, '3rd', 'Greg Cross rush for no gain to the IC38 (C. Hipp).', 0),
(61, 13, 1, '2', 10, 39, '3rd', 'Jason Barbour rush for 1 yard to the IC39 (Bro. Gabel).', 1),
(62, 13, 1, '4', 18, 19, '3rd', 'Nick Montrey punt 51 yards to the KC19, D. James return 10 yards to the KC29 (Jacob Homann), PENALTY KC illegal block 10 yards to the KC19, 1st and 10, KC ball on KC19.', 51),
(63, 14, 1, '1', 10, 21, '3rd', 'M. McCaffrey pass complete to D. James for 2 yards to the KC21 (JD Roesch).', 2),
(64, 14, 1, '3', 9, 22, '3rd', 'M. McCaffrey pass complete to D. James for 2 yards to the KC22 (Steve Reyna).', 2),
(65, 15, 1, '1', 10, 30, '3rd', 'Blake Matson pass complete to Jason Barbour for 5 yards to the KC30, out-of-bounds (I. Smith).', 5),
(66, 15, 1, '3', 5, 28, '3rd', 'Jason Barbour rush for 2 yards to the KC28 (T. Wooten).', 2),
(67, 15, 1, '4', 3, 0, '3rd', 'Blake Matson pass complete to Kyle Obertino for 28 yards to the KC0, 1ST DOWN IC, TOUCHDOWN, clock 06:10.', 28),
(68, 16, 1, '1', 10, 31, '3rd', 'N. Edlund rush for 10 yards to the KC31, 1ST DOWN KC (Austin Buchanan).', 10),
(69, 16, 1, '1', 10, 32, '3rd', 'M. McCaffrey rush for 1 yard to the KC32 (Austin Buchanan;Matt Graef).', 1),
(70, 16, 1, '2', 9, 45, '3rd', 'M. McCaffrey pass complete to P. Marzolino for 13 yards to the KC45, 1ST DOWN KC (JD Roesch).', 13),
(71, 16, 1, '1', 10, 47, '3rd', 'M. McCaffrey rush for 8 yards to the IC47 (Austin Buchanan).', 8),
(72, 16, 1, '2', 2, 5, '3rd', 'N. Edlund rush for 42 yards to the IC5, 1ST DOWN KC (Michael Garcia).', 42),
(73, 17, 1, '1', 10, 1, '3rd', 'Jason Barbour rush for no gain to the IC1 (T. Follis).', 0),
(74, 17, 1, '2', 10, 9, '3rd', 'Greg Cross rush for 8 yards to the IC9 (D. Sommerville).', 8),
(75, 17, 1, '3', 2, 12, '3rd', 'Greg Cross rush for 3 yards to the IC12, 1ST DOWN IC (I. Smith;L. Hollis).', 3),
(76, 17, 1, '1', 10, 16, '3rd', 'Jason Barbour rush for 4 yards to the IC16 (T. Podwojski;Be. Gabel).', 4),
(77, 17, 1, '4', 6, 47, '3rd', 'Nick Montrey punt 31 yards to the IC47, D. James return 3 yards to the IC44 (Dyllan Bailey).', 31),
(78, 18, 1, '1', 10, 32, '3rd', 'J. Auger rush for 12 yards to the IC32, 1ST DOWN KC (Steve Reyna).', 12),
(79, 18, 1, '2', 10, 30, '4th', 'M. McCaffrey rush for 2 yards to the IC30 (Brady Jernigan).', 2),
(80, 18, 1, '4', 18, 24, '4th', 'M. McCaffrey punt 16 yards to the IC24, downed.', 16),
(81, 19, 1, '1', 10, 25, '4th', 'Greg Cross rush for 1 yard to the IC25 (M. Whitley;T. Wooten).', 1),
(82, 19, 1, '2', 9, 30, '4th', 'Blake Matson pass complete to Kyle Obertino for 5 yards to the IC30 (M. Whitley).', 5),
(83, 19, 1, '3', 4, 31, '4th', 'Bo Davis rush for 1 yard to the IC31 (T. Wooten;G. Jordan).', 1),
(84, 19, 1, '4', 3, 27, '4th', 'Nick Montrey punt 42 yards to the KC27, D. James return 0 yards to the KC27.', 42),
(85, 20, 1, '2', 14, 38, '4th', 'M. McCaffrey pass complete to P. Marzolino for 15 yards to the KC38, 1ST DOWN KC (Nick Tadie).', 15),
(86, 20, 1, '3', 11, 44, '4th', 'M. McCaffrey rush for 7 yards to the KC44 (Ryan Torrance).', 7),
(87, 20, 1, '4', 4, 21, '4th', 'K. Shutter punt 35 yards to the IC21, fair catch by Kyle Obertino.', 35),
(88, 21, 1, '1', 10, 21, '4th', 'Blake Matson rush for no gain to the IC21 (T. Follis).', 0),
(89, 21, 1, '2', 10, 38, '4th', 'Blake Matson pass complete to Andy Webb for 17 yards to the IC38, 1ST DOWN IC (Bro. Gabel).', 17),
(90, 21, 1, '2', 10, 37, '4th', 'Blake Matson pass complete to Kyle Obertino for 25 yards to the KC37, 1ST DOWN IC (L. Hollis).', 25),
(91, 21, 1, '1', 10, 30, '4th', 'Blake Matson pass complete to Alex Ausmus for 7 yards to the KC30 (I. Smith).', 7),
(92, 21, 1, '2', 3, 28, '4th', 'Bo Davis rush for 2 yards to the KC28 (L. Hollis;Bro. Gabel).', 2),
(93, 21, 1, '3', 1, 20, '4th', 'Bo Davis rush for 8 yards to the KC20, 1ST DOWN IC (E. Economos).', 8),
(94, 21, 1, '1', 10, 19, '4th', 'Greg Cross rush for 1 yard to the KC19 (J. Paul).', 1),
(95, 21, 1, '3', 10, 0, '4th', 'Blake Matson pass complete to Andy Webb for 20 yards to the KC0, 1ST DOWN IC, TOUCHDOWN, clock 05:15.', 20),
(96, 22, 1, '1', 10, 33, '4th', 'M. McCaffrey pass complete to J. Auger for 7 yards to the IC33 (Matt Graef).', 7),
(97, 22, 1, '2', 3, 21, '4th', 'M. McCaffrey rush for 12 yards to the IC21, 1ST DOWN KC (Jacob Homann).', 12),
(98, 22, 1, '1', 10, 6, '4th', 'M. McCaffrey pass complete to D. James for 15 yards to the IC6, 1ST DOWN KC (Steve Reyna).', 15),
(99, 23, 1, '1', 10, 47, '4th', 'Bo Davis rush for 3 yards to the IC47 (Be. Gabel).', 3),
(100, 23, 1, '2', 7, 49, '4th', 'Jason Barbour rush for 2 yards to the IC49 (T. Paul;Be. Gabel).', 2),
(101, 23, 1, '4', 5, 21, '4th', 'Nick Montrey punt 30 yards to the KC21, fair catch by D. James.', 30),
(102, 24, 1, '1', 10, 29, '4th', 'M. McCaffrey pass complete to J. Auger for 8 yards to the KC29, out-of-bounds (Dalton Merry).', 8),
(103, 24, 1, '2', 2, 36, '4th', 'M. McCaffrey rush for 7 yards to the KC36, 1ST DOWN KC (V. Vanhorne).', 7);

-- --------------------------------------------------------

--
-- Table structure for table `punts`
--

CREATE TABLE `punts` (
  `play_id` int(11) NOT NULL,
  `distance` tinyint(4) NOT NULL,
  `net` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `punts`
--

INSERT INTO `punts` (`play_id`, `distance`, `net`) VALUES
(3, 6, 44),
(59, 16, 45),
(62, 18, 51),
(77, 6, 31),
(80, 18, 16),
(84, 3, 42),
(87, 4, 35),
(101, 5, 30);

-- --------------------------------------------------------

--
-- Table structure for table `teams`
--

CREATE TABLE `teams` (
  `id` int(11) NOT NULL,
  `school` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `teams`
--

INSERT INTO `teams` (`id`, `school`) VALUES
(2, 'Illinois College'),
(1, 'Knox College');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `drives`
--
ALTER TABLE `drives`
  ADD PRIMARY KEY (`id`),
  ADD KEY `game_id` (`game_id`,`team_id`);

--
-- Indexes for table `field_goals`
--
ALTER TABLE `field_goals`
  ADD PRIMARY KEY (`play_id`);

--
-- Indexes for table `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`id`),
  ADD KEY `home_id` (`home_id`,`road_id`,`gamecode`);

--
-- Indexes for table `goforit`
--
ALTER TABLE `goforit`
  ADD PRIMARY KEY (`play_id`);

--
-- Indexes for table `plays`
--
ALTER TABLE `plays`
  ADD PRIMARY KEY (`id`),
  ADD KEY `drive_id` (`drive_id`);

--
-- Indexes for table `punts`
--
ALTER TABLE `punts`
  ADD PRIMARY KEY (`play_id`);

--
-- Indexes for table `teams`
--
ALTER TABLE `teams`
  ADD PRIMARY KEY (`id`),
  ADD KEY `school` (`school`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `drives`
--
ALTER TABLE `drives`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT for table `games`
--
ALTER TABLE `games`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `plays`
--
ALTER TABLE `plays`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;
--
-- AUTO_INCREMENT for table `teams`
--
ALTER TABLE `teams`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
