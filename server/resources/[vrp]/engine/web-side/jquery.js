var selectPage = "benefactor";
var reversePage = "benefactor";
/* ---------------------------------------------------------------------------------------------------------------- */
$(document).ready(function(){
	benefactor('Carros');

	window.addEventListener("message",function(event){
		switch (event["data"]["action"]){
			case "openSystem":
				$("#mainPage").css("display","block");
			break;

			case "closeSystem":
				$("#mainPage").css("display","none");
			break;

			case "updatePossuidos":
				updatePossuidos();
			break;

			case "updateCarros":
				updateCarros();
			break;

			case "updateMotos":
				updateMotos();
			break;
			
			case "updateAluguel":
				updateAluguel();
			break;
		};
	});

	document.onkeyup = function(data){
		if (data["which"] == 27){
			$.post("http://engine/closeSystem");
		};
	};
});
/* ---------------------------------------------------------------------------------------------------------------- */
$(document).on("click","#mainMenu li",function(){
	if (selectPage != reversePage){
		let isActive = $(this).hasClass("active");
		$("#mainMenu li").removeClass("active");
		if (!isActive){
			$(this).addClass("active");
			reversePage = selectPage;
		};
	};
});
/* ---------------------------------------------------------------------------------------------------------------- */
var benMode = "Carros"
var benSearch = "alphabetic"

const searchTypePage = (mode) => {
	benSearch = mode;
	benefactor(benMode);
}
/* ---------------------------------------------------------------------------------------------------------------- */
const UpdateLista = (mode) => {
	benMode = mode;
	selectPage = "benefactor";
	
	$("#content").html(`
		<div id="benefactorBar">
		<li id="benefactor" onclick="UpdateLista('Carros');" data-id="Carros" ${mode == "Carros" ? "class=active":""}>CARROS</li>
		<li id="benefactor" onclick="UpdateLista('Motos');" data-id="Motos" ${mode == "Motos" ? "class=active":""}>MOTOS</li>
		<li id="benefactor" onclick="UpdateLista('Aluguel');" data-id="Aluguel" ${mode == "Aluguel" ? "class=active":""}>ALUGUEL</li>
		<li id="benefactor" onclick="UpdateLista('Possuidos');" data-id="Possuidos" ${mode == "Possuidos" ? "class=active":""}>POSSUÍDOS</li>
		</div>

		<div id="contentVehicles">
			<div id="titleVehicles">${mode}</div>
			<div id="pageVehicles"></div>
		</div>
	`);
	$.post(`http://engine/request${mode}`,JSON.stringify({}),(data) => {
		let i = 0;
		var nameList = data["veiculos"].sort((a,b) => (a["name"] > b["name"]) ? 1: -1);
		
		if (mode == "Possuidos"){
			$("#pageVehicles").html(`
			${nameList.map((item) => (`<span>
				<left>
					<i>${item["name"]}</i>
					<b>Valor:</b> ${mode == "Aluguel" ? format(item["price"])+" Gemas":"$"+format(item["price"])}<br>
					<b>Taxa:</b> ${item["tax"]}<br>
					<b>Porta-Malas:</b> ${format(item["chest"])}Kg
				</left>
				<right>
					<div id="benefactorSell" data-name="${item["k"]}">VENDER</div><br>
				</right>
			</span>`)).join('')}
		`);
		} else {
			$("#pageVehicles").html(`
				${nameList.map((item) => (`<span>
					<left>
						<i>${item["name"]}</i>
						<b>Valor:</b> ${mode == "Aluguel" ? format(item["price"])+" Gemas":"$"+format(item["price"])}<br>
						<b>Taxa:</b> $${format(item["tax"])}<br>
						<b>Porta-Malas:</b> ${format(item["chest"])}Kg
					</left>
					<right>
						<div id="benefactorBuy" data-name="${item["k"]}">Comprar</div>
						<div id="benefactorDrive" data-name="${item["k"]}">Testar</div>
					</right>
				</span>`)).join('')}
			`);
		}
	});
}
/* ---------------------------------------------------------------------------------------------------------------- */
const benefactor = () => {
	selectPage = "benefactor";
	$("#content").html(`
		<div id="benefactorBar">
		<li id="benefactor" onclick="UpdateLista('Carros');" data-id="Carros" class="active">CARROS</li>
		<li id="benefactor" onclick="UpdateLista('Motos');" data-id="Motos">MOTOS</li>
		<li id="benefactor" onclick="UpdateLista('Aluguel');" data-id="Aluguel">ALUGUEL</li>
		<li id="benefactor" onclick="UpdateLista('Possuidos');" data-id="Possuidos">POSSUÍDOS</li>
		</div>

		<div id="contentVehicles">
			<div id="titleVehicles">Carros</div>
			<div id="pageVehicles"></div>
		</div>
	`);

	$.post(`http://engine/requestCarros`,JSON.stringify({}),(data) => {
		let i = 0;
		const nameList = data.veiculos.sort((a,b) => (a.nome > b.nome) ? 1: -1);
		$("#pageVehicles").html(`
			${nameList.map((item) => (`<span>
				<left>
					<i>${item["name"]}</i>
					<b>Valor:</b> $${format(item["price"])}<br>
					<b>Taxa:</b> $${format(item["tax"])}<br>
					<b>Porta-Malas:</b> ${format(item["chest"])}Kg
				</left>
				<right>
					<div id="benefactorBuy" data-name="${item["k"]}">Comprar</div>
					<div id="benefactorDrive" data-name="${item["k"]}">Testar</div>
				</right>
			</span>`)).join('')}
		`);
	});
}
/* ----------BENEFACTORBUY---------- */
$(document).on("click","#benefactorBuy",function(e){
	$.post("http://engine/buyDealer",JSON.stringify({
		name: e["target"]["dataset"]["name"]
	}));
	
	UpdateLista('Carros');
	$.post("http://engine/closeSystem");
});
/* ----------BENEFACTORSELL---------- */
$(document).on("click","#benefactorSell",function(e){
	$.post("http://engine/sellDealer",JSON.stringify({
		name: e["target"]["dataset"]["name"]
	}));
	
	UpdateLista('Carros');
	$.post("http://engine/closeSystem");
});
/* ----------BENEFACTORTAX---------- */
$(document).on("click","#benefactorTax",function(e){
	$.post("http://engine/requestTax",JSON.stringify({ name: e["target"]["dataset"]["name"] }));
});
/* ----------BENEFACTORDRIVE---------- */
$(document).on("click","#benefactorDrive",function(e){
	$.post("http://engine/requestDrive",JSON.stringify({ name: e["target"]["dataset"]["name"] }));
});
/* ----------FORMAT---------- */
const format = (n) => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}