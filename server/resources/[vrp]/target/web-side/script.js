window.addEventListener("message",function(event){
	let item = event["data"];

	if (item["response"] == "openTarget"){
		$(".target-label").html("");
		$(".target-wrapper").show();
		$(".target-eye").show();
		$(".target-eye").css("color","#fff");
	} else if (item["response"] == "closeTarget"){
		$(".target-label").html("");
		$(".target-wrapper").hide();
		$(".target-eye").hide();
	} else if (item["response"] == "validTarget"){
		$(".target-label").html("");

		$.each(item["data"],function(index,item){
			$(".target-label").append("<div id='target-" + index + "'<li>" + item["label"] + "</li></div>");

			$("#target-" + index).hover((e) => {
				$("#target-" + index).css("color",e["type"] === "mouseenter" ? "#00e07a":"#d6d9df")
			});

			$("#target-" + index + "").css("padding-top","7px");

			$("#target-" + index).data("TargetData",item["event"]);
			$("#target-" + index).data("TunnelData",item["tunnel"]);
			$("#target-" + index).data("ServiceData",item["service"]);
		});

		$(".target-eye").css("color","#00e07a");
	} else if (item["response"] == "leftTarget"){
		$(".target-label").html("");
		$(".target-eye").css("color","#fff");
	}

	document.onkeyup = data => {
		if (data["key"] === "Escape"){
			$(".target-label").html("");
			$(".target-wrapper").hide();
			$(".target-eye").hide();
			$.post("http://target/closeTarget");
		}
	};
});

$(document).on("mousedown",(event) => {
	let element = event["target"];

	if (element["id"].split("-")[0] === "target"){
		let TargetData = $("#" + element["id"]).data("TargetData");
		let TunnelData = $("#" + element["id"]).data("TunnelData");
		let ServiceData = $("#" + element["id"]).data("ServiceData");

		$.post("http://target/selectTarget",JSON.stringify({ event: TargetData, tunnel: TunnelData, service: ServiceData }));

		$(".target-label").html("");
		$(".target-wrapper").hide();
	}
});