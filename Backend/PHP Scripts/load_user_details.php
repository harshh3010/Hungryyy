<?php
 include "config.php";
 
$email = mysqli_real_escape_string($connect, $_POST['email']);
$sql = $connect->query("SELECT * FROM user_details WHERE email='$email'");
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