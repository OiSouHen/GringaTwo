$(document).ready(function(){
	window.addEventListener("message",function(event){

		if (event.data.hud !== undefined){
			if (event.data.hud == true){
				$("#displayHud").css("display","block");
			} else {
				$("#displayHud").css("display","none");
			}
			return
		}

		if (event.data.movie !== undefined){
			if (event.data.movie == true){
				$("#movieTop").css("display","block");
				$("#movieBottom").css("display","block");
			} else {
				$("#movieTop").css("display","none");
				$("#movieBottom").css("display","none");
			}
			return
		}

		if (event.data.hood !== undefined){
			if (event.data.hood == true){
				$("#hoodDisplay").css("display","block");
			} else {
				$("#hoodDisplay").css("display","none");
			}
		}

		if (event.data.talking == true) {
			if (event.data.voice == 1){
				$("#voice01").css("background","rgba(255,255,0,0)");
				$("#voice02").css("background","rgba(255,255,0,0)");
				$("#voice03").css("background","rgba(255,255,0,0.5)");
			} else if (event.data.voice == 2){
				$("#voice01").css("background","rgba(255,255,0,0)");
				$("#voice02").css("background","rgba(255,255,0,0.5)");
				$("#voice03").css("background","rgba(255,255,0,0.5)");
			} else if (event.data.voice == 3){
				$("#voice01").css("background","rgba(255,255,0,0.5)");
				$("#voice02").css("background","rgba(255,255,0,0.5)");
				$("#voice03").css("background","rgba(255,255,0,0.5)");
			}
		} else {
			if (event.data.voice == 1) {
				$("#voice01").css("background","rgba(255,255,255,0)");
				$("#voice02").css("background","rgba(255,255,255,0)");
				$("#voice03").css("background","rgba(255,255,255,0.5)");
			} else if (event.data.voice == 2){
				$("#voice01").css("background","rgba(255,255,255,0)");
				$("#voice02").css("background","rgba(255,255,255,0.5)");
				$("#voice03").css("background","rgba(255,255,255,0.5)");
			} else if (event.data.voice == 3){
				$("#voice01").css("background","rgba(255,255,255,0.5)");
				$("#voice02").css("background","rgba(255,255,255,0.5)");
				$("#voice03").css("background","rgba(255,255,255,0.5)");
			}
		}

		if (event.data.health <= 1){
			$("#displayHealth").css("height","0");
		} else {
			$("#displayHealth").css("height",event.data.health + "%");
		}

		if (event.data.armour == 1){
			$("#backArmour").css("display","none");
		} else {
			$("#backArmour").css("display","block");
			$("#displayArmour").css("height",event.data.armour +"%");
		}	
		
		$("#displayWater").css("height",event.data.thirst + "%");
		$("#displayFood").css("height",event.data.hunger + "%");
		$("#displayStress").css("height",event.data.stress + "%");

		if (event.data.oxigen <= 10){
			$("#displayOxigen").css("height",(event.data.oxigen * 10) + "%");
		} else {
			$("#displayOxigen").css("height",(event.data.oxigen / 20) + "%");
		}

		if (event.data.hours <= 9){
			event.data.hours = "0" + event.data.hours
		}

		if (event.data.minutes <= 9){
			event.data.minutes = "0" + event.data.minutes
		}

		if (event.data.vehicle !== undefined){
			if (event.data.vehicle == true){
				var status = document.getElementById("displayTop");
				if (status.style.display !== "block"){
					$("#displayTop").css("display","block");
				}

				if (event.data.seatbelt){
					$("#seatBelt").css("display","none");
				} else {
					$("#seatBelt").css("display","block");
				}

				$("#gasoline").html("GAS <s>" + parseInt(event.data.fuel) + "</s>");
				$("#kmh").html("KMH <s>" + parseInt(event.data.speed) + "</s>");
			} else {
				var status = document.getElementById("displayTop");
				if (status.style.display !== "none"){
					$("#displayTop").css("display","none");
				}
			}
		}

		$("#displayMiddle").html(event.data.radio + event.data.street + " <s> : </s> " + event.data.hours+":"+event.data.minutes);
	});
});
