<?php

include 'connection.php';

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$pass_no = (int) json_decode($_POST["passport_num"]);


$res = mysqli_query($conn, "SELECT fare_id,seat_reservation_id FROM customer_fares WHERE passport_number=$pass_no");

$fares = array();
while($row = mysqli_fetch_assoc($res)){
  $fare = array();
  $fare_id = $row["fare_id"];
  
  $fare_row = mysqli_fetch_assoc(mysqli_query($conn, "SELECT * FROM fare WHERE fare_id=$fare_id"));
  array_push($fare, $fare_row["fare_id"]);
  array_push($fare, $fare_row["flight_id"]);
  array_push($fare, $fare_row["amount"]);

  $seat_id = $row["seat_reservation_id"];
  array_push($fare, $seat_id);
  $transRow = mysqli_query($conn, "SELECT transaction_checkhed FROM ffc WHERE seat_reservation_id=$seat_id");
  $ffc_checked = mysqli_fetch_assoc($transRow)["transaction_checkhed"];
  array_push($fare, $ffc_checked);
  $legid = mysqli_fetch_assoc(mysqli_query($conn, "SELECT leg_instance_id FROM seat_reservation WHERE seat_reservation_id=$seat_id"));
  array_push($fare, $legid["leg_instance_id"]);

  array_push($fares, $fare);
}

$conn->close();

echo json_encode($fares);
?>