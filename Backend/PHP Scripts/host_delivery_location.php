<?php

include "config.php";

$order_id = mysqli_real_escape_string($connect, $_POST['order_id']);
$restaurant_id = mysqli_real_escape_string($connect, $_POST['restaurant_id']);
$latitude = mysqli_real_escape_string($connect, $_POST['latitude']);
$longitude = mysqli_real_escape_string($connect, $_POST['longitude']);

$sql = $connect->query("UPDATE delivery SET latitude='$latitude',longitude='$longitude' WHERE order_id='$order_id' AND restaurant_id='$restaurant_id' ");

?>