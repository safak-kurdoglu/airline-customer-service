-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 23, 2021 at 09:58 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `air_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `airline`
--

CREATE TABLE `airline` (
  `airline_id` int(11) NOT NULL,
  `airline_name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `airline`
--

INSERT INTO `airline` (`airline_id`, `airline_name`) VALUES
(1, 'defaut'),
(6, 'Pegasus'),
(7, 'Atlas'),
(8, 'Anadolu Jet'),
(9, 'Türk Hava Yolları');

-- --------------------------------------------------------

--
-- Table structure for table `airplane`
--

CREATE TABLE `airplane` (
  `airplane_id` int(11) NOT NULL,
  `airplane_name` varchar(100) NOT NULL,
  `airplane_type_name` varchar(100) NOT NULL,
  `total_no_seats` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `airplane`
--

INSERT INTO `airplane` (`airplane_id`, `airplane_name`, `airplane_type_name`, `total_no_seats`) VALUES
(1, 'default', 'geniş gövdeli', 120),
(6, 'boing-727', 'dar gövdeli', 150),
(7, 'boing-777', 'geniş gövdeli', 180);

-- --------------------------------------------------------

--
-- Table structure for table `airplane_type`
--

CREATE TABLE `airplane_type` (
  `Airplane_type_name` varchar(100) NOT NULL,
  `Max_seat` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `airplane_type`
--

INSERT INTO `airplane_type` (`Airplane_type_name`, `Max_seat`) VALUES
('dar gövdeli', 120),
('geniş gövdeli', 240),
('Light Jet', 20),
('Narrow Body', 200),
('Wide Body', 400);

-- --------------------------------------------------------

--
-- Table structure for table `airport`
--

CREATE TABLE `airport` (
  `Airport_id` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `City` varchar(100) NOT NULL,
  `State` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `airport`
--

INSERT INTO `airport` (`Airport_id`, `Name`, `City`, `State`) VALUES
(1, 'default', '', ''),
(2, 'Adnan Menderes', 'İzmir', 'Türkiye'),
(3, 'Sabiha Gökçen', 'İstanbul', 'Türkiye'),
(4, 'Şakirpaşa ', 'Adana', 'Türkiye'),
(5, 'J.F.Kennedy', 'New York', 'New York');

-- --------------------------------------------------------

--
-- Table structure for table `can_land`
--

CREATE TABLE `can_land` (
  `Airplane_type_name` varchar(100) NOT NULL,
  `airport_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `can_land`
--

INSERT INTO `can_land` (`Airplane_type_name`, `airport_id`) VALUES
('dar gövdeli', 4),
('dar gövdeli', 5),
('geniş gövdeli', 5);

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE `company` (
  `comp_id` int(11) NOT NULL,
  `company_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`comp_id`, `company_name`) VALUES
(2, 'Turkish Airlines Company'),
(3, 'Sabancı Group');

-- --------------------------------------------------------

--
-- Table structure for table `company_owns`
--

CREATE TABLE `company_owns` (
  `comp_id` int(11) NOT NULL,
  `airplane_id` int(11) NOT NULL DEFAULT 1,
  `airline_id` int(11) NOT NULL DEFAULT 1,
  `Comp_type` bit(1) NOT NULL DEFAULT b'0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `company_owns`
--

INSERT INTO `company_owns` (`comp_id`, `airplane_id`, `airline_id`, `Comp_type`) VALUES
(2, 6, 1, b'0'),
(3, 1, 6, b'1'),
(3, 6, 1, b'0'),
(3, 7, 1, b'0');

--
-- Triggers `company_owns`
--
DELIMITER $$
CREATE TRIGGER `checkoverlaping` BEFORE INSERT ON `company_owns` FOR EACH ROW IF (NEW.airplane_id = 1 AND NEW.airline_id = 1) THEN

		    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "One of the own type must be different from 1";
END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `passport_number` int(11) NOT NULL,
  `name` varchar(200) NOT NULL DEFAULT '"hakkı"',
  `adress` varchar(100) NOT NULL,
  `phone` varchar(14) NOT NULL,
  `email` varchar(200) NOT NULL,
  `country` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`passport_number`, `name`, `adress`, `phone`, `email`, `country`) VALUES
(222222222, '\"ramazan\"', 'aydın', '123141231', 'rm4@gmail.com', 'türkiye'),
(333333333, '\"barış\"', 'karşıyaka izmir', '12314123131231', 'b5@gmail.com', 'türkiye'),
(444444444, '\"şafak\"', 'bursa özlüce', '6666666666', 'sa7@gmail.com', 'türkiye'),
(1111111111, '\"murat\"', 'bornove izmir', '5340128846', 'mc5@gmail.com', 'türkiye');

-- --------------------------------------------------------

--
-- Table structure for table `customer_fares`
--

CREATE TABLE `customer_fares` (
  `fare_id` int(11) NOT NULL,
  `passport_number` int(11) NOT NULL,
  `seat_reservation_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer_fares`
--

INSERT INTO `customer_fares` (`fare_id`, `passport_number`, `seat_reservation_id`) VALUES
(1, 1111111111, 63493),
(1, 222222222, 63494),
(1, 222222222, 63495),
(1, 222222222, 63497),
(1, 222222222, 5690253),
(1, 222222222, 5690254),
(1, 222222222, 5690255),
(1, 222222222, 5690256),
(1, 222222222, 5690257),
(11, 222222222, 5690268),
(17, 222222222, 5690274),
(18, 222222222, 5690275),
(19, 222222222, 5690276),
(20, 222222222, 5690277),
(21, 222222222, 5690278),
(22, 222222222, 5690279),
(23, 222222222, 5690280),
(24, 222222222, 5690281),
(25, 222222222, 5690282),
(26, 222222222, 5690283),
(27, 222222222, 5690284),
(28, 222222222, 5690285);

-- --------------------------------------------------------

--
-- Table structure for table `customer_segment_list`
--

CREATE TABLE `customer_segment_list` (
  `segment_id` int(11) NOT NULL,
  `passport_number` int(11) NOT NULL,
  `total_milage_info` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer_segment_list`
--

INSERT INTO `customer_segment_list` (`segment_id`, `passport_number`, `total_milage_info`) VALUES
(1, 222222222, 2228),
(4, 444444444, 0),
(4, 1111111111, 0);

-- --------------------------------------------------------

--
-- Table structure for table `fare`
--

CREATE TABLE `fare` (
  `fare_id` int(11) NOT NULL,
  `flight_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `fare`
--

INSERT INTO `fare` (`fare_id`, `flight_id`, `amount`) VALUES
(1, 1, 250),
(2, 1, 300),
(3, 1, 51),
(4, 1, 265),
(5, 1, 1137),
(6, 1, 572),
(7, 1, 1072),
(8, 1, 838),
(9, 1, 438),
(10, 1, 114),
(11, 1, 231),
(12, 1, 295),
(13, 1, 316),
(14, 1, 972),
(15, 1, 556),
(16, 1, 732),
(17, 1, 1168),
(18, 1, 137),
(19, 1, 777),
(20, 1, 97),
(21, 1, 668),
(22, 1, 594),
(23, 1, 1167),
(24, 1, 864),
(25, 1, 201),
(26, 1, 515),
(27, 1, 988),
(28, 1, 747);

-- --------------------------------------------------------

--
-- Table structure for table `ffc`
--

CREATE TABLE `ffc` (
  `seat_reservation_id` int(11) NOT NULL,
  `transaction_checkhed` bit(1) NOT NULL,
  `milage_info` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ffc`
--

INSERT INTO `ffc` (`seat_reservation_id`, `transaction_checkhed`, `milage_info`) VALUES
(63494, b'1', 696),
(63495, b'1', 668),
(63497, b'0', 520),
(5690252, b'0', 0),
(5690253, b'0', 359),
(5690254, b'0', 371),
(5690255, b'0', 104),
(5690256, b'0', 1136),
(5690257, b'0', 496),
(5690258, b'0', 288),
(5690259, b'0', 362),
(5690260, b'0', 51),
(5690261, b'0', 265),
(5690262, b'0', 0),
(5690263, b'0', 0),
(5690264, b'0', 0),
(5690265, b'0', 0),
(5690266, b'0', 0),
(5690267, b'0', 0),
(5690268, b'0', 0),
(5690269, b'0', 0),
(5690270, b'0', 0),
(5690271, b'0', 0),
(5690272, b'0', 0),
(5690273, b'0', 0),
(5690274, b'0', 0),
(5690275, b'1', 0),
(5690276, b'0', 0),
(5690277, b'0', 0),
(5690278, b'0', 668),
(5690279, b'0', 594),
(5690280, b'0', 1167),
(5690281, b'1', 864),
(5690282, b'0', 201),
(5690283, b'0', 515),
(5690284, b'0', 988),
(5690285, b'0', 747);

--
-- Triggers `ffc`
--
DELIMITER $$
CREATE TRIGGER `total_milage_update` AFTER UPDATE ON `ffc` FOR EACH ROW IF NEW.transaction_checkhed = 1 THEN
    SET @pnum=(SELECT passport_number from seat_reservation where seat_reservation_id=NEW.seat_reservation_id);
    IF  OLD.transaction_checkhed=0 THEN           
            SET @oldmilage=(SELECT total_milage_info from customer_segment_list where passport_number=@pnum);
            UPDATE customer_segment_list SET total_milage_info=(@oldmilage + NEW.milage_info)WHERE passport_number=@pnum;
    ELSE
        SET @oldmilage=(SELECT total_milage_info from customer_segment_list where passport_number=@pnum);
         UPDATE customer_segment_list SET total_milage_info=(@oldmilage + NEW.milage_info - OLD.milage_info)WHERE passport_number=@pnum;   
      END IF;
END IF
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `total_milage_updatefordelete` AFTER DELETE ON `ffc` FOR EACH ROW BEGIN
SET @passport_id = (SELECT passport_number from seat_reservation WHERE seat_reservation_id = OLD.seat_reservation_id);

 

SET @oldmilage = ( SELECT total_milage_info from customer_segment_list where passport_number=@passport_id );

 

UPDATE customer_segment_list SET total_milage_info=(@oldmilage - OLD.milage_info) where passport_number = @passport_id ;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `flight`
--

CREATE TABLE `flight` (
  `flight` int(11) NOT NULL,
  `airline_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `flight`
--

INSERT INTO `flight` (`flight`, `airline_id`) VALUES
(1, 6),
(2, 8);

-- --------------------------------------------------------

--
-- Table structure for table `flight_leg`
--

CREATE TABLE `flight_leg` (
  `leg_number` int(11) NOT NULL,
  `flight_id` int(11) NOT NULL,
  `sch_dep_airport_id` int(11) NOT NULL,
  `sch_arr_airport_id` int(11) NOT NULL,
  `sch_dep_time` time NOT NULL,
  `sch_arr_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `flight_leg`
--

INSERT INTO `flight_leg` (`leg_number`, `flight_id`, `sch_dep_airport_id`, `sch_arr_airport_id`, `sch_dep_time`, `sch_arr_time`) VALUES
(1, 1, 2, 4, '21:45:10', '22:45:10'),
(2, 1, 2, 4, '23:45:10', '00:45:10');

-- --------------------------------------------------------

--
-- Table structure for table `leg_instance`
--

CREATE TABLE `leg_instance` (
  `leg_instance_id` int(11) NOT NULL,
  `airplane_id` int(11) NOT NULL,
  `flight_id` int(11) NOT NULL,
  `flight_leg_id` int(11) NOT NULL,
  `dep_airport_id` int(11) NOT NULL,
  `arr_airport_id` int(11) NOT NULL,
  `number_of_avaible_seats` int(11) NOT NULL,
  `date` date NOT NULL,
  `dep_time` time DEFAULT NULL,
  `arr_time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `leg_instance`
--

INSERT INTO `leg_instance` (`leg_instance_id`, `airplane_id`, `flight_id`, `flight_leg_id`, `dep_airport_id`, `arr_airport_id`, `number_of_avaible_seats`, `date`, `dep_time`, `arr_time`) VALUES
(1, 6, 1, 1, 2, 4, 100, '2021-02-18', NULL, NULL),
(2, 7, 1, 2, 2, 4, 120, '2021-02-19', NULL, NULL),
(5, 7, 2, 1, 2, 3, 100, '2021-02-18', NULL, NULL);

--
-- Triggers `leg_instance`
--
DELIMITER $$
CREATE TRIGGER `leg_instance_time` BEFORE INSERT ON `leg_instance` FOR EACH ROW BEGIN 
	IF NEW.arr_time < NEW.dep_time THEN
    	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Arrival time cannot be before departure time.";
     ELSEIF DAYOFWEEK(NEW.date) NOT IN (SELECT weekdays from weekdays as w WHERE w.flight_id = NEW.flight_id) THEN
     SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT="Leg instance date must be in weekdays.";
    end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `seat_reservation`
--

CREATE TABLE `seat_reservation` (
  `seat_reservation_id` int(11) NOT NULL,
  `seat_number` int(11) NOT NULL,
  `leg_instance_id` int(11) NOT NULL,
  `passport_number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `seat_reservation`
--

INSERT INTO `seat_reservation` (`seat_reservation_id`, `seat_number`, `leg_instance_id`, `passport_number`) VALUES
(63494, 0, 1, 222222222),
(63495, 0, 2, 222222222),
(63493, 0, 5, 1111111111),
(63497, 1, 1, 222222222),
(5690283, 30, 2, 222222222),
(5690284, 36, 2, 222222222),
(5690252, 42, 2, 222222222),
(5690282, 43, 2, 222222222),
(5690260, 48, 1, 222222222),
(5690271, 48, 2, 222222222),
(5690277, 49, 2, 222222222),
(5690269, 54, 1, 222222222),
(5690263, 54, 2, 222222222),
(5690265, 55, 2, 222222222),
(5690281, 56, 2, 222222222),
(5690261, 60, 1, 222222222),
(5690253, 60, 2, 222222222),
(5690270, 61, 2, 222222222),
(5690264, 66, 2, 222222222),
(5690259, 66, 5, 222222222),
(5690274, 67, 2, 222222222),
(5690262, 72, 2, 222222222),
(5690258, 72, 5, 222222222),
(5690266, 73, 2, 222222222),
(5690256, 78, 1, 222222222),
(5690268, 78, 2, 222222222),
(5690276, 79, 2, 222222222),
(5690267, 84, 2, 222222222),
(5690273, 85, 2, 222222222),
(5690254, 90, 2, 222222222),
(5690257, 90, 5, 222222222),
(5690275, 91, 2, 222222222),
(5690285, 94, 2, 222222222),
(5690278, 96, 2, 222222222),
(5690255, 98, 2, 222222222),
(5690272, 102, 2, 222222222),
(5690279, 108, 2, 222222222),
(5690280, 126, 2, 222222222);

--
-- Triggers `seat_reservation`
--
DELIMITER $$
CREATE TRIGGER `FFC_adder` AFTER INSERT ON `seat_reservation` FOR EACH ROW INSERT INTO `ffc`(`seat_reservation_id`, `transaction_checkhed`, `milage_info`) VALUES (NEW.seat_reservation_id,0,0)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `segment_list`
--

CREATE TABLE `segment_list` (
  `segment_id` int(11) NOT NULL,
  `segment_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `segment_list`
--

INSERT INTO `segment_list` (`segment_id`, `segment_name`) VALUES
(1, 'platinum'),
(2, 'gold'),
(3, 'silver'),
(4, 'bronze');

-- --------------------------------------------------------

--
-- Table structure for table `weekdays`
--

CREATE TABLE `weekdays` (
  `flight_id` int(11) NOT NULL,
  `weekdays` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `weekdays`
--

INSERT INTO `weekdays` (`flight_id`, `weekdays`) VALUES
(1, 2),
(1, 3),
(1, 5),
(2, 1),
(2, 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `airline`
--
ALTER TABLE `airline`
  ADD PRIMARY KEY (`airline_id`);

--
-- Indexes for table `airplane`
--
ALTER TABLE `airplane`
  ADD PRIMARY KEY (`airplane_id`),
  ADD KEY `airplane_type_name` (`airplane_type_name`);

--
-- Indexes for table `airplane_type`
--
ALTER TABLE `airplane_type`
  ADD PRIMARY KEY (`Airplane_type_name`);

--
-- Indexes for table `airport`
--
ALTER TABLE `airport`
  ADD PRIMARY KEY (`Airport_id`);

--
-- Indexes for table `can_land`
--
ALTER TABLE `can_land`
  ADD PRIMARY KEY (`Airplane_type_name`,`airport_id`),
  ADD KEY `airport_id` (`airport_id`);

--
-- Indexes for table `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`comp_id`);

--
-- Indexes for table `company_owns`
--
ALTER TABLE `company_owns`
  ADD PRIMARY KEY (`comp_id`,`airplane_id`,`airline_id`),
  ADD KEY `airplane_id` (`airplane_id`),
  ADD KEY `airline_id` (`airline_id`),
  ADD KEY `comp_id` (`comp_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`passport_number`);

--
-- Indexes for table `customer_fares`
--
ALTER TABLE `customer_fares`
  ADD PRIMARY KEY (`seat_reservation_id`),
  ADD KEY `fare_id` (`fare_id`),
  ADD KEY `passport_number` (`passport_number`);

--
-- Indexes for table `customer_segment_list`
--
ALTER TABLE `customer_segment_list`
  ADD PRIMARY KEY (`passport_number`),
  ADD KEY `segment_id` (`segment_id`);

--
-- Indexes for table `fare`
--
ALTER TABLE `fare`
  ADD PRIMARY KEY (`fare_id`),
  ADD KEY `flight_id` (`flight_id`);

--
-- Indexes for table `ffc`
--
ALTER TABLE `ffc`
  ADD PRIMARY KEY (`seat_reservation_id`);

--
-- Indexes for table `flight`
--
ALTER TABLE `flight`
  ADD PRIMARY KEY (`flight`),
  ADD KEY `airline_id` (`airline_id`);

--
-- Indexes for table `flight_leg`
--
ALTER TABLE `flight_leg`
  ADD PRIMARY KEY (`leg_number`),
  ADD KEY `flight_id` (`flight_id`),
  ADD KEY `sch_dep_airport_id` (`sch_dep_airport_id`),
  ADD KEY `sch_arr_airport_id` (`sch_arr_airport_id`);

--
-- Indexes for table `leg_instance`
--
ALTER TABLE `leg_instance`
  ADD PRIMARY KEY (`leg_instance_id`),
  ADD KEY `airplane_id` (`airplane_id`),
  ADD KEY `flight_id` (`flight_id`),
  ADD KEY `flight_leg_id` (`flight_leg_id`),
  ADD KEY `dep_airport_id` (`dep_airport_id`),
  ADD KEY `arr_airport_id` (`arr_airport_id`);

--
-- Indexes for table `seat_reservation`
--
ALTER TABLE `seat_reservation`
  ADD PRIMARY KEY (`seat_number`,`leg_instance_id`),
  ADD UNIQUE KEY `seat_reservation_id` (`seat_reservation_id`),
  ADD KEY `passport_number` (`passport_number`),
  ADD KEY `leg_instance_id` (`leg_instance_id`);

--
-- Indexes for table `segment_list`
--
ALTER TABLE `segment_list`
  ADD PRIMARY KEY (`segment_id`);

--
-- Indexes for table `weekdays`
--
ALTER TABLE `weekdays`
  ADD PRIMARY KEY (`flight_id`,`weekdays`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `airline`
--
ALTER TABLE `airline`
  MODIFY `airline_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `airplane`
--
ALTER TABLE `airplane`
  MODIFY `airplane_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `airport`
--
ALTER TABLE `airport`
  MODIFY `Airport_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `company`
--
ALTER TABLE `company`
  MODIFY `comp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `company_owns`
--
ALTER TABLE `company_owns`
  MODIFY `comp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `fare`
--
ALTER TABLE `fare`
  MODIFY `fare_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `flight`
--
ALTER TABLE `flight`
  MODIFY `flight` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `flight_leg`
--
ALTER TABLE `flight_leg`
  MODIFY `leg_number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `leg_instance`
--
ALTER TABLE `leg_instance`
  MODIFY `leg_instance_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `seat_reservation`
--
ALTER TABLE `seat_reservation`
  MODIFY `seat_reservation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5690286;

--
-- AUTO_INCREMENT for table `segment_list`
--
ALTER TABLE `segment_list`
  MODIFY `segment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `airplane`
--
ALTER TABLE `airplane`
  ADD CONSTRAINT `airplane_ibfk_1` FOREIGN KEY (`airplane_type_name`) REFERENCES `airplane_type` (`Airplane_type_name`);

--
-- Constraints for table `can_land`
--
ALTER TABLE `can_land`
  ADD CONSTRAINT `can_land_ibfk_1` FOREIGN KEY (`airport_id`) REFERENCES `airport` (`Airport_id`),
  ADD CONSTRAINT `can_land_ibfk_2` FOREIGN KEY (`Airplane_type_name`) REFERENCES `airplane_type` (`Airplane_type_name`);

--
-- Constraints for table `company_owns`
--
ALTER TABLE `company_owns`
  ADD CONSTRAINT `company_owns_ibfk_1` FOREIGN KEY (`airplane_id`) REFERENCES `airplane` (`airplane_id`),
  ADD CONSTRAINT `company_owns_ibfk_2` FOREIGN KEY (`airline_id`) REFERENCES `airline` (`airline_id`),
  ADD CONSTRAINT `company_owns_ibfk_3` FOREIGN KEY (`comp_id`) REFERENCES `company` (`comp_id`);

--
-- Constraints for table `customer_fares`
--
ALTER TABLE `customer_fares`
  ADD CONSTRAINT `customer_fares_ibfk_1` FOREIGN KEY (`seat_reservation_id`) REFERENCES `seat_reservation` (`seat_reservation_id`),
  ADD CONSTRAINT `customer_fares_ibfk_2` FOREIGN KEY (`fare_id`) REFERENCES `fare` (`fare_id`),
  ADD CONSTRAINT `customer_fares_ibfk_3` FOREIGN KEY (`passport_number`) REFERENCES `customer` (`passport_number`);

--
-- Constraints for table `customer_segment_list`
--
ALTER TABLE `customer_segment_list`
  ADD CONSTRAINT `customer_segment_list_ibfk_1` FOREIGN KEY (`segment_id`) REFERENCES `segment_list` (`segment_id`),
  ADD CONSTRAINT `customer_segment_list_ibfk_2` FOREIGN KEY (`passport_number`) REFERENCES `customer` (`passport_number`);

--
-- Constraints for table `fare`
--
ALTER TABLE `fare`
  ADD CONSTRAINT `fare_ibfk_1` FOREIGN KEY (`flight_id`) REFERENCES `flight` (`flight`);

--
-- Constraints for table `ffc`
--
ALTER TABLE `ffc`
  ADD CONSTRAINT `ffc_ibfk_1` FOREIGN KEY (`seat_reservation_id`) REFERENCES `seat_reservation` (`seat_reservation_id`);

--
-- Constraints for table `flight`
--
ALTER TABLE `flight`
  ADD CONSTRAINT `flight_ibfk_1` FOREIGN KEY (`airline_id`) REFERENCES `airline` (`airline_id`);

--
-- Constraints for table `flight_leg`
--
ALTER TABLE `flight_leg`
  ADD CONSTRAINT `flight_leg_ibfk_1` FOREIGN KEY (`flight_id`) REFERENCES `flight` (`flight`),
  ADD CONSTRAINT `flight_leg_ibfk_2` FOREIGN KEY (`sch_dep_airport_id`) REFERENCES `airport` (`Airport_id`),
  ADD CONSTRAINT `flight_leg_ibfk_3` FOREIGN KEY (`sch_arr_airport_id`) REFERENCES `airport` (`Airport_id`);

--
-- Constraints for table `leg_instance`
--
ALTER TABLE `leg_instance`
  ADD CONSTRAINT `leg_instance_ibfk_1` FOREIGN KEY (`airplane_id`) REFERENCES `airplane` (`airplane_id`),
  ADD CONSTRAINT `leg_instance_ibfk_2` FOREIGN KEY (`flight_id`) REFERENCES `flight` (`flight`),
  ADD CONSTRAINT `leg_instance_ibfk_3` FOREIGN KEY (`flight_leg_id`) REFERENCES `flight_leg` (`leg_number`),
  ADD CONSTRAINT `leg_instance_ibfk_4` FOREIGN KEY (`dep_airport_id`) REFERENCES `airport` (`Airport_id`),
  ADD CONSTRAINT `leg_instance_ibfk_5` FOREIGN KEY (`arr_airport_id`) REFERENCES `airport` (`Airport_id`);

--
-- Constraints for table `seat_reservation`
--
ALTER TABLE `seat_reservation`
  ADD CONSTRAINT `seat_reservation_ibfk_1` FOREIGN KEY (`leg_instance_id`) REFERENCES `leg_instance` (`leg_instance_id`),
  ADD CONSTRAINT `seat_reservation_ibfk_2` FOREIGN KEY (`passport_number`) REFERENCES `customer` (`passport_number`);

--
-- Constraints for table `weekdays`
--
ALTER TABLE `weekdays`
  ADD CONSTRAINT `weekdays_ibfk_1` FOREIGN KEY (`flight_id`) REFERENCES `flight` (`flight`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
