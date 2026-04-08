<?php
require_once("db.php");

class flight extends db {
    
    function searchFlights($origin, $destination, $date) {
        $sql = "CALL sp_search_flights({$origin}, {$destination}, '{$date}')";
        return $this->getJSON($sql);
    }
    
    function getAllFlights() {
        $sql = "SELECT f.*, 
                a.Model as Aircraft,
                ap1.Name as OriginAirport,
                ap1.City as OriginCity,
                ap2.Name as DestAirport,
                ap2.City as DestCity
                FROM flights f
                JOIN aircraft a ON f.AircraftID = a.AircraftID
                JOIN airport ap1 ON f.OriginAirportID = ap1.AirportID
                JOIN airport ap2 ON f.DestinationAirportID = ap2.AirportID";
        return $this->getJSON($sql);
    }
    
    function getFlightDetails($flightid) {
        $sql = "CALL sp_getFlight({$flightid})";
        return $this->getJSON($sql);
    }
    
    function createBooking($passengerName, $passengerEmail, $passengerPhone, $passportNo, $flightId, $seatNumber) {
        try {
            $conn = $this->connect();
            
            // First, create passenger
            $sqlPassenger = "INSERT INTO passenger (Name, Email, Phone, PassportNo) 
                            VALUES (?, ?, ?, ?)";
            $stmt = $conn->prepare($sqlPassenger);
            $stmt->execute([$passengerName, $passengerEmail, $passengerPhone, $passportNo]);
            $passengerId = $conn->lastInsertId();
            
            // Then create booking
            $sqlBooking = "CALL sp_createBooking({$passengerId}, {$flightId}, '{$seatNumber}', 'Confirmed')";
            $stmt = $conn->prepare($sqlBooking);
            $stmt->execute();
            
            return [
                "status" => "success",
                "message" => "Booking confirmed successfully!",
                "booking_id" => $conn->lastInsertId()
            ];
            
        } catch (PDOException $e) {
            return [
                "status" => "error",
                "message" => $e->getMessage()
            ];
        }
    }
}
?>