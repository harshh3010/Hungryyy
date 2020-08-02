<?php
$servername = "localhost";
$database = "hungryyy_app_db";
$username = "root";
$password = "";
// Create connection
$connect = mysqli_connect($servername, $username, $password, $database);
// Check connection
if (!$connect) {
    echo json_encode("Connection Failed");
}
?>