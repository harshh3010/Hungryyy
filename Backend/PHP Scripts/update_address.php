<?php

include "config.php";

$email = mysqli_real_escape_string($connect, $_POST['email']);
$house_name = mysqli_real_escape_string($connect, $_POST['house_name']);
$city_name = mysqli_real_escape_string($connect, $_POST['city_name']);
$street_name = mysqli_real_escape_string($connect, $_POST['street_name']);
$state_name = mysqli_real_escape_string($connect, $_POST['state_name']);
$country_name = mysqli_real_escape_string($connect, $_POST['country_name']);
$postal_code = mysqli_real_escape_string($connect, $_POST['postal_code']);

$sql = $connect->query("UPDATE user_details SET house_name='$house_name',city_name='$city_name',street_name='$street_name',state_name='$state_name',country_name='$country_name',postal_code='$postal_code' WHERE email='$email' ");

if($sql){
    echo json_encode("SUCCESS");
}else{
    json_encode("FAILED");
}

?>