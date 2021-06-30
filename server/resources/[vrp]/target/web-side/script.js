window.addEventListener("message",function(event){
	let item = event["data"];

	if (item["response"] == "openTarget"){

		$(".target-label").html("");
		$(".target").css("display","flex");
		$(".target-eye").css("color","#fff");

	} else if (item["response"] == "closeTarget"){

		$(".target-label").html("");
		$(".target").css("display","none");
		$(".target-eye").css("color","#fff");

	} else if (item["response"] == "validTarget"){

		$(".target-label").html("");

		$.each(item["data"],function(index,item){
			$(".target-label").append("<div id='target-" + index + "'<li>" + item["label"] + "</li></div>");

			$("#target-" + index).hover((e) => {
				$("#target-" + index).css("color",e["type"] === "mouseenter" ? "#16ad76":"#d6d9df")
			});

			$("#target-" + index).css("padding-top","7px");
			$("#target-" + index).data("TargetData",item["event"]);
			$("#target-" + index).data("TunnelData",item["tunnel"]);
			$("#target-" + index).data("ServiceData",item["service"]);
		});

		$(".target-eye").css("color","#16ad76");

	} else if (item["response"] == "leftTarget"){

		$(".target-label").html("");
		$(".target").css("display","none");
		$(".target-eye").css("color","#fff");

		$.post("http://target/closeTarget");

	}

	document.onkeyup = data => {
		if (data["key"] === "Escape"){
			$(".target-label").html("");
			$(".target").css("display","none");
			$(".target-eye").css("color","#fff");

			$.post("http://target/closeTarget");
		}
	};
});

$(document).on("mousedown",(event) => {
	let element = event["target"];

	if (element["id"].split("-")[0] === "target"){
		let targetData = $("#" + element["id"]).data("TargetData");
		let tunnelData = $("#" + element["id"]).data("TunnelData");
		let serviceData = $("#" + element["id"]).data("ServiceData");

		$.post("http://target/selectTarget",JSON.stringify({ event: targetData, tunnel: tunnelData, service: serviceData }));

		$(".target-label").html("");
		$(".target").css("display","none");
		$(".target-eye").css("color","#fff");
	}
});