<?php 
include "config.php";

$sql = mysqli_query($connect,"SELECT MAX(id) FROM orders");
$num_rows = mysqli_num_rows($sql);
if($num_rows > 0){
    $last_order = mysqli_fetch_row($sql);
    $id = ++$last_order[0];
}else{
    $id = 'O100000001';
}


$restaurant_id = mysqli_real_escape_string($connect, $_POST['restaurant_id']);
$restaurant_name = mysqli_real_escape_string($connect, $_POST['restaurant_name']);
$customer_email = mysqli_real_escape_string($connect, $_POST['customer_email']);
$customer_contact = mysqli_real_escape_string($connect, $_POST['customer_contact']);
$to_lat = mysqli_real_escape_string($connect, $_POST['to_lat']);
$to_long = mysqli_real_escape_string($connect, $_POST['to_long']);
$price = mysqli_real_escape_string($connect, $_POST['price']);
$timestamp = mysqli_real_escape_string($connect, $_POST['timestamp']);
$cart_items = mysqli_real_escape_string($connect, $_POST['cart_items']);
$status = mysqli_real_escape_string($connect, $_POST['status']);

$result = mysqli_query($connect,"INSERT INTO orders(id,restaurant_id,restaurant_name,customer_email,customer_contact,to_lat,to_long,price,timestamp,cart_items,status) VALUES ('$id','$restaurant_id','$restaurant_name','$customer_email',$customer_contact,$to_lat,$to_long,$price,'$timestamp','$cart_items','$status')");
if($result>0){
    echo json_encode('SUCCESS');
}else{
    echo json_encode('FAILED');
}
?>