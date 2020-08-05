<?php 
include "config.php";

$email = mysqli_real_escape_string($connect, $_POST['email']);
$name = mysqli_real_escape_string($connect, $_POST['name']);
$phone_number = mysqli_real_escape_string($connect, $_POST['phone_number']);
$house_name = mysqli_real_escape_string($connect, $_POST['house_name']);
$city_name = mysqli_real_escape_string($connect, $_POST['city_name']);
$street_name = mysqli_real_escape_string($connect, $_POST['street_name']);
$state_name = mysqli_real_escape_string($connect, $_POST['state_name']);
$country_name = mysqli_real_escape_string($connect, $_POST['country_name']);
$postal_code = mysqli_real_escape_string($connect, $_POST['postal_code']);

$query = "INSERT INTO user_details (email,name,phone_number,house_name,street_name,city_name,state_name,postal_code,country_name) VALUES('$email','$name',$phone_number,'$house_name','$street_name','$city_name','$state_name','$postal_code','$country_name')";
$results = mysqli_query($connect, $query);
if($results>0)
{
    //Data added
    echo json_encode("SUCCESS");
}else{
    //Data not added
    echo json_encode("FAILED");
}
    
?>