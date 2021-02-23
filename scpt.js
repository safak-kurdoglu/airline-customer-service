$(document).ready(function(){
  $("#buyButton").click(function(){
    $("#buyForm").toggle();
  });
});

function checkCustomer(val){
  $.ajax({
    type: "POST",
    url: "check.php",
    data: {val : JSON.stringify(val)},
    success: function(response){

      var newOrNot = JSON.parse(response);
      if(newOrNot == "1"){
        
        cont1 = document.getElementById("flights").childNodes;      //this part is to clear childnodes, in case of second push to proceed button.
        cont2 = document.getElementById("fares").childNodes;
        cont3 = document.getElementById("fares2").childNodes;
        for(i=1; i<cont1.length; i++)
          cont1[i].style.display = "none";
        
        for(i=1; i<cont2.length; i++)
          cont2[i].style.display = "none";

        for(i=1; i<cont3.length; i++)
          cont3[i].style.display = "none";

   

        document.getElementById("flights").style.display = "inline-block";
        document.getElementById("checkP").innerHTML = "Welcome back!. You can select Flight from below.";
        document.getElementById("recordForm").style.display = "none";
        document.getElementById("fares").style.display = "inline-block";
        document.getElementById("fares2").style.display = "inline-block";
        getFlights();
        getFares(val);
      }else{
        document.getElementById("checkP").innerHTML = "Welcome new customer!. After registering, you can select Flight";
        document.getElementById("recordForm").style.display = "inline-block";
      }
    }
  });
}

function getFlights(){
  var cont = document.getElementById("flights");
  $.ajax({
    type: "POST",
    url: "getFlights.php",
    success: function(response){

      var datas = JSON.parse(response);
      for(i=0; i<datas.length; i++){
        var str = "";
        str += datas[i][0] + " --> " + datas[i][1] + " ";
        var leg_ins_id = datas[i][2];
        var flight_id = datas[i][3];
        var total_seats = datas[i][4];

        var q = document.createElement("p");
        q.classList.add("leg_ins");        
        q.innerHTML = leg_ins_id;
        q.style.display = "none";

        var c = document.createElement("p");
        c.classList.add("flightid");        
        c.innerHTML = flight_id;
        c.style.display = "none";   

        var z = document.createElement("p");
        z.classList.add("total_seats");        
        z.innerHTML = total_seats;
        z.style.display = "none";   

        var btn = document.createElement("button");
        btn.innerHTML = str;
        btn.appendChild(q);
        btn.appendChild(c);
        btn.appendChild(z);
        btn.addEventListener("click", e=>{chooseSeat(e.target.getElementsByClassName('leg_ins')[0].innerHTML, document.getElementById("passportNum").value,e.target.getElementsByClassName('flightid')[0].innerHTML, e.target.getElementsByClassName('total_seats')[0].innerHTML)});
        cont.appendChild(btn);
      }
    }
  });
}

