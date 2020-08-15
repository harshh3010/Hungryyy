<?php
 include "config.php";
 
$email = mysqli_real_escape_string($connect, $_POST['email']);
$password = mysqli_real_escape_string($connect, $_POST['password']);
$result = mysqli_query($connect,"select * from user_authentication where email = '$email' and password = '$password' ");
$num_rows = mysqli_num_rows($result);
if($num_rows >= 1){
    $row = $result->fetch_assoc();
    $verified = $row['verified'];
    
    if($verified == 1){
        // Login user
        echo json_encode("Login Success");
    }else{
        // Email not verified
        echo json_encode("Not Verified");
    }
    
}else{
    echo json_encode("Invalid Credentials");
}
?>