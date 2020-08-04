<?php 
include "config.php";

$email = mysqli_real_escape_string($connect, $_POST['email']);
$name = mysqli_real_escape_string($connect, $_POST['name']);
$phone_number = mysqli_real_escape_string($connect, $_POST['phone_number']);

$query = "INSERT INTO user_details (email,name,phone_number) VALUES('$email','$name',$phone_number)";
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