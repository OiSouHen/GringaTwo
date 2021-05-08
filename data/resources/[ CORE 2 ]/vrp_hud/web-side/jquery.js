var tickInterval = undefined;

$(document).ready(function(){
	window.addEventListener("message",function(event){

		if (event["data"]["progress"] == true){
			var timeSlamp = event["data"]["progressTimer"];

			var background = document.getElementById("progressBackground");
			if (background["style"]["display"] == "block"){
				$("#progressDisplay").css("stroke-dashoffset","100");
				$("#progressBackground").css("display","none");
				clearInterval(tickInterval);
				tickInterval = undefined;

				return
			} else {
				$("#progressBackground").css("display","block");
				$("#progressDisplay").css("stroke-dashoffset","100");
			}

			var tickPerc = 100;
			var tickTimer = (timeSlamp / 100);
			tickInterval = setInterval(tickFrame,tickTimer);

			function tickFrame(){
				tickPerc--;

				if (tickPerc <= 0){
					clearInterval(tickInterval);
					tickInterval = undefined;
					$("#progressBackground").css("display","none");
				} else {
					timeSlamp = timeSlamp - (timeSlamp / tickPerc);
				}

				$("#textProgress").html(parseInt(timeSlamp / 1000));
				$("#progressDisplay").css("stroke-dashoffset",tickPerc);
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

		if (event["data"]["talking"] == true){
			$("#voice").css("background","#333 url(micOn.png)");
		} else {
			$("#voice").css("background","#222 url(micOff.png)");

			if (event["data"]["voice"] == 1){
				$(".voiceDisplay").css("stroke-dashoffset","66");
			} else if (event["data"]["voice"] == 2){
				$(".voiceDisplay").css("stroke-dashoffset","33");
			} else if (event["data"]["voice"] == 3){
				$(".voiceDisplay").css("stroke-dashoffset","0");
			}
		}

		if (event["data"]["health"] <= 1){
			$(".healthDisplay").css("stroke-dashoffset","100");
		} else {
			$(".healthDisplay").css("stroke-dashoffset",100 - event["data"]["health"]);
		}

		if(parseInt(event.data.armour) > 0 ){
			$(".armourBackground").css("display", "block")
			$(".armourDisplay").css("stroke-dashoffset",100 - event["data"]["armour"]);
		}else{
			$(".armourBackground").css("display", "none")
		}

		$(".waterDisplay").css("stroke-dashoffset",100 - event["data"]["thirst"]);
		
		$(".foodDisplay").css("stroke-dashoffset",100 - event["data"]["hunger"]);
		
		if(parseInt(event.data.stress) > 0 ){
			$(".stressBackground").css("display", "block")
			$(".stressDisplay").css("stroke-dashoffset",100 - event["data"]["stress"]);
		}else{
			$(".stressBackground").css("display", "none")
		}
		
		if (event["data"]["oxigen"] < 10){
			$(".oxigenBackground").css("display", "block")
			$(".oxigenDisplay").css("stroke-dashoffset",100 - (event["data"]["oxigen"] * 10));
		} else {
			$(".oxigenBackground").css("display", "none")
			$(".oxigenDisplay").css("stroke-dashoffset",100 - (event["data"]["oxigen"] / 12));
		}

		if (event["data"]["hours"] <= 9){
			event["data"]["hours"] = "0" + event["data"]["hours"]
		}

		if (event["data"]["minutes"] <= 9){
			event["data"]["minutes"] = "0" + event["data"]["minutes"]
		}

		if (event["data"]["vehicle"] !== undefined){
			if (event["data"]["vehicle"] == true){
				if ($("#displayTop").is(":visible") == false){
					$("#displayTop").fadeIn(500);
				}

				if (event["data"]["hardness"] == 1){
					$("#hardBelt").css("color","#43a949");
				} else {
					$("#hardBelt").css("color","#939393");
				}

				if (event["data"]["seatbelt"] == 1){
					$("#seatBeltTrue").css("color","#43a949");
					$("#seatBeltFalse").css("display","none");
					$("#seatBeltTrue").css("display","block");
				} else {
					$("#seatBeltFalse").css("color","#939393");
					$("#seatBeltFalse").css("display","block");
					$("#seatBeltTrue").css("display","none");
				}
				

				$("#gasoline").html("GAS: <s>" + parseInt(event["data"]["fuel"]) + "%</s>");
				$("#mph").html("MPH: <s>" + parseInt(event["data"]["speed"] + "</s>") );
			} else {
				if ($("#displayTop").is(":visible") == true){
					$("#displayTop").fadeOut(500);
				}
			}
		}

		$("#displayMiddle").html("<font color='#e5e5e5'>" + event["data"]["direction"] + "</font><font color='#e5e5e5'>" + event["data"]["street"] + "</font> \xa0\ <font color='#e5e5e5'>" + event["data"]["radio"] + "</font>");
	});
});