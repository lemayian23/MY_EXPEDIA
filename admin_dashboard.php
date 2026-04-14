<?php
session_start();
if (!isset($_SESSION['admin_logged_in'])) {
    header('Location: admin_login.php');
    exit;
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - MY_EXPEDIA</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-dark bg-dark">
        <div class="container">
            <span class="navbar-brand">MY_EXPEDIA Admin Panel</span>
            <a href="admin_logout.php" class="btn btn-danger">Logout</a>
        </div>
    </nav>
    <div class="container mt-4">
        <h2>Flight Management</h2>
        <a href="admin_add_flight.php" class="btn btn-success mb-3">Add New Flight</a>
        <div id="flightList"></div>
    </div>
    <script>
        async function loadFlights() {
            const res = await fetch('controllers/flightoperations.php?getallflights');
            const flights = await res.json();
            let html = '<table class="table table-bordered"><thead><tr><th>ID</th><th>Flight#</th><th>Origin</th><th>Dest</th><th>Departure</th><th>Arrival</th><th>Aircraft</th><th>Actions</th></tr></thead><tbody>';
            flights.forEach(f => {
                html += `<tr>
                    <td>${f.FlightID}</td>
                    <td>${f.FlightNumber}</td>
                    <td>${f.OriginCity}</td>
                    <td>${f.DestCity}</td>
                    <td>${f.DepartureTime}</td>
                    <td>${f.ArrivalTime}</td>
                    <td>${f.Aircraft}</td>
                    <td>
                        <a href="admin_edit_flight.php?id=${f.FlightID}" class="btn btn-sm btn-primary">Edit</a>
                        <button onclick="deleteFlight(${f.FlightID})" class="btn btn-sm btn-danger">Delete</button>
                    </td>
                </tr>`;
            });
            html += '</tbody></table>';
            document.getElementById('flightList').innerHTML = html;
        }
        async function deleteFlight(id) {
            if (confirm('Are you sure?')) {
                const res = await fetch('controllers/flightoperations.php?deleteflight='+id);
                const data = await res.json();
                alert(data.message);
                loadFlights();
            }
        }
        loadFlights();
    </script>
</body>
</html>