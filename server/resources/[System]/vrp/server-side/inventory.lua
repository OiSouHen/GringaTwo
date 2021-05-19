-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
	["skate"] = {
		index = "skate",
		name = "Skate",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 2.00
	},	
	["bonusDelivery"] = {
		index = "bonusDelivery",
		name = "Bônus Tacos",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.10
	},
	["bonusPostOp"] = {
		index = "bonusPostOp",
		name = "Bônus Entregador",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.10
	},
	["radio"] = {
		index = "radio",
		name = "Rádio",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.10
	},
	["radiodamaged"] = {
        index = "radiodamaged",
        name = "Rádio Queimado",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
        type = "use",
        weight = 1.10
    },
	["vest"] = {
		index = "vest",
		name = "Colete",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 3.00 --testar
	},
	["bandage"] = {
		index = "bandage",
		name = "Curativo",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["warfarin"] = {
		index = "warfarin",
		name = "Primeiros Socorros",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 3.00
	},
	["adrenaline"] = {
		index = "adrenaline",
		name = "Adrenalina",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["credential"] = {
		index = "credential",
		name = "Credencial",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.10
	},
	["pouch"] = {
		index = "pouch",
		name = "Saco de Dinheiro",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.10
	},
	["woodlog"] = {
		index = "woodlog",
		name = "Tora de Madeira",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 7.00
	},
	["fishingrod"] = {
		index = "fishingrod",
		name = "Vara de Pescar",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 2.00
	},
	["octopus"] = {
		index = "octopus",
		name = "Polvo",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.00
	},
	["shrimp"] = {
		index = "shrimp",
		name = "Camarão",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.20
	},
	["carp"] = {
		index = "carp",
		name = "Carpa",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.20
	},
	["bait"] = {
		index = "bait",
		name = "Isca",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.10
	},
	["cannabisseed"] = {
		index = "cannabisseed",
		name = "Semente de Maconha",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.10
	},
	["bucket"] = {
		index = "bucket",
		name = "Balde",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.50
	},
	["compost"] = {
		index = "compost",
		name = "Adubo",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["weed"] = {
		index = "weed",
		name = "Maconha",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["joint"] = {
		index = "joint",
		name = "Baseado",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.80
	},
	["lean"] = {
		index = "lean",
		name = "Lean",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.50
	},
	["ecstasy"] = {
		index = "ecstasy",
		name = "Ecstasy",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.20
	},
	["cocaine"] = {
		index = "cocaine",
		name = "Cocaína",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["meth"] = {
		index = "meth",
		name = "Metanfetamina",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.60
	},
	["methliquid"] = {
		index = "methliquid",
		name = "Meta Líquida",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.00
	},
	["silk"] = {
		index = "silk",
		name = "Seda",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["normalbackpack"] = {
		index = "normalbackpack",
		name = "Mochila",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 4.25
	},
	["premiumbackpack"] = {
		index = "premiumbackpack",
		name = "Mochila especial",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 2.25
	},
	["tecido"] = {
		index = "tecido",
		name = "Tecido",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.05
	},
	["cotton"] = {
		index = "cotton",
		name = "Algodão",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.05
	},
	["premium01"] = {
		index = "premium01",
		name = "3 Dias",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.00
	},
	["premium02"] = {
		index = "premium02",
		name = "7 Dias",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.00
	},
	["premium03"] = {
		index = "premium03",
		name = "15 Dias",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.00
	},
	["premium04"] = {
		index = "premium04",
		name = "1 Mês",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.00
	},
	["premiumname"] = {
		index = "premiumname",
		name = "Mudar Nome",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.00
	},
	["premiumpersonagem"] = {
		index = "premiumpersonagem",
		name = "+1 Personagem",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.00
	},
	["premiumgarage"] = {
		index = "premiumgarage",
		name = "2 Vagas de Garagem",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.00
	},
	["premiumplate"] = {
		index = "plate",
		name = "Placa Premium",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["energetic"] = {
		index = "energetic",
		name = "Energético",
		desc = "",
		tipo = "Bebida",
		unity = "Não",
		economy = "315",
		type = "use",
		weight = 0.25
	},
	["delivery"] = {
		index = "delivery",
		name = "Caixa cheia",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.00
	},
	["emptybox"] = {
		index = "emptybox",
		name = "Caixa vazia",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.20
	},
	["paperbag"] = {
		index = "paperbag",
		name = "Saco de Papel",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["battery"] = {
		index = "battery",
		name = "Bateria",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.20
	},
	["brokenbottle"] = {
		index = "brokenbottle",
		name = "Garrafa de vidro",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["elastic"] = {
		index = "elastic",
		name = "Elásticos",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.10
	},
	["emptycan"] = {
		index = "emptycan",
		name = "Latinha",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.20
	},
	["littlebottle"] = {
		index = "littlebottle",
		name = "Garrafinha",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.10
	},
	["alface"] = {
		index = "alface",
		name = "Alface",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.15
	},
	["bacon"] = {
		index = "bacon",
		name = "Bacon",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.15
	},
	["bread"] = {
		index = "bread",
		name = "Pão",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.20
	},
	["burguer"] = {
		index = "burguer",
		name = "Hamburguer",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.35
	},
	["milk"] = {
		index = "milk",
		name = "Leite",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.75
	},
	["onion"] = {
		index = "onion",
		name = "Cebola",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.45
	},
	["ovos"] = {
		index = "ovos",
		name = "Ovos",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.35
	},
	["presunto"] = {
		index = "presunto",
		name = "Presunto",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.45
	},
	["queijo"] = {
		index = "queijo",
		name = "Queijo",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.45
	},
	["tomate"] = {
		index = "tomate",
		name = "Tomate",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["frutalaranja"] = {
		index = "frutalaranja",
		name = "Laranja",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["frutamaca"] = {
		index = "frutamaca",
		name = "Maça",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["frutamanga"] = {
		index = "frutamanga",
		name = "Manga",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["frutauva"] = {
		index = "frutauva",
		name = "Uva",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["sucolaranja"] = {
		index = "sucolaranja",
		name = "Suco de Laranja",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.45
	},
	["sucomaca"] = {
		index = "sucomaca",
		name = "Suco de Maça",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.45
	},
	["sucomanga"] = {
		index = "sucomanga",
		name = "Suco de Manga",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.45
	},
	["sucouva"] = {
		index = "sucouva",
		name = "Suco de Uva",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.45
	},
	["emptybottle"] = {
		index = "emptybottle",
		name = "Garrafa vazia",
		desc = "",
		tipo = "Bebida",
		unity = "Não",
		economy = "650",
		type = "use",
		weight = 0.10
	},
	["water"] = {
		index = "water",
		name = "Água",
		desc = "",
		tipo = "Bebida",
		unity = "Não",
		economy = "800",
		type = "use",
		weight = 0.20
	},
	["dirtywater"] = {
		index = "dirtywater",
		name = "Água Suja",
		desc = "",
		tipo = "Bebida",
		unity = "Não",
		economy = "450",
		type = "use",
		weight = 0.30
	},
-- SUBTYPE COMIDA
-- subtype = "comida",
-- transform = "comida-estragada",
-- durability = 1500,
    ["cola"] = {
		index = "cola",
		name = "Cola",
		desc = "",
		tipo = "Bebida",
		unity = "Sim",
		economy = "515",
		type = "use",
		subtype = "comida",
		transform = "badcola",
		durability = 1500,
		weight = 0.15
	},
	["badcola"] = {
		index = "badcola",
		name = "Cola vencida",
		desc = "",
		tipo = "Bebida",
		unity = "Não",
		economy = "250",
		type = "use",
		weight = 0.15
	},
    ["soda"] = {
		index = "soda",
		name = "Sprunk",
		desc = "",
		tipo = "Bebida",
		unity = "Sim",
		economy = "515",
		type = "use",
		subtype = "comida",
		transform = "badsoda",
		durability = 1500,
		weight = 0.15
	},
	["badsoda"] = {
		index = "badsoda",
		name = "Sprunk vencida",
		desc = "",
		tipo = "Bebida",
		unity = "Não",
		economy = "250",
		type = "use",
		weight = 0.15
	},
	["coffee"] = {
		index = "coffee",
		name = "Café",
		desc = "",
		tipo = "Bebida",
		unity = "Sim",
		economy = "320",
		type = "use",
		subtype = "comida",
		transform = "badcoffee",
		durability = 1500,
		weight = 0.15
	},
	["badcoffee"] = {
		index = "badcoffee",
		name = "Café vencido",
		desc = "",
		tipo = "Bebida",
		unity = "Não",
		economy = "160",
		type = "use",
		weight = 0.15
	},
	["hamburger"] = {
		index = "hamburger",
		name = "Hambúrguer",
		desc = "",
		tipo = "Comida",
		unity = "Sim",
		economy = "1600",
		type = "use",
		subtype = "comida",
		transform = "badhamburger",
		durability = 1500,
		weight = 0.35
	},
	["badhamburger"] = {
		index = "badhamburger",
		name = "Hambúrguer vencido",
		desc = "",
		tipo = "Comida",
		unity = "Não",
		economy = "800",
		type = "use",
		weight = 0.35
	},
	["sandwich"] = {
		index = "sandwich",
		name = "Sanduiche",
		desc = "",
		tipo = "Comida",
		unity = "Sim",
		economy = "1300",
		type = "use",
		subtype = "comida",
		transform = "badhamburger",
		durability = 1500,
		weight = 0.25
	},
	["badsandwich"] = {
		index = "badsandwich",
		name = "Sanduiche vencido",
		desc = "",
		tipo = "Comida",
		unity = "Não",
		economy = "650",
		type = "use",
		weight = 0.25
	},
	["chocolate"] = {
		index = "chocolate",
		name = "Chocolate",
		desc = "",
		tipo = "Doce",
		unity = "Sim",
		economy = "315",
		type = "use",
		subtype = "comida",
		transform = "badchocolate",
		durability = 1500,
		weight = 0.10
	},
	["badchocolate"] = {
		index = "badchocolate",
		name = "Chocolate vencido",
		desc = "",
		tipo = "Doce",
		unity = "Não",
		economy = "150",
		type = "use",
		weight = 0.10
	},
	["donut"] = {
		index = "donut",
		name = "Donut",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		subtype = "comida",
		transform = "baddonut",
		durability = 1500,
		weight = 0.20
	},
	["baddonut"] = {
		index = "baddonut",
		name = "Donut vencido",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.20
	},
-- END SUBTYPE COMIDA
	["plate"] = {
		index = "plate",
		name = "Placa",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["lockpick"] = {
		index = "lockpick",
		name = "Lockpick",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.25
	},
	["toolbox"] = {
		index = "toolbox",
		name = "Caixa de Ferramentas",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.75
	},
	["postit"] = {
		index = "postit",
		name = "Bloco de Notas",
		desc = "",
		tipo = "Acessório",
		unity = "Não",
		economy = "10",
		type = "use",
		weight = 0.25
	},
	["tires"] = {
		index = "tires",
		name = "Pneus",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.50
	},
	["cellphone"] = {
		index = "cellphone",
		name = "Telefone",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.00
	},
	["cellphonedamaged"] = {
        index = "cellphonedamaged",
        name = "Celular Queimado",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
        type = "use",
        weight = 1.00
    },
	["divingsuit"] = {
		index = "divingsuit",
		name = "Roupa de Mergulho",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 5.00
	},
	["handcuff"] = {
		index = "handcuff",
		name = "Algemas",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.00
	},
	["rope"] = {
		index = "rope",
		name = "Cordas",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.40
	},
	["hood"] = {
		index = "hood",
		name = "Capuz",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.00
	},
	["plastic"] = {
		index = "plastic",
		name = "Plástico",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.10
	},
	["glass"] = {
		index = "glass",
		name = "Vidro",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.20
	},
	["rubber"] = {
		index = "rubber",
		name = "Borracha",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.20
	},
	["aluminum"] = {
		index = "aluminum",
		name = "Alúminio",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.30
	},
	["copper"] = {
		index = "copper",
		name = "Cobre",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["eletronics"] = {
		index = "eletronics",
		name = "Eletrônico",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.80
	},
	["notebook"] = {
		index = "notebook",
		name = "Notebook",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 6.00
	},
	["keyboard"] = {
		index = "keyboard",
		name = "Teclado",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 2.50
	},
	["mouse"] = {
		index = "mouse",
		name = "Mouse",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.50
	},
	["ring"] = {
		index = "ring",
		name = "Anel",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 2.60
	},
	["watch"] = {
		index = "watch",
		name = "Relógio",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.20
	},
	["c4"] = {
		index = "c4",
		name = "C4",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 2.50
	},
	["ritmoneury"] = {
		index = "ritmoneury",
		name = "Ritmoneury",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["sinkalmy"] = {
		index = "sinkalmy",
		name = "Sinkalmy",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["cigarette"] = {
		index = "cigarette",
		name = "Cigarro",
		desc = "",
		tipo = "Calmante",
		unity = "Não",
		economy = "75",
		type = "use",
		weight = 0.05
	},
	["lighter"] = {
		index = "lighter",
		name = "Isqueiro",
		desc = "",
		tipo = "Acessório",
		unity = "Não",
		economy = "175",
		type = "use",
		weight = 0.25
	},
	["vape"] = {
		index = "vape",
		name = "Vape",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 3.50
	},
	["dollars"] = {
		index = "dollars",
		name = "Dinheiro",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.00
	},
	["dollars2"] = {
		index = "dollars2",
		name = "Dinheiro Marcado",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.00
	},
	["blackcard"] = {
		index = "blackcard",
		name = "Cartão Preto",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["bluecard"] = {
		index = "bluecard",
		name = "Cartão Azul",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["rose"] = {
		index = "rose",
		name = "Rosa",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.15
	},
	["teddy"] = {
		index = "teddy",
		name = "Teddy",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 3.50
	},
	["absolut"] = {
		index = "absolut",
		name = "Absolut",
		desc = "",
		tipo = "Bebida",
		unity = "Não",
		economy = "215",
		type = "use",
		weight = 0.25
	},
	["chandon"] = {
		index = "chandon",
		name = "Chandon",
		desc = "",
		tipo = "Bebida",
		unity = "Não",
		economy = "215",
		type = "use",
		weight = 0.35
	},
	["dewars"] = {
		index = "dewars",
		name = "Dewars",
		desc = "",
		tipo = "Bebida",
		unity = "Não",
		economy = "215",
		type = "use",
		weight = 0.25
	},
	["hennessy"] = {
		index = "hennessy",
		name = "Hennessy",
		desc = "",
		tipo = "Bebida",
		unity = "Não",
		economy = "215",
		type = "use",
		weight = 0.25
	},
	["identity"] = {
		index = "identity",
		name = "Identidade",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.50
	},
	["goldbar"] = {
		index = "goldbar",
		name = "Barra de Ouro",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 10.00
	},
	["binoculars"] = {
		index = "binoculars",
		name = "Binóculos",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 5.00
	},
	["camera"] = {
		index = "camera",
		name = "Câmera",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 3.50
	},
	["playstation"] = {
		index = "playstation",
		name = "Playstation",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 5.00
	},
	["xbox"] = {
		index = "xbox",
		name = "Xbox",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 6.00
	},
	["legos"] = {
		index = "legos",
		name = "Legos",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 2.50
	},
	["ominitrix"] = {
		index = "ominitrix",
		name = "Ominitrix",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 2.50
	},
	["bracelet"] = {
		index = "bracelet",
		name = "Bracelete",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 3.50
	},
	["dildo"] = {
		index = "dildo",
		name = "Vibrador",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.50
	},
	["WEAPON_KNIFE"] = {
		index = "knife",
		name = "Faca",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 1.50
	},
	["WEAPON_HATCHET"] = {
		index = "hatchet",
		name = "Machado",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 7.50
	},
	["WEAPON_BAT"] = {
		index = "bat",
		name = "Bastão de Beisebol",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 5.50
	},
	["WEAPON_BATTLEAXE"] = {
		index = "battleaxe",
		name = "Machado de Batalha",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 8.50
	},
	["WEAPON_BOTTLE"] = {
		index = "bottle",
		name = "Garrafa",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 2.50
	},
	["WEAPON_CROWBAR"] = {
		index = "crowbar",
		name = "Pé de Cabra",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 3.50
	},
	["WEAPON_DAGGER"] = {
		index = "dagger",
		name = "Adaga",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 1.50
	},
	["WEAPON_GOLFCLUB"] = {
		index = "golfclub",
		name = "Taco de Golf",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 3.00
	},
	["WEAPON_HAMMER"] = {
		index = "hammer",
		name = "Martelo",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 3.50
	},
	["WEAPON_MACHETE"] = {
		index = "machete",
		name = "Facão",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 2.00
	},
	["WEAPON_POOLCUE"] = {
		index = "poolcue",
		name = "Taco de Sinuca",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 2.00
	},
	["WEAPON_STONE_HATCHET"] = {
		index = "stonehatchet",
		name = "Machado de Pedra",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 15.00
	},
	["WEAPON_SWITCHBLADE"] = {
		index = "switchblade",
		name = "Canivete",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 1.50
	},
	["WEAPON_WRENCH"] = {
		index = "wrench",
		name = "Chave Inglesa",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 3.00
	},
	["WEAPON_KNUCKLE"] = {
		index = "knuckle",
		name = "Soco Inglês",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 2.00
	},
	["WEAPON_FLASHLIGHT"] = {
		index = "flashlight",
		name = "Lanterna",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 1.00
	},
	["WEAPON_NIGHTSTICK"] = {
		index = "nightstick",
		name = "Cassetete",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 3.00
	},
	["WEAPON_PETROLCAN"] = {
		index = "gallon",
		name = "Galão",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_PETROLCAN_AMMO",
		weight = 2.50
	},
	["GADGET_PARACHUTE"] = {
		index = "parachute",
		name = "Paraquedas",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 5.00
	},
	["WEAPON_STUNGUN"] = {
		index = "stungun",
		name = "Tazer",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 2.00
	},
	["WEAPON_FIREEXTINGUISHER"] = {
		index = "extinguisher",
		name = "Extintor",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 3.00
	},
	
 -- START PISTOLS
    ["WEAPON_PISTOL"] = {
	    index = "m1911",
		name = "M1911",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_PISTOL_AMMO",
		weight = 2.00
    },
	["WEAPON_PISTOL_MK2"] = {
		index = "fiveseven",
		name = "FN Five Seven",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_PISTOL_MK2_AMMO",
		weight = 2.00
	},
	["WEAPON_APPISTOL"] = {
	    index = "kochvp9",
	    name = "Koch Vp9",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_APPISTOL_AMMO",
		weight = 2.00
	},
    ["WEAPON_HEAVYPISTOL"] = {
		index = "atifx45",
		name = "Ati FX45",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_HEAVYPISTOL_AMMO",
		weight = 2.00
	},
	["WEAPON_SNSPISTOL"] = {
		index = "amt380",
		name = "AMT 380",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_SNSPISTOL_AMMO",
		weight = 2.00
	},
	["WEAPON_SNSPISTOL_MK2"] = {
		index = "hkp7m10",
		name = "HK P7M10",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_SNSPISTOL_MK2_AMMO",
		weight = 2.00
	},
	["WEAPON_VINTAGEPISTOL"] = {
		index = "m1922",
		name = "M1922",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_VINTAGEPISTOL_AMMO",
		weight = 2.00
	},
	["WEAPON_PISTOL50"] = {
		index = "desert",
		name = "Desert Eagle",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_PISTOL50_AMMO",
		weight = 2.00
	},
	["WEAPON_REVOLVER"] = {
		index = "magnum",
		name = "Magnum 44",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_REVOLVER_AMMO",
		weight = 2.00
	},
	["WEAPON_COMBATPISTOL"] = {
		index = "glock",
		name = "Glock",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_COMBATPISTOL_AMMO",
		weight = 2.00
	},
	["WEAPON_PISTOL_AMMO"] = {
		index = "m1911ammo",
		name = "M. M1911",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_PISTOL_MK2_AMMO"] = {
		index = "fivesevenammo",
		name = "M. Five Seven",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_APPISTOL_AMMO"] = {
		index = "kochvp9ammo",
		name = "M. Koch Vp9",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_HEAVYPISTOL_AMMO"] = {
		index = "atifx45ammo",
		name = "M. Ati FX45",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_SNSPISTOL_AMMO"] = {
		index = "amt380ammo",
		name = "M. AMT 380",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_SNSPISTOL_MK2_AMMO"] = {
		index = "hkp7m10ammo",
		name = "M. HK P7M10",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_VINTAGEPISTOL_AMMO"] = {
		index = "m1922ammo",
		name = "M. M1922",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_PISTOL50_AMMO"] = {
		index = "desertammo",
		name = "M. Desert Eagle",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_REVOLVER_AMMO"] = {
		index = "magnumammo",
		name = "M. Magnum 44",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_COMBATPISTOL_AMMO"] = {
		index = "glockammo",
		name = "M. Glock",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
 -- END PISTOLS

 -- START SMG
    ["WEAPON_COMPACTRIFLE"] = {
		index = "akcompact",
		name = "AK Compact",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_COMPACTRIFLE_AMMO",
		weight = 3.00
	},
	["WEAPON_MICROSMG"] = {
		index = "uzi",
		name = "Uzi",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_MICROSMG_AMMO",
		weight = 3.00
	},
	["WEAPON_MINISMG"] = {
		index = "skorpionv61",
		name = "Skorpion V61",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_MINISMG_AMMO",
		weight = 3.00
	},
	["WEAPON_SMG"] = {
		index = "mp5",
		name = "MP5",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_SMG_AMMO",
		weight = 3.00
	},
	["WEAPON_ASSAULTSMG"] = {
		index = "mtar21",
		name = "MTAR-21",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_ASSAULTSMG_AMMO",
		weight = 3.00
	},
	["WEAPON_GUSENBERG"] = {
		index = "thompson",
		name = "Thompson",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_GUSENBERG_AMMO",
		weight = 3.00
	},
	["WEAPON_MACHINEPISTOL"] = {
		index = "tec9",
		name = "Tec-9",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_MACHINEPISTOL_AMMO",
		weight = 3.00
	},
	["WEAPON_COMPACTRIFLE_AMMO"] = {
		index = "akcompactammo",
		name = "M. AK Compact",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_MICROSMG_AMMO"] = {
		index = "uziammo",
		name = "M. Uzi",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_MINISMG_AMMO"] = {
		index = "skorpionv61ammo",
		name = "M. Skorpion V61",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_SMG_AMMO"] = {
		index = "mp5ammo",
		name = "M. MP5",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_ASSAULTSMG_AMMO"] = {
		index = "mtar21ammo",
		name = "M. MTAR-21",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_GUSENBERG_AMMO"] = {
		index = "thompsonammo",
		name = "M. Thompson",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_MACHINEPISTOL_AMMO"] = {
		index = "tec9ammo",
		name = "M. Tec-9",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
 -- END SMG

 -- START RIFLE
    ["WEAPON_CARBINERIFLE"] = {
		index = "m4a1",
		name = "M4A1",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_ASSAULTRIFLE_AMMO",
		weight = 3.00
	},
	["WEAPON_ASSAULTRIFLE"] = {
		index = "ak103",
		name = "AK-103",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_ASSAULTRIFLE_AMMO",
		weight = 3.00
	},
	["WEAPON_ASSAULTRIFLE_MK2"] = {
		index = "ak74",
		name = "AK-74",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_ASSAULTRIFLE_MK2_AMMO",
		weight = 3.00
	},
	["WEAPON_CARBINERIFLE_AMMO"] = {
		index = "m4a1ammo",
		name = "M. M4A1",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_ASSAULTRIFLE_AMMO"] = {
		index = "ak103ammo",
		name = "M. AK-103",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_ASSAULTRIFLE_MK2_AMMO"] = {
		index = "ak74ammo",
		name = "M. AK-74",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
 -- END RIFLE

 -- START SHOTGUN
    ["WEAPON_PUMPSHOTGUN"] = {
		index = "remington",
		name = "Remington",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_PUMPSHOTGUN_AMMO",
		weight = 3.00
	},
	["WEAPON_SAWNOFFSHOTGUN"] = {
		index = "mossberg590",
		name = "Mossberg 590",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_SAWNOFFSHOTGUN_AMMO",
		weight = 3.00
	},
	["WEAPON_PUMPSHOTGUN_AMMO"] = {
		index = "remingtonammo",
		name = "M. Remington",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_SAWNOFFSHOTGUN_AMMO"] = {
		index = "mossberg590ammo",
		name = "M. Mossberg 590",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
 -- END SHOTGUN

 -- START OTHERS
	["WEAPON_PETROLCAN_AMMO"] = {
		index = "fuel",
		name = "Combustível",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_RAYPISTOL"] = {
		index = "raypistol",
		name = "Pistola de Raios",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 1.00
	},
	["WEAPON_RPG"] = {
		index = "rpg",
		name = "RPG-7",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 3.00
	},
	["WEAPON_RPG_AMMO"] = {
		index = "rpgammo",
		name = "M. RPG-7",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.50
	},
 -- END OTHERS

	["pager"] = {
		index = "pager",
		name = "Pager",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.50
	},
	["firecracker"] = {
		index = "firecracker",
		name = "Fogos de Artificio",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 2.50
	},
	["analgesic"] = {
		index = "analgesic",
		name = "Analgésico",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["gauze"] = {
		index = "gauze",
		name = "Gazes",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 2.50
	},
	["gsrkit"] = {
		index = "gsrkit",
		name = "Kit Residual",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 3.50
	},
	["gdtkit"] = {
		index = "gdtkit",
		name = "Kit Químico",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 6.50
	},
	["fueltech"] = {
		index = "fueltech",
		name = "Fueltech",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 3.50
	},
	["cpuchip"] = {
		index = "cpuchip",
		name = "Processador",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 5.50
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATE:ADVTOOLBOX
-----------------------------------------------------------------------------------------------------------------------------------------
for i = 1,99 do
	itemlist["toolboxes"..i] = {
		index = "toolbox",
		name = "Caixa de Ferramentas",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.75
	}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMBODYLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemBodyList(item)
	if itemlist[item] then
		return itemlist[item]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMINDEXLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemIndexList(item)
	if itemlist[item] then
		return itemlist[item].index
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMNAMELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemNameList(item)
	if itemlist[item] then
		return itemlist[item].name
	end
	return "REMOVIDO"
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDESCLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemDescList(item)
    if itemlist[item] then
        return itemlist[item].desc or nil
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMTIPOLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemTipoList(item)
    if itemlist[item] then
        return itemlist[item].tipo or nil
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMUNITYLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemUnityList(item)
    if itemlist[item] then
        return itemlist[item].unity or nil
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMECONOMYLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemEconomyList(item)
    if itemlist[item] then
        return itemlist[item].economy or nil
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMSUBTYPELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemSubTypeList(item)
    if itemlist[item] then
        return itemlist[item].subtype or nil
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMTRANSFORMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemTransformList(item)
    if itemlist[item] then
        return itemlist[item].transform or nil
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDURABILITYLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemDurabilityList(item)
    if itemlist[item] then
        return itemlist[item].durability or nil
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMTYPELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemTypeList(item)
	if itemlist[item] then
		return itemlist[item].type
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMAMMOLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemAmmoList(item)
	if itemlist[item] then
		return itemlist[item].ammo
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMWEIGHTLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemWeightList(item)
	if itemlist[item] then
		return itemlist[item].weight
	end
	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPUTEINVWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.computeInvWeight(user_id)
	local weight = 0
	local inventory = vRP.getInventory(user_id)
	if inventory then
		for k,v in pairs(inventory) do
			if vRP.itemBodyList(v.item) then
				weight = weight + vRP.itemWeightList(v.item) * parseInt(v.amount)
			end
		end
		return weight
	end
	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPUTECHESTWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.computeChestWeight(items)
	local weight = 0
	for k,v in pairs(items) do
		if vRP.itemBodyList(k) then
			weight = weight + vRP.itemWeightList(k) * parseInt(v.amount)
		end
	end
	return weight
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETINVENTORYITEMAMOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getInventoryItemAmount(user_id,idname)
	local data = vRP.getInventory(user_id)
	if data then
		for k,v in pairs(data) do
			if v.item == idname then
				return parseInt(v.amount)
			end
		end
	end
	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SWAPSLOT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.swapSlot(user_id,slot,target)
	local data = vRP.getInventory(user_id)
	if data then
		local temp = data[tostring(slot)]
		data[tostring(slot)] = data[tostring(target)]
		data[tostring(target)] = temp
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETINVENTORYITEMDURABILITY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getInventoryItemDurability(user_id,idname)
	local data = vRP.getInventory(user_id)
	if data then
		for k,v in pairs(data) do
			if v.item == idname and v.timestamp then
				return v.timestamp
			end
		end
	end
	return nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVEINVENTORYITEM
-----------------------------------------------------------------------------------------------------------------------------------------
	function vRP.giveInventoryItem(user_id,idname,amount,notify,slot,timestamp)
		local data = vRP.getInventory(user_id)
		if data and parseInt(amount) > 0 then
			if not slot then
				local initial = 0
				repeat
					initial = initial + 1
				until data[tostring(initial)] == nil or (data[tostring(initial)] and data[tostring(initial)].item == idname)
				initial = tostring(initial)
				

				if vRP.itemSubTypeList(idname) then
					if vRP.getInventoryItemAmount(user_id,idname) > 0 then
						return false
					else
						if data[initial] == nil then
							if timestamp then
								data[initial] = { item = idname, amount = parseInt(1), timestamp = timestamp }
							else
								data[initial] = { item = idname, amount = parseInt(1), timestamp = (os.time() + vRP.itemDurabilityList(idname)) }
							end
							
						elseif data[initial] and data[initial].item == idname then
							return false
						end
		
						if notify and vRP.itemBodyList(idname) then
							TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "+",vRP.itemIndexList(idname),vRP.format(parseInt(1)),vRP.itemNameList(idname) })
						end
						return true
					end
				else
					if data[initial] == nil then
						data[initial] = { item = idname, amount = parseInt(amount) }
					elseif data[initial] and data[initial].item == idname then
						data[initial].amount = parseInt(data[initial].amount) + parseInt(amount)
					end

					if notify and vRP.itemBodyList(idname) then
						TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "+",vRP.itemIndexList(idname),vRP.format(parseInt(amount)),vRP.itemNameList(idname) })
					end
					return true
				end
			else
				slot = tostring(slot)

				if vRP.itemSubTypeList(idname) then
					if data[slot] then
						return false
					else
						if timestamp then
							data[slot] = { item = idname, amount = parseInt(1), timestamp = timestamp }
						else
							data[slot] = { item = idname, amount = parseInt(1), timestamp = (os.time() + vRP.itemDurabilityList(idname)) }
						end
					end

					if notify and vRP.itemBodyList(idname) then
						TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "+",vRP.itemIndexList(idname),vRP.format(parseInt(1)),vRP.itemNameList(idname) })
					end
					return true
				else
					if data[slot] then
						if data[slot].item == idname then
							local oldAmount = parseInt(data[slot].amount)
							data[slot] = { item = idname, amount = parseInt(oldAmount) + parseInt(amount) }
						end
					else
						data[slot] = { item = idname, amount = parseInt(amount) }
					end

					if notify and vRP.itemBodyList(idname) then
						TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "+",vRP.itemIndexList(idname),vRP.format(parseInt(amount)),vRP.itemNameList(idname) })
					end
					return true
				end
			end
		end
	end

	-- function vRP.giveInventoryItem(user_id,idname,amount,notify,slot)
	-- 	local data = vRP.getInventory(user_id)
	-- 	if data and parseInt(amount) > 0 then
	-- 		if not slot then
	-- 			local initial = 0
	-- 			repeat
	-- 				initial = initial + 1
	-- 			until data[tostring(initial)] == nil or (data[tostring(initial)] and data[tostring(initial)].item == idname)
	-- 			initial = tostring(initial)
				
	-- 			if data[initial] == nil then
	-- 				data[initial] = { item = idname, amount = parseInt(amount) }
	-- 			elseif data[initial] and data[initial].item == idname then
	-- 				data[initial].amount = parseInt(data[initial].amount) + parseInt(amount)
	-- 			end

	-- 			if notify and vRP.itemBodyList(idname) then
	-- 				TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "RECEBEU",vRP.itemIndexList(idname),vRP.format(parseInt(amount)),vRP.itemNameList(idname) })
	-- 			end
	-- 		else
	-- 			slot = tostring(slot)

	-- 			if data[slot] then
	-- 				if data[slot].item == idname then
	-- 					local oldAmount = parseInt(data[slot].amount)
	-- 					data[slot] = { item = idname, amount = parseInt(oldAmount) + parseInt(amount) }
	-- 				end
	-- 			else
	-- 				data[slot] = { item = idname, amount = parseInt(amount) }
	-- 			end

	-- 			if notify and vRP.itemBodyList(idname) then
	-- 				TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "RECEBEU",vRP.itemIndexList(idname),vRP.format(parseInt(amount)),vRP.itemNameList(idname) })
	-- 			end
	-- 		end
	-- 	end
	-- end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYGETINVENTORYITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.tryGetInventoryItem(user_id,idname,amount,notify,slot)
	local data = vRP.getInventory(user_id)
	if data then
		if not slot then
			for k,v in pairs(data) do
				if v.item == idname and parseInt(v.amount) >= parseInt(amount) then
					v.amount = parseInt(v.amount) - parseInt(amount)

					if parseInt(v.amount) <= 0 then
						data[k] = nil
					end

					if notify and vRP.itemBodyList(idname) then
						TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "-",vRP.itemIndexList(idname),vRP.format(parseInt(amount)),vRP.itemNameList(idname) })
					end
					return true
				end
			end
		else
			local slot  = tostring(slot)

			if data[slot] and data[slot].item == idname and parseInt(data[slot].amount) >= parseInt(amount) then
				data[slot].amount = parseInt(data[slot].amount) - parseInt(amount)

				if parseInt(data[slot].amount) <= 0 then
					data[slot] = nil
				end

				if notify and vRP.itemBodyList(idname) then
					TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "-",vRP.itemIndexList(idname),vRP.format(parseInt(amount)),vRP.itemNameList(idname) })
				end
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEINVENTORYITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.removeInventoryItem(user_id,idname,amount,notify)
	local data = vRP.getInventory(user_id)
	if data then
		for k,v in pairs(data) do
			if v.item == idname and parseInt(v.amount) >= parseInt(amount) then
				v.amount = parseInt(v.amount) - parseInt(amount)

				if parseInt(v.amount) <= 0 then
					data[k] = nil
				end

				if notify and vRP.itemBodyList(idname) then
					TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "-",vRP.itemIndexList(idname),vRP.format(parseInt(amount)),vRP.itemNameList(idname) })
				end

				break
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEDURABILITY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.createDurability(itemName)
	local advFile = LoadResourceFile("logsystem","toolboxes.json")
	local advDecode = json.decode(advFile)

	if advDecode[itemName] then
		advDecode[itemName] = advDecode[itemName] - 1

		if advDecode[itemName] <= 0 then
			advDecode[itemName] = nil
			vRP.removeInventoryItem(user_id,itemName,1,true)
		end
	else
		advDecode[itemName] = 9
	end

	SaveResourceFile("logsystem","toolboxes.json",json.encode(advDecode),-1)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVED
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
local activedAmount = {}
Citizen.CreateThread(function()
	while true do
		local slyphe = 500
		if actived then
			slyphe = 100 
			for k,v in pairs(actived) do
				if actived[k] > 0 then
					actived[k] = v - 1
					if actived[k] <= 0 then
						actived[k] = nil
					end
				end
			end
		end
		Citizen.Wait(slyphe)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARLOGS
-----------------------------------------------------------------------------------------------------------------------------------------
local policeLogs = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYCHESTITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.tryChestItem(user_id,chestData,itemName,amount,slot)
	if actived[user_id] == nil then
		actived[user_id] = 1
		local data = vRP.getSData(chestData)
		local items = json.decode(data) or {}
		if data and items ~= nil then
			if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then

				if parseInt(amount) > 0 then
					activedAmount[user_id] = parseInt(amount)
				else
					activedAmount[user_id] = parseInt(items[itemName].amount)
				end

				local new_weight = vRP.computeInvWeight(user_id) + vRP.itemWeightList(itemName) * parseInt(activedAmount[user_id])
				if new_weight <= vRP.getBackpack(user_id) then
					vRP.giveInventoryItem(user_id,itemName,parseInt(activedAmount[user_id]),true,slot)

					items[itemName].amount = parseInt(items[itemName].amount) - parseInt(activedAmount[user_id])

					if chestData == "chest:Police" then
						vRP.createWeebHook(policeLogs,"```PASSAPORTE: "..user_id.." ( RETIROU )\nITEM: "..vRP.format(parseInt(activedAmount[user_id])).."x "..vRP.itemNameList(itemName).."```")
					end

					if parseInt(items[itemName].amount) <= 0 then
						items[itemName] = nil
					end

					vRP.setSData(chestData,json.encode(items))
					return true
				end
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORECHESTITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.storeChestItem(user_id,chestData,itemName,amount,chestWeight,slot)
	if actived[user_id] == nil then
		actived[user_id] = 1
		local slot = tostring(slot)
		local data = vRP.getSData(chestData)
		local items = json.decode(data) or {}
		if data and items ~= nil then

			if parseInt(amount) > 0 then
				activedAmount[user_id] = parseInt(amount)
			else
				local inv = vRP.getInventory(user_id)
				if inv[slot] then
					activedAmount[user_id] = parseInt(inv[slot].amount)
				end
			end

			local new_weight = vRP.computeChestWeight(items) + vRP.itemWeightList(itemName) * parseInt(activedAmount[user_id])
			if new_weight <= chestWeight then
				if vRP.tryGetInventoryItem(user_id,itemName,parseInt(activedAmount[user_id]),true,slot) then
					if items[itemName] ~= nil then
						items[itemName].amount = parseInt(items[itemName].amount) + parseInt(activedAmount[user_id])
					else
						items[itemName] = { amount = parseInt(activedAmount[user_id]) }
					end

					if chestData == "chest:Police" then
						vRP.createWeebHook(policeLogs,"```PASSAPORTE: "..user_id.." ( GUARDOU )\nITEM: "..vRP.format(parseInt(activedAmount[user_id])).."x "..vRP.itemNameList(itemName).."```")
					end

					vRP.setSData(chestData,json.encode(items))
					return true
				end
			end
		end
	end
	return false
end