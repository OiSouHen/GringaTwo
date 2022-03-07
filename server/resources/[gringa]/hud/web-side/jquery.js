var lastRadio = ""
var tickInterval = undefined;
// -------------------------------------------------------------------------------------------
function direction(heading){
	var dirResult = "Sul"

	if (heading >= 315 || heading < 45){
		dirResult = "Norte"
	} else if (heading >= 45 || heading < 135){
		dirResult = "Oeste"
	} else if (heading >= 135 || heading < 225){
		dirResult = "Sul"
	} else if (heading >= 225 || heading < 315){
		dirResult = "Leste"
	}

	return dirResult
}
// -------------------------------------------------------------------------------------------
function minimalTimers(Seconds){
	var Days = Math.floor(Seconds / 86400)
	Seconds = Seconds - Days * 86400
	var Hours = Math.floor(Seconds / 3600)
	Seconds = Seconds - Hours * 3600
	var Minutes = Math.floor(Seconds / 60)
	Seconds = Seconds - Minutes * 60

	const [D,H,M,S] = [Days,Hours,Minutes,Seconds].map(s => s.toString().padStart(2,0))

    if (Days > 0){
        return D + ":" + H
    } else if (Hours > 0){
        return H + ":" + M
    } else if (Minutes > 0){
        return M + ":" + S
    } else if (Seconds > 0){
        return "00:" + S
    }
}
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

		if (event["data"]["health"] !== undefined){
			if (event["data"]["health"] <= 101){
				if ($("#health").css("display") === "block"){
					$("#health").css("display","none");
				}
			} else {
				if ($("#health").css("display") === "none"){
					$("#health").css("display","block");
				}

				$(".healthDisplay").css("--val",event["data"]["health"] - 99);
			}
		}

		if (event["data"]["seatbelt"] !== undefined){
			if (event["data"]["seatbelt"] == true){
				$("#seatBelt").css("color","#70cc72");
			} else {
				$("#seatBelt").css("color","#939393");
			}
		}

		if (event["data"]["thirst"] !== undefined){
			$(".waterDisplay").css("--val",event["data"]["thirst"]);
		}

		if (event["data"]["hunger"] !== undefined){
			$(".foodDisplay").css("--val",event["data"]["hunger"]);
		}

		if (event["data"]["radio"] !== undefined){
			lastRadio = event["data"]["radio"];
		}

		if (event["data"]["stress"] !== undefined){
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

		if (event["data"]["oxigen"] !== undefined){
			if (event["data"]["oxigenShow"] === undefined){
				if ($("#oxigen").css("display") === "block"){
					$("#oxigen").css("display","none");
				}
			} else {
				if ($("#oxigen").css("display") === "none"){
					$("#oxigen").css("display","block");
				}
			}

			$(".oxigenDisplay").css("--val",event["data"]["oxigen"]);
		}

		if (event["data"]["armour"] !== undefined){
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

				if (event["data"]["nitro"] > 0){
					if ($("#nitroFuel").css("display") === "none"){
						$("#nitroFuel").css("display","block");
					}

					$("#nitroFuel").html(parseInt(event["data"]["nitro"] / 2) + "%");
				} else {
					if ($("#nitroFuel").css("display") === "block"){
						$("#nitroFuel").css("display","none");
					}
				}
			} else {
				if ($("#displayVehicle").css("display") === "block"){
					$("#displayVehicle").css("display","none");
				}
			}

			var wantedText = ""
			var wantedTimers = parseInt((event["data"]["wanted"] - event["data"]["timer"]) / 1000)
			if (wantedTimers > 0){
				wantedText = "<text>"+ minimalTimers(wantedTimers) +" Procurado</text>"
			}

			var reposeText = ""
			var reposeTimers = parseInt((event["data"]["repose"] - event["data"]["timer"]) / 1000)
			if (reposeTimers > 0){
				reposeText = "<text>"+ minimalTimers(reposeTimers) +" Repouso</text>"
			}

			$("#displayBoxes").html(lastRadio + reposeText + wantedText +"<text>"+ direction(event["data"]["direction"]) +"</text><text>"+ event["data"]["street"] +"</text>");
		}
	});
});