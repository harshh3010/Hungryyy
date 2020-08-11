<?php

include "config.php";

$customer_email = mysqli_real_escape_string($connect, $_POST['customer_email']);

$sql = $connect->query(
    "SELECT o.id,o.restaurant_id,o.restaurant_name,o.customer_email,o.customer_contact,u.name,o.to_lat,o.to_long,r.latitude,r.longitude,o.price,o.timestamp,o.cart_items,o.status FROM restaurants r, orders o, user_details u WHERE r.id=o.restaurant_id AND o.customer_email = u.email AND u.email = '$customer_email' "
);

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