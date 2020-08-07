<?php
 include "config.php";
 
$city_name = mysqli_real_escape_string($connect, $_POST['city_name']);
$state_name = mysqli_real_escape_string($connect, $_POST['state_name']);
$country_name = mysqli_real_escape_string($connect, $_POST['country_name']);
$category_id = mysqli_real_escape_string($connect, $_POST['category_id']);
if($category_id == 'none'){
    $sql = $connect->query("SELECT * FROM dishes WHERE city_name='$city_name' AND state_name='$state_name' AND country_name='$country_name'");
}else{
    $sql = $connect->query("SELECT * FROM dishes WHERE city_name='$city_name' AND state_name='$state_name' AND country_name='$country_name' AND category_id='$category_id'");
}

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