<?php

include "config.php";

$mobile = mysqli_real_escape_string($connect, $_POST['mobile']);
$otp_input = mysqli_real_escape_string($connect, $_POST['otp']);

$result = mysqli_query($connect,"SELECT * FROM mobile WHERE mobile_number = $mobile AND verified = 0 ");

$num_rows = mysqli_num_rows($result);

if($num_rows >= 1){
    $row = $result->fetch_assoc();
    $otp = $row['otp'];
    
    if($otp == $otp_input){
        
        $update = $connect->query("UPDATE mobile SET verified = 1 WHERE mobile_number=$mobile LIMIT 1");
        if($update){
            echo json_encode("SUCCESS");
        }else{
            echo json_encode("FAILED");
        }
        
    }else{
        echo json_encode("FAILED");
    }
    
}else{
    echo json_encode("FAILED");
}

?>