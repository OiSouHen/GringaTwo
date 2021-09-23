$(document).ready(() => {
	var percent = 0;

	document.onkeydown = function (data){
		if (data["which"] == 69){
			$.post("http://taskbar/taskEnd",JSON.stringify({ taskResult: percent }));
			$(".circlewrap").css("display","none");
		}
	}

	window.addEventListener("message",function(event){
		var item = event["data"];

		if (item["runProgress"] === true){
			percent = 0;
			$(".circlewrap").css("display","flex")
			$("#skillgap").css("transform", `rotate(${(item["chance"] * 360)/100}deg`);
			$("#skillgap").css("--val",item["skillGap"]);
		}

		if (item["runUpdate"] === true){
			percent = item["Length"]
			$("#skillprogress").css("--val",item["Length"]);

			if (item["Length"] < (item["chance"] + item["skillGap"]) && item["Length"] > (item["chance"])){
				$("#skillgap").css("stroke","#6b3434");
			} else {
				$("#skillgap").css("stroke","#68708c");
			}
		}

		if (item["closeProgress"] === true){
			$(".circlewrap").css("display","none");
		}
	});
});