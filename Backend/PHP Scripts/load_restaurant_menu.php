<?php
 include "config.php";
 
$restaurant_id = mysqli_real_escape_string($connect, $_POST['restaurant_id']);
$sql = $connect->query("SELECT * FROM dishes WHERE restaurant_id='$restaurant_id'");
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