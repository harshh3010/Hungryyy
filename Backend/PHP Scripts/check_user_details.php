<?php
 include "config.php";
 
$email = mysqli_real_escape_string($connect, $_POST['email']);
$result = mysqli_query($connect,"select email from user_details");
$num_rows = mysqli_num_rows($result);
if($num_rows >= 1){
    echo json_encode("Data Present");
}else{
    echo json_encode("Data Absent");
}
?>