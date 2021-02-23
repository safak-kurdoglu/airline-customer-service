<?php
include 'connection.php';

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$val = json_decode($_POST["val"]);
$sql = "SELECT passport_number FROM customer WHERE passport_number='$val' LIMIT 1";
$res = mysqli_query($conn,$sql);

$conn->close();

if($res->num_rows == 1)
  echo json_encode(1);
else
  echo json_encode(0);


?>