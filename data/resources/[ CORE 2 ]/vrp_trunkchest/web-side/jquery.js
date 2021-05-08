const mySlots = 50;
const inSlots = 100;
let shiftPressed = false;

$(document).ready(function () {
	window.addEventListener("message", function (event) {
		switch (event.data.action) {
			case "showMenu":
				updateChest();
				$(".inventory").css("display", "flex")
				break;

			case "hideMenu":
				$(".inventory").css("display", "none")
				break;

			case "updateMochila":
				updateChest();
				break;
		}
	});

	document.onkeydown = data => {
		const key = data.key;
		if (key === "Shift") {
			shiftPressed = true;
		}
	}

	document.onkeyup = data => {
		const key = data.key;
		if (key === "Escape") {
			$.post("http://vrp_trunkchest/invClose", JSON.stringify({}));
		} else if (key === "Shift") {
			shiftPressed = false;
		}
	}
});

const updateDrag = () => {
	$('.populated').draggable({
		helper: 'clone'
	});

	$('.empty').droppable({
		hoverClass: 'hoverControl',
		drop: function (event, ui) {
			const origin = ui.draggable.parent()[0].className;
			if (origin === undefined) return;
			const tInv = $(this).parent()[0].className;

			itemData = { key: ui.draggable.data('item-key'), slot: ui.draggable.data('slot') };
			const target = $(this).data('slot');

			if (itemData.key === undefined || target === undefined) return;

			let amount = $(".amount").val();
			if (shiftPressed) amount = ui.draggable.data('amount');

			if (tInv === "invLeft") {
				if (origin === "invLeft") {
					$.post("http://vrp_trunkchest/populateSlot", JSON.stringify({
						item: itemData.key,
						slot: itemData.slot,
						target: target,
						amount: parseInt(amount)
					}))

					$('.amount').val("");
				} else if (origin === "invRight") {
					$.post("http://vrp_trunkchest/takeItem", JSON.stringify({
						item: itemData.key,
						slot: target,
						amount: parseInt(amount)
					}));

					$('.amount').val("");
				}
			} else if (tInv === "invRight") {
				if (origin === "invLeft") {
					$.post("http://vrp_trunkchest/storeItem", JSON.stringify({
						item: itemData.key,
						slot: itemData.slot,
						amount: parseInt(amount)
					}));

					$('.amount').val("");
				}
			}
		}
	});

	$('.populated').droppable({
		hoverClass: 'hoverControl',
		drop: function (event, ui) {
			const origin = ui.draggable.parent()[0].className;
			if (origin === undefined) return;
			const tInv = $(this).parent()[0].className;

			itemData = { key: ui.draggable.data('item-key'), slot: ui.draggable.data('slot') };
			const target = $(this).data('slot');

			if (itemData.key === undefined || target === undefined) return;

			let amount = $(".amount").val();
			if (shiftPressed) amount = ui.draggable.data('amount');


			if (tInv === "invLeft") {
				if (origin === "invLeft") {
					$.post("http://vrp_trunkchest/updateSlot", JSON.stringify({
						item: itemData.key,
						slot: itemData.slot,
						target: target,
						amount: parseInt(amount)
					}));

					$('.amount').val("");
				} else if (origin === "invRight") {
					$.post("http://vrp_trunkchest/sumSlot", JSON.stringify({
						item: itemData.key,
						slot: target,
						amount: parseInt(amount)
					}));

					$('.amount').val("");
				}
			} else if (tInv === "invRight") {
				if (origin === "invLeft") {
					$.post("http://vrp_trunkchest/storeItem", JSON.stringify({
						item: itemData.key,
						slot: itemData.slot,
						amount: parseInt(amount)
					}));

					$('.amount').val("");
				}
			}
		}
	});
}

const updateChest = () => {
	$.post("http://vrp_trunkchest/requestMochila", JSON.stringify({}), (data) => {
		$(".myInfos").html(`
			<b>${data.infos[0]} <i>#${data.infos[1]}</i></b>
			<div class="infosContent">
				<span><s>TELEFONE:</s> ${data.infos[4]}</span>
				<span><s>RG:</s> ${data.infos[5]}</span>
				<span><s>BANCO:</s> $${formatarNumero(data.infos[2])}</span>
				<span>${(data.peso).toFixed(2)} / ${(data.maxpeso).toFixed(2)}</span>
				<span>${(data.peso2).toFixed(2)} / ${(data.maxpeso2).toFixed(2)}</span>
			</div>
		`);

		const nameList2 = data.inventario2.sort((a, b) => (a.name > b.name) ? 1 : -1);

		$(".invLeft").html("");
		$(".invRight").html("");

		for (let x = 1; x <= mySlots; x++) {
			const slot = x.toString();

			if (data.inventario[slot] !== undefined) {
				const v = data.inventario[slot];
				const item = `<div class="item populated" style="background-image: url('http://191.96.78.51/imagens/${v.index}.png'); background-position: center; background-repeat: no-repeat;" data-amount="${v.amount}" data-peso="${v.peso}" data-item-key="${v.key}" data-name-key="${v.name}" data-slot="${slot}">
				<div class="top">
				<div class="itemWeight"></div>
				<div class="itemAmount">${formatarNumero(v.amount)}x   |   ${(v.peso * v.amount).toFixed(2)}</div>
			</div>
				<div class="itemname">${v.name}</div>
			</div>`;

				$(".invLeft").append(item);
			} else {
				const item = `<div class="item empty" data-slot="${slot}"></div>`;

				$(".invLeft").append(item);
			}
		}

		for (let x = 1; x <= inSlots; x++) {
			const slot = x.toString();

			if (nameList2[x - 1] !== undefined) {
				const v = nameList2[x - 1];
				const item = `<div class="item populated" style="background-image: url('http://191.96.78.51/imagens/${v.index}.png'); background-position: center; background-repeat: no-repeat;" data-amount="${v.amount}" data-peso="${v.peso}" data-item-key="${v.key}" data-name-key="${v.name}" data-slot="${slot}">
				<div class="top">
				<div class="itemWeight"></div>
				<div class="itemAmount">${formatarNumero(v.amount)}x   |   ${(v.peso * v.amount).toFixed(2)}</div>
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

const formatarNumero = (n) => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}