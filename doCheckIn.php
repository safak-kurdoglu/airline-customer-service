<?php

include 'connection.php';

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$seat_id = (int) json_decode($_POST["seat_ID"]);
$res = mysqli_query($conn, "UPDATE ffc SET transaction_checkhed=1 WHERE seat_reservation_id=$seat_id");

if($res){
  		
  	$res=mysqli_fetch_assoc(mysqli_query($conn,"SELECT total_milage_info,name,customer.passport_number as passport from seat_reservation,customer,customer_segment_list where $seat_id= seat_reservation.seat_reservation_id and seat_reservation.passport_number =customer_segment_list.passport_number and customer.passport_number=seat_reservation.passport_number "));
  	if(isset($res)){
  		$congstr="";
  		$segment=4;
  		if($res["total_milage_info"]>2000){
  			$segment=1;
  			$congstr= $res["name"] . ", you are upgraded to platinum level customer. You won a flight up to 500 mile!.";
  		}
  		elseif($res["total_milage_info"]>1000){
  			$segment=2;
  			$congstr= $res["name"] . ", you are upgraded to gold level customer. You won a flight up to 200 mile!.";
  		}
  		elseif($res["total_milage_info"]>500){
  			$segment=3;
  			$congstr= $res["name"] . ", you are upgraded to silver level customer. You won a flight up to 100 mile!.";
  		}
  		else{
  			$congstr="0-".$res["name"];
  		}
  		mysqli_query($conn,"UPDATE customer_segment_list SET segment_id=$segment WHERE passport_number=".$res["passport"]);
  		echo json_encode($congstr);
  	}
  	else{
  		echo json_encode($seat_id);
  	}

}else{
  echo json_encode($seat_id);
}

$conn->close();
?>