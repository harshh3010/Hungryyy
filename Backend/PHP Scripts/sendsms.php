<?php

include "config.php";
require('textlocal.class.php');

$mobile = mysqli_real_escape_string($connect, $_POST['mobile']);

$textlocal = new Textlocal(false,false,'<ENTER YOUR TEXTLOCAL API KEY HERE>');

$numbers = array('91'.$mobile);
$sender = 'TXTLCL';
$otp = mt_rand(10000,99999);
$message = 'Dear user, ' . $otp . ' is your OTP verification code for hungryyy app.';

try {
    $result = $textlocal->sendSms($numbers, $message, $sender);
    
    $res = $connect->query("INSERT INTO mobile (mobile_number,otp) VALUES ($mobile,$otp) ");
    if($res>0){
        echo json_encode('OTP Sent');
    }else{
        echo json_encode('ERROR');
    }
    
} catch (Exception $e) {
    echo json_encode('OTP Not Sent');
}

?>