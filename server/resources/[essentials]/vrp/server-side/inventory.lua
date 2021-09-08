-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
    ["scrapmetal"] = {
	    index = "scrapmetal",
		name = "Sucata de Metal",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "5",
		type = "use",
		weight = 0.05
	},
    ["whistle"] = {
	    index = "whistle",
		name = "Apito Animal",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "325",
		type = "use",
		weight = 0.15
	},
	["syringe"] = {
	    index = "adrenaline",
		name = "Seringa",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "4",
		type = "use",
		weight = 0.10
	},
	["syringeB"] = {
	    index = "syringe",
		name = "Seringa B+",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.10
	},
	["syringeA"] = {
	    index = "syringe",
		name = "Seringa A+",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.10
	},
    ["tablet"] = {
	    index = "tablet",
		name = "Tablet Particular",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "125",
		type = "use",
		weight = 0.15
	},
	["coptablet"] = {
		index = "coptablet",
		name = "Tablet Policial",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "125",
		type = "use",
		weight = 0.15
	},
	["foodburger"] = {
		index = "foodburger",
		name = "Caixa de Hamburger",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.15
	},
	["foodjuice"] = {
		index = "foodjuice",
		name = "Copo de Suco",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.15
	},
	["foodbox"] = {
		index = "foodbox",
		name = "Combo",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 1.00
	},
	["evidence01"] = {
		index = "evidence01",
		name = "Evidência",
		desc = "",
		tipo = "Evidência",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.05
	},
	["evidence02"] = {
		index = "evidence02",
		name = "Evidência",
		desc = "",
		tipo = "Evidência",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.05
	},
	["evidence03"] = {
		index = "evidence03",
		name = "Evidência",
		desc = "",
		tipo = "Evidência",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.05
	},
	["evidence04"] = {
		index = "evidence04",
		name = "Evidência",
		desc = "",
		tipo = "Evidência",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.05
	},
	["radio"] = {
		index = "radio",
		name = "Rádio",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "975",
		type = "use",
		weight = 0.75
	},
	["radiodamaged"] = {
        index = "radiodamaged",
        name = "Rádio Queimado",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "975",
        type = "use",
        weight = 0.75
    },
	["wheelchair"] = {
		index = "wheelchair",
		name = "Cadeira de Rodas",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "2250",
		type = "use",
		weight = 7.50
	},
	["bandage"] = {
		index = "bandage",
		name = "Bandagem",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "225",
		type = "use",
		weight = 0.10
	},
	["medkit"] = {
		index = "medkit",
		name = "Kit Médico",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "525",
		type = "use",
		weight = 0.45
	},
	["adrenaline"] = {
		index = "adrenaline",
		name = "Adrenalina",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "975",
		type = "use",
		weight = 0.35
	},
	["credential"] = {
		index = "credential",
		name = "Credencial",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "225",
		type = "use",
		weight = 0.75
	},
	["pouch"] = {
		index = "pouch",
		name = "Malote",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.75
	},
	["woodlog"] = {
		index = "woodlog",
		name = "Tora de Madeira",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.75
	},
	["fishingrod"] = {
		index = "fishingrod",
		name = "Vara de Pescar",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "725",
		type = "use",
		weight = 2.75
	},
	["octopus"] = {
		index = "octopus",
		name = "Polvo",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "20",
		type = "use",
		weight = 0.75
	},
	["shrimp"] = {
		index = "shrimp",
		name = "Camarão",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "20",
		type = "use",
		weight = 0.50
	},
	["carp"] = {
		index = "carp",
		name = "Carpa",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "18",
		type = "use",
		weight = 0.50
	},
	["codfish"] = {
		index = "codfish",
		name = "Bacalhau",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "22",
		type = "use",
		weight = 0.50
	},
	["catfish"] = {
		index = "catfish",
		name = "Bagre",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "22",
		type = "use",
		weight = 0.50
	},
	["goldenfish"] = {
		index = "goldenfish",
		name = "Dourado",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "23",
		type = "use",
		weight = 0.25
	},
	["horsefish"] = {
		index = "horsefish",
		name = "Cavala",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "18",
		type = "use",
		weight = 0.50
	},
	["tilapia"] = {
		index = "tilapia",
		name = "Tilápia",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "20",
		type = "use",
		weight = 0.25
	},
	["pacu"] = {
		index = "pacu",
		name = "Pacu",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "25",
		type = "use",
		weight = 0.50
	},
	["pirarucu"] = {
		index = "pirarucu",
		name = "Pirarucu",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "23",
		type = "use",
		weight = 0.25
	},
	["tambaqui"] = {
		index = "tambaqui",
		name = "Tambaqui",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "23",
		type = "use",
		weight = 0.75
	},
	["bait"] = {
		index = "bait",
		name = "Isca",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "4",
		type = "use",
		weight = 0.25
	},
	["meatA"] = {
		index = "meat",
		name = "Carne Animal",
		desc = "Corte nobre de classe A.",
		tipo = "Comum",
		unity = "Não",
		economy = "40",
		type = "use",
		weight = 0.75
	},
	["meatB"] = {
		index = "meat2",
		name = "Carne Animal",
		desc = "Corte nobre de classe B.",
		tipo = "Comum",
		unity = "Não",
		economy = "45",
		type = "use",
		weight = 0.75
	},
	["meatC"] = {
		index = "meat3",
		name = "Carne Animal",
		desc = "Corte nobre de classe C.",
		tipo = "Comum",
		unity = "Não",
		economy = "50",
		type = "use",
		weight = 0.75
	},
	["meatS"] = {
		index = "meat4",
		name = "Carne Animal",
		desc = "Corte nobre de classe S.",
		tipo = "Comum",
		unity = "Não",
		economy = "55",
		type = "use",
		weight = 0.75
	},
	["animalpelt"] = {
		index = "animalpelt",
		name = "Pele Animal",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "50",
		type = "use",
		weight = 0.10
	},
	["horndeer"] = {
		index = "horndeer",
		name = "Chifre de Cervo",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "225",
		type = "use",
		weight = 4.00
	},
	["joint"] = {
		index = "joint",
		name = "Baseado",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "40",
		type = "use",
		weight = 0.50
	},
	["lean"] = {
		index = "lean",
		name = "Lean",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "35",
		type = "use",
		weight = 0.50
	},
	["ecstasy"] = {
		index = "ecstasy",
		name = "Ecstasy",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "35",
		type = "use",
		weight = 0.50
	},
	["cocaine"] = {
		index = "cocaine",
		name = "Cocaína",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "35",
		type = "use",
		weight = 0.50
	},
	["meth"] = {
		index = "meth",
		name = "Metanfetamina",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "35",
		type = "use",
		weight = 0.50
	},
	["heroine"] = {
		index = "heroine",
		name = "Heroína",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "3500",
		type = "use",
		weight = 0.50
	},
	["backpack"] = {
		index = "backpack",
		name = "Mochila",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "2225",
		type = "use",
		weight = 4.25
	},
	["premium01"] = {
		index = "premium01",
		name = "Premium 3 Dias",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "22500",
		type = "use",
		weight = 0.00
	},
	["premium02"] = {
		index = "premium02",
		name = "Premium 7 Dias",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "45000",
		type = "use",
		weight = 0.00
	},
	["premium03"] = {
		index = "premium03",
		name = "Premium 15 Dias",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "67500",
		type = "use",
		weight = 0.00
	},
	["premium04"] = {
		index = "premium04",
		name = "Premium 1 Mês",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "90000",
		type = "use",
		weight = 0.00
	},
	["namechange"] = {
		index = "namechange",
		name = "Troca de nome",
		desc = "Troca o nome do personagem.",
		tipo = "Usável",
		unity = "Não",
		economy = "75000",
		type = "use",
		weight = 0.00
	},
	["newchars"] = {
		index = "newchars",
		name = "+1 Personagem",
		desc = "Limite de personagem em +1.",
		tipo = "Usável",
		unity = "Não",
		economy = "150000",
		type = "use",
		weight = 0.00
	},
	["newgarage"] = {
		index = "newgarage",
		name = "+1 Garagem",
		desc = "Limite de garagem em +1.",
		tipo = "Usável",
		unity = "Não",
		economy = "75000",
		type = "use",
		weight = 0.00
	},
	["premiumplate"] = {
		index = "platepremium",
		name = "Placa Premium",
		desc = "Troca a placa de registro do veículo.",
		tipo = "Usável",
		unity = "Não",
		economy = "45000",
		type = "use",
		weight = 0.50
	},
	["energetic"] = {
		index = "energetic",
		name = "Energético",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "15",
		type = "use",
		weight = 0.25
	},
	["battery"] = {
		index = "battery",
		name = "Pilhas",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "60",
		type = "use",
		weight = 0.20
	},
	["elastic"] = {
		index = "elastic",
		name = "Elástico",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "48",
		type = "use",
		weight = 0.10
	},
	["plasticbottle"] = {
		index = "plasticbottle",
		name = "Garrafa Plástica",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "48",
		type = "use",
		weight = 0.20
	},
	["glassbottle"] = {
		index = "glassbottle",
		name = "Garrafa de Vidro",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "42",
		type = "use",
		weight = 0.50
	},
	["metalcan"] = {
		index = "metalcan",
		name = "Lata de Metal",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "60",
		type = "use",
		weight = 0.20
	},
	["emptybottle"] = {
		index = "emptybottle",
		name = "Garrafa Vazia",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "30",
		type = "use",
		weight = 0.10
	},
	["water"] = {
		index = "water",
		name = "Água",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "30",
		type = "use",
		weight = 0.15
	},
	["dirtywater"] = {
		index = "dirtywater",
		name = "Água Suja",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "30",
		type = "use",
		weight = 0.15
	},
	["cellphone"] = {
		index = "cellphone",
		name = "Celular",
		desc = "Celular funcionando",
		tipo = "Usável",
		unity = "Sim",
		economy = "575",
		type = "use",
		subtype = "comida",
		transform = "nbcellphone",
		durability = 10800,
		weight = 0.75
	},
	["nbcellphone"] = {
        index = "nbcellphone",
        name = "Celular Descarregado",
		desc = "Celular sem bateria",
		tipo = "Comum",
		unity = "Não",
		economy = "325",
        type = "use",
        weight = 0.75
    },
	["cellphonedamaged"] = {
        index = "cellphonedamaged",
        name = "Celular Queimado",
		desc = "Celular totalmente queimado",
		tipo = "Eletrônico",
		unity = "Não",
		economy = "240",
        type = "use",
        weight = 0.85
    },
	["mbattery"] = {
		index = "mbattery",
		name = "Bateria Móvel",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "35",
		type = "use",
		weight = 0.35
	},
    ["cola"] = {
		index = "cola",
		name = "Cola",
		desc = "",
		tipo = "Usável",
		unity = "Sim",
		economy = "15",
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
		tipo = "Usável",
		unity = "Não",
		economy = "10",
		type = "use",
		weight = 0.15
	},
    ["soda"] = {
		index = "soda",
		name = "Sprunk",
		desc = "",
		tipo = "Usável",
		unity = "Sim",
		economy = "15",
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
		tipo = "Usável",
		unity = "Não",
		economy = "10",
		type = "use",
		weight = 0.15
	},
	["coffee"] = {
		index = "coffee",
		name = "Café",
		desc = "",
		tipo = "Usável",
		unity = "Sim",
		economy = "20",
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
		tipo = "Usável",
		unity = "Não",
		economy = "10",
		type = "use",
		weight = 0.15
	},
	["hamburger"] = {
		index = "hamburger",
		name = "Hambúrguer",
		desc = "",
		tipo = "Usável",
		unity = "Sim",
		economy = "25",
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
		tipo = "Comum",
		unity = "Não",
		economy = "15",
		type = "use",
		weight = 0.35
	},
	["hamburger2"] = {
		index = "hamburger2",
		name = "X-Burguer",
		desc = "",
		tipo = "Usável",
		unity = "Sim",
		economy = "50",
		type = "use",
		subtype = "comida",
		transform = "badhamburger2",
		durability = 1500,
		weight = 0.55
	},
	["badhamburger2"] = {
		index = "badhamburger2",
		name = "X-Burguer vencido",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "25",
		type = "use",
		weight = 0.55
	},
	["hamburger3"] = {
		index = "hamburger3",
		name = "X-Salada",
		desc = "",
		tipo = "Usável",
		unity = "Sim",
		economy = "60",
		type = "use",
		subtype = "comida",
		transform = "badhamburger3",
		durability = 1500,
		weight = 0.55
	},
	["badhamburger3"] = {
		index = "badhamburger3",
		name = "X-Salada vencido",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "30",
		type = "use",
		weight = 0.55
	},
	["hamburger4"] = {
		index = "hamburger4",
		name = "X-Bacon",
		desc = "",
		tipo = "Usável",
		unity = "Sim",
		economy = "70",
		type = "use",
		subtype = "comida",
		transform = "badhamburger4",
		durability = 1500,
		weight = 0.55
	},
	["badhamburger4"] = {
		index = "badhamburger4",
		name = "X-Bacon vencido",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "35",
		type = "use",
		weight = 0.55
	},
	["hamburger5"] = {
		index = "hamburger5",
		name = "X-Picanha",
		desc = "",
		tipo = "Usável",
		unity = "Sim",
		economy = "80",
		type = "use",
		subtype = "comida",
		transform = "badhamburger5",
		durability = 1500,
		weight = 0.55
	},
	["badhamburger5"] = {
		index = "badhamburger5",
		name = "X-Picanha vencido",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "40",
		type = "use",
		weight = 0.55
	},
	["hotdog"] = {
		index = "hotdog",
		name = "Cachorro-Quente",
		desc = "",
		tipo = "Usável",
		unity = "Sim",
		economy = "15",
		type = "use",
		subtype = "comida",
		transform = "badhotdog",
		durability = 1500,
		weight = 0.35
	},
	["badhotdog"] = {
		index = "badhotdog",
		name = "Cachorro-Quente vencido",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "10",
		type = "use",
		weight = 0.35
	},
	["sandwich"] = {
		index = "sandwich",
		name = "Sanduiche",
		desc = "",
		tipo = "Usável",
		unity = "Sim",
		economy = "15",
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
		tipo = "Comum",
		unity = "Não",
		economy = "10",
		type = "use",
		weight = 0.25
	},
	["chocolate"] = {
		index = "chocolate",
		name = "Chocolate",
		desc = "",
		tipo = "Usável",
		unity = "Sim",
		economy = "15",
		type = "use",
		weight = 0.10
	},
	["donut"] = {
		index = "donut",
		name = "Rosquinha",
		desc = "",
		tipo = "Usável",
		unity = "Sim",
		economy = "15",
		type = "use",
		subtype = "comida",
		transform = "baddonut",
		durability = 1500,
		weight = 0.25
	},
	["baddonut"] = {
		index = "baddonut",
		name = "Rosquinha vencida",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "10",
		type = "use",
		weight = 0.25
	},
	["tacos"] = {
		index = "tacos",
		name = "Tacos",
		desc = "",
		tipo = "Usável",
		unity = "Sim",
		economy = "22",
		type = "use",
		subtype = "comida",
		transform = "badtacos",
		durability = 1500,
		weight = 0.25
	},
	["badtacos"] = {
		index = "badtacos",
		name = "Tacos vencido",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "11",
		type = "use",
		weight = 0.25
	},
	["fries"] = {
		index = "fries",
		name = "Fritas",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "15",
		type = "use",
		weight = 0.15
	},
	["bread"] = {
		index = "bread",
		name = "Pão",
		desc = "Usado para fazer Hambúrguers",
		tipo = "Usável",
		unity = "Não",
		economy = "5",
		type = "use",
		weight = 0.25
	},
	["plate"] = {
		index = "plate",
		name = "Placa",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "275",
		type = "use",
		weight = 0.50
	},
	["lockpick"] = {
		index = "lockpick",
		name = "Lockpick",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "400",
		type = "use",
		subtype = "comida",
		transform = "lockpick2",
		durability = 10800,
		weight = 1.25
	},
	["lockpick2"] = {
		index = "lockpick2",
		name = "Lockpick Quebrada",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "65",
		type = "use",
		weight = 1.25
	},
	["vest"] = {
		index = "vest",
		name = "Colete",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "875",
		type = "use",
		subtype = "comida",
		transform = "vest2",
		durability = 10800,
		weight = 2.25
	},
	["vest2"] = {
		index = "vest2",
		name = "Colete Danificado",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "125",
		type = "use",
		weight = 2.25
	},
	["toolbox"] = {
		index = "toolbox",
		name = "Caixa de Ferramentas",
		desc = "",
		tipo = "Ferramentas",
		unity = "Não",
		economy = "500",
		type = "use",
		weight = 1.75
	},
	["notepad"] = {
		index = "notepad",
		name = "Bloco de Notas",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "10",
		type = "use",
		weight = 0.25
	},
	["tires"] = {
		index = "tires",
		name = "Pneus",
		desc = "",
		tipo = "Material",
		unity = "Não",
		economy = "250",
		type = "use",
		weight = 1.50
	},
	["divingsuit"] = {
		index = "divingsuit",
		name = "Roupa de Mergulho",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "975",
		type = "use",
		weight = 4.75
	},
	["amethyst"] = {
		index = "amethyst",
		name = "Ametista",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "40",
		type = "use",
		weight = 0.65
	},
	["diamond"] = {
		index = "diamond",
		name = "Diamante",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "90",
		type = "use",
		weight = 0.80
	},
	["emerald"] = {
		index = "emerald",
		name = "Esmeralda",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "120",
		type = "use",
		weight = 0.85
	},
	["ruby"] = {
		index = "ruby",
		name = "Rubi",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "50",
		type = "use",
		weight = 0.75
	},
	["sapphire"] = {
		index = "sapphire",
		name = "Safira",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "45",
		type = "use",
		weight = 0.70
	},
	["turquoise"] = {
		index = "turquoise",
		name = "Turquesa",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "30",
		type = "use",
		weight = 0.55
	},
	["amber"] = {
		index = "amber",
		name = "Âmbar",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "35",
		type = "use",
		weight = 0.60
	},
	["gemstone"] = {
		index = "gemstone",
		name = "Gemstone",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "1250",
		type = "use",
		weight = 0.10
	},
	["handcuff"] = {
		index = "handcuff",
		name = "Algemas",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "3975",
		type = "use",
		weight = 0.75
	},
	["rope"] = {
		index = "rope",
		name = "Cordas",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "875",
		type = "use",
		weight = 1.50
	},
	["hood"] = {
		index = "hood",
		name = "Capuz",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "3675",
		type = "use",
		weight = 1.50
	},
	["key"] = {
		index = "key",
		name = "Chaves",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "45",
		type = "use",
		weight = 0.25
	},
	["fabric"] = {
		index = "fabric",
		name = "Tecido",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "100",
		type = "use",
		weight = 0.050
	},
	["plastic"] = {
		index = "plastic",
		name = "Plástico",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "16",
		type = "use",
		weight = 0.075
	},
	["glass"] = {
		index = "glass",
		name = "Vidro",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "14",
		type = "use",
		weight = 0.075
	},
	["rubber"] = {
		index = "rubber",
		name = "Borracha",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "16",
		type = "use",
		weight = 0.050
	},
	["aluminum"] = {
		index = "aluminum",
		name = "Alúminio",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "20",
		type = "use",
		weight = 0.075
	},
	["copper"] = {
		index = "copper",
		name = "Cobre",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "20",
		type = "use",
		weight = 0.075
	},
	["titanium"] = {
		index = "titanium",
		name = "Titânio",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "275",
		type = "use",
		weight = 0.150
	},
	["keyboard"] = {
		index = "keyboard",
		name = "Teclado",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "85",
		type = "use",
		weight = 0.50
	},
	["mouse"] = {
		index = "mouse",
		name = "Mouse",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "85",
		type = "use",
		weight = 0.25
	},
	["watch"] = {
		index = "watch",
		name = "Relógio",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "100",
		type = "use",
		weight = 0.25
	},
	["c4"] = {
		index = "c4",
		name = "C4",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "275",
		type = "use",
		weight = 2.50
	},
	["ritmoneury"] = {
		index = "ritmoneury",
		name = "Ritmoneury",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "475",
		type = "use",
		weight = 0.25
	},
	["sinkalmy"] = {
		index = "sinkalmy",
		name = "Sinkalmy",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "325",
		type = "use",
		weight = 0.25
	},
	["cigarette"] = {
		index = "cigarette",
		name = "Cigarro",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "10",
		type = "use",
		weight = 0.05
	},
	["lighter"] = {
		index = "lighter",
		name = "Isqueiro",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "175",
		type = "use",
		weight = 0.25
	},
	["vape"] = {
		index = "vape",
		name = "Vape",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "4750",
		type = "use",
		weight = 0.75
	},
	["newspaper"] = {
		index = "newspaper",
		name = "Jornal",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "15",
		type = "use",
		weight = 0.375
	},
	["dollars"] = {
		index = "dollars",
		name = "Dólares",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.0001
	},
	["dollars2"] = {
		index = "dollarsz",
		name = "Dólares Marcados",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.0001
	},
	["mask"] = {
		index = "mask",
		name = "Máscara",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "275",
		type = "use",
		weight = 0.20
	},
	["gloves"] = {
		index = "gloves",
		name = "Luvas",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "225",
		type = "use",
		weight = 0.15
	},
	["hat"] = {
		index = "hat",
		name = "Chapéu",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "225",
		type = "use",
		weight = 0.25
	},
	["glasses"] = {
		index = "glasses",
		name = "Óculos",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "225",
		type = "use",
		weight = 0.10
	},
	["card01"] = {
		index = "card01",
		name = "Cartão Classic",
		desc = "Hackear Lojas de Departamento.",
		tipo = "Usável",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.10
	},
	["card02"] = {
		index = "card02",
		name = "Cartão Gold",
		desc = "Hackear Lojas de Armas.",
		tipo = "Usável",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.10
	},
	["card03"] = {
		index = "card03",
		name = "Cartão Platinum",
		desc = "Hackear Bancos Fleeca.",
		tipo = "Usável",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.10
	},
	["card04"] = {
		index = "card04",
		name = "Cartão Standard",
		desc = "Hackear Barbearias.",
		tipo = "Usável",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.10
	},
	["card05"] = {
		index = "card05",
		name = "Cartão Black",
		desc = "Hackear Bancos.",
		tipo = "Usável",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.10
	},
	["hardness"] = {
		index = "hardness",
		name = "Cinto Reforçado",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "50000",
		type = "use",
		weight = 5.00
	},
	["rose"] = {
		index = "rose",
		name = "Rosa",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "25",
		type = "use",
		weight = 0.15
	},
	["teddy"] = {
		index = "teddy",
		name = "Teddy",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "75",
		type = "use",
		weight = 0.75
	},
	["absolut"] = {
		index = "absolut",
		name = "Absolut",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "15",
		type = "use",
		weight = 0.25
	},
	["chandon"] = {
		index = "chandon",
		name = "Chandon",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "15",
		type = "use",
		weight = 0.35
	},
	["dewars"] = {
		index = "dewars",
		name = "Dewars",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "15",
		type = "use",
		weight = 0.25
	},
	["hennessy"] = {
		index = "hennessy",
		name = "Hennessy",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "15",
		type = "use",
		weight = 0.25
	},
	["identity"] = {
		index = "newchars",
		name = "Identidade",
		desc = "Use e mostre para a pessoa mais próxima.",
		tipo = "Usável",
		unity = "Não",
		economy = "25",
		type = "use",
		weight = 0.25
	},
	["goldbar"] = {
		index = "goldbar",
		name = "Barra de Ouro",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "875",
		type = "use",
		weight = 0.25
	},
	["binoculars"] = {
		index = "binoculars",
		name = "Binóculos",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "275",
		type = "use",
		weight = 0.75
	},
	["camera"] = {
		index = "camera",
		name = "Câmera",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "275",
		type = "use",
		weight = 2.25
	},
	["playstation"] = {
		index = "playstation",
		name = "Playstation",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "100",
		type = "use",
		weight = 2.00
	},
	["xbox"] = {
		index = "xbox",
		name = "Xbox",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "100",
		type = "use",
		weight = 1.75
	},
	["legos"] = {
		index = "legos",
		name = "Legos",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "85",
		type = "use",
		weight = 0.25
	},
	["ominitrix"] = {
		index = "ominitrix",
		name = "Ominitrix",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "85",
		type = "use",
		weight = 0.50
	},
	["bracelet"] = {
		index = "bracelet",
		name = "Bracelete",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "95",
		type = "use",
		weight = 0.25
	},
	["dildo"] = {
		index = "dildo",
		name = "Vibrador",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "85",
		type = "use",
		weight = 0.25
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
		tipo = "Armamento",
		unity = "Não",
		economy = "975",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_BAT"] = {
		index = "bat",
		name = "Bastão de Beisebol",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "975",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_BATTLEAXE"] = {
		index = "battleaxe",
		name = "Machado de Batalha",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "975",
		type = "equip",
		weight = 0.75
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
		tipo = "Armamento",
		unity = "Não",
		economy = "975",
		type = "equip",
		weight = 0.75
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
		tipo = "Armamento",
		unity = "Não",
		economy = "975",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_HAMMER"] = {
		index = "hammer",
		name = "Martelo",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "725",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_MACHETE"] = {
		index = "machete",
		name = "Facão",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "975",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_POOLCUE"] = {
		index = "poolcue",
		name = "Taco de Sinuca",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "975",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_STONE_HATCHET"] = {
		index = "stonehatchet",
		name = "Machado de Pedra",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "975",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_SWITCHBLADE"] = {
		index = "switchblade",
		name = "Canivete",
		desc = "Utilizada para remoção de carne.",
		tipo = "Usável",
		unity = "Não",
		economy = "525",
		type = "equip",
		weight = 0.75
	},
	["switchblade"] = {
		index = "switchblade",
		name = "Canivete",
		desc = "Utilizada para remoção de carne.",
		tipo = "Usável",
		unity = "Não",
		economy = "525",
		type = "use",
		weight = 0.75
	},
	["WEAPON_WRENCH"] = {
		index = "wrench",
		name = "Chave Inglesa",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "975",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_KNUCKLE"] = {
		index = "knuckle",
		name = "Soco Inglês",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "975",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_FLASHLIGHT"] = {
		index = "flashlight",
		name = "Lanterna",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "675",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_NIGHTSTICK"] = {
		index = "nightstick",
		name = "Cassetete",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "725",
		type = "equip",
		weight = 0.75
	},
	["GADGET_PARACHUTE"] = {
		index = "parachute",
		name = "Paraquedas",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "500",
		type = "equip",
		weight = 2.25
	},
	["WEAPON_STUNGUN"] = {
		index = "stungun",
		name = "Tazer",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "2250",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_FIREEXTINGUISHER"] = {
		index = "extinguisher",
		name = "Extintor",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "725",
		type = "equip",
		weight = 4.65
	},
	
 -- START PISTOLS
    ["WEAPON_PISTOL"] = {
	    index = "m1911",
		name = "M1911",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "3795",
		type = "equip",
		ammo = "WEAPON_PISTOL_AMMO",
		weight = 1.25
    },
	["TOKEN_WEAPON_PISTOL"] = {
	    index = "tokenpistol",
		name = "Token - M1911",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "3795",
		type = "use",
		weight = 0.50
    },
	["WEAPON_PISTOL_MK2"] = {
		index = "fiveseven",
		name = "FN Five Seven",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "3775",
		type = "equip",
		ammo = "WEAPON_PISTOL_MK2_AMMO",
		weight = 1.50
	},
	["TOKEN_WEAPON_PISTOL_MK2"] = {
	    index = "tokenpistol",
		name = "Token - FN Five Seven",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "3775",
		type = "use",
		weight = 0.50
    },
	["WEAPON_APPISTOL"] = {
	    index = "kochvp9",
	    name = "Koch Vp9",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "4775",
		type = "equip",
		ammo = "WEAPON_APPISTOL_AMMO",
		weight = 1.25
	},
	["TOKEN_WEAPON_APPISTOL"] = {
	    index = "tokenpistol",
		name = "Token - Koch Vp9",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "4775",
		type = "use",
		weight = 0.50
    },
    ["WEAPON_HEAVYPISTOL"] = {
		index = "atifx45",
		name = "Ati FX45",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "3750",
		type = "equip",
		ammo = "WEAPON_HEAVYPISTOL_AMMO",
		weight = 1.50
	},
	["TOKEN_WEAPON_HEAVYPISTOL"] = {
	    index = "tokenpistol",
		name = "Token - Ati FX45",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "3750",
		type = "use",
		weight = 0.50
    },
	["WEAPON_SNSPISTOL"] = {
		index = "amt380",
		name = "AMT 380",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "3225",
		type = "equip",
		ammo = "WEAPON_SNSPISTOL_AMMO",
		weight = 1.00
	},
	["TOKEN_WEAPON_SNSPISTOL"] = {
	    index = "tokenpistol",
		name = "Token - AMT 380",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "3225",
		type = "use",
		weight = 0.50
    },
	["WEAPON_SNSPISTOL_MK2"] = {
		index = "hkp7m10",
		name = "HK P7M10",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "3795",
		type = "equip",
		ammo = "WEAPON_SNSPISTOL_MK2_AMMO",
		weight = 1.25
	},
	["TOKEN_WEAPON_SNSPISTOL_MK2"] = {
	    index = "tokenpistol",
		name = "Token - HK P7M10",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "3795",
		type = "use",
		weight = 0.50
    },
	["WEAPON_VINTAGEPISTOL"] = {
		index = "m1922",
		name = "M1922",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "2775",
		type = "equip",
		ammo = "WEAPON_VINTAGEPISTOL_AMMO",
		weight = 1.25
	},
	["TOKEN_WEAPON_VINTAGEPISTOL"] = {
	    index = "tokenpistol",
		name = "Token - M1922",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "2775",
		type = "use",
		weight = 0.50
    },
	["WEAPON_PISTOL50"] = {
		index = "desert",
		name = "Desert Eagle",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "5225",
		type = "equip",
		ammo = "WEAPON_PISTOL50_AMMO",
		weight = 1.50
	},
	["TOKEN_WEAPON_PISTOL50"] = {
	    index = "tokenpistol",
		name = "Token - Desert Eagle",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "5225",
		type = "use",
		weight = 0.50
    },
	["WEAPON_REVOLVER"] = {
		index = "magnum",
		name = "Magnum 44",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "4225",
		type = "equip",
		ammo = "WEAPON_REVOLVER_AMMO",
		weight = 1.50
	},
	["TOKEN_WEAPON_REVOLVER"] = {
	    index = "tokenpistol",
		name = "Token - Magnum 44",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "4225",
		type = "use",
		weight = 0.50
    },
	["WEAPON_COMBATPISTOL"] = {
		index = "glock",
		name = "Glock",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "3250",
		type = "equip",
		ammo = "WEAPON_COMBATPISTOL_AMMO",
		weight = 1.25
	},
	["TOKEN_WEAPON_COMBATPISTOL"] = {
	    index = "tokenpistol",
		name = "Token - Glock",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "3250",
		type = "use",
		weight = 0.50
    },
	["WEAPON_PISTOL_AMMO"] = {
		index = "pistolammo",
		name = "M. M1911",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "20",
		type = "recharge",
		weight = 0.02
	},
	["WEAPON_PISTOL_MK2_AMMO"] = {
		index = "pistolammo",
		name = "M. Five Seven",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "24",
		type = "recharge",
		weight = 0.02
	},
	["WEAPON_APPISTOL_AMMO"] = {
		index = "pistolammo",
		name = "M. Koch Vp9",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "22",
		type = "recharge",
		weight = 0.02
	},
	["WEAPON_HEAVYPISTOL_AMMO"] = {
		index = "pistolammo",
		name = "M. Ati FX45",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "20",
		type = "recharge",
		weight = 0.02
	},
	["WEAPON_SNSPISTOL_AMMO"] = {
		index = "pistolammo",
		name = "M. AMT 380",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "25",
		type = "recharge",
		weight = 0.02
	},
	["WEAPON_SNSPISTOL_MK2_AMMO"] = {
		index = "pistolammo",
		name = "M. HK P7M10",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "23",
		type = "recharge",
		weight = 0.02
	},
	["WEAPON_VINTAGEPISTOL_AMMO"] = {
		index = "pistolammo",
		name = "M. M1922",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "20",
		type = "recharge",
		weight = 0.02
	},
	["WEAPON_PISTOL50_AMMO"] = {
		index = "pistolammo",
		name = "M. Desert Eagle",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "25",
		type = "recharge",
		weight = 0.02
	},
	["WEAPON_REVOLVER_AMMO"] = {
		index = "pistolammo",
		name = "M. Magnum 44",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "22",
		type = "recharge",
		weight = 0.02
	},
	["WEAPON_COMBATPISTOL_AMMO"] = {
		index = "pistolammo",
		name = "M. Glock",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "21",
		type = "recharge",
		weight = 0.02
	},
 -- END PISTOLS

 -- START SMG
    ["WEAPON_COMPACTRIFLE"] = {
		index = "akcompact",
		name = "AK Compact",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "12225",
		type = "equip",
		ammo = "WEAPON_COMPACTRIFLE_AMMO",
		weight = 2.25
	},
	["TOKEN_WEAPON_COMPACTRIFLE"] = {
		index = "tokensmg",
		name = "Token - AK Compact",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "12225",
		type = "use",
		weight = 0.50
	},
	["WEAPON_MICROSMG"] = {
		index = "uzi",
		name = "Uzi",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "12225",
		type = "equip",
		ammo = "WEAPON_MICROSMG_AMMO",
		weight = 1.25
	},
	["TOKEN_WEAPON_MICROSMG"] = {
		index = "tokensmg",
		name = "Token - Uzi",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "12225",
		type = "use",
		weight = 0.50
	},
	["WEAPON_MINISMG"] = {
		index = "skorpionv61",
		name = "Skorpion V61",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "12225",
		type = "equip",
		ammo = "WEAPON_MINISMG_AMMO",
		weight = 1.75
	},
	["TOKEN_WEAPON_MINISMG"] = {
		index = "tokensmg",
		name = "Token - Skorpion V61",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "12225",
		type = "use",
		weight = 0.50
	},
	["WEAPON_SMG"] = {
		index = "mp5",
		name = "MP5",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "3250",
		type = "equip",
		ammo = "WEAPON_SMG_AMMO",
		weight = 5.25
	},
	["TOKEN_WEAPON_SMG"] = {
		index = "tokensmg",
		name = "Token - MP5",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "3250",
		type = "use",
		weight = 0.50
	},
	["WEAPON_ASSAULTSMG"] = {
		index = "steyraug",
		name = "Steyr AUG",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "12225",
		type = "equip",
		ammo = "WEAPON_ASSAULTSMG_AMMO",
		weight = 5.75
	},
	["TOKEN_WEAPON_ASSAULTSMG"] = {
		index = "tokenrifle",
		name = "Token - Steyr AUG",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "12225",
		type = "use",
		weight = 0.50
	},
	["WEAPON_GUSENBERG"] = {
		index = "thompson",
		name = "Thompson",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "12225",
		type = "equip",
		ammo = "WEAPON_GUSENBERG_AMMO",
		weight = 6.25
	},
	["TOKEN_WEAPON_GUSENBERG"] = {
		index = "tokenrifle",
		name = "Token - Thompson",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "12225",
		type = "use",
		weight = 0.50
	},
	["WEAPON_MACHINEPISTOL"] = {
		index = "tec9",
		name = "Tec-9",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "4775",
		type = "equip",
		ammo = "WEAPON_MACHINEPISTOL_AMMO",
		weight = 1.75
	},
	["TOKEN_WEAPON_MACHINEPISTOL"] = {
		index = "tokenrifle",
		name = "Token - Tec-9",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "4775",
		type = "use",
		weight = 0.50
	},
	["WEAPON_COMPACTRIFLE_AMMO"] = {
		index = "rifleammo",
		name = "Munição de AK Compact",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "25",
		type = "recharge",
		weight = 0.04
	},
	["WEAPON_MICROSMG_AMMO"] = {
		index = "smgammo",
		name = "M. Uzi",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "24",
		type = "recharge",
		weight = 0.03
	},
	["WEAPON_MINISMG_AMMO"] = {
		index = "smgammo",
		name = "M. Skorpion V61",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "24",
		type = "recharge",
		weight = 0.03
	},
	["WEAPON_SMG_AMMO"] = {
		index = "smgammo",
		name = "Munição de MP5",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "24",
		type = "recharge",
		weight = 0.03
	},
	["WEAPON_ASSAULTSMG_AMMO"] = {
		index = "smgammo",
		name = "Munição de MTAR-21",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "24",
		type = "recharge",
		weight = 0.03
	},
	["WEAPON_GUSENBERG_AMMO"] = {
		index = "smgammo",
		name = "Munição de Thompson",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "24",
		type = "recharge",
		weight = 0.03
	},
	["WEAPON_MACHINEPISTOL_AMMO"] = {
		index = "tec9ammo",
		name = "Munição de Tec-9",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "24",
		type = "recharge",
		weight = 0.03
	},
 -- END SMG

 -- START RIFLE
    ["WEAPON_CARBINERIFLE"] = {
		index = "m4a1",
		name = "M4A1",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "5250",
		type = "equip",
		ammo = "WEAPON_CARBINERIFLE_AMMO",
		weight = 7.75
	},
	["TOKEN_WEAPON_CARBINERIFLE"] = {
		index = "tokenrifle",
		name = "Token - M4A1",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "5250",
		type = "use",
		weight = 0.50
	},
	["WEAPON_CARBINERIFLE_MK2"] = {
		index = "m4a4",
		name = "M4A4",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "6250",
		type = "equip",
		ammo = "WEAPON_CARBINERIFLE_MK2_AMMO",
		weight = 8.50
	},
	["TOKEN_WEAPON_CARBINERIFLE_MK2"] = {
		index = "tokenrifle",
		name = "Token - M4A4",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "6250",
		type = "use",
		weight = 0.50
	},
	["WEAPON_ASSAULTRIFLE"] = {
		index = "ak103",
		name = "AK-103",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "17775",
		type = "equip",
		ammo = "WEAPON_ASSAULTRIFLE_AMMO",
		weight = 7.75
	},
	["TOKEN_WEAPON_ASSAULTRIFLE"] = {
		index = "tokenrifle",
		name = "Token - AK-103",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "17775",
		type = "use",
		weight = 0.50
	},
	["WEAPON_ASSAULTRIFLE_MK2"] = {
		index = "ak74",
		name = "AK-74",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "18775",
		type = "equip",
		ammo = "WEAPON_ASSAULTRIFLE_MK2_AMMO",
		weight = 7.75
	},
	["TOKEN_WEAPON_ASSAULTRIFLE_MK2"] = {
		index = "tokenrifle",
		name = "Token - AK-74",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "18775",
		type = "use",
		weight = 0.50
	},
	["WEAPON_CARBINERIFLE_AMMO"] = {
		index = "rifleammo",
		name = "Munição de M4A1",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "25",
		type = "recharge",
		weight = 0.04
	},
	["WEAPON_CARBINERIFLE_MK2_AMMO"] = {
		index = "rifleammo",
		name = "Munição de M4A4",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "25",
		type = "recharge",
		weight = 0.04
	},
	["WEAPON_ASSAULTRIFLE_AMMO"] = {
		index = "rifleammo",
		name = "Munição de AK-103",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "25",
		type = "recharge",
		weight = 0.04
	},
	["WEAPON_ASSAULTRIFLE_MK2_AMMO"] = {
		index = "rifleammo",
		name = "Munição de AK-74",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "25",
		type = "recharge",
		weight = 0.04
	},
 -- END RIFLE

 -- START SHOTGUN
    ["WEAPON_MUSKET"] = {
		index = "winchester",
		name = "Winchester 1892",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "2750",
		type = "equip",
		ammo = "WEAPON_MUSKET_AMMO",
		weight = 6.25
	},
	["TOKEN_WEAPON_MUSKET"] = {
		index = "tokenrifle",
		name = "Token - Winchester 1892",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "2750",
		type = "use",
		weight = 0.50
	},
	["WEAPON_SNIPERRIFLE"] = {
		index = "sauer101",
		name = "Sauer 101",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "6750",
		type = "equip",
		ammo = "WEAPON_SNIPERRIFLE_AMMO",
		weight = 8.25
	},
	["TOKEN_WEAPON_SNIPERRIFLE"] = {
		index = "tokenrifle",
		name = "Token - Sauer 101",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "6750",
		type = "use",
		weight = 0.50
	},
	["WEAPON_PUMPSHOTGUN"] = {
		index = "mossberg590",
		name = "Mossberg 590",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "4250",
		type = "equip",
		ammo = "WEAPON_PUMPSHOTGUN_AMMO",
		weight = 7.25
	},
	["TOKEN_WEAPON_PUMPSHOTGUN"] = {
		index = "tokenrifle",
		name = "Token - Mossberg 590",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "4250",
		type = "use",
		weight = 0.50
	},
	["WEAPON_PUMPSHOTGUN_MK2"] = {
		index = "mossberg590a1",
		name = "Mossberg 590A1",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "16775",
		type = "equip",
		ammo = "WEAPON_PUMPSHOTGUN_MK2_AMMO",
		weight = 7.25
	},
	["TOKEN_WEAPON_PUMPSHOTGUN_MK2"] = {
		index = "tokenrifle",
		name = "Token - Mossberg 590A1",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "16775",
		type = "use",
		weight = 0.50
	},
	["WEAPON_SAWNOFFSHOTGUN"] = {
		index = "mossberg500",
		name = "Mossberg 500",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "10775",
		type = "equip",
		ammo = "WEAPON_SAWNOFFSHOTGUN_AMMO",
		weight = 5.75
	},
	["TOKEN_WEAPON_SAWNOFFSHOTGUN"] = {
		index = "tokenrifle",
		name = "Token - Mossberg 500",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "10775",
		type = "use",
		weight = 0.50
	},
	["WEAPON_MUSKET_AMMO"] = {
		index = "musketammo",
		name = "Munição de Mosquete",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "10",
		type = "recharge",
		weight = 0.05
	},
	["WEAPON_SNIPERRIFLE_AMMO"] = {
		index = "musketammo",
		name = "Munição de Sauer",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "12",
		type = "recharge",
		weight = 0.07
	},
	["WEAPON_PUMPSHOTGUN_AMMO"] = {
		index = "remingtonammo",
		name = "Munição de Mossberg 590",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "45",
		type = "recharge",
		weight = 0.05
	},
	["WEAPON_PUMPSHOTGUN_MK2_AMMO"] = {
		index = "remingtonammo",
		name = "Munição de Mossberg 590A1",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "45",
		type = "recharge",
		weight = 0.05
	},
	["WEAPON_SAWNOFFSHOTGUN_AMMO"] = {
		index = "shotgunammo",
		name = "Munição de Mossberg 500",
		desc = "",
		tipo = "Munição",
		unity = "Não",
		economy = "45",
		type = "recharge",
		weight = 0.05
	},
 -- END SHOTGUN

 -- START OTHERS
	["WEAPON_PETROLCAN"] = {
		index = "gallon",
		name = "Galão",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "250",
		type = "equip",
		ammo = "WEAPON_PETROLCAN_AMMO",
		weight = 1.25
	},
	["WEAPON_PETROLCAN_AMMO"] = {
		index = "fuel",
		name = "Combustível",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "S/E",
		type = "recharge",
		weight = 0.001
	},
	["WEAPON_RAYPISTOL"] = {
		index = "raypistol",
		name = "Pistola de Raios",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "S/E",
		type = "equip",
		weight = 2.25
	},
	["WEAPON_RPG"] = {
		index = "rpg",
		name = "RPG-7",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "S/E",
		type = "equip",
		weight = 9.55
	},
	["WEAPON_RPG_AMMO"] = {
		index = "rpgammo",
		name = "Munição de RPG-7",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "S/E",
		type = "recharge",
		weight = 3.25
	},
 -- END OTHERS
	["pager"] = {
		index = "pager",
		name = "Pager",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "225",
		type = "use",
		weight = 1.25
	},
	["firecracker"] = {
		index = "firecracker",
		name = "Fogos de Artificio",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "100",
		type = "use",
		weight = 2.25
	},
	["analgesic"] = {
		index = "analgesic",
		name = "Analgésico",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "105",
		type = "use",
		weight = 0.10
	},
	["oxy"] = {
		index = "analgesic",
		name = "Oxy",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "75",
		type = "use",
		weight = 0.10
	},
	["gauze"] = {
		index = "gauze",
		name = "Gazes",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "175",
		type = "use",
		weight = 0.10
	},
	["gsrkit"] = {
		index = "gsrkit",
		name = "Kit Residual",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "35",
		type = "use",
		weight = 0.75
	},
	["gdtkit"] = {
		index = "gdtkit",
		name = "Kit Químico",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "35",
		type = "use",
		weight = 0.75
	},
	["orange"] = {
		index = "orange",
		name = "Laranja",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "4",
		type = "use",
		weight = 0.25
	},
	["strawberry"] = {
		index = "strawberry",
		name = "Morango",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "4",
		type = "use",
		weight = 0.15
	},
	["grape"] = {
		index = "grape",
		name = "Uva",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "4",
		type = "use",
		weight = 0.15
	},
	["tange"] = {
		index = "tange",
		name = "Tangerina",
		type = "use",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "4",
		weight = 0.25
	},
	["banana"] = {
		index = "banana",
		name = "Banana",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "4",
		type = "use",
		weight = 0.25
	},
	["passion"] = {
		index = "passion",
		name = "Maracujá",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "4",
		type = "use",
		weight = 0.25
	},
	["tomato"] = {
		index = "tomato",
		name = "Tomate",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "6",
		type = "use",
		weight = 0.15
	},
	["ketchup"] = {
		index = "ketchup",
		name = "Ketchup",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "20",
		type = "use",
		weight = 0.25
	},
	["orangejuice"] = {
		index = "orangejuice",
		name = "Suco de Laranja",
		desc = "Mata sede e cura estresse",
		tipo = "Usável",
		unity = "Não",
		economy = "85",
		type = "use",
		weight = 0.75
	},
	["tangejuice"] = {
		index = "tangejuice",
		name = "Suco de Tangerina",
		desc = "Mata sede e cura estresse",
		tipo = "Usável",
		unity = "Não",
		economy = "85",
		type = "use",
		weight = 0.45
	},
	["grapejuice"] = {
		index = "grapejuice",
		name = "Suco de Uva",
		desc = "Mata sede e cura estresse",
		tipo = "Usável",
		unity = "Não",
		economy = "85",
		type = "use",
		weight = 0.45
	},
	["strawberryjuice"] = {
		index = "strawberryjuice",
		name = "Suco de Morango",
		desc = "Mata sede e cura estresse",
		tipo = "Usável",
		unity = "Não",
		economy = "85",
		type = "use",
		weight = 0.45
	},
	["bananajuice"] = {
		index = "bananajuice",
		name = "Suco de Banana",
		desc = "Mata sede e cura estresse",
		tipo = "Usável",
		unity = "Não",
		economy = "85",
		type = "use",
		weight = 0.45
	},
	["passionjuice"] = {
		index = "passionjuice",
		name = "Suco de Maracujá",
		desc = "Mata sede e cura estresse",
		tipo = "Usável",
		unity = "Não",
		economy = "90",
		type = "use",
		weight = 0.45
	},
	["cannedsoup"] = {
		index = "cannedsoup",
		name = "Sopa em Lata",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "15",
		type = "use",
		weight = 0.25
	},
	["canofbeans"] = {
		index = "canofbeans",
		name = "Lata de Feijão",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "15",
		type = "use",
		weight = 0.25
	},
