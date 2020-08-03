<?php 
include "config.php";
// REGISTER USER
$email = mysqli_real_escape_string($connect, $_POST['email']);
$password = mysqli_real_escape_string($connect, $_POST['password']);
$result = mysqli_query($connect,"SELECT email FROM user_authentication where email='$email'");
$num_rows = mysqli_num_rows($result);
if($num_rows >= 1){
    //Email already exists
    echo json_encode("User exists");
}else{
    $query = "INSERT INTO user_authentication (email,password) VALUES('$email','$password')";
    $results = mysqli_query($connect, $query);
    if($results>0)
    {
        //User registered
        echo json_encode("User registered");
    }
}
?>