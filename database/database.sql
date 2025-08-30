/*
SQLyog Community v13.3.0 (64 bit)
MySQL - 10.4.32-MariaDB : Database - flightbooking2
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`flightbooking2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `flightbooking2`;

/*Table structure for table `aircraft` */

DROP TABLE IF EXISTS `aircraft`;

CREATE TABLE `aircraft` (
  `AircraftID` int(11) NOT NULL AUTO_INCREMENT,
  `Model` varchar(50) NOT NULL,
  `Capacity` int(11) NOT NULL,
  `RegistrationNo` varchar(20) NOT NULL,
  PRIMARY KEY (`AircraftID`),
  UNIQUE KEY `RegistrationNo` (`RegistrationNo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `aircraft` */

insert  into `aircraft`(`AircraftID`,`Model`,`Capacity`,`RegistrationNo`) values 
(1,'Boeing 737',180,'5Y-KQA'),
(3,'Boeing 737',180,'5Y-KQB');

/*Table structure for table `airlines` */

DROP TABLE IF EXISTS `airlines`;

CREATE TABLE `airlines` (
  `airlineid` int(11) NOT NULL AUTO_INCREMENT,
  `airlinename` varchar(100) NOT NULL,
  `homecountryid` int(11) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`airlineid`),
  UNIQUE KEY `unique_airlinename` (`airlinename`),
  KEY `homecountryid` (`homecountryid`),
  CONSTRAINT `airlines_ibfk_1` FOREIGN KEY (`homecountryid`) REFERENCES `countries` (`countryid`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `airlines` */

insert  into `airlines`(`airlineid`,`airlinename`,`homecountryid`,`logo`,`created_at`,`updated_at`) values 
(6,'Ethiopian Airlines',28,'ethiopian_airlines.png','2025-08-20 13:59:17','2025-08-20 13:59:17'),
(7,'RwandAir',29,'rwandair.png','2025-08-20 13:59:17','2025-08-20 13:59:17'),
(9,'Tanzania Airways',31,'tanzania_airways.png','2025-08-20 13:59:17','2025-08-20 13:59:17'),
(10,'South African Airways',32,'south_african_airways.png','2025-08-20 13:59:17','2025-08-20 13:59:17'),
(22,'Kenya Airways',27,'kenya_airways.png','2025-08-30 14:30:02','2025-08-30 14:30:02');

/*Table structure for table `airport` */

DROP TABLE IF EXISTS `airport`;

CREATE TABLE `airport` (
  `AirportID` int(11) NOT NULL AUTO_INCREMENT,
  `Code` varchar(5) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `City` varchar(30) NOT NULL,
  PRIMARY KEY (`AirportID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `airport` */

insert  into `airport`(`AirportID`,`Code`,`Name`,`City`) values 
(6,'NBO','Jomo Kenyatta International','Nairobi'),
(7,'JFK','John F. Kennedy International','New York'),
(8,'NBO','Jomo Kenyatta International','Nairobi'),
(9,'JFK','John F. Kennedy International','New York'),
(10,'NBO','Jomo Kenyatta International','Nairobi'),
(11,'JFK','John F. Kennedy International','New York'),
(12,'NBO','Jomo Kenyatta International','Nairobi'),
(13,'JFK','John F. Kennedy International','New York');

/*Table structure for table `booking` */

DROP TABLE IF EXISTS `booking`;

CREATE TABLE `booking` (
  `BookingID` int(11) NOT NULL AUTO_INCREMENT,
  `PassengerID` int(11) NOT NULL,
  `FlightID` int(11) NOT NULL,
  `SeatNumber` varchar(10) NOT NULL,
  `Status` varchar(20) DEFAULT 'Confirmed',
  PRIMARY KEY (`BookingID`),
  KEY `PassengerID` (`PassengerID`),
  KEY `FlightID` (`FlightID`),
  CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`PassengerID`) REFERENCES `passenger` (`PassengerID`),
  CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`FlightID`) REFERENCES `flights` (`FlightID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `booking` */

/*Table structure for table `cities` */

DROP TABLE IF EXISTS `cities`;

CREATE TABLE `cities` (
  `cityid` int(11) NOT NULL AUTO_INCREMENT,
  `cityname` varchar(100) DEFAULT NULL,
  `countryid` int(11) DEFAULT NULL,
  PRIMARY KEY (`cityid`),
  KEY `countryid` (`countryid`),
  CONSTRAINT `cities_ibfk_1` FOREIGN KEY (`countryid`) REFERENCES `countries` (`countryid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `cities` */

insert  into `cities`(`cityid`,`cityname`,`countryid`) values 
(1,'Nairobi',27),
(2,'Mombasa',27),
(3,'Addis Ababa',28);

/*Table structure for table `countries` */

DROP TABLE IF EXISTS `countries`;

CREATE TABLE `countries` (
  `countryid` int(11) NOT NULL AUTO_INCREMENT,
  `countryname` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`countryid`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `countries` */

insert  into `countries`(`countryid`,`countryname`) values 
(27,'Kenya'),
(28,'Ethiopia'),
(29,'Rwanda'),
(30,'Uganda'),
(31,'Tanzania'),
(32,'South Africa'),
(33,'Ethiopia'),
(34,'Rwanda'),
(35,'Uganda'),
(36,'Somalia'),
(37,'South Sudan'),
(38,'usa');

/*Table structure for table `crew` */

DROP TABLE IF EXISTS `crew`;

CREATE TABLE `crew` (
  `CrewID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `Role` varchar(20) NOT NULL,
  `FlightID` int(11) NOT NULL,
  PRIMARY KEY (`CrewID`),
  KEY `FlightID` (`FlightID`),
  CONSTRAINT `crew_ibfk_1` FOREIGN KEY (`FlightID`) REFERENCES `flights` (`FlightID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `crew` */

/*Table structure for table `flights` */

DROP TABLE IF EXISTS `flights`;

CREATE TABLE `flights` (
  `FlightID` int(11) NOT NULL AUTO_INCREMENT,
  `FlightNumber` varchar(10) NOT NULL,
  `DepartureTime` datetime NOT NULL,
  `ArrivalTime` datetime NOT NULL,
  `OriginAirportID` int(11) NOT NULL,
  `DestinationAirportID` int(11) NOT NULL,
  `AircraftID` int(11) NOT NULL,
  `EcoRoute` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`FlightID`),
  KEY `OriginAirportID` (`OriginAirportID`),
  KEY `DestinationAirportID` (`DestinationAirportID`),
  KEY `AircraftID` (`AircraftID`),
  CONSTRAINT `flights_ibfk_1` FOREIGN KEY (`OriginAirportID`) REFERENCES `airport` (`AirportID`),
  CONSTRAINT `flights_ibfk_2` FOREIGN KEY (`DestinationAirportID`) REFERENCES `airport` (`AirportID`),
  CONSTRAINT `flights_ibfk_3` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `flights` */

insert  into `flights`(`FlightID`,`FlightNumber`,`DepartureTime`,`ArrivalTime`,`OriginAirportID`,`DestinationAirportID`,`AircraftID`,`EcoRoute`) values 
(6,'NW101','2025-08-20 10:00:00','2025-08-20 12:00:00',6,7,1,0);

/*Table structure for table `passenger` */

DROP TABLE IF EXISTS `passenger`;

CREATE TABLE `passenger` (
  `PassengerID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `PassportNo` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`PassengerID`),
  UNIQUE KEY `PassportNo` (`PassportNo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `passenger` */

/*Table structure for table `payment` */

DROP TABLE IF EXISTS `payment`;

CREATE TABLE `payment` (
  `PaymentID` int(11) NOT NULL AUTO_INCREMENT,
  `BookingID` int(11) NOT NULL,
  `Amount` decimal(10,2) NOT NULL,
  `Method` varchar(20) NOT NULL,
  `Status` varchar(20) DEFAULT 'Completed',
  PRIMARY KEY (`PaymentID`),
  KEY `BookingID` (`BookingID`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`BookingID`) REFERENCES `booking` (`BookingID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `payment` */

/* Procedure structure for procedure `sp_checkairlines` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_checkairlines` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_checkairlines`($airlineid int, $airlinename varchar(50))
BEGIN
		select *
		from `airlines`
		where `airlineid`!=$airlineid and `airlinename`!= $airlinename;

	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_checkcity` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_checkcity` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_checkcity`(
    IN p_cityid INT,
    IN p_cityname VARCHAR(100)
)
BEGIN
    -- Check if city name exists (excluding current city if updating)
    IF p_cityid = 0 THEN
        -- For new cities, check if any city with this name exists
        SELECT COUNT(*) AS city_count 
        FROM cities 
        WHERE cityname = p_cityname;
    ELSE
        -- For updates, check if other cities have this name (excluding current)
        SELECT COUNT(*) AS city_count 
        FROM cities 
        WHERE cityname = p_cityname 
        AND cityid != p_cityid;
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_checkCountry` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_checkCountry` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_checkCountry`($countryid int, $countryname varchar(100))
BEGIN
		select * from `countries`
		where `countryid`!=$countryid and `countryname` = $countryname;

	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_createAircraft` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_createAircraft` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_createAircraft`(
    IN in_model VARCHAR(50),
    IN in_capacity INT,
    IN in_registrationNo VARCHAR(20)
)
BEGIN
    INSERT INTO `Aircraft` (`Model`, `Capacity`, `RegistrationNo`)
    VALUES (in_model, in_capacity, in_registrationNo);
    SELECT LAST_INSERT_ID() AS NewAircraftID;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_createAirport` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_createAirport` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_createAirport`(
    IN in_code VARCHAR(5),
    IN in_name VARCHAR(50),
    IN in_city VARCHAR(30)
)
BEGIN
    INSERT INTO `Airport` (`Code`, `Name`, `City`)
    VALUES (in_code, in_name, in_city);
    SELECT LAST_INSERT_ID() AS AirportID;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_createBooking` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_createBooking` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_createBooking`(
    IN in_passengerID INT,
    IN in_flightID INT,
    IN in_seatNumber VARCHAR(10),
    IN in_status VARCHAR(20)
)
BEGIN
    DECLARE seat_taken INT;
    
    -- Check if seat is already booked
    SELECT COUNT(*) INTO seat_taken 
    FROM `Booking` 
    WHERE `FlightID` = in_flightID AND `SeatNumber` = in_seatNumber;
    
    IF seat_taken > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Seat already occupied';
    ELSE
        INSERT INTO `Booking` (
            `PassengerID`, 
            `FlightID`, 
            `SeatNumber`, 
            `Status`
        ) VALUES (
            in_passengerID,
            in_flightID,
            in_seatNumber,
            IFNULL(in_status, 'Confirmed')
        );
        
        SELECT LAST_INSERT_ID() AS NewBookingID;
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_createCrew` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_createCrew` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_createCrew`(
    IN in_name VARCHAR(50),
    IN in_role VARCHAR(20),
    IN in_flightID INT)
BEGIN
    -- Validate flight exists
    IF NOT EXISTS (SELECT 1 FROM `Flight` WHERE `FlightID` = in_flightID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Flight does not exist';
    ELSE
        INSERT INTO `Crew` (`Name`, `Role`, `FlightID`)
        VALUES (in_name, in_role, in_flightID);
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_createFlight` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_createFlight` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_createFlight`(
    IN in_flightNumber VARCHAR(10),
    IN in_departureTime DATETIME,
    IN in_arrivalTime DATETIME,
    IN in_originAirportID INT,
    IN in_destinationAirportID INT,
    IN in_aircraftID INT,
    IN in_ecoRoute BOOLEAN
)
BEGIN
    INSERT INTO `Flight` (
        `FlightNumber`, 
        `DepartureTime`, 
        `ArrivalTime`, 
        `OriginAirportID`, 
        `DestinationAirportID`, 
        `AircraftID`, 
        `EcoRoute`
    ) VALUES (
        in_flightNumber,
        in_departureTime,
        in_arrivalTime,
        in_originAirportID,
        in_destinationAirportID,
        in_aircraftID,
        IFNULL(in_ecoRoute, FALSE)
    );
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_createPassenger` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_createPassenger` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_createPassenger`(
    IN in_name VARCHAR(50),
    IN in_phone VARCHAR(15),
    IN in_email VARCHAR(100),
    IN in_passportNo VARCHAR(20)
)
BEGIN
    INSERT INTO `Passenger` (`Name`, `Phone`, `Email`, `PassportNo`)
    VALUES (in_name, in_phone, in_email, in_passportNo);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_createPayment` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_createPayment` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_createPayment`(
    IN in_bookingID INT,
    IN in_amount DECIMAL(10,2),
    IN in_method VARCHAR(20),
    IN in_status VARCHAR(20))
BEGIN
    -- Validate booking exists
    IF NOT EXISTS (SELECT 1 FROM `Booking` WHERE `BookingID` = in_bookingID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Booking does not exist';
    ELSE
        INSERT INTO `Payment` (`BookingID`, `Amount`, `Method`, `Status`)
        VALUES (in_bookingID, in_amount, in_method, IFNULL(in_status, 'Completed'));
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_deleteAircraft` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_deleteAircraft` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deleteAircraft`(IN in_aircraftID INT)
BEGIN
    -- Prevent deletion if assigned to flights
    IF EXISTS (SELECT 1 FROM `Flight` WHERE `AircraftID` = in_aircraftID) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot delete aircraft assigned to active flights';
    ELSE
        DELETE FROM `Aircraft` WHERE `AircraftID` = in_aircraftID;
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_deleteairline` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_deleteairline` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deleteairline`($airlineid int)
BEGIN
		delete from `airlines`
		where `airlineid` = $airlineid;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_deleteAirport` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_deleteAirport` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deleteAirport`(IN in_airportID INT)
BEGIN
    -- Check for flight dependencies
    IF EXISTS (SELECT 1 FROM `Flight` 
               WHERE `OriginAirportID` = in_airportID 
               OR `DestinationAirportID` = in_airportID) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot delete airport used in flight routes';
    ELSE
        DELETE FROM `Airport` WHERE `AirportID` = in_airportID;
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_deleteBooking` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_deleteBooking` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deleteBooking`(IN in_bookingID INT)
BEGIN
    DECLARE payment_exists INT;
    
    -- Check for linked payment
    SELECT COUNT(*) INTO payment_exists 
    FROM `Payment` 
    WHERE `BookingID` = in_bookingID;
    
    IF payment_exists > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot delete booking with existing payment';
    ELSE
        DELETE FROM `Booking` WHERE `BookingID` = in_bookingID;
        SELECT CONCAT('Booking ', in_bookingID, ' deleted') AS Result;
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_deletecity` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_deletecity` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deletecity`(IN p_cityid INT)
BEGIN
    DELETE FROM cities WHERE cityid = p_cityid;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_deletecountry` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_deletecountry` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deletecountry`($countryid INT)
BEGIN
		DELETE FROM `countries`
		WHERE `countryid`= $countryid;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_deleteCrew` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_deleteCrew` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deleteCrew`(IN in_crewID INT)
BEGIN
    DELETE FROM `Crew` WHERE `CrewID` = in_crewID;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_deleteFlight` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_deleteFlight` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deleteFlight`(IN in_flightID INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error: Cannot delete flight with existing bookings/crew assignments' AS Message;
    END;
    
    START TRANSACTION;
    DELETE FROM `Booking` WHERE `FlightID` = in_flightID;
    DELETE FROM `CrewAssignment` WHERE `FlightID` = in_flightID;
    DELETE FROM `Flight` WHERE `FlightID` = in_flightID;
    COMMIT;
    
    SELECT CONCAT('Flight ', in_flightID, ' deleted successfully') AS Message;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_deletePassenger` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_deletePassenger` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deletePassenger`(IN in_id INT)
BEGIN
    DELETE FROM `Passenger` WHERE `PassengerID` = in_id;
    SELECT ROW_COUNT() AS 'RowsAffected';
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_deletePayment` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_deletePayment` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deletePayment`(IN in_paymentID INT)
BEGIN
    DELETE FROM `Payment` WHERE `PaymentID` = in_paymentID;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_filterairlines` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_filterairlines` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_filterairlines`($airlinename varchar (100), $countryname varchar(100))
BEGIN
		if $airlinename='' then
			set $airlinename='@@@';
		end if;
		
		if $countryname ='' then
			set $countryname = '@@@';
		end if;
		
		
		select  a. *, countryname
		from `airline` a
		join `countries`  c on c.countryid = a.homecuntryid
		where `airlinename` like concat ('%',$airlinename, '%')
		or countryname like concat('%', $countryname,'%')
		order by airlinename;

	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getAircraft` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getAircraft` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getAircraft`(IN in_aircraftID INT)
BEGIN
    SELECT 
        a.*,
        COUNT(f.FlightID) AS AssignedFlights
    FROM `Aircraft` a
    LEFT JOIN `Flight` f ON a.AircraftID = f.AircraftID
    WHERE a.`AircraftID` = in_aircraftID
    GROUP BY a.AircraftID;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getairlinedetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getairlinedetails` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localost` PROCEDURE `sp_getairlinedetails`($airlineid int)
BEGIN
		select a.*,countryname
		from `airline` a
		join `countries` c on c.countryid = a.homecountryid
		where a.arlineid = $airlineid;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getairlines` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getairlines` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getairlines`()
BEGIN
    SELECT * FROM airlines;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getAirport` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getAirport` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getAirport`(IN in_airportID INT)
BEGIN
    SELECT 
        a.*,
        (SELECT COUNT(*) FROM `Flight` WHERE `OriginAirportID` = a.AirportID) AS DepartingFlights,
        (SELECT COUNT(*) FROM `Flight` WHERE `DestinationAirportID` = a.AirportID) AS ArrivingFlights
    FROM `Airport` a
    WHERE a.`AirportID` = in_airportID;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getBooking` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getBooking` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getBooking`(IN in_bookingID INT)
BEGIN
    SELECT 
        b.*,
        p.Name AS PassengerName,
        f.FlightNumber,
        CONCAT(o.Code, ' → ', d.Code) AS Route
    FROM `Booking` b
    JOIN `Passenger` p ON b.PassengerID = p.PassengerID
    JOIN `Flight` f ON b.FlightID = f.FlightID
    JOIN `Airport` o ON f.OriginAirportID = o.AirportID
    JOIN `Airport` d ON f.DestinationAirportID = d.AirportID
    WHERE b.`BookingID` = in_bookingID;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getcities` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getcities` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getcities`()
BEGIN
    SELECT * FROM cities;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getcountries` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getcountries` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getcountries`()
BEGIN
    SELECT * FROM `countries`
    ORDER BY `countryname`;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getCrew` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getCrew` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getCrew`(IN in_crewID INT)
BEGIN
    SELECT 
        c.*,
        f.FlightNumber,
        CONCAT(a1.Code, '→', a2.Code) AS Route
    FROM `Crew` c
    JOIN `Flight` f ON c.FlightID = f.FlightID
    JOIN `Airport` a1 ON f.OriginAirportID = a1.AirportID
    JOIN `Airport` a2 ON f.DestinationAirportID = a2.AirportID
    WHERE c.`CrewID` = in_crewID;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getFlight` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getFlight` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getFlight`(IN in_flightID INT)
BEGIN
    SELECT 
        f.*,
        o.Name AS OriginAirport,
        d.Name AS DestinationAirport,
        a.Model AS AircraftModel
    FROM `Flight` f
    LEFT JOIN `Airport` o ON f.OriginAirportID = o.AirportID
    LEFT JOIN `Airport` d ON f.DestinationAirportID = d.AirportID
    LEFT JOIN `Aircraft` a ON f.AircraftID = a.AircraftID
    WHERE f.`FlightID` = in_flightID;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getPayment` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getPayment` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getPayment`(IN in_paymentID INT)
BEGIN
    SELECT 
        p.*,
        b.SeatNumber,
        CONCAT(ps.Name, ' (', f.FlightNumber, ')') AS BookingDetails
    FROM `Payment` p
    JOIN `Booking` b ON p.BookingID = b.BookingID
    JOIN `Passenger` ps ON b.PassengerID = ps.PassengerID
    JOIN `Flight` f ON b.FlightID = f.FlightID
    WHERE p.`PaymentID` = in_paymentID;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_readPassenger` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_readPassenger` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_readPassenger`(IN in_id INT)
BEGIN
    SELECT * FROM `Passenger` WHERE `PassengerID` = in_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_saveairline` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_saveairline` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_saveairline`(
    $airlineid INT,
    $airlinename VARCHAR(100),
    $homecountryid INT,  -- Fixed: Changed $omecountryid to $homecountryid
    $logo VARCHAR(100)
)
BEGIN
    -- Check if adding a new airline
    IF $airlineid = 0 THEN
        -- check if airline name exists 
        IF NOT EXISTS(SELECT * FROM `airlines` WHERE `airlinename` = $airlinename) THEN
            INSERT INTO  `airlines`(`airlinename`, `homecountryid`, `logo`)
            VALUES($airlinename, $homecountryid, $logo);
        END IF;
    ELSE
        -- check if airline name exists different from airlineid
        IF NOT EXISTS(SELECT * FROM `airlines` WHERE `airlineid` != $airlineid AND `airlinename` = $airlinename) THEN
            UPDATE `airlines`
            SET `airlinename` = $airlinename, `homecountryid` = $homecountryid, `logo` = $logo
            WHERE `airlineid` = $airlineid;
        END IF;
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_savecity` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_savecity` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savecity`(
    IN p_cityid INT,
    IN p_cityname VARCHAR(100),
    IN p_countryid INT
)
BEGIN
    DECLARE v_exists INT;
    
    -- Check if city exists
    CALL sp_checkcity(p_cityid, p_cityname);
    SELECT city_count INTO v_exists;
    
    IF v_exists = 0 THEN
        IF p_cityid = 0 THEN
            INSERT INTO cities (cityname, countryid) VALUES (p_cityname, p_countryid);
            SELECT 1 AS result, 'City created successfully' AS message;
        ELSE
            UPDATE cities SET cityname = p_cityname, countryid = p_countryid WHERE cityid = p_cityid;
            SELECT 1 AS result, 'City updated successfully' AS message;
        END IF;
    ELSE
        SELECT 0 AS result, 'City already exists' AS message;
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_savecountry` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_savecountry` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savecountry`(
    IN p_countryid INT,
    IN p_countryname VARCHAR(50)
)
BEGIN
    DECLARE v_exists INT DEFAULT 0;
    
    -- For UPDATE (countryid > 0)
    IF p_countryid > 0 THEN
        SELECT COUNT(*) INTO v_exists FROM countries WHERE countryid = p_countryid;
        
        IF v_exists > 0 THEN
            UPDATE countries SET countryname = p_countryname 
            WHERE countryid = p_countryid;
            
            SELECT 1 AS result, 
                   'Country updated successfully' AS message,
                   p_countryid AS countryid;
        ELSE
            SELECT 0 AS result, 
                   CONCAT('No country found with ID ', p_countryid) AS message,
                   p_countryid AS countryid;
        END IF;
    
    -- For INSERT (countryid = 0)
    ELSE
        SELECT COUNT(*) INTO v_exists FROM countries WHERE countryname = p_countryname;
        
        IF v_exists = 0 THEN
            INSERT INTO countries (countryname) VALUES (p_countryname);
            SELECT 1 AS result, 
                   'Country inserted successfully' AS message,
                   LAST_INSERT_ID() AS countryid;
        ELSE
            SELECT 0 AS result, 
                   'Country already exists' AS message,
                   (SELECT countryid FROM countries WHERE countryname = p_countryname LIMIT 1) AS countryid;
        END IF;
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_updateAircraft` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_updateAircraft` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_updateAircraft`(
    IN in_aircraftID INT,
    IN in_model VARCHAR(50),
    IN in_capacity INT,
    IN in_registrationNo VARCHAR(20)
)
BEGIN
    -- Check for registration conflicts (excluding current aircraft)
    IF EXISTS (SELECT 1 FROM `Aircraft` 
               WHERE `RegistrationNo` = in_registrationNo 
               AND `AircraftID` != in_aircraftID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Registration number already in use';
    ELSE
        UPDATE `Aircraft`
        SET `Model` = in_model,
            `Capacity` = in_capacity,
            `RegistrationNo` = in_registrationNo
        WHERE `AircraftID` = in_aircraftID;
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_updateAirport` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_updateAirport` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_updateAirport`(
    IN in_airportID INT,
    IN in_code VARCHAR(5),
    IN in_name VARCHAR(50),
    IN in_city VARCHAR(30)
)
BEGIN
    UPDATE `Airport`
    SET `Code` = in_code,
        `Name` = in_name,
        `City` = in_city
    WHERE `AirportID` = in_airportID;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_updateBooking` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_updateBooking` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_updateBooking`(
    IN in_bookingID INT,
    IN in_seatNumber VARCHAR(10),
    IN in_status VARCHAR(20)
)
BEGIN
    DECLARE original_flightID INT;
    DECLARE seat_taken INT;
    
    -- Get original flight for seat validation
    SELECT FlightID INTO original_flightID 
    FROM `Booking` 
    WHERE BookingID = in_bookingID;
    
    -- Check new seat availability
    SELECT COUNT(*) INTO seat_taken 
    FROM `Booking` 
    WHERE FlightID = original_flightID 
      AND SeatNumber = in_seatNumber
      AND BookingID != in_bookingID;
    
    IF seat_taken > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Seat already occupied';
    ELSE
        UPDATE `Booking`
        SET 
            `SeatNumber` = in_seatNumber,
            `Status` = in_status
        WHERE `BookingID` = in_bookingID;
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_updateCrew` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_updateCrew` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_updateCrew`(
    IN in_crewID INT,
    IN in_name VARCHAR(50),
    IN in_role VARCHAR(20),
    IN in_flightID INT)
BEGIN
    UPDATE `Crew`
    SET `Name` = in_name,
        `Role` = in_role,
        `FlightID` = in_flightID
    WHERE `CrewID` = in_crewID;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_updateFlight` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_updateFlight` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_updateFlight`(
    IN in_flightID INT,
    IN in_flightNumber VARCHAR(10),
    IN in_departureTime DATETIME,
    IN in_arrivalTime DATETIME,
    IN in_originAirportID INT,
    IN in_destinationAirportID INT,
    IN in_aircraftID INT,
    IN in_ecoRoute BOOLEAN
)
BEGIN
    UPDATE `Flight`
    SET 
        `FlightNumber` = in_flightNumber,
        `DepartureTime` = in_departureTime,
        `ArrivalTime` = in_arrivalTime,
        `OriginAirportID` = in_originAirportID,
        `DestinationAirportID` = in_destinationAirportID,
        `AircraftID` = in_aircraftID,
        `EcoRoute` = IFNULL(in_ecoRoute, FALSE)
    WHERE `FlightID` = in_flightID;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_updatePassenger` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_updatePassenger` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_updatePassenger`(
    IN in_id INT,
    IN in_name VARCHAR(50),
    IN in_phone VARCHAR(15),
    IN in_email VARCHAR(100),
    IN in_passportNo VARCHAR(20)
)
BEGIN
    UPDATE `Passenger`
    SET `Name` = in_name, 
        `Phone` = in_phone, 
        `Email` = in_email, 
        `PassportNo` = in_passportNo
    WHERE `PassengerID` = in_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_updatePayment` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_updatePayment` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_updatePayment`(
    IN in_paymentID INT,
    IN in_status VARCHAR(20))
BEGIN
    UPDATE `Payment`
    SET `Status` = in_status
    WHERE `PaymentID` = in_paymentID;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
