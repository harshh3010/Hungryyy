<?php
 include "config.php";
 
$city_name = mysqli_real_escape_string($connect, $_POST['city_name']);
$state_name = mysqli_real_escape_string($connect, $_POST['state_name']);
$country_name = mysqli_real_escape_string($connect, $_POST['country_name']);

$sql = $connect->query("select * from dishes where city_name='$city_name' AND state_name='$state_name' AND country_name='$country_name' group by rating having rating=max(rating) order by rating DESC");

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