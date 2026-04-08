<?php
header("Content-Type: application/json");
require_once(__DIR__ . '/../models/flight.php');

$flight = new flight();

if(isset($_GET['search'])) {
    $origin = $_GET['origin'] ?? 0;
    $destination = $_GET['destination'] ?? 0;
    $date = $_GET['date'] ?? date('Y-m-d');
    echo $flight->searchFlights($origin, $destination, $date);
}
else if(isset($_GET['getallflights'])) {
    echo $flight->getAllFlights();
}
else if(isset($_GET['getflightdetails'])) {
    $flightid = $_GET['flightid'] ?? 0;
    echo $flight->getFlightDetails($flightid);
}
else if(isset($_POST['createbooking'])) {
    $result = $flight->createBooking(
        $_POST['passengerName'],
        $_POST['passengerEmail'],
        $_POST['passengerPhone'],
        $_POST['passportNo'],
        $_POST['flightId'],
        $_POST['seatNumber'] ?? 'A1'
    );
    echo json_encode($result);
}
else {
    echo json_encode(["status" => "error", "message" => "Invalid request"]);
}
?>