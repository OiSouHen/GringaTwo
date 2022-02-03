$(document).ready(function(){
	window.addEventListener("message",function(evt){
		var data = evt["data"];

		if (data["death"] == true){
			$("#deathDiv").css("display","block");
		}
		else if (data["death"] == false){
			$("#deathDiv").css("display","none");
		}
		else if (data["deathtext"] !== undefined){
			$("#deathText").html(data["deathtext"]);
		}
	});
});