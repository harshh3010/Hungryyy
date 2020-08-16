<?php

include 'config.php';

if(isset($_GET['vkey'])){
    // Process verification
    $vkey = $_GET['vkey'];
    $result = $connect->query("SELECT verified,vkey FROM user_authentication WHERE verified=0 AND vkey ='$vkey' LIMIT 1");
    
    if($result->num_rows == 1){
        // Validate the email
        $update = $connect->query("UPDATE user_authentication SET verified = 1 WHERE vkey='$vkey' LIMIT 1");
        if($update){
            echo "Your account has been verified. You may now sign in.";
        }else{
            echo $connect->error;
        }
    }else{
        echo "This account is invalid or already verified";
    }
}else{
    die("Something went wrong");
}

?>