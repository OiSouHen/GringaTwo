$(document).ready(function(){
	window.addEventListener("message",function(event){
		if (event.data.hud == true){
			$("#hudDisplay").css("display","block");
		}

		if (event.data.hud == false){
			$("#hudDisplay").css("display","none");
		}
		
		$(".infosBack").html("<b>"+ event.data.day +"</b>, <b>"+ event.data.month +"</b>  :  "+ event.data.street);

		$(".healthDisplay").css("width",event.data.health +"%");
		$(".thirstDisplay").css("width",100-event.data.thirst +"%");
		$(".hungerDisplay").css("width",100-event.data.hunger +"%");
		$(".armourDisplay").css("width",event.data.armour + "%");

		if (event.data.car == true){
			var mph = event.data.seatbelt == true ? "<div class='cintodeseguranca'><img src='https://cdn.discordapp.com/attachments/759804901709709362/840032377349734400/cinto-on.png' style='width: 15px'></div>":"<div class='cintodesegurancabotado'><img src='https://cdn.discordapp.com/attachments/759804901709709362/840049473682276352/cinto-off.png' style='width: 15px'>"
			$(".carDisplay").css("display","block");
			$(".fuelDisplay").css("display","block");

			$(".fuelDisplay").css("width",event.data.fuel + "%");
			$(".amcarDisplay").css("width",event.data.vidadocarro/10 +"%");
			$(".speedcount").html(" " +event.data.speed + mph + " ");


		} else {
			$("#hudDisplay").css("bottom","100px");
			$(".fuelDisplay").css("display","none");
			$(".carDisplay").css("display","none");
		}
	})
});