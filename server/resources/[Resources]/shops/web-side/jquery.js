const mySlots = 50;
var selectShop = "selectShop";
var selectType = "Buy";
let shiftPressed = true;
/* --------------------------------------------------- */
$(document).ready(function(){
	window.addEventListener("message",function(event){
		switch(event.data.action){
			case "showNUI":
				selectShop = event.data.name;
				selectType = event.data.type;
				$(".inventory").css("display","flex")
				requestShop();
			break;

			case "hideNUI":
				$(".inventory").css("display","none")
			break;

			case "requestShop":
				requestShop();
			break;
		}
	});

	document.onkeydown = data => {
		const key = data.key;
		if (key === "Shift"){
			shiftPressed = false;
		}
	}

	document.onkeyup = data => {
		const key = data.key;
		if (key === "Escape"){
			$.post("http://shops/close");
		} else if (key === "Shift"){
			shiftPressed = true;
		}
	}
});
/* --------------------------------------------------- */
const updateDrag = () => {
	$('.populated').draggable({
		helper: 'clone'
	});

	$('.empty').droppable({
		hoverClass: 'hoverControl',
		drop: function(event,ui){
			const origin = ui.draggable.parent()[0].className;
			if (origin === undefined) return;
			const tInv = $(this).parent()[0].className;

			itemData = { key: ui.draggable.data('item-key'), slot: ui.draggable.data('slot') };
			const target = $(this).data('slot');

			if (itemData.key === undefined || target === undefined) return;

			let amount = parseInt($(".amount").val());
			if (shiftPressed) amount = ui.draggable.data('amount');

			if (tInv === "invLeft"){
				if (origin === "invLeft"){
					$.post("http://shops/populateSlot",JSON.stringify({
						item: itemData.key,
						slot: itemData.slot,
						target: target,
						amount: parseInt($(".amount").val())
					}))

					$('.amount').val("");
				} else if (origin === "invRight"){
					$.post("http://shops/functionShops",JSON.stringify({
						shop: selectShop,
						item: itemData.key,
						slot: target,
						amount: parseInt($(".amount").val())
					}));

					$('.amount').val("");
				}
			} else if (tInv === "invRight"){
				if (origin === "invLeft" && selectType === "Sell"){
					$.post("http://shops/functionShops",JSON.stringify({
						shop: selectShop,
						item: itemData.key,
						slot: itemData.slot,
						amount: parseInt($(".amount").val())
					}));

					$('.amount').val("");
				}
			}
		}
	});

	$('.populated').droppable({
		hoverClass: 'hoverControl',
		drop: function(event,ui){
			const origin = ui.draggable.parent()[0].className;
			if (origin === undefined) return;
			const tInv = $(this).parent()[0].className;
			
			itemData = { key: ui.draggable.data('item-key'), slot: ui.draggable.data('slot') };
			const target = $(this).data('slot');

			if (itemData.key === undefined || target === undefined) return;

			let amount = parseInt($(".amount").val());
			if (shiftPressed) amount = ui.draggable.data('amount');


			if (tInv === "invLeft" ){
				if (origin === "invLeft"){
					$.post("http://shops/updateSlot",JSON.stringify({
						item: itemData.key,
						slot: itemData.slot,
						target: target,
						amount: parseInt($(".amount").val())
					}));

					$('.amount').val("");
				} else if (origin === "invRight"){
					$.post("http://shops/functionShops",JSON.stringify({
						shop: selectShop,
						item: itemData.key,
						slot: target,
						amount: parseInt($(".amount").val())
					}));

					$('.amount').val("");
				}
			} else if (tInv === "invRight"){
				if (origin === "invLeft" && selectType === "Sell"){
					$.post("http://shops/functionShops",JSON.stringify({
						shop: selectShop,
						item: itemData.key,
						slot: itemData.slot,
						amount: parseInt($(".amount").val())
					}));

					$('.amount').val("");
				}
			}
		}
	});
}
/* --------------------------------------------------- */
const formatarNumero = (n) => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--){
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}
/* --------------------------------------------------- */
const requestShop = () => {
	$.post("http://shops/requestShop",JSON.stringify({ shop: selectShop }),(data) => {
		$(".myInfos").html(`
			<b>${data.infos[0]} <i>#${data.infos[1]}</i></b>
			<div class="infosContent">
				<span><s>TELEFONE:</s> ${data.infos[4]}</span>
				<span><s>RG:</s> ${data.infos[5]}</span>
				<span><s>BANCO:</s> $${formatarNumero(data.infos[2])}</span>
				<span><s>COINS:</s> ${formatarNumero(data.infos[3])}</span>
				<span><s>PESO:</s> ${(data.weight).toFixed(2)} / ${(data.maxweight).toFixed(2)}</span>
			</div>
		`);

		const nameList2 = data.inventoryShop.sort((a,b) => (a.name > b.name) ? 1: -1);

		$(".invLeft").html("");
		$(".invRight").html("");

		for (let x=1; x <= mySlots; x++) {
			const slot = x.toString();

			if (data.inventoryUser[slot] !== undefined) {
				const v = data.inventoryUser[slot];
				const item = `<div class="item populated" style="background-image: url('http://45.224.128.146/inventory/${v.index}.png'); background-position: center; background-repeat: no-repeat;" data-item-key="${v.key}" data-name-key="${v.name}" data-amount="${v.amount}" data-slot="${slot}">
					<div class="top">
						<div class="itemWeight">${(v.peso*v.amount).toFixed(2)}</div>
						<div class="itemAmount">${formatarNumero(v.amount)}x</div>
					</div>
					<div class="itemname">${v.name}</div>
				</div>`;

				$(".invLeft").append(item);
			} else {
				const item = `<div class="item empty" data-slot="${slot}"></div>`;

				$(".invLeft").append(item);
			}
		}

		for (let x=1; x <= mySlots; x++) {
			const slot = x.toString();

			if (nameList2[x-1] !== undefined) {
				const v = nameList2[x-1];
				const item = `<div class="item populated" style="background-image: url('http://45.224.128.146/inventory/${v.index}.png'); background-position: center; background-repeat: no-repeat;" data-item-key="${v.key}" data-name-key="${v.name}" data-amount="${v.amount}" data-slot="${slot}">
					<div class="top">
						<div class="itemWeight">${(v.weight).toFixed(2)}</div>
						<div class="itemAmount">$${formatarNumero(v.price)}</div>
					</div>
					<div class="itemname">${v.name}</div>
				</div>`;

				$(".invRight").append(item);
			} else {
				const item = `<div class="item empty" data-slot="${slot}"></div>`;

				$(".invRight").append(item);
			}
		}
		updateDrag();
	});
}

function somenteNumeros(e){
	var charCode = e.charCode ? e.charCode : e.keyCode;
	if (charCode != 8 && charCode != 9){
		var max = 9;
		var num = parseInt($(".amount").val());

		if ((charCode < 48 || charCode > 57)||(num.length >= max)){
			return false;
		}
	}
}