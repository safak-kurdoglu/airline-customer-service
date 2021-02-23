<?php

include 'connection.php';

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$leg_ins_id = intval(json_decode($_POST["leg_ins_id"]));
$total_seats = intval(json_decode($_POST["total_no_seats"]));
$seats = array();

for($i=0; $i<150; $i++){
  $seats[$i] = 0;
}


$sql = mysqli_query($conn, "SELECT seat_number FROM seat_reservation WHERE leg_instance_id=$leg_ins_id");
while($row = mysqli_fetch_assoc($sql)){
  $seats[$row["seat_number"]] = 1;                   //  filled seats
}

$conn->close();
echo json_encode($seats);

?>