<?php

include 'connection.php';
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$passNum = (int) json_decode($_POST["passNum"]);
$leg_ins_id = (int) json_decode($_POST["leg_ins_id"]);
$flight_id = (int) json_decode($_POST["flight_id"]);
$seat_no = (int) json_decode($_POST["seat_id"]);

mysqli_query($conn, "INSERT INTO seat_reservation (seat_number, leg_instance_id, passport_number) VALUES ($seat_no, $leg_ins_id, $passNum)");

$res = mysqli_query($conn, "SELECT seat_reservation_id FROM seat_reservation WHERE seat_number=$seat_no AND leg_instance_id=$leg_ins_id");
$seat_id = mysqli_fetch_assoc($res)["seat_reservation_id"];
$ranmil=random_int(50,1200);

mysqli_query($conn, "INSERT INTO fare (flight_id, amount) VALUES ($flight_id, $ranmil)");

$res = mysqli_query($conn, "SELECT MAX(fare_id) AS max FROM fare");
$fare_id = mysqli_fetch_assoc($res)["max"];

mysqli_query($conn, "INSERT INTO customer_fares (fare_id, passport_number, seat_reservation_id) VALUES ($fare_id, $passNum, $seat_id)");

$res=mysqli_query($conn, "UPDATE ffc SET milage_info=$ranmil WHERE seat_reservation_id=$seat_id");

echo json_encode("New fare with fare id : " . $fare_id . ", flight id : " . $flight_id . ", seat number : " . $seat_no . " is created. Now you can check in.");

$conn->close();



?>