--  [Homes]
    ["lampshade"] = {
		index = "lampshade",
		name = "Abajur",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "115",
		type = "use",
		weight = 0.50
	},
	["pliers"] = {
		index = "pliers",
		name = "Alicate",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "75",
		type = "use",
		weight = 0.25
	},
	["silverring"] = {
		index = "silverring",
		name = "Anel de Prata",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "85",
		type = "use",
		weight = 0.25
	},
	["goldring"] = {
		index = "goldring",
		name = "Anel de Ouro",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "125",
		type = "use",
		weight = 0.25
	},
	["silvercoin"] = {
		index = "silvercoin",
		name = "Moeda de Prata",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "5",
		type = "use",
		weight = 0.01
	},
	["goldcoin"] = {
		index = "goldcoin",
		name = "Moeda de Ouro",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "10",
		type = "use",
		weight = 0.01
	},
	["spray01"] = {
		index = "spray01",
		name = "Desodorante 24hrs",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "85",
		type = "use",
		weight = 0.25
	},
	["spray02"] = {
		index = "spray02",
		name = "Antisséptico",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "85",
		type = "use",
		weight = 0.25
	},
	["spray03"] = {
		index = "spray03",
		name = "Desodorante 48hrs",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "85",
		type = "use",
		weight = 0.25
	},
	["spray04"] = {
		index = "spray04",
		name = "Desodorante 72hrs",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "85",
		type = "use",
		weight = 0.25
	},
	["eraser"] = {
		index = "eraser",
		name = "Apagador",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "75",
		type = "use",
		weight = 0.15
	},
	["deck"] = {
		index = "deck",
		name = "Baralho",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "75",
		type = "use",
		weight = 0.15
	},
	["slipper"] = {
		index = "slipper",
		name = "Chinelo",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "75",
		type = "use",
		weight = 0.50
	},
	["pendrive"] = {
		index = "pendrive",
		name = "Pendrive",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "575",
		type = "use",
		weight = 0.25
	},
	["cup"] = {
		index = "cup",
		name = "Cálice",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "125",
		type = "use",
		weight = 0.25
	},
	["dices"] = {
		index = "dices",
		name = "Dados",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "40",
		type = "use",
		weight = 0.25
	},
	["floppy"] = {
		index = "floppy",
		name = "Disquete",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "55",
		type = "use",
		weight = 0.15
	},
	["domino"] = {
		index = "domino",
		name = "Dominó",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "65",
		type = "use",
		weight = 0.25
	},
	["brush"] = {
		index = "brush",
		name = "Escova",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "85",
		type = "use",
		weight = 0.25
	},
	["horseshoe"] = {
		index = "horseshoe",
		name = "Ferradura",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "85",
		type = "use",
		weight = 0.25
	},
	["switch"] = {
		index = "switch",
		name = "Interruptor",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "35",
		type = "use",
		weight = 0.25
	},
	["blender"] = {
		index = "blender",
		name = "Liquidificador",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "85",
		type = "use",
		weight = 0.50
	},
	["pan"] = {
		index = "pan",
		name = "Panela",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "125",
		type = "use",
		weight = 0.50
	},
	["rimel"] = {
		index = "rimel",
		name = "Rímel",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "85",
		type = "use",
		weight = 0.25
	},
	["soap"] = {
		index = "soap",
		name = "Sabonete",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "75",
		type = "use",
		weight = 0.25
	},
	["sneakers"] = {
		index = "sneakers",
		name = "Tenis",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "115",
		type = "use",
		weight = 0.50
	},
	["brick"] = {
		index = "brick",
		name = "Tijolo",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "30",
		type = "use",
		weight = 0.50
	},
	["fan"] = {
		index = "fan",
		name = "Ventilador",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "85",
		type = "use",
		weight = 0.50
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
		tipo = "Ferramentas",
		unity = "Não",
		economy = "500",
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