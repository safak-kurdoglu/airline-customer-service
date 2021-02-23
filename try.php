<?php

include 'connection.php';

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$res =  mysqli_query($conn, "SELECT `transaction_checkhed` FROM `ffc` WHERE seat_reservation_id=5690281");
$res2 = mysqli_fetch_assoc($res)["transaction_checkhed"];
echo $res2;

$conn->close();

?>