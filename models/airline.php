<?php
class airline extends db {
    
    // Method to check if airline exists
    function checkairline($airlineid, $airlinename) {
        try {
            $conn = $this->connect();
            $sql = "SELECT COUNT(*) as count FROM airlines WHERE airlinename = ? AND airlineid != ?";
            $stmt = $conn->prepare($sql);
            $stmt->execute([$airlinename, $airlineid]);
            $result = $stmt->fetch(PDO::FETCH_ASSOC);
            return $result['count'] > 0;
        } catch (PDOException $e) {
            error_log("Check airline error: " . $e->getMessage());
            return false;
        }
    }
    
    // Method to save/update airline
    function saveairline($airlineid, $airlinename, $homecountryid, $logo) {
        try {
            // Check if airline already exists (for new records)
            if ($airlineid == 0 && $this->checkairline($airlineid, $airlinename)) {
                return [
                    "status" => "error",
                    "message" => "Airline name already exists"
                ];
            }
            
            // Use stored procedure
            $conn = $this->connect();
            $sql = "CALL sp_saveairline(?, ?, ?, ?)";
            $stmt = $conn->prepare($sql);
            $stmt->execute([$airlineid, $airlinename, $homecountryid, $logo]);
            
            return [
                "status" => "success",
                "message" => "Airline saved successfully"
            ];
            
        } catch (PDOException $e) {
            error_log("Save airline error: " . $e->getMessage());
            return [
                "status" => "error",
                "message" => "Database error: " . $e->getMessage()
            ];
        }
    }
    
    // Method to get all airlines
    function getairlines() {
        try {
            $conn = $this->connect();
            $stmt = $conn->query("SELECT * FROM airlines");
            $results = $stmt->fetchAll(PDO::FETCH_ASSOC);
            return json_encode($results);
        } catch (PDOException $e) {
            return json_encode(["error" => $e->getMessage()]);
        }
    }

    function filterairlines($airlinename, $countryname){
        $sql = "CALL `sp_filterairlines`('{$airlinename}', '{$countryname}')";
        return $this->getJSON($sql);
    }
    
    // Method to get airline details
    function getairlinedetails($airlineid) {
        try {
            $conn = $this->connect();
            $stmt = $conn->prepare("SELECT * FROM airlines WHERE airlineid = ?");
            $stmt->execute([$airlineid]);
            $result = $stmt->fetch(PDO::FETCH_ASSOC);
            return json_encode($result);
        } catch (PDOException $e) {
            return json_encode(["error" => $e->getMessage()]);
        }
    }
    
    // Method to delete airline
    function deleteairline($airlineid) {
        try {
            $conn = $this->connect();
            $stmt = $conn->prepare("DELETE FROM airlines WHERE airlineid = ?");
            $stmt->execute([$airlineid]);
            return [
                "status" => "success",
                "message" => "Airline deleted successfully"
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