$(document).ready(function(){
	window.addEventListener("message",function(event){
		switch(event["data"]["action"]){
			case "show":
				$("#body").css("display","flex");
			break;

			case "hide":
				$("#body").css("display","none");
			break;
		}
	});

	document.onkeyup = function(data){
		if (data.which == 27){
			$.post("http://atm/close");
		}
	};
});
/* ----------DEPOSIT---------- */
$(document).on("click","#deposit",function(){
	let value = parseInt($('#value').val());
	if(value > 0){
		$.post("http://atm/deposit",JSON.stringify({ value }));
		$("#value").val("");
	}
});
/* ----------WITHDRAW---------- */
$(document).on("click","#withdraw",function(){
	let value = parseInt($('#value').val());
	if(value > 0){
		$.post("http://atm/withdraw",JSON.stringify({ value }));
		$("#value").val("");
	}
});