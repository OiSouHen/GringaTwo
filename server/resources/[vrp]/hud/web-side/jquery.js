var lastRadio = ""
var tickInterval = undefined;
var lastHealth = 999;
var lastArmour = 999;
var lastStress = 999;
var lastHunger = 999;
var lastOxigen = 999;
var lastWater = 999;
// -------------------------------------------------------------------------------------------
$(document).ready(function(){
	$(".voiceDisplay").css("--val","50");

	window.addEventListener("message",function(event){
		if (event["data"]["progress"] !== undefined){
			var timeSlamp = event["data"]["progressTimer"];

			if ($("#progressBackground").css("display") === "block"){
				$(".progressDisplay").css("--val","136");
				$("#progressBackground").css("display","none");
				$("#progressText").text("0");
				clearInterval(tickInterval);
				tickInterval = undefined;

				return
			} else {
				$("#progressBackground").css("display","block");
				$(".progressDisplay").css("--val","136");
			}

			var tickPerc = 136;
			var tickTimer = (timeSlamp / 136);
			tickInterval = setInterval(tickFrame,tickTimer);

			function tickFrame(){
				tickPerc--;

				if (tickPerc <= 0){
					clearInterval(tickInterval);
					tickInterval = undefined;
					$("#progressBackground").css("display","none");
					$("#progressText").text("0");
				} else {
					timeSlamp = timeSlamp - (timeSlamp / tickPerc);
				}

				$("#progressText").text(parseInt(timeSlamp / 1000));
				$(".progressDisplay").css("--val",tickPerc);
			}

			return
		}

		if (event["data"]["hud"] !== undefined){
			if (event["data"]["hud"] == true){
				$("#displayHud").fadeIn(500);
			} else {
				$("#displayHud").fadeOut(500);
			}

			return
		}

		if (event["data"]["movie"] !== undefined){
			if (event["data"]["movie"] == true){
				$("#movieTop").fadeIn(500);
				$("#movieBottom").fadeIn(500);
			} else {
				$("#movieTop").fadeOut(500);
				$("#movieBottom").fadeOut(500);
			}

			return
		}

		if (event["data"]["hood"] !== undefined){
			if (event["data"]["hood"] == true){
				$("#hoodDisplay").fadeIn(500);
			} else {
				$("#hoodDisplay").fadeOut(500);
			}
		}

		if (event["data"]["voice"] !== undefined){
			if (event["data"]["voice"] == 1){
				$(".voiceDisplay").css("--val","75");
			} else if (event["data"]["voice"] == 2){
				$(".voiceDisplay").css("--val","50");
			} else if (event["data"]["voice"] == 3){
				$(".voiceDisplay").css("--val","25");
			} else if (event["data"]["voice"] == 4){
				$(".voiceDisplay").css("--val","0");
			}
		}

		if (event["data"]["talking"] !== undefined){
			if (event["data"]["talking"] == 1){
				$("#voice").attr("href","images/micOn.png");
			} else {
				$("#voice").attr("href","images/micOff.png");
			}
		}
		
		if (lastHealth !== event["data"]["health"]){
			lastHealth = event["data"]["health"];

			if (event["data"]["health"] <= 1){
				if ($("#health").css("display") === "block"){
					$("#health").css("display","none");
				}
			} else {
				if ($("#health").css("display") === "none"){
					$("#health").css("display","block");
				}
				
				$(".healthDisplay").css("--val",event["data"]["health"]);
			}
		}
		
		if (event["data"]["seatbelt"] !== undefined){
			if (event["data"]["seatbelt"] == true){
				$("#seatBelt").css("color","#70cc72");
			} else {
				$("#seatBelt").css("color","#939393");
			}
		}

		if (lastArmour !== event["data"]["armour"]){
			lastArmour = event["data"]["armour"];

			if (event["data"]["armour"] <= 0){
				if ($("#armour").css("display") === "block"){
					$("#armour").css("display","none");
				}
			} else {
				if ($("#armour").css("display") === "none"){
					$("#armour").css("display","block");
				}
			}

			$(".armourDisplay").css("--val",event["data"]["armour"]);
		}

		if (lastStress !== event["data"]["stress"]){
			lastStress = event["data"]["stress"];

			if (event["data"]["stress"] <= 0){
				if ($("#stress").css("display") === "block"){
					$("#stress").css("display","none");
				}
			} else {
				if ($("#stress").css("display") === "none"){
					$("#stress").css("display","block");
				}
			}

			$(".stressDisplay").css("--val",100 - event["data"]["stress"]);
		}

		if (lastWater !== event["data"]["thirst"]){
			lastWater = event["data"]["thirst"];

			$(".waterDisplay").css("--val",event["data"]["thirst"]);
		}

		if (lastHunger !== event["data"]["hunger"]){
			lastHunger = event["data"]["hunger"];

			$(".foodDisplay").css("--val",event["data"]["hunger"]);
		}
		
		if (event["data"]["radio"] !== undefined){
			lastRadio = event["data"]["radio"];
		}
		
		if (event["data"]["suit"] == undefined){
			if($(".oxigenBackground").css("display") === "block"){
				$(".oxigenBackground").css("display","none");
			}
		} else {
			if($(".oxigenBackground").css("display") === "none"){
				$(".oxigenBackground").css("display","block");
			}
		}

		if (lastOxigen !== event["data"]["oxigen"]){
			lastOxigen = event["data"]["oxigen"];

			$(".oxigenDisplay").css("stroke-dashoffset",100 - event["data"]["oxigen"]);
		}
		
		if (event["data"]["vehicle"] !== undefined){
			if (event["data"]["vehicle"] == true){
				if ($("#displayVehicle").css("display") === "none"){
					$("#displayVehicle").css("display","block");
				}

				if (event["data"]["showbelt"] == false){
					if ($("#seatBelt").css("display") === "block"){
						$("#seatBelt").css("display","none");
					}
				} else {
					if ($("#seatBelt").css("display") === "none"){
						$("#seatBelt").css("display","block");
					}
				}

				$("#gasoline").html("GAS <s>" + parseInt(event["data"]["fuel"]) + "</s>");
				$("#mph").html("MPH <s>" + parseInt(event["data"]["speed"]) + "</s>");

			} else {
				if ($("#displayVehicle").css("display") === "block"){
					$("#displayVehicle").css("display","none");
				}
			}
		}

		$("#displayBoxes").html(lastRadio +"<text>"+ event["data"]["direction"] +"</text><text>"+ event["data"]["street"] +"</text>");
	});
});