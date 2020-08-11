<?php

include "config.php";

$restaurant_id = mysqli_real_escape_string($connect, $_POST['restaurant_id']);
$id = mysqli_real_escape_string($connect, $_POST['id']);

$sql = $connect->query("DELETE FROM orders WHERE restaurant_id='$restaurant_id' AND id='$id'");

if($sql){
    echo json_encode("SUCCESS");
}else{
    echo json_encode("FAILED");
}
?>