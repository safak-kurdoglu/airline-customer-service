<?php

include 'connection.php';

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT dep_airport_id, arr_airport_id, leg_instance_id, flight_id, airplane_id FROM leg_instance";
$res = mysqli_query($conn,$sql);

$datas = array();
while($row = mysqli_fetch_assoc($res)){
  $data = [];
  $dep_id = $row['dep_airport_id'];
  $dep_city = mysqli_query($conn, "SELECT City FROM airport WHERE Airport_id='$dep_id'");
  array_push($data, mysqli_fetch_assoc($dep_city)["City"]);

  $arr_id = $row['arr_airport_id'];
  $arr_city = mysqli_query($conn, "SELECT City FROM airport WHERE Airport_id=$arr_id");
  array_push($data, mysqli_fetch_assoc($arr_city)["City"]);

  array_push($data, $row['leg_instance_id']);
  array_push($data, $row['flight_id']);

  $air_id = $row["airplane_id"];
  $total_seat = mysqli_query($conn, "SELECT total_no_seats FROM airplane WHERE airplane_id=$air_id");
  array_push($data, mysqli_fetch_assoc($total_seat)["total_no_seats"]);

  array_push($datas, $data);
}
$conn->close();

echo json_encode($datas);
?>