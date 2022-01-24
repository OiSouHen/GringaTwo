-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
	["coal"] = {
	    index = "coal",
		name = "Carvão Vegetal",
		tipo = "Comum",
		economy = "2",
		type = "use",
		weight = 0.02
	},
	["sewingkit"] = {
	    index = "sewingkit",
		name = "Kit de Costura",
		tipo = "Comum",
		economy = "16",
		type = "use",
		weight = 0.01
	},
	["metalfragments"] = {
	    index = "metalfragments",
		name = "Fragmento de Metal",
		tipo = "Comum",
		economy = "4",
		type = "use",
		weight = 0.01
	},
	["gear"] = {
	    index = "gear",
		name = "Engrenagem",
		tipo = "Comum",
		economy = "10",
		type = "use",
		weight = 0.01
	},
	["sulfur"] = {
	    index = "sulfur",
		name = "Enxofre",
		tipo = "Comum",
		economy = "4",
		type = "use",
		weight = 0.01
	},
	["gunpowder"] = {
	    index = "gunpowder",
		name = "Pólvora",
		tipo = "Comum",
		economy = "20",
		type = "use",
		weight = 0.01
	},
    ["whistle"] = {
	    index = "whistle",
		name = "Apito Animal",
		tipo = "Usável",
		economy = "325",
		type = "use",
		weight = 0.15
	},
	["syringe"] = {
	    index = "adrenaline",
		name = "Seringa",
		tipo = "Comum",
		economy = "4",
		type = "use",
		weight = 0.10
	},
	["syringeB"] = {
	    index = "syringe",
		name = "Seringa B+",
		tipo = "Comum",
		type = "use",
		weight = 0.10
	},
	["syringeA"] = {
	    index = "syringe",
		name = "Seringa A+",
		tipo = "Comum",
		type = "use",
		weight = 0.10
	},
	["notebook"] = {
	    index = "notebook",
		name = "Notebook",
		tipo = "Usável",
		unity = "Sim",
		economy = "5225",
		type = "use",
		subtype = "comida",
		transform = "nbnotebook",
		durability = 10800,
		weight = 7.25
	},
	["nbnotebook"] = {
	    index = "notebook",
		name = "Notebook descarregado",
		tipo = "Usável",
		economy = "4885",
		type = "use",
		weight = 7.25
	},
	["foodburger"] = {
		index = "foodburger",
		name = "Caixa de Hamburger",
		tipo = "Comum",
		type = "use",
		weight = 0.15
	},
	["foodjuice"] = {
		index = "foodjuice",
		name = "Copo de Suco",
		tipo = "Comum",
		type = "use",
		weight = 0.15
	},
	["foodbox"] = {
		index = "foodbox",
		name = "Combo",
		tipo = "Comum",
		type = "use",
		weight = 1.00
	},
	["evidence01"] = {
		index = "evidence01",
		name = "Evidência",
		tipo = "Evidência",
		type = "use",
		weight = 0.05
	},
	["evidence02"] = {
		index = "evidence02",
		name = "Evidência",
		tipo = "Evidência",
		type = "use",
		weight = 0.05
	},
	["evidence03"] = {
		index = "evidence03",
		name = "Evidência",
		tipo = "Evidência",
		type = "use",
		weight = 0.05
	},
	["evidence04"] = {
		index = "evidence04",
		name = "Evidência",
		tipo = "Evidência",
		type = "use",
		weight = 0.05
	},
	["radio"] = {
		index = "radio",
		name = "Rádio",
		tipo = "Usável",
		economy = "975",
		type = "use",
		weight = 0.75
	},
	["radiodamaged"] = {
        index = "radiodamaged",
        name = "Rádio Queimado",
		tipo = "Comum",
		economy = "975",
        type = "use",
        weight = 0.75
    },
	["wheelchair"] = {
		index = "wheelchair",
		name = "Cadeira de Rodas",
		tipo = "Usável",
		economy = "2250",
		type = "use",
		weight = 7.50
	},
	["bandage"] = {
		index = "bandage",
		name = "Bandagem",
		tipo = "Usável",
		economy = "225",
		type = "use",
		weight = 0.10
	},
	["medkit"] = {
		index = "medkit",
		name = "Kit Médico",
		tipo = "Usável",
		economy = "525",
		type = "use",
		weight = 0.45
	},
	["adrenaline"] = {
		index = "adrenaline",
		name = "Adrenalina",
		tipo = "Usável",
		economy = "975",
		type = "use",
		weight = 0.35
	},
	["credential"] = {
		index = "credential",
		name = "Credencial",
		tipo = "Usável",
		economy = "125",
		type = "use",
		weight = 0.75
	},
	["pouch"] = {
		index = "pouch",
		name = "Malote",
		tipo = "Comum",
		type = "use",
		weight = 0.75
	},
	["woodlog"] = {
		index = "woodlog",
		name = "Tora de Madeira",
		tipo = "Comum",
		type = "use",
		weight = 0.75
	},
	["fishingrod"] = {
		index = "fishingrod",
		name = "Vara de Pescar",
		tipo = "Usável",
		economy = "725",
		type = "use",
		weight = 2.75
	},
	["octopus"] = {
		index = "octopus",
		name = "Polvo",
		tipo = "Comum",
		economy = "20",
		type = "use",
		weight = 0.75
	},
	["shrimp"] = {
		index = "shrimp",
		name = "Camarão",
		tipo = "Comum",
		economy = "20",
		type = "use",
		weight = 0.50
	},
	["carp"] = {
		index = "carp",
		name = "Carpa",
		tipo = "Comum",
		economy = "18",
		type = "use",
		weight = 0.50
	},
	["codfish"] = {
		index = "codfish",
		name = "Bacalhau",
		tipo = "Comum",
		economy = "22",
		type = "use",
		weight = 0.50
	},
	["catfish"] = {
		index = "catfish",
		name = "Bagre",
		tipo = "Comum",
		economy = "22",
		type = "use",
		weight = 0.50
	},
	["goldenfish"] = {
		index = "goldenfish",
		name = "Dourado",
		tipo = "Comum",
		economy = "23",
		type = "use",
		weight = 0.25
	},
	["horsefish"] = {
		index = "horsefish",
		name = "Cavala",
		tipo = "Comum",
		economy = "18",
		type = "use",
		weight = 0.50
	},
	["tilapia"] = {
		index = "tilapia",
		name = "Tilápia",
		tipo = "Comum",
		economy = "20",
		type = "use",
		weight = 0.25
	},
	["pacu"] = {
		index = "pacu",
		name = "Pacu",
		tipo = "Comum",
		economy = "25",
		type = "use",
		weight = 0.50
	},
	["pirarucu"] = {
		index = "pirarucu",
		name = "Pirarucu",
		tipo = "Comum",
		economy = "23",
		type = "use",
		weight = 0.25
	},
	["tambaqui"] = {
		index = "tambaqui",
		name = "Tambaqui",
		tipo = "Comum",
		economy = "23",
		type = "use",
		weight = 0.75
	},
	["bait"] = {
		index = "bait",
		name = "Isca",
		tipo = "Comum",
		economy = "4",
		type = "use",
		weight = 0.25
	},
	["meatA"] = {
		index = "meat",
		name = "Carne Animal",
		desc = "Corte nobre de classe A.",
		tipo = "Comum",
		economy = "40",
		type = "use",
		weight = 0.75
	},
	["meatB"] = {
		index = "meat2",
		name = "Carne Animal",
		desc = "Corte nobre de classe B.",
		tipo = "Comum",
		economy = "45",
		type = "use",
		weight = 0.75
	},
	["meatC"] = {
		index = "meat3",
		name = "Carne Animal",
		desc = "Corte nobre de classe C.",
		tipo = "Comum",
		economy = "50",
		type = "use",
		weight = 0.75
	},
	["meatS"] = {
		index = "meat4",
		name = "Carne Animal",
		desc = "Corte nobre de classe S.",
		tipo = "Comum",
		economy = "55",
		type = "use",
		weight = 0.75
	},
	["animalpelt"] = {
		index = "animalpelt",
		name = "Pele Animal",
		tipo = "Comum",
		economy = "50",
		type = "use",
		weight = 0.10
	},
	["horndeer"] = {
		index = "horndeer",
		name = "Chifre de Cervo",
		tipo = "Comum",
		economy = "225",
		type = "use",
		weight = 4.00
	},
	["joint"] = {
		index = "joint",
		name = "Baseado",
		tipo = "Usável",
		economy = "40",
		type = "use",
		weight = 0.50
	},
	["joint2"] = {
		index = "joint2",
		name = "Semente",
		tipo = "Usável",
		economy = "5",
		type = "use",
		weight = 0.10
	},
	["bucket"] = {
		index = "bucket",
		name = "Balde",
		tipo = "Usável",
		type = "use",
		weight = 0.50
	},
	["compost"] = {
		index = "compost",
		name = "Adubo",
		tipo = "Usável",
		type = "use",
		weight = 0.30
	},
	["weed"] = {
		index = "weed",
		name = "Folhas de Maconha",
		tipo = "Usável",
		type = "use",
		weight = 0.10
	},
	["lean"] = {
		index = "lean",
		name = "Lean",
		tipo = "Usável",
		economy = "30",
		type = "use",
		weight = 0.50
	},
	["lean2"] = {
		index = "lean2",
		name = "Codeína",
		tipo = "Usável",
		economy = "5",
		type = "use",
		weight = 0.10
	},
	["ecstasy"] = {
		index = "ecstasy",
		name = "Ecstasy",
		tipo = "Usável",
		economy = "35",
		type = "use",
		weight = 0.50
	},
	["ecstasy"] = {
		index = "ecstasy",
		name = "Ecstasy",
		tipo = "Usável",
		economy = "35",
		type = "use",
		weight = 0.50
	},
	["ecstasy2"] = {
		index = "ecstasy2",
		name = "Anfetamina",
		tipo = "Usável",
		economy = "5",
		type = "use",
		weight = 0.10
	},
	["cocaine"] = {
		index = "cocaine",
		name = "Cocaína",
		tipo = "Usável",
		economy = "30",
		type = "use",
		weight = 0.50
	},
	["cocaine2"] = {
		index = "cocaine2",
		name = "Folha de Coca",
		tipo = "Usável",
		economy = "5",
		type = "use",
		weight = 0.10
	},
	["meth"] = {
		index = "meth",
		name = "Metanfetamina",
		tipo = "Usável",
		economy = "35",
		type = "use",
		weight = 0.50
	},
	["meth2"] = {
		index = "meth2",
		name = "Acetona",
		tipo = "Usável",
		economy = "5",
		type = "use",
		weight = 0.10
	},
	["heroinea"] = {
		index = "heroinea",
		name = "Heroína 25%",
		tipo = "Comum",
		economy = "125",
		type = "use",
		weight = 0.50
	},
	["heroineb"] = {
		index = "heroineb",
		name = "Heroína 40%",
		tipo = "Comum",
		economy = "125",
		type = "use",
		weight = 0.50
	},
	["heroinec"] = {
		index = "heroinec",
		name = "Heroína 55%",
		tipo = "Comum",
		economy = "125",
		type = "use",
		weight = 0.50
	},
	["heroined"] = {
		index = "heroined",
		name = "Heroína 70%",
		tipo = "Comum",
		economy = "125",
		type = "use",
		weight = 0.50
	},
	["heroinee"] = {
		index = "heroinee",
		name = "Heroína 85%",
		tipo = "Comum",
		economy = "125",
		type = "use",
		weight = 0.50
	},
	["heroine"] = {
		index = "heroine",
		name = "Heroína 100%",
		tipo = "Comum",
		economy = "275",
		type = "use",
		weight = 0.50
	},
	["backpack"] = {
		index = "backpack",
		name = "Mochila",
		tipo = "Usável",
		economy = "2750",
		type = "use",
		weight = 4.25
	},
	["premium01"] = {
		index = "premium01",
		name = "Premium Bronze",
		tipo = "Usável",
		economy = "50000",
		type = "use",
		color = "26,27,30,0.5",
		weight = 0.00
	},
	["premium02"] = {
		index = "premium02",
		name = "Premium Prata",
		tipo = "Usável",
		economy = "62500",
		type = "use",
		weight = 0.00
	},
	["premium03"] = {
		index = "premium03",
		name = "Premium Ouro",
		tipo = "Usável",
		economy = "75000",
		type = "use",
		weight = 0.00
	},
	["premium04"] = {
		index = "premium04",
		name = "Premium Platina",
		tipo = "Usável",
		economy = "87500",
		type = "use",
		weight = 0.00
	},
	["newgarage"] = {
		index = "newgarage",
		name = "+1 Garagem",
		desc = "Limite de garagem em +1.",
		tipo = "Usável",
		economy = "50000",
		type = "use",
		weight = 0.00
	},
	["premiumplate"] = {
		index = "platepremium",
		name = "Placa Premium",
		desc = "Troca a placa de registro do veículo.",
		tipo = "Usável",
		economy = "50000",
		type = "use",
		weight = 0.00
	},
	["newchars"] = {
		index = "newchars",
		name = "+1 Personagem",
		desc = "Limite de personagem em +1.",
		tipo = "Usável",
		economy = "100000",
		type = "use",
		weight = 0.00
	},
	["newprops"] = {
		index = "newprops",
		name = "+1 Propriedade",
		desc = "Limite de propriedade em +1.",
		tipo = "Usável",
		economy = "100000",
		type = "use",
		weight = 0.00
	},
	["chip"] = {
		index = "chip",
		name = "Chip Telefônico",
		desc = "Troca o número telefônico.",
		tipo = "Usável",
		economy = "75000",
		type = "use",
		weight = 0.00
	},
	["namechange"] = {
		index = "namechange",
		name = "Troca de Nome",
		desc = "Troca o nome do personagem.",
		tipo = "Usável",
		economy = "62500",
		type = "use",
		weight = 0.00
	},
	["energetic"] = {
		index = "energetic",
		name = "Energético",
		tipo = "Usável",
		economy = "15",
		type = "use",
		weight = 0.25
	},
	["energetic2"] = {
		index = "energetic2",
		name = "Energético +",
		tipo = "Usável",
		economy = "20",
		type = "use",
		weight = 0.25
	},
	["battery"] = {
		index = "battery",
		name = "Pilhas",
		tipo = "Comum",
		economy = "60",
		type = "use",
		weight = 0.20
	},
	["elastic"] = {
		index = "elastic",
		name = "Elástico",
		tipo = "Comum",
		economy = "48",
		type = "use",
		weight = 0.10
	},
	["plasticbottle"] = {
		index = "plasticbottle",
		name = "Garrafa Plástica",
		tipo = "Comum",
		economy = "48",
		type = "use",
		weight = 0.20
	},
	["glassbottle"] = {
		index = "glassbottle",
		name = "Garrafa de Vidro",
		tipo = "Comum",
		economy = "42",
		type = "use",
		weight = 0.50
	},
	["metalcan"] = {
		index = "metalcan",
		name = "Lata de Metal",
		tipo = "Comum",
		economy = "60",
		type = "use",
		weight = 0.20
	},
	["emptybottle"] = {
		index = "emptybottle",
		name = "Garrafa Vazia",
		tipo = "Usável",
		economy = "30",
		type = "use",
		weight = 0.10
	},
	["water"] = {
		index = "water",
		name = "Água",
		tipo = "Usável",
		economy = "30",
		type = "use",
		weight = 0.15
	},
	["dirtywater"] = {
		index = "dirtywater",
		name = "Água Suja",
		tipo = "Usável",
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
		durability = 54000,
		weight = 0.75
	},
	["nbcellphone"] = {
        index = "cellphone",
        name = "Celular Descarregado",
		desc = "Celular sem bateria",
		tipo = "Comum",
        type = "use",
        weight = 0.75
    },
	["mbattery"] = {
		index = "mbattery",
		name = "Bateria Móvel",
		tipo = "Usável",
		economy = "35",
		type = "use",
		weight = 0.35
	},
    ["cola"] = {
		index = "cola",
		name = "Cola",
		tipo = "Usável",
		unity = "Sim",
		economy = "15",
		type = "use",
		subtype = "comida",
		transform = "badcola",
		durability = 2700,
		weight = 0.15
	},
	["badcola"] = {
		index = "cola",
		name = "Cola vencida",
		tipo = "Usável",
		economy = "10",
		type = "use",
		weight = 0.15
	},
    ["soda"] = {
		index = "soda",
		name = "Sprunk",
		tipo = "Usável",
		unity = "Sim",
		economy = "15",
		type = "use",
		subtype = "comida",
		transform = "badsoda",
		durability = 2700,
		weight = 0.15
	},
	["badsoda"] = {
		index = "soda",
		name = "Sprunk vencida",
		tipo = "Usável",
		economy = "10",
		type = "use",
		weight = 0.15
	},
	["coffee"] = {
		index = "coffee",
		name = "Café",
		tipo = "Usável",
		unity = "Sim",
		economy = "20",
		type = "use",
		subtype = "comida",
		transform = "badcoffee",
		durability = 2700,
		weight = 0.15
	},
	["coffee2"] = {
		index = "coffee2",
		name = "Café",
		tipo = "Usável",
		economy = "6",
		type = "use",
		weight = 0.10
	},
	["badcoffee"] = {
		index = "coffee",
		name = "Café vencido",
		tipo = "Usável",
		economy = "10",
		type = "use",
		weight = 0.15
	},
	["hamburger"] = {
		index = "hamburger",
		name = "Hambúrguer",
		tipo = "Usável",
		unity = "Sim",
		economy = "25",
		type = "use",
		subtype = "comida",
		transform = "badhamburger",
		durability = 2700,
		weight = 0.35
	},
	["badhamburger"] = {
		index = "hamburger",
		name = "Hambúrguer vencido",
		tipo = "Comum",
		economy = "15",
		type = "use",
		weight = 0.35
	},
	["hamburger2"] = {
		index = "hamburger2",
		name = "X-Burguer",
		tipo = "Usável",
		unity = "Sim",
		economy = "50",
		type = "use",
		subtype = "comida",
		transform = "badhamburger2",
		durability = 2700,
		weight = 0.55
	},
	["badhamburger2"] = {
		index = "hamburger2",
		name = "X-Burguer vencido",
		tipo = "Comum",
		economy = "25",
		type = "use",
		weight = 0.55
	},
	["hamburger3"] = {
		index = "hamburger3",
		name = "X-Salada",
		tipo = "Usável",
		unity = "Sim",
		economy = "60",
		type = "use",
		subtype = "comida",
		transform = "badhamburger3",
		durability = 2700,
		weight = 0.55
	},
	["badhamburger3"] = {
		index = "hamburger3",
		name = "X-Salada vencido",
		tipo = "Comum",
		economy = "30",
		type = "use",
		weight = 0.55
	},
	["hamburger4"] = {
		index = "hamburger4",
		name = "X-Bacon",
		tipo = "Usável",
		unity = "Sim",
		economy = "70",
		type = "use",
		subtype = "comida",
		transform = "badhamburger4",
		durability = 2700,
		weight = 0.55
	},
	["badhamburger4"] = {
		index = "hamburger4",
		name = "X-Bacon vencido",
		tipo = "Comum",
		economy = "35",
		type = "use",
		weight = 0.55
	},
	["hamburger5"] = {
		index = "hamburger5",
		name = "X-Picanha",
		tipo = "Usável",
		unity = "Sim",
		economy = "80",
		type = "use",
		subtype = "comida",
		transform = "badhamburger5",
		durability = 2700,
		weight = 0.55
	},
	["badhamburger5"] = {
		index = "hamburger5",
		name = "X-Picanha vencido",
		tipo = "Comum",
		economy = "40",
		type = "use",
		weight = 0.55
	},
	["hotdog"] = {
		index = "hotdog",
		name = "Cachorro-Quente",
		tipo = "Usável",
		unity = "Sim",
		economy = "15",
		type = "use",
		subtype = "comida",
		transform = "badhotdog",
		durability = 2700,
		weight = 0.35
	},
	["badhotdog"] = {
		index = "hotdog",
		name = "Cachorro-Quente vencido",
		tipo = "Comum",
		economy = "10",
		type = "use",
		weight = 0.35
	},
	["sandwich"] = {
		index = "sandwich",
		name = "Sanduiche",
		tipo = "Usável",
		unity = "Sim",
		economy = "15",
		type = "use",
		subtype = "comida",
		transform = "badhamburger",
		durability = 2700,
		weight = 0.25
	},
	["badsandwich"] = {
		index = "sandwich",
		name = "Sanduiche vencido",
		tipo = "Comum",
		economy = "10",
		type = "use",
		weight = 0.25
	},
	["chocolate"] = {
		index = "chocolate",
		name = "Chocolate",
		tipo = "Usável",
		unity = "Sim",
		economy = "15",
		type = "use",
		weight = 0.10
	},
	["donut"] = {
		index = "donut",
		name = "Rosquinha",
		tipo = "Usável",
		unity = "Sim",
		economy = "15",
		type = "use",
		subtype = "comida",
		transform = "baddonut",
		durability = 2700,
		weight = 0.25
	},
	["baddonut"] = {
		index = "donut",
		name = "Rosquinha vencida",
		tipo = "Comum",
		economy = "10",
		type = "use",
		weight = 0.25
	},
	["tacos"] = {
		index = "tacos",
		name = "Tacos",
		tipo = "Usável",
		unity = "Sim",
		economy = "22",
		type = "use",
		subtype = "comida",
		transform = "badtacos",
		durability = 2700,
		weight = 0.25
	},
	["badtacos"] = {
		index = "tacos",
		name = "Tacos vencido",
		tipo = "Comum",
		economy = "11",
		type = "use",
		weight = 0.25
	},
	["fries"] = {
		index = "fries",
		name = "Fritas",
		tipo = "Usável",
		economy = "15",
		type = "use",
		weight = 0.15
	},
	["bread"] = {
		index = "bread",
		name = "Pão",
		desc = "Usado para fazer Hambúrguers",
		tipo = "Usável",
		economy = "5",
		type = "use",
		weight = 0.25
	},
	["plate"] = {
		index = "plate",
		name = "Placa",
		tipo = "Usável",
		economy = "275",
		type = "use",
		weight = 0.50
	},
	["lockpick"] = {
		index = "lockpick",
		name = "Lockpick",
		tipo = "Usável",
		economy = "525",
		type = "use",
		subtype = "comida",
		transform = "lockpick2",
		durability = 10800,
		weight = 1.25
	},
	["lockpick2"] = {
		index = "lockpick2",
		name = "Lockpick Quebrada",
		tipo = "Comum",
		type = "use",
		weight = 1.25
	},
	["vest"] = {
		index = "vest",
		name = "Colete",
		tipo = "Usável",
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
		tipo = "Comum",
		economy = "125",
		type = "use",
		weight = 2.25
	},
	["toolbox"] = {
		index = "toolbox",
		name = "Caixa de Ferramentas",
		tipo = "Ferramentas",
		economy = "475",
		type = "use",
		subtype = "comida",
		transform = "toolbox2",
		durability = 10800,
		weight = 1.75
	},
	["toolbox2"] = {
		index = "toolbox",
		name = "Caixa Enferrujada",
		tipo = "Comum",
		economy = "245",
		type = "use",
		weight = 1.75
	},
	["notepad"] = {
		index = "notepad",
		name = "Bloco de Notas",
		tipo = "Usável",
		economy = "10",
		type = "use",
		weight = 0.25
	},
	["tires"] = {
		index = "tires",
		name = "Pneus",
		tipo = "Material",
		economy = "325",
		type = "use",
		weight = 1.50
	},
	["divingsuit"] = {
		index = "divingsuit",
		name = "Roupa de Mergulho",
		tipo = "Usável",
		economy = "975",
		type = "use",
		weight = 4.75
	},
	["amethyst"] = {
		index = "amethyst",
		name = "Ametista",
		tipo = "Comum",
		economy = "40",
		type = "use",
		weight = 0.65
	},
	["diamond"] = {
		index = "diamond",
		name = "Diamante",
		tipo = "Comum",
		economy = "90",
		type = "use",
		weight = 0.80
	},
	["emerald"] = {
		index = "emerald",
		name = "Esmeralda",
		tipo = "Comum",
		economy = "120",
		type = "use",
		weight = 0.85
	},
	["ruby"] = {
		index = "ruby",
		name = "Rubi",
		tipo = "Comum",
		economy = "50",
		type = "use",
		weight = 0.75
	},
	["sapphire"] = {
		index = "sapphire",
		name = "Safira",
		tipo = "Comum",
		economy = "45",
		type = "use",
		weight = 0.70
	},
	["turquoise"] = {
		index = "turquoise",
		name = "Turquesa",
		tipo = "Comum",
		economy = "30",
		type = "use",
		weight = 0.55
	},
	["amber"] = {
		index = "amber",
		name = "Âmbar",
		tipo = "Comum",
		economy = "35",
		type = "use",
		weight = 0.60
	},
	["gemstone"] = {
		index = "gemstone",
		name = "Gemstone",
		tipo = "Usável",
		economy = "1250",
		type = "use",
		weight = 0.10
	},
	["handcuff"] = {
		index = "handcuff",
		name = "Algemas",
		tipo = "Usável",
		economy = "3975",
		type = "use",
		weight = 0.75
	},
	["rope"] = {
		index = "rope",
		name = "Cordas",
		tipo = "Usável",
		economy = "875",
		type = "use",
		weight = 1.50
	},
	["hood"] = {
		index = "hood",
		name = "Capuz",
		tipo = "Usável",
		economy = "3675",
		type = "use",
		weight = 1.50
	},
	["key"] = {
		index = "key",
		name = "Chaves",
		tipo = "Comum",
		economy = "45",
		type = "use",
		weight = 0.25
	},
	["fabric"] = {
		index = "fabric",
		name = "Tecido",
		tipo = "Comum",
		economy = "100",
		type = "use",
		weight = 0.050
	},
	["plastic"] = {
		index = "plastic",
		name = "Plástico",
		tipo = "Comum",
		economy = "16",
		type = "use",
		weight = 0.075
	},
	["glass"] = {
		index = "glass",
		name = "Vidro",
		tipo = "Comum",
		economy = "14",
		type = "use",
		weight = 0.075
	},
	["rubber"] = {
		index = "rubber",
		name = "Borracha",
		tipo = "Comum",
		economy = "16",
		type = "use",
		weight = 0.050
	},
	["aluminum"] = {
		index = "aluminum",
		name = "Alúminio",
		tipo = "Comum",
		economy = "20",
		type = "use",
		weight = 0.075
	},
	["copper"] = {
		index = "copper",
		name = "Cobre",
		tipo = "Comum",
		economy = "20",
		type = "use",
		weight = 0.075
	},
	["titanium"] = {
		index = "titanium",
		name = "Titânio",
		tipo = "Comum",
		economy = "275",
		type = "use",
		weight = 0.150
	},
	["keyboard"] = {
		index = "keyboard",
		name = "Teclado",
		tipo = "Comum",
		economy = "85",
		type = "use",
		weight = 0.50
	},
	["mouse"] = {
		index = "mouse",
		name = "Mouse",
		tipo = "Comum",
		economy = "85",
		type = "use",
		weight = 0.25
	},
	["watch"] = {
		index = "watch",
		name = "Relógio",
		tipo = "Comum",
		economy = "100",
		type = "use",
		weight = 0.25
	},
	["c4"] = {
		index = "c4",
		name = "C4",
		tipo = "Usável",
		economy = "275",
		type = "use",
		weight = 2.50
	},
	["ritmoneury"] = {
		index = "ritmoneury",
		name = "Ritmoneury",
		tipo = "Usável",
		economy = "475",
		type = "use",
		weight = 0.25
	},
	["sinkalmy"] = {
		index = "sinkalmy",
		name = "Sinkalmy",
		tipo = "Usável",
		economy = "325",
		type = "use",
		weight = 0.25
	},
	["cigarette"] = {
		index = "cigarette",
		name = "Cigarro",
		tipo = "Usável",
		economy = "10",
		type = "use",
		weight = 0.05
	},
	["lighter"] = {
		index = "lighter",
		name = "Isqueiro",
		tipo = "Usável",
		economy = "175",
		type = "use",
		weight = 0.25
	},
	["vape"] = {
		index = "vape",
		name = "Vape",
		tipo = "Usável",
		economy = "4750",
		type = "use",
		weight = 0.75
	},
	["newspaper"] = {
		index = "newspaper",
		name = "Jornal",
		tipo = "Comum",
		economy = "15",
		type = "use",
		weight = 0.375
	},
	["dollars"] = {
		index = "dollars",
		name = "Dólares",
		tipo = "Comum",
		type = "use",
		weight = 0.0001
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
		tipo = "Usável",
		economy = "50000",
		type = "use",
		weight = 5.00
	},
	["rose"] = {
		index = "rose",
		name = "Rosa",
		tipo = "Usável",
		economy = "25",
		type = "use",
		weight = 0.15
	},
	["teddy"] = {
		index = "teddy",
		name = "Teddy",
		tipo = "Usável",
		economy = "75",
		type = "use",
		weight = 0.75
	},
	["absolut"] = {
		index = "absolut",
		name = "Absolut",
		tipo = "Usável",
		economy = "15",
		type = "use",
		weight = 0.25
	},
	["chandon"] = {
		index = "chandon",
		name = "Chandon",
		tipo = "Usável",
		economy = "15",
		type = "use",
		weight = 0.35
	},
	["dewars"] = {
		index = "dewars",
		name = "Dewars",
		tipo = "Usável",
		economy = "15",
		type = "use",
		weight = 0.25
	},
	["hennessy"] = {
		index = "hennessy",
		name = "Hennessy",
		tipo = "Usável",
		economy = "15",
		type = "use",
		weight = 0.25
	},
	["identity"] = {
		index = "newchars",
		name = "Identidade",
		desc = "Use e mostre para a pessoa mais próxima.",
		tipo = "Usável",
		economy = "25",
		type = "use",
		weight = 0.25
	},
	["goldbar"] = {
		index = "goldbar",
		name = "Barra de Ouro",
		tipo = "Comum",
		economy = "875",
		type = "use",
		weight = 0.25
	},
	["binoculars"] = {
		index = "binoculars",
		name = "Binóculos",
		tipo = "Usável",
		economy = "275",
		type = "use",
		weight = 0.75
	},
	["camera"] = {
		index = "camera",
		name = "Câmera",
		tipo = "Usável",
		economy = "275",
		type = "use",
		weight = 2.25
	},
	["playstation"] = {
		index = "playstation",
		name = "Playstation",
		tipo = "Comum",
		economy = "100",
		type = "use",
		weight = 2.00
	},
	["xbox"] = {
		index = "xbox",
		name = "Xbox",
		tipo = "Comum",
		economy = "100",
		type = "use",
		weight = 1.75
	},
	["legos"] = {
		index = "legos",
		name = "Legos",
		tipo = "Comum",
		economy = "85",
		type = "use",
		weight = 0.25
	},
	["ominitrix"] = {
		index = "ominitrix",
		name = "Ominitrix",
		tipo = "Comum",
		economy = "85",
		type = "use",
		weight = 0.50
	},
	["bracelet"] = {
		index = "bracelet",
		name = "Bracelete",
		tipo = "Comum",
		economy = "95",
		type = "use",
		weight = 0.25
	},
	["dildo"] = {
		index = "dildo",
		name = "Vibrador",
		tipo = "Comum",
		economy = "85",
		type = "use",
		weight = 0.25
	},
	["WEAPON_HATCHET"] = {
		index = "hatchet",
		name = "Machado",
		tipo = "Armamento",
		economy = "975",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_BAT"] = {
		index = "bat",
		name = "Bastão de Beisebol",
		tipo = "Armamento",
		economy = "975",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_BATTLEAXE"] = {
		index = "battleaxe",
		name = "Machado de Batalha",
		tipo = "Armamento",
		economy = "975",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_CROWBAR"] = {
		index = "crowbar",
		name = "Pé de Cabra",
		tipo = "Armamento",
		economy = "725",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_DAGGER"] = {
		index = "dagger",
		name = "Adaga",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 1.50
	},
	["WEAPON_GOLFCLUB"] = {
		index = "golfclub",
		name = "Taco de Golf",
		tipo = "Armamento",
		economy = "975",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_HAMMER"] = {
		index = "hammer",
		name = "Martelo",
		tipo = "Armamento",
		economy = "725",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_MACHETE"] = {
		index = "machete",
		name = "Facão",
		tipo = "Armamento",
		economy = "975",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_POOLCUE"] = {
		index = "poolcue",
		name = "Taco de Sinuca",
		tipo = "Armamento",
		economy = "975",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_STONE_HATCHET"] = {
		index = "stonehatchet",
		name = "Machado de Pedra",
		tipo = "Armamento",
		economy = "975",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_SWITCHBLADE"] = {
		index = "switchblade",
		name = "Canivete",
		desc = "Utilizada para remoção de carne.",
		tipo = "Usável",
		economy = "525",
		type = "equip",
		weight = 0.75
	},
	["switchblade"] = {
		index = "switchblade",
		name = "Canivete",
		desc = "Utilizada para remoção de carne.",
		tipo = "Usável",
		economy = "525",
		type = "use",
		weight = 0.75
	},
	["WEAPON_WRENCH"] = {
		index = "wrench",
		name = "Chave Inglesa",
		tipo = "Armamento",
		economy = "725",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_KNUCKLE"] = {
		index = "knuckle",
		name = "Soco Inglês",
		tipo = "Armamento",
		economy = "975",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_FLASHLIGHT"] = {
		index = "flashlight",
		name = "Lanterna",
		tipo = "Armamento",
		economy = "675",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_NIGHTSTICK"] = {
		index = "nightstick",
		name = "Cassetete",
		tipo = "Armamento",
		economy = "725",
		type = "equip",
		weight = 0.75
	},
	["GADGET_PARACHUTE"] = {
		index = "parachute",
		name = "Paraquedas",
		tipo = "Usável",
		economy = "500",
		type = "equip",
		weight = 2.25
	},
	["WEAPON_STUNGUN"] = {
		index = "stungun",
		name = "Tazer",
		tipo = "Armamento",
		economy = "2250",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_FIREEXTINGUISHER"] = {
		index = "extinguisher",
		name = "Extintor",
		tipo = "Armamento",
		economy = "725",
		type = "equip",
		weight = 4.65
	},
	
 -- START PISTOLS
    ["WEAPON_PISTOL"] = {
	    index = "m1911",
		name = "M1911",
		tipo = "Armamento",
		economy = "3795",
		type = "equip",
		ammo = "WEAPON_PISTOL_AMMO",
		weight = 1.25
    },
	["WEAPON_PISTOL_MK2"] = {
		index = "fiveseven",
		name = "FN Five Seven",
		tipo = "Armamento",
		economy = "3775",
		type = "equip",
		ammo = "WEAPON_PISTOL_MK2_AMMO",
		weight = 1.50
	},
	["WEAPON_APPISTOL"] = {
	    index = "kochvp9",
	    name = "Koch Vp9",
		tipo = "Armamento",
		economy = "4775",
		type = "equip",
		ammo = "WEAPON_APPISTOL_AMMO",
		weight = 1.25
	},
    ["WEAPON_HEAVYPISTOL"] = {
		index = "atifx45",
		name = "Ati FX45",
		tipo = "Armamento",
		economy = "3750",
		type = "equip",
		ammo = "WEAPON_HEAVYPISTOL_AMMO",
		weight = 1.50
	},
	["WEAPON_SNSPISTOL"] = {
		index = "amt380",
		name = "AMT 380",
		tipo = "Armamento",
		economy = "3225",
		type = "equip",
		ammo = "WEAPON_SNSPISTOL_AMMO",
		weight = 1.00
	},
	["WEAPON_SNSPISTOL_MK2"] = {
		index = "hkp7m10",
		name = "HK P7M10",
		tipo = "Armamento",
		economy = "3795",
		type = "equip",
		ammo = "WEAPON_SNSPISTOL_MK2_AMMO",
		weight = 1.25
	},
	["WEAPON_VINTAGEPISTOL"] = {
		index = "m1922",
		name = "M1922",
		tipo = "Armamento",
		economy = "2775",
		type = "equip",
		ammo = "WEAPON_VINTAGEPISTOL_AMMO",
		weight = 1.25
	},
	["WEAPON_PISTOL50"] = {
		index = "desert",
		name = "Desert Eagle",
		tipo = "Armamento",
		economy = "5225",
		type = "equip",
		ammo = "WEAPON_PISTOL50_AMMO",
		weight = 1.50
	},
	["WEAPON_REVOLVER"] = {
		index = "magnum",
		name = "Magnum 44",
		tipo = "Armamento",
		economy = "4225",
		type = "equip",
		ammo = "WEAPON_REVOLVER_AMMO",
		weight = 1.50
	},
	["WEAPON_COMBATPISTOL"] = {
		index = "glock",
		name = "Glock",
		tipo = "Armamento",
		economy = "3250",
		type = "equip",
		ammo = "WEAPON_COMBATPISTOL_AMMO",
		weight = 1.25
	},
	["WEAPON_PISTOL_AMMO"] = {
		index = "pistolammo",
		name = "M. M1911",
		tipo = "Munição",
		type = "recharge",
		weight = 0.02
	},
	["WEAPON_PISTOL_MK2_AMMO"] = {
		index = "pistolammo",
		name = "M. Five Seven",
		tipo = "Munição",
		type = "recharge",
		weight = 0.02
	},
	["WEAPON_APPISTOL_AMMO"] = {
		index = "pistolammo",
		name = "M. Koch Vp9",
		tipo = "Munição",
		type = "recharge",
		weight = 0.02
	},
	["WEAPON_HEAVYPISTOL_AMMO"] = {
		index = "pistolammo",
		name = "M. Ati FX45",
		tipo = "Munição",
		type = "recharge",
		weight = 0.02
	},
	["WEAPON_SNSPISTOL_AMMO"] = {
		index = "pistolammo",
		name = "M. AMT 380",
		economy = "25",
		type = "recharge",
		weight = 0.02
	},
	["WEAPON_SNSPISTOL_MK2_AMMO"] = {
		index = "pistolammo",
		name = "M. HK P7M10",
		tipo = "Munição",
		type = "recharge",
		weight = 0.02
	},
	["WEAPON_VINTAGEPISTOL_AMMO"] = {
		index = "pistolammo",
		name = "M. M1922",
		tipo = "Munição",
		type = "recharge",
		weight = 0.02
	},
	["WEAPON_PISTOL50_AMMO"] = {
		index = "pistolammo",
		name = "M. Desert Eagle",
		tipo = "Munição",
		type = "recharge",
		weight = 0.02
	},
	["WEAPON_REVOLVER_AMMO"] = {
		index = "pistolammo",
		name = "M. Magnum 44",
		tipo = "Munição",
		type = "recharge",
		weight = 0.02
	},
	["WEAPON_COMBATPISTOL_AMMO"] = {
		index = "pistolammo",
		name = "M. Glock",
		tipo = "Munição",
		type = "recharge",
		weight = 0.02
	},
 -- END PISTOLS

 -- START SMG
    ["WEAPON_COMPACTRIFLE"] = {
		index = "akcompact",
		name = "AK Compact",
		tipo = "Armamento",
		economy = "12225",
		type = "equip",
		ammo = "WEAPON_COMPACTRIFLE_AMMO",
		weight = 2.25
	},
	["WEAPON_MICROSMG"] = {
		index = "uzi",
		name = "Uzi",
		tipo = "Armamento",
		economy = "12225",
		type = "equip",
		ammo = "WEAPON_MICROSMG_AMMO",
		weight = 1.25
	},
	["WEAPON_MINISMG"] = {
		index = "skorpionv61",
		name = "Skorpion V61",
		tipo = "Armamento",
		economy = "12225",
		type = "equip",
		ammo = "WEAPON_MINISMG_AMMO",
		weight = 1.75
	},
	["WEAPON_SMG"] = {
		index = "mp5",
		name = "MP5",
		tipo = "Armamento",
		economy = "3250",
		type = "equip",
		ammo = "WEAPON_SMG_AMMO",
		weight = 5.25
	},
	["WEAPON_SMG_MK2"] = {
		index = "evo3",
		name = "Evo-3",
		tipo = "Armamento",
		economy = "12225",
		type = "equip",
		ammo = "WEAPON_SMG_MK2_AMMO",
		weight = 5.25
	},
	["WEAPON_ASSAULTSMG"] = {
		index = "steyraug",
		name = "Steyr AUG",
		tipo = "Armamento",
		economy = "12225",
		type = "equip",
		ammo = "WEAPON_ASSAULTSMG_AMMO",
		weight = 5.75
	},
	["WEAPON_GUSENBERG"] = {
		index = "thompson",
		name = "Thompson",
		tipo = "Armamento",
		economy = "12225",
		type = "equip",
		ammo = "WEAPON_GUSENBERG_AMMO",
		weight = 6.25
	},
	["WEAPON_MACHINEPISTOL"] = {
		index = "tec9",
		name = "Tec-9",
		tipo = "Armamento",
		economy = "4775",
		type = "equip",
		ammo = "WEAPON_MACHINEPISTOL_AMMO",
		weight = 1.75
	},
	["WEAPON_COMPACTRIFLE_AMMO"] = {
		index = "rifleammo",
		name = "Munição de AK Compact",
		tipo = "Munição",
		type = "recharge",
		weight = 0.04
	},
	["WEAPON_MICROSMG_AMMO"] = {
		index = "smgammo",
		name = "M. Uzi",
		tipo = "Munição",
		type = "recharge",
		weight = 0.03
	},
	["WEAPON_MINISMG_AMMO"] = {
		index = "smgammo",
		name = "M. Skorpion V61",
		tipo = "Munição",
		type = "recharge",
		weight = 0.03
	},
	["WEAPON_SMG_AMMO"] = {
		index = "smgammo",
		name = "Munição de MP5",
		tipo = "Munição",
		type = "recharge",
		weight = 0.03
	},
	["WEAPON_SMG_MK2_AMMO"] = {
		index = "smgammo",
		name = "Munição de Evo-3",
		tipo = "Munição",
		type = "recharge",
		weight = 0.03
	},
	["WEAPON_ASSAULTSMG_AMMO"] = {
		index = "smgammo",
		name = "Munição de MTAR-21",
		tipo = "Munição",
		type = "recharge",
		weight = 0.03
	},
	["WEAPON_GUSENBERG_AMMO"] = {
		index = "smgammo",
		name = "Munição de Thompson",
		tipo = "Munição",
		type = "recharge",
		weight = 0.03
	},
	["WEAPON_MACHINEPISTOL_AMMO"] = {
		index = "pistolammo",
		name = "Munição de Tec-9",
		tipo = "Munição",
		type = "recharge",
		weight = 0.03
	},
 -- END SMG

 -- START RIFLE
    ["WEAPON_CARBINERIFLE"] = {
		index = "m4a1",
		name = "M4A1",
		tipo = "Armamento",
		economy = "5250",
		type = "equip",
		ammo = "WEAPON_CARBINERIFLE_AMMO",
		weight = 7.75
	},
	["WEAPON_SPECIALCARBINE"] = {
		index = "g36c",
		name = "G36C",
		tipo = "Armamento",
		economy = "17775",
		type = "equip",
		ammo = "WEAPON_SPECIALCARBINE_AMMO",
		weight = 8.25
	},
	["WEAPON_SPECIALCARBINE_MK2"] = {
		index = "sigsauer556",
		name = "Sig Sauer 556",
		tipo = "Armamento",
		economy = "18775",
		type = "equip",
		ammo = "WEAPON_SPECIALCARBINE_MK2_AMMO",
		weight = 8.25
	},
	["WEAPON_BULLPUPRIFLE_MK2"] = {
		index = "l85",
		name = "L85",
		tipo = "Armamento",
		economy = "18775",
		type = "equip",
		ammo = "WEAPON_BULLPUPRIFLE_MK2_AMMO",
		weight = 7.75
	},
	["WEAPON_CARBINERIFLE_MK2"] = {
		index = "m4a4",
		name = "M4A4",
		tipo = "Armamento",
		economy = "6250",
		type = "equip",
		ammo = "WEAPON_CARBINERIFLE_MK2_AMMO",
		weight = 8.50
	},
	["WEAPON_ASSAULTRIFLE"] = {
		index = "ak103",
		name = "AK-103",
		tipo = "Armamento",
		economy = "17775",
		type = "equip",
		ammo = "WEAPON_ASSAULTRIFLE_AMMO",
		weight = 7.75
	},
	["WEAPON_ASSAULTRIFLE_MK2"] = {
		index = "ak74",
		name = "AK-74",
		tipo = "Armamento",
		economy = "18775",
		type = "equip",
		ammo = "WEAPON_ASSAULTRIFLE_MK2_AMMO",
		weight = 7.75
	},
	["WEAPON_BULLPUPRIFLE"] = {
		index = "qbz95",
		name = "QBZ-95",
		tipo = "Armamento",
		economy = "17775",
		type = "equip",
		ammo = "WEAPON_BULLPUPRIFLE_AMMO",
		weight = 7.75
	},
	["WEAPON_ADVANCEDRIFLE"] = {
		index = "tar21",
		name = "Tar-21",
		tipo = "Armamento",
		economy = "17775",
		type = "equip",
		ammo = "WEAPON_ADVANCEDRIFLE_AMMO",
		weight = 7.75
	},
	["WEAPON_CARBINERIFLE_AMMO"] = {
		index = "rifleammo",
		name = "Munição de M4A1",
		tipo = "Munição",
		type = "recharge",
		weight = 0.04
	},
	["WEAPON_SPECIALCARBINE_AMMO"] = {
		index = "rifleammo",
		name = "Munição de G36C",
		tipo = "Munição",
		type = "recharge",
		weight = 0.04
	},
	["WEAPON_SPECIALCARBINE_MK2_AMMO"] = {
		index = "rifleammo",
		name = "Munição de Sig Sauer 556",
		tipo = "Munição",
		type = "recharge",
		weight = 0.04
	},
	["WEAPON_BULLPUPRIFLE_MK2_AMMO"] = {
		index = "rifleammo",
		name = "Munição de L85",
		tipo = "Munição",
		type = "recharge",
		weight = 0.04
	},
	["WEAPON_CARBINERIFLE_MK2_AMMO"] = {
		index = "rifleammo",
		name = "Munição de M4A4",
		tipo = "Munição",
		type = "recharge",
		weight = 0.04
	},
	["WEAPON_ASSAULTRIFLE_AMMO"] = {
		index = "rifleammo",
		name = "Munição de AK-103",
		tipo = "Munição",
		type = "recharge",
		weight = 0.04
	},
	["WEAPON_ASSAULTRIFLE_MK2_AMMO"] = {
		index = "rifleammo",
		name = "Munição de AK-74",
		tipo = "Munição",
		type = "recharge",
		weight = 0.04
	},
	["WEAPON_BULLPUPRIFLE_AMMO"] = {
		index = "rifleammo",
		name = "Munição de QBZ-95",
		tipo = "Munição",
		type = "recharge",
		weight = 0.04
	},
	["WEAPON_ADVANCEDRIFLE_AMMO"] = {
		index = "rifleammo",
		name = "Munição de Tar-21",
		tipo = "Munição",
		type = "recharge",
		weight = 0.04
	},
 -- END RIFLE

 -- START SHOTGUN
    ["WEAPON_MUSKET"] = {
		index = "winchester",
		name = "Winchester 1892",
		tipo = "Armamento",
		economy = "2750",
		type = "equip",
		ammo = "WEAPON_MUSKET_AMMO",
		weight = 6.25
	},
	["WEAPON_SNIPERRIFLE"] = {
		index = "sauer101",
		name = "Sauer 101",
		tipo = "Armamento",
		economy = "6750",
		type = "equip",
		ammo = "WEAPON_SNIPERRIFLE_AMMO",
		weight = 8.25
	},
	["WEAPON_PUMPSHOTGUN"] = {
		index = "mossberg590",
		name = "Mossberg 590",
		tipo = "Armamento",
		economy = "4250",
		type = "equip",
		ammo = "WEAPON_PUMPSHOTGUN_AMMO",
		weight = 7.25
	},
	["WEAPON_PUMPSHOTGUN_MK2"] = {
		index = "mossberg590a1",
		name = "Mossberg 590A1",
		tipo = "Armamento",
		economy = "16775",
		type = "equip",
		ammo = "WEAPON_PUMPSHOTGUN_MK2_AMMO",
		weight = 7.25
	},
	["WEAPON_SAWNOFFSHOTGUN"] = {
		index = "mossberg500",
		name = "Mossberg 500",
		tipo = "Armamento",
		economy = "10775",
		type = "equip",
		ammo = "WEAPON_SAWNOFFSHOTGUN_AMMO",
		weight = 5.75
	},
	["WEAPON_MUSKET_AMMO"] = {
		index = "musketammo",
		name = "Munição de Mosquete",
		tipo = "Munição",
		type = "recharge",
		weight = 0.05
	},
	["WEAPON_SNIPERRIFLE_AMMO"] = {
		index = "musketammo",
		name = "Munição de Sauer",
		tipo = "Munição",
		type = "recharge",
		weight = 0.07
	},
	["WEAPON_PUMPSHOTGUN_AMMO"] = {
		index = "shotgunammo",
		name = "Munição de Mossberg 590",
		tipo = "Munição",
		type = "recharge",
		weight = 0.05
	},
	["WEAPON_PUMPSHOTGUN_MK2_AMMO"] = {
		index = "shotgunammo",
		name = "Munição de Mossberg 590A1",
		tipo = "Munição",
		type = "recharge",
		weight = 0.05
	},
	["WEAPON_SAWNOFFSHOTGUN_AMMO"] = {
		index = "shotgunammo",
		name = "Munição de Mossberg 500",
		tipo = "Munição",
		type = "recharge",
		weight = 0.05
	},
 -- END SHOTGUN

 -- START OTHERS
	["WEAPON_PETROLCAN"] = {
		index = "gallon",
		name = "Galão",
		tipo = "Armamento",
		economy = "250",
		type = "equip",
		ammo = "WEAPON_PETROLCAN_AMMO",
		weight = 1.25
	},
	["WEAPON_PETROLCAN_AMMO"] = {
		index = "fuel",
		name = "Combustível",
		tipo = "Usável",
		type = "recharge",
		weight = 0.001
	},
	["WEAPON_RAYPISTOL"] = {
		index = "raypistol",
		name = "Pistola de Raios",
		tipo = "Armamento",
		type = "equip",
		weight = 2.25
	},
	["WEAPON_RPG"] = {
		index = "rpg",
		name = "RPG-7",
		tipo = "Armamento",
		type = "equip",
		weight = 9.55
	},
	["WEAPON_RPG_AMMO"] = {
		index = "rpgammo",
		name = "Munição de RPG-7",
		tipo = "Armamento",
		type = "recharge",
		weight = 3.25
	},
 -- END OTHERS
	["pager"] = {
		index = "pager",
		name = "Pager",
		tipo = "Usável",
		economy = "225",
		type = "use",
		weight = 1.25
	},
	["firecracker"] = {
		index = "firecracker",
		name = "Fogos de Artificio",
		tipo = "Usável",
		economy = "100",
		type = "use",
		weight = 2.25
	},
	["analgesic"] = {
		index = "analgesic",
		name = "Analgésico",
		tipo = "Usável",
		economy = "105",
		type = "use",
		weight = 0.10
	},
	["oxy"] = {
		index = "analgesic",
		name = "Oxy",
		tipo = "Usável",
		economy = "75",
		type = "use",
		weight = 0.10
	},
	["gauze"] = {
		index = "gauze",
		name = "Gazes",
		tipo = "Usável",
		economy = "175",
		type = "use",
		weight = 0.10
	},
	["gsrkit"] = {
		index = "gsrkit",
		name = "Kit Residual",
		tipo = "Usável",
		economy = "35",
		type = "use",
		weight = 0.75
	},
	["gdtkit"] = {
		index = "gdtkit",
		name = "Kit Químico",
		tipo = "Usável",
		economy = "35",
		type = "use",
		weight = 0.75
	},
	["orange"] = {
		index = "orange",
		name = "Laranja",
		tipo = "Usável",
		economy = "4",
		type = "use",
		weight = 0.25
	},
	["strawberry"] = {
		index = "strawberry",
		name = "Morango",
		tipo = "Usável",
		economy = "4",
		type = "use",
		weight = 0.15
	},
	["grape"] = {
		index = "grape",
		name = "Uva",
		tipo = "Usável",
		economy = "4",
		type = "use",
		weight = 0.15
	},
	["tange"] = {
		index = "tange",
		name = "Tangerina",
		type = "use",
		tipo = "Usável",
		economy = "4",
		weight = 0.25
	},
	["banana"] = {
		index = "banana",
		name = "Banana",
		tipo = "Usável",
		economy = "4",
		type = "use",
		weight = 0.25
	},
	["passion"] = {
		index = "passion",
		name = "Maracujá",
		tipo = "Usável",
		economy = "4",
		type = "use",
		weight = 0.25
	},
	["tomato"] = {
		index = "tomato",
		name = "Tomate",
		tipo = "Usável",
		economy = "6",
		type = "use",
		weight = 0.15
	},
	["ketchup"] = {
		index = "ketchup",
		name = "Ketchup",
		tipo = "Comum",
		economy = "20",
		type = "use",
		weight = 0.25
	},
	["orangejuice"] = {
		index = "orangejuice",
		name = "Suco de Laranja",
		desc = "Mata sede e cura estresse",
		tipo = "Usável",
		economy = "85",
		type = "use",
		weight = 0.75
	},
	["tangejuice"] = {
		index = "tangejuice",
		name = "Suco de Tangerina",
		desc = "Mata sede e cura estresse",
		tipo = "Usável",
		economy = "85",
		type = "use",
		weight = 0.45
	},
	["grapejuice"] = {
		index = "grapejuice",
		name = "Suco de Uva",
		desc = "Mata sede e cura estresse",
		tipo = "Usável",
		economy = "85",
		type = "use",
		weight = 0.45
	},
	["strawberryjuice"] = {
		index = "strawberryjuice",
		name = "Suco de Morango",
		desc = "Mata sede e cura estresse",
		tipo = "Usável",
		economy = "85",
		type = "use",
		weight = 0.45
	},
	["bananajuice"] = {
		index = "bananajuice",
		name = "Suco de Banana",
		desc = "Mata sede e cura estresse",
		tipo = "Usável",
		economy = "85",
		type = "use",
		weight = 0.45
	},
	["passionjuice"] = {
		index = "passionjuice",
		name = "Suco de Maracujá",
		desc = "Mata sede e cura estresse",
		tipo = "Usável",
		economy = "90",
		type = "use",
		weight = 0.45
	},
	["cannedsoup"] = {
		index = "cannedsoup",
		name = "Sopa em Lata",
		tipo = "Usável",
		economy = "15",
		type = "use",
		weight = 0.25
	},
	["canofbeans"] = {
		index = "canofbeans",
		name = "Lata de Feijão",
		tipo = "Usável",
		economy = "15",
		type = "use",
		weight = 0.25
	},
