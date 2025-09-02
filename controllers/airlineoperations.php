<?php
// Set header first to ensure proper JSON response
header("Content-Type: application/json");

// Include required files with proper error handling
require_once(__DIR__ . '/../models/db.php');
require_once(__DIR__ . '/../models/airline.php');

// Create airline instance
$airline = new airline();

// Handle POST request
if(isset($_POST['saveairline'])){
    // Get form data
    $airlineid = $_POST['airlineid'] ?? 0;
    $airlinename = $_POST['airlinename'] ?? '';
    $homecountryid = $_POST['homecountryid'] ?? null;
    $logo = $_POST['logo'] ?? null;

    // Validate required fields
    if(empty($airlinename)) {
        echo json_encode([
            "status" => "error",
            "message" => "Airline name is required"
        ]);
        exit;
    }

    // Save airline and return response
    $response = $airline->saveairline($airlineid, $airlinename, $homecountryid, $logo);
    echo json_encode($response);
} 

// Handle POST request for delete
else if(isset($_POST['deleteairline'])){
    $airlineid = $_POST['airlineid'] ?? 0;
    $response = $airline->deleteairline($airlineid);
    echo json_encode($response);
}

// Handle GET request for filtering
else if(isset($_GET['filterairlines'])){
    $airlinename = isset($_GET['airlinename']) ? $_GET['airlinename'] : "";
    $countryname = isset($_GET['countryname']) ? $_GET['countryname'] : "";

    echo $airline->filterairlines($airlinename, $countryname);
}

// Handle GET request for airline details
else if(isset($_GET['getairlinedetails'])){
    $airlineid = $_GET['airlineid'] ?? 0;
    echo $airline->getairlinedetails($airlineid);
}

else {
    // Return error if not a valid request
    echo json_encode([
        "status" => "error",
        "message" => "Invalid request method or missing parameters"
    ]);
}
?><?php
// Set header first to ensure proper JSON response
header("Content-Type: application/json");

// Include required files with proper error handling
require_once(__DIR__ . '/../models/db.php');
require_once(__DIR__ . '/../models/airline.php');

// Create airline instance
$airline = new airline();

// Handle POST request
if(isset($_POST['saveairline'])){
    // Get form data
    $airlineid = $_POST['airlineid'] ?? 0;
    $airlinename = $_POST['airlinename'] ?? '';
    $homecountryid = $_POST['homecountryid'] ?? null;
    $logo = $_POST['logo'] ?? null;

    // Validate required fields
    if(empty($airlinename)) {
        echo json_encode([
            "status" => "error",
            "message" => "Airline name is required"
        ]);
        exit;
    }

    // Save airline and return response
    $response = $airline->saveairline($airlineid, $airlinename, $homecountryid, $logo);
    echo json_encode($response);
} 

// Handle POST request for delete
else if(isset($_POST['deleteairline'])){
    $airlineid = $_POST['airlineid'] ?? 0;
    $response = $airline->deleteairline($airlineid);
    echo json_encode($response);
}

// Handle GET request for filtering
else if(isset($_GET['filterairlines'])){
    $airlinename = isset($_GET['airlinename']) ? $_GET['airlinename'] : "";
    $countryname = isset($_GET['countryname']) ? $_GET['countryname'] : "";

    echo $airline->filterairlines($airlinename, $countryname);
}

// Handle GET request for airline details
else if(isset($_GET['getairlinedetails'])){
    $airlineid = $_GET['airlineid'] ?? 0;
    echo $airline->getairlinedetails($airlineid);
}

else {
    // Return error if not a valid request
    echo json_encode([
        "status" => "error",
        "message" => "Invalid request method or missing parameters"
    ]);
}
?>