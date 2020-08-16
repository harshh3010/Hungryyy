<?php

include "config.php";

$order_id = mysqli_real_escape_string($connect, $_POST['order_id']);
$restaurant_id = mysqli_real_escape_string($connect, $_POST['restaurant_id']);

$sql = $connect->query("SELECT d.latitude AS d_lat,d.longitude AS d_lon,r.latitude AS r_lat,r.longitude AS r_lon from delivery d, restaurants r WHERE d.order_id='$order_id' AND d.restaurant_id='$restaurant_id' AND d.restaurant_id=r.id");
$res = array();

if($sql){
    while($row=$sql->fetch_assoc()){
        $res[]=$row;
    }
    echo json_encode($res);
}else{
    echo json_encode('Error loading data');
}

?>