--  [Homes]
    ["lampshade"] = {
		index = "lampshade",
		name = "Abajur",
		tipo = "Comum",
		economy = "115",
		type = "use",
		weight = 0.50
	},
	["pliers"] = {
		index = "pliers",
		name = "Alicate",
		tipo = "Comum",
		economy = "75",
		type = "use",
		weight = 0.25
	},
	["silverring"] = {
		index = "silverring",
		name = "Anel de Prata",
		tipo = "Comum",
		economy = "85",
		type = "use",
		weight = 0.25
	},
	["goldring"] = {
		index = "goldring",
		name = "Anel de Ouro",
		tipo = "Comum",
		economy = "125",
		type = "use",
		weight = 0.25
	},
	["silvercoin"] = {
		index = "silvercoin",
		name = "Moeda de Prata",
		tipo = "Comum",
		economy = "5",
		type = "use",
		weight = 0.01
	},
	["goldcoin"] = {
		index = "goldcoin",
		name = "Moeda de Ouro",
		tipo = "Comum",
		economy = "10",
		type = "use",
		weight = 0.01
	},
	["spray01"] = {
		index = "spray01",
		name = "Desodorante 24hrs",
		tipo = "Comum",
		economy = "85",
		type = "use",
		weight = 0.25
	},
	["spray02"] = {
		index = "spray02",
		name = "Antisséptico",
		tipo = "Comum",
		economy = "85",
		type = "use",
		weight = 0.25
	},
	["spray03"] = {
		index = "spray03",
		name = "Desodorante 48hrs",
		tipo = "Comum",
		economy = "85",
		type = "use",
		weight = 0.25
	},
	["spray04"] = {
		index = "spray04",
		name = "Desodorante 72hrs",
		tipo = "Comum",
		economy = "85",
		type = "use",
		weight = 0.25
	},
	["eraser"] = {
		index = "eraser",
		name = "Apagador",
		tipo = "Comum",
		economy = "75",
		type = "use",
		weight = 0.15
	},
	["deck"] = {
		index = "deck",
		name = "Baralho",
		tipo = "Comum",
		economy = "75",
		type = "use",
		weight = 0.15
	},
	["slipper"] = {
		index = "slipper",
		name = "Chinelo",
		tipo = "Comum",
		economy = "75",
		type = "use",
		weight = 0.50
	},
	["pendrive"] = {
		index = "pendrive",
		name = "Pendrive",
		tipo = "Comum",
		economy = "575",
		type = "use",
		weight = 0.25
	},
	["cup"] = {
		index = "cup",
		name = "Cálice",
		tipo = "Comum",
		economy = "125",
		type = "use",
		weight = 0.25
	},
	["dices"] = {
		index = "dices",
		name = "Dados",
		tipo = "Comum",
		economy = "40",
		type = "use",
		weight = 0.25
	},
	["dish"] = {
		index = "dish",
		name = "Prato",
		tipo = "Comum",
		economy = "85",
		type = "use",
		weight = 0.25
	},
	["floppy"] = {
		index = "floppy",
		name = "Disquete",
		tipo = "Comum",
		economy = "55",
		type = "use",
		weight = 0.15
	},
	["domino"] = {
		index = "domino",
		name = "Dominó",
		tipo = "Comum",
		economy = "65",
		type = "use",
		weight = 0.25
	},
	["brush"] = {
		index = "brush",
		name = "Escova",
		tipo = "Comum",
		economy = "85",
		type = "use",
		weight = 0.25
	},
	["horseshoe"] = {
		index = "horseshoe",
		name = "Ferradura",
		tipo = "Comum",
		economy = "85",
		type = "use",
		weight = 0.25
	},
	["switch"] = {
		index = "switch",
		name = "Interruptor",
		tipo = "Comum",
		economy = "35",
		type = "use",
		weight = 0.25
	},
	["blender"] = {
		index = "blender",
		name = "Liquidificador",
		tipo = "Usável",
		economy = "85",
		type = "use",
		weight = 0.50
	},
	["pan"] = {
		index = "pan",
		name = "Panela",
		tipo = "Usável",
		economy = "125",
		type = "use",
		weight = 0.50
	},
	["rimel"] = {
		index = "rimel",
		name = "Rímel",
		tipo = "Comum",
		economy = "85",
		type = "use",
		weight = 0.25
	},
	["soap"] = {
		index = "soap",
		name = "Sabonete",
		tipo = "Usável",
		economy = "75",
		type = "use",
		weight = 0.25
	},
	["sneakers"] = {
		index = "sneakers",
		name = "Tenis",
		tipo = "Comum",
		economy = "115",
		type = "use",
		weight = 0.50
	},
	["brick"] = {
		index = "brick",
		name = "Tijolo",
		tipo = "Comum",
		economy = "30",
		type = "use",
		weight = 0.50
	},
	["fan"] = {
		index = "fan",
		name = "Ventilador",
		tipo = "Comum",
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
		tipo = "Ferramentas",
		economy = "500",
		type = "use",
		weight = 1.75
	}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMBODYLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemBodyList(item)
	local splitName = splitString(item,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMINDEXLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemIndexList(item)
	local splitName = splitString(item,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["index"]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMNAMELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemNameList(item)
	local splitName = splitString(item,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["name"]
	end
	
	return "Deletado"
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDESCLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemDescList(item)
	local splitName = splitString(item,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["desc"] or nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMVEHICLELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemVehicleList(item)
	local splitName = splitString(item,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["vehicle"] or false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMTIPOLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemTipoList(item)
	local splitName = splitString(item,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["tipo"] or nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMUNITYLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemUnityList(item)
	local splitName = splitString(item,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["unity"] or "Não"
	end
	
	return "Não"
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMMAXAMOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemMaxAmount(item)
	local splitName = splitString(item,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["max"] or nil
	end

	return nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMECONOMYLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemEconomyList(item)
	local splitName = splitString(item,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["economy"] or "S/V"
	end
	
	return "S/V"
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMSUBTYPELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemSubTypeList(item)
	local splitName = splitString(item,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["subtype"] or nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMTRANSFORMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemTransformList(item)
	local splitName = splitString(item,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["transform"] or nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDURABILITYLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemDurabilityList(item)
	local splitName = splitString(item,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["durability"] or false
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMCOLOR
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemColor(item)
	local splitName = splitString(item,"-")

	if itemlist[splitName[1]] then
		if itemlist[splitName[1]]["color"] ~= nil then
			return itemlist[splitName[1]]["color"]
		end
	end

	return { 26,27,30,0.5 }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMTYPELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemTypeList(item)
	local splitName = splitString(item,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["type"]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMAMMOLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemAmmoList(item)
	local splitName = splitString(item,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["ammo"]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMWEIGHTLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemWeightList(item)
	local splitName = splitString(item,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["weight"] or 0.0
	end

	return 0.0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPUTEINVWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.computeInvWeight(user_id)
	local weight = 0.0
	local inventory = vRP.getInventory(user_id)
	if inventory then
		for k,v in pairs(inventory) do
			if vRP.itemBodyList(v.item) then
				weight = weight + vRP.itemWeightList(v.item) * parseInt(v.amount)
			end
		end
		
		return weight
	end
	
	return 0.0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPUTECHESTWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.computeChestWeight(items)
	local weight = 0.0
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
							TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "RECEBEU",vRP.itemIndexList(idname),vRP.format(parseInt(1)),vRP.itemNameList(idname) })
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
						TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "RECEBEU",vRP.itemIndexList(idname),vRP.format(parseInt(amount)),vRP.itemNameList(idname) })
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
						TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "RECEBEU",vRP.itemIndexList(idname),vRP.format(parseInt(1)),vRP.itemNameList(idname) })
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
						TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "RECEBEU",vRP.itemIndexList(idname),vRP.format(parseInt(amount)),vRP.itemNameList(idname) })
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
						TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "REMOVIDO",vRP.itemIndexList(idname),vRP.format(parseInt(amount)),vRP.itemNameList(idname) })
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
					TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "REMOVIDO",vRP.itemIndexList(idname),vRP.format(parseInt(amount)),vRP.itemNameList(idname) })
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
					TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "REMOVIDO",vRP.itemIndexList(idname),vRP.format(parseInt(amount)),vRP.itemNameList(idname) })
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
						creativeLogs(policeLogs,"```PASSAPORTE: "..user_id.." ( RETIROU )\nITEM: "..vRP.format(parseInt(activedAmount[user_id])).."x "..vRP.itemNameList(itemName).."```")
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
						creativeLogs(policeLogs,"```PASSAPORTE: "..user_id.." ( GUARDOU )\nITEM: "..vRP.format(parseInt(activedAmount[user_id])).."x "..vRP.itemNameList(itemName).."```")
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
-- CREATIVELOGS
-----------------------------------------------------------------------------------------------------------------------------------------
function creativeLogs(webhook,message)
	if webhook ~= "" then
		PerformHttpRequest(webhook,function(err,text,headers) end,"POST",json.encode({ content = message }),{ ['Content-Type'] = "application/json" })
	end
end