function chooseSeat(leg_instance_id, passportNum, flight_ID, total_seats){


  document.getElementById("selectSeat").style.display = "inline-block";
  airplane = document.getElementById("airplane");
  airplane.style.display = "inline-block";
  childNodes = airplane.childNodes;

  for(i=1; i<childNodes.length; i++)  //this code is for choosing new flight.
    childNodes[i].style.display = "none";  
  

  $.ajax({
    type: "POST",
    url: "checkSeat.php",
    data: {leg_ins_id: JSON.stringify(leg_instance_id), total_no_seats: JSON.stringify(total_seats)},
    success: function(response){
      var datas = JSON.parse(response);
      for(i=0;i<datas.length;i++){
      }
      var width = document.getElementById("airplane").offsetWidth-50;
      var total_seats_row = total_seats/6;
      var seatWidth = parseInt((width - (2*(total_seats_row-1))) / total_seats_row);  //width minus gap between seats and division by total seats.
      airplane = document.getElementById("airplane");

      for(i=0; i<6; i++){
        for(j=0; j<total_seats_row; j++){

          seat = document.createElement("DIV");
          seat.style.width = seatWidth;       
          seat.style.height = seatWidth;
          seat.style.borderRadius = "50%";
          seat.style.backgroundColor = "black";
          seat.style.display = "inline";
          seat.innerHTML = "seat";
          seat.classList.add("seat");          
          
          if(datas[(i+6*j)] == 1){
            seat.style.opacity = "1";
           
          }
          else{
            seat.style.opacity = "0.5";
            seat.classList.add("emptySeat");

            p = document.createElement("P");
            p.innerHTML = leg_instance_id;
            p.style.display = "none";
            seat.appendChild(p);

            p = document.createElement("P");
            p.innerHTML = passportNum;
            p.style.display = "none";
            seat.appendChild(p);

            p = document.createElement("P");
            p.innerHTML = flight_ID;
            p.style.display = "none";
            seat.appendChild(p);
            
            p = document.createElement("P");
            p.innerHTML = i+6*j;
            p.style.display = "none";
            seat.appendChild(p);
            seat.addEventListener("click", e=>{makeReservation(e.target.childNodes[1].innerHTML, e.target.childNodes[2].innerHTML, +e.target.childNodes[3].innerHTML, e.target.childNodes[4].innerHTML);});
          }
          airplane.appendChild(seat);
        }
        gap = document.createElement("DIV");
        if(i==2)
          gap.style.height = "120px";
        else
          gap.style.height = "10px";   //gapHeight;

        gap.style.borderRadius = "50%";
        gap.style.backgroundColor = "black";
        gap.style.visibility = "hidden";
        gap.innerHTML = "gap";
        airplane.appendChild(gap);
        
      }
    }

  });
}

  function makeReservation(leg_instance_id, passportNum, flight_ID, seat_id){
    $.ajax({
    type: "POST",
    url: "makeReservation.php",
    data: {leg_ins_id : JSON.stringify(leg_instance_id), passNum: JSON.stringify(passportNum), flight_id: JSON.stringify(flight_ID), seat_id: JSON.stringify(seat_id)},
    success: function(response){
      alert(response);  
    },
    error: function(response){
      console.log("error");
    },})

}

function getFares(pass_id){
  $.ajax({
    type: "POST",
    url: "getFares.php",
    data: {passport_num: JSON.stringify(pass_id)},
    success: function(response){      
      var cont1 = document.getElementById("fares");
      var cont2 = document.getElementById("fares2");
      var fares = JSON.parse(response);      

      for(var i=0; i<fares.length; i++){

        var str = "fare id = " + fares[i][0] + ", flight id = " + fares[i][1] +"<br> leg instance id = "+ fares[i][5]+ "<br>amount = " + fares[i][2];
        if(fares[i][4] == 1){
          fare = document.createElement("DIV");
          fare.classList.add("customerFare");
          fare.innerHTML = str;
          cont2.appendChild(fare);
        }else{
          fare = document.createElement("BUTTON");        
          fare.classList.add("customerFareChecked");
          fare.innerHTML = str;
          p = document.createElement("P");
          p.innerHTML = fares[i][3];
          p.style.display = "none";
          fare.appendChild(p);        
          fare.addEventListener("click", e=>{doCheckIn(e.target.childNodes[7].innerHTML)});
          cont1.appendChild(fare);
        }
      }
    }
  });
}

function doCheckIn(seat_id){
 $.ajax({
 type: "POST",
 url: "doCheckIn.php",
 data: {seat_ID: JSON.stringify(seat_id)},
 success: function(response){
   alert(JSON.parse(response));
 },
 });
 
}

function registerCustomer(passNum, Caddress, Cphone, Cemail, Ccountry){
  $.ajax({
    type: "POST",
    url: "registerCustomer.php",
    data: {passport_num: JSON.stringify(passNum), address: JSON.stringify(Caddress), phone: JSON.stringify(Cphone), email: JSON.stringify(Cemail), country: JSON.stringify(Ccountry)},
    success: function(response){
      alert(JSON.parse(response));
    }
  });

}
