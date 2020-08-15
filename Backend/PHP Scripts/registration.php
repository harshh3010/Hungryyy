<?php 
include "config.php";
// REGISTER USER
$email = mysqli_real_escape_string($connect, $_POST['email']);
$password = mysqli_real_escape_string($connect, $_POST['password']);
$vkey = md5(time().$email);

$result = mysqli_query($connect,"SELECT email FROM user_authentication where email='$email'");
$num_rows = mysqli_num_rows($result);
if($num_rows >= 1){
    //Email already exists
    echo json_encode("User exists");
}else{
    $query = "INSERT INTO user_authentication (email,password,vkey) VALUES('$email','$password','$vkey')";
    $results = mysqli_query($connect, $query);
    if($results>0)
    {
        //User registered
        $to = $email;
        $subject = 'Email Verification for Hungryyy App';
        $message = "<a href='http://192.168.43.50/hungryyy-app/verify.php?vkey=$vkey'>Verify Now</a>";
        $headers = "From: aise.hi0001@gmail.com \r\n";
        $headers .= "MIME-Version: 1.0"."\r\n";
        $headers .= "Content-type:text/html;charset=UTF-8"."\r\n";
        
        mail($to,$subject,$message,$headers);
        
        echo json_encode("User registered");
    }
}
?>