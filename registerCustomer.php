<?php
include 'connection.php';

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$pass_no = (int) json_decode($_POST["passport_num"]);
$address = json_decode($_POST["address"]);
$phone = json_decode($_POST["phone"]);
$email = json_decode($_POST["email"]);
$country = json_decode($_POST["country"]);

$res = mysqli_query($conn, "INSERT INTO customer (`passport_number`, `adress`, `phone`, `email`, `country`) VALUES ($pass_no, '$address', '$phone', '$email', '$country')");

mysqli_query($conn, "INSERT INTO customer_segment_list (segment_id, passport_number, total_milage_info) VALUES (4,$pass_no,0)");


if($res){
echo json_encode("New customer successfully inserted. You can enter your passport number and proceed.");
}else{
echo json_encode("New customer could not be added.");
}

$conn->close();

?>