$(document).ready(() => {
	$(".buttonGroup > .buttonsBox > button").on("click",function(){
		$(this).parent().find("button").removeClass("active")
		$(this).addClass("active");
	});

	$(".spawnBox").on("click",function(){
		$(".spawnBox").removeClass("active");
		$(this).addClass("active");
	});

	function returnSeleted(type){
		return $(`#${type}`).find(".active").attr("id");
	}

	window.addEventListener("message",function(event){
		switch (event["data"]["action"]){
			case "openSystem":
				$("#charPage").css("display","block");
				generateDisplay();
			break;

			case "closeSystem":
				$("#charPage").css("display","none");
			break;
			
			case "closeNew":
				$("#charPage").css("display","none");
				$("#createPage").css("display","none");
			break;
		};
	});

	$(document).on("click",".charBox",function(e){
		$.post("http://spawn/characterChosen",JSON.stringify({ id: parseInt(e["currentTarget"]["dataset"]["id"]) }));
		$("#charPage").css("display","none");
	});

	$(document).on("click",".charNew",function(e){
		$("#charPage").css("display","none");
		$("#createPage").css("display","block");
	});

	$(document).on("click","#createBack",function(e){
		$("#charPage").css("display","block");
		$("#createPage").css("display","none");
	});

	$(document).on("click","#createNew",function(e){
		var name = $("#charNome").val();
		var name2 = $("#charSobrenome").val();
		var sex = returnSeleted("gender");

		if (name != "" && name2 != "" && (sex == "M" || sex == "F")) {
			if (sex == "M") {
				sex = "mp_m_freemode_01"
			} else {
				sex = "mp_f_freemode_01"
			}

			$.post("http://spawn/newCharacter",JSON.stringify({ name: name, name2: name2, sex: sex }));
		}
	});
});

const generateDisplay = () => {
	$.post("http://spawn/generateDisplay",JSON.stringify({}),(data) => {

		var characterList = data["result"].sort((a,b) => (a["id"] > b["id"]) ? 1 : -1);

		$("#charPage").html(`
			<div class="charNew"><p>NOVO PERSONAGEM</p><o>Criar um novo personagem</o></div>

			${characterList.map((item) => (`
				<div class="charBox" data-id="${item["id"]}">
					<div class="playerInfo">
						<p><b>Passaporte:</b> ${item["id"]}</p>
						<p><b>Nome:</b> ${item["name"]}</p>
					</div>
					<div class="playerButton"><p>Entrar</p></div>
			</div>`)).join("")}
		`);
	});
}