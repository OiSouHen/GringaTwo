-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
	["skate"] = {
		index = "skate",
		name = "Skate",
		type = "use",
		weight = 2.00
	},	
	["bonusDelivery"] = {
		index = "bonusDelivery",
		name = "Bônus Tacos",
		type = "use",
		weight = 0.10
	},
	["bonusPostOp"] = {
		index = "bonusPostOp",
		name = "Bônus Entregador",
		type = "use",
		weight = 0.10
	},
	["radio"] = {
		index = "radio",
		name = "Rádio",
		type = "use",
		weight = 1.10
	},
	["radiodamaged"] = {
        index = "radiodamaged",
        name = "Rádio Queimado",
        type = "use",
        weight = 1.10
    },
	["vest"] = {
		index = "vest",
		name = "Colete",
		type = "use",
		weight = 3.00 --testar
	},
	["bandage"] = {
		index = "bandage",
		name = "Curativo",
		type = "use",
		weight = 0.50
	},
	["warfarin"] = {
		index = "warfarin",
		name = "Primeiros Socorros",
		type = "use",
		weight = 3.00
	},
	["adrenaline"] = {
		index = "adrenaline",
		name = "Adrenalina",
		type = "use",
		weight = 0.50
	},
	["raceticket"] = {
		index = "raceticket",
		name = "Ticket de Corrida",
		type = "use",
		weight = 0.50
	},
	["pouch"] = {
		index = "pouch",
		name = "Saco de Dinheiro",
		type = "use",
		weight = 0.10
	},
	["woodlog"] = {
		index = "woodlog",
		name = "Tora de Madeira",
		type = "use",
		weight = 7.00
	},
	["fishingrod"] = {
		index = "fishingrod",
		name = "Vara de Pescar",
		type = "use",
		weight = 2.00
	},
	["octopus"] = {
		index = "octopus",
		name = "Polvo",
		type = "use",
		weight = 1.00
	},
	["shrimp"] = {
		index = "shrimp",
		name = "Camarão",
		type = "use",
		weight = 0.20
	},
	["carp"] = {
		index = "carp",
		name = "Carpa",
		type = "use",
		weight = 0.20
	},
	["bait"] = {
		index = "bait",
		name = "Isca",
		type = "use",
		weight = 0.10
	},
	["cannabisseed"] = {
		index = "cannabisseed",
		name = "Sementes de Maconha",
		type = "use",
		weight = 0.10
	},
	["bucket"] = {
		index = "bucket",
		name = "Balde",
		type = "use",
		weight = 1.50
	},
	["compost"] = {
		index = "compost",
		name = "Adubo",
		type = "use",
		weight = 0.50
	},
	["weed"] = {
		index = "weed",
		name = "Maconha",
		type = "use",
		weight = 0.50
	},
	["joint"] = {
		index = "joint",
		name = "Baseado",
		type = "use",
		weight = 0.80
	},
	["lean"] = {
		index = "lean",
		name = "Lean",
		type = "use",
		weight = 1.50
	},
	["ecstasy"] = {
		index = "ecstasy",
		name = "Ecstasy",
		type = "use",
		weight = 0.20
	},
	["cocaine"] = {
		index = "cocaine",
		name = "Cocaína",
		type = "use",
		weight = 0.50
	},
	["meth"] = {
		index = "meth",
		name = "Metanfetamina",
		type = "use",
		weight = 0.60
	},
	["methliquid"] = {
		index = "methliquid",
		name = "Meta Líquida",
		type = "use",
		weight = 1.00
	},
	["silk"] = {
		index = "silk",
		name = "Seda",
		type = "use",
		weight = 0.50
	},
	["backpackp"] = {
		index = "backpackp",
		name = "Mochila P",
		type = "use",
		weight = 1.00
	},
	["backpackm"] = {
		index = "backpackm",
		name = "Mochila M",
		type = "use",
		weight = 2.00
	},
	["backpackg"] = {
		index = "backpackg",
		name = "Mochila G",
		type = "use",
		weight = 3.00
	},
	["backpackx"] = {
		index = "backpackx",
		name = "Mochila X",
		type = "use",
		weight = 4.00
	},
	["premium01"] = {
		index = "premium01",
		name = "3 Dias",
		type = "use",
		weight = 1.00
	},
	["premium02"] = {
		index = "premium02",
		name = "7 Dias",
		type = "use",
		weight = 1.00
	},
	["premium03"] = {
		index = "premium03",
		name = "15 Dias",
		type = "use",
		weight = 1.00
	},
	["premium04"] = {
		index = "premium04",
		name = "1 Mês",
		type = "use",
		weight = 1.00
	},
	["premiumname"] = {
		index = "premiumname",
		name = "Mudar Nome",
		type = "use",
		weight = 1.00
	},
	["premiumpersonagem"] = {
		index = "premiumpersonagem",
		name = "+1 Personagem",
		type = "use",
		weight = 1.00
	},
	["premiumgarage"] = {
		index = "premiumgarage",
		name = "2 Vagas de Garagem",
		type = "use",
		weight = 1.00
	},
	["premiumplate"] = {
		index = "plate",
		name = "Placa Premium",
		type = "use",
		weight = 2.0
	},
	["energetic"] = {
		index = "energetic",
		name = "Energético",
		type = "use",
		weight = 0.50
	},
	["delivery"] = {
		index = "delivery",
		name = "Pacote",
		type = "use",
		weight = 1.20
	},
	["paperbag"] = {
		index = "paperbag",
		name = "Saco de Papel",
		type = "use",
		weight = 1.50
	},
	["alface"] = {
		index = "alface",
		name = "Alface",
		type = "use",
		weight = 0.20
	},
	["bacon"] = {
		index = "bacon",
		name = "Bacon",
		type = "use",
		weight = 0.20
	},
	["bread"] = {
		index = "bread",
		name = "Pão",
		type = "use",
		weight = 0.20
	},
	["burguer"] = {
		index = "burguer",
		name = "Hamburguer",
		type = "use",
		weight = 0.20
	},
	["milk"] = {
		index = "milk",
		name = "Leite",
		type = "use",
		weight = 0.20
	},
	["onion"] = {
		index = "onion",
		name = "Cebola",
		type = "use",
		weight = 0.20
	},
	["ovos"] = {
		index = "ovos",
		name = "Ovos",
		type = "use",
		weight = 0.20
	},
	["presunto"] = {
		index = "presunto",
		name = "Presunto",
		type = "use",
		weight = 0.20
	},
	["queijo"] = {
		index = "queijo",
		name = "Queijo",
		type = "use",
		weight = 0.20
	},
	["tomate"] = {
		index = "tomate",
		name = "Tomare",
		type = "use",
		weight = 0.20
	},
	["emptybottle"] = {
		index = "emptybottle",
		name = "Garrafa vazia",
		type = "use",
		subtype = "comida",
		transform = "emptybottle",
		durability = 1500,
		weight = 0.10
	},
-- SUBTYPE COMIDA
-- subtype = "comida",
-- transform = "comida-estragada",
-- durability = 1500,
    ["cola"] = {
		index = "cola",
		name = "Coca Cola",
		type = "use",
		subtype = "comida",
		transform = "badcola",
		durability = 1500,
		weight = 0.50
	},
	["badcola"] = {
		index = "badcola",
		name = "Cola Cola vencida",
		type = "use",
		weight = 0.50
	},
    ["soda"] = {
		index = "soda",
		name = "Soda",
		type = "use",
		subtype = "comida",
		transform = "badsoda",
		durability = 1500,
		weight = 0.50
	},
	["badsoda"] = {
		index = "badsoda",
		name = "Soda vencida",
		type = "use",
		weight = 0.50
	},
	["coffee"] = {
		index = "coffee",
		name = "Café",
		type = "use",
		subtype = "comida",
		transform = "badcoffee",
		durability = 1500,
		weight = 0.20
	},
	["badcoffee"] = {
		index = "badcoffee",
		name = "Café vencido",
		type = "use",
		weight = 0.20
	},
	["water"] = {
		index = "water",
		name = "Água",
		type = "use",
		subtype = "comida",
		transform = "dirtywater",
		durability = 1500,
		weight = 0.50
	},
	["dirtywater"] = {
		index = "dirtywater",
		name = "Água Suja",
		type = "use",
		weight = 0.50
	},
	["hamburger"] = {
		index = "hamburger",
		name = "Hamburger",
		type = "use",
		subtype = "comida",
		transform = "badhamburger",
		durability = 1500,
		weight = 0.30
	},
	["badhamburger"] = {
		index = "badhamburger",
		name = "Hamburger vencido",
		type = "use",
		weight = 0.30
	},
	["tacos"] = {
		index = "tacos",
		name = "Taco",
		type = "use",
		subtype = "comida",
		transform = "badtacos",
		durability = 1500,
		weight = 0.20
	},
	["badtacos"] = {
		index = "badtacos",
		name = "Taco vencido",
		type = "use",
		weight = 0.20
	},
	["chocolate"] = {
		index = "chocolate",
		name = "Chocolate",
		type = "use",
		subtype = "comida",
		transform = "badchocolate",
		durability = 1500,
		weight = 0.10
	},
	["badchocolate"] = {
		index = "badchocolate",
		name = "Chocolate vencido",
		type = "use",
		weight = 0.10
	},
	["donut"] = {
		index = "donut",
		name = "Donut",
		type = "use",
		subtype = "comida",
		transform = "baddonut",
		durability = 1500,
		weight = 0.20
	},
	["baddonut"] = {
		index = "baddonut",
		name = "Donut vencido",
		type = "use",
		weight = 0.20
	},
-- END SUBTYPE COMIDA
    ["molho"] = {
		index = "molho",
		name = "Molho de Tacos",
		type = "use",
		weight = 0.20
	},
	["plate"] = {
		index = "plate",
		name = "Placa",
		type = "use",
		weight = 2.00
	},
	["lockpick"] = {
		index = "lockpick",
		name = "Lockpick",
		type = "use",
		weight = 2.00
	},
	["toolbox"] = {
		index = "toolbox",
		name = "Caixa de Ferramentas",
		type = "use",
		weight = 4.00
	},
	["postit"] = {
		index = "postit",
		name = "Bloco de Notas",
		type = "use",
		weight = 0.10
	},
	["tires"] = {
		index = "tires",
		name = "Pneus",
		type = "use",
		weight = 3.00
	},
	["cellphone"] = {
		index = "cellphone",
		name = "Telefone",
		type = "use",
		weight = 1.00
	},
	["cellphonedamaged"] = {
        index = "cellphonedamaged",
        name = "Celular Queimado",
        type = "use",
        weight = 1.00
    },
	["divingsuit"] = {
		index = "divingsuit",
		name = "Roupa de Mergulho",
		type = "use",
		weight = 5.00
	},
	["handcuff"] = {
		index = "handcuff",
		name = "Algemas",
		type = "use",
		weight = 1.00
	},
	["rope"] = {
		index = "rope",
		name = "Cordas",
		type = "use",
		weight = 1.40
	},
	["hood"] = {
		index = "hood",
		name = "Capuz",
		type = "use",
		weight = 1.00
	},
	["plastic"] = {
		index = "plastic",
		name = "Plástico",
		type = "use",
		weight = 0.50
	},
	["glass"] = {
		index = "glass",
		name = "Vidro",
		type = "use",
		weight = 1.00
	},
	["rubber"] = {
		index = "rubber",
		name = "Borracha",
		type = "use",
		weight = 0.50
	},
	["aluminum"] = {
		index = "aluminum",
		name = "Alúminio",
		type = "use",
		weight = 2.50
	},
	["copper"] = {
		index = "copper",
		name = "Cobre",
		type = "use",
		weight = 3.00
	},
	["eletronics"] = {
		index = "eletronics",
		name = "Eletrônico",
		type = "use",
		weight = 1.80
	},
	["notebook"] = {
		index = "notebook",
		name = "Notebook",
		type = "use",
		weight = 6.00
	},
	["keyboard"] = {
		index = "keyboard",
		name = "Teclado",
		type = "use",
		weight = 2.50
	},
	["mouse"] = {
		index = "mouse",
		name = "Mouse",
		type = "use",
		weight = 1.50
	},
	["ring"] = {
		index = "ring",
		name = "Anel",
		type = "use",
		weight = 2.60
	},
	["watch"] = {
		index = "watch",
		name = "Relógio",
		type = "use",
		weight = 1.20
	},
	["c4"] = {
		index = "c4",
		name = "C4",
		type = "use",
		weight = 2.50
	},
	["ritmoneury"] = {
		index = "ritmoneury",
		name = "Ritmoneury",
		type = "use",
		weight = 0.50
	},
	["sinkalmy"] = {
		index = "sinkalmy",
		name = "Sinkalmy",
		type = "use",
		weight = 0.50
	},
	["cigarette"] = {
		index = "cigarette",
		name = "Cigarro",
		type = "use",
		weight = 0.50
	},
	["lighter"] = {
		index = "lighter",
		name = "Isqueiro",
		type = "use",
		weight = 0.55
	},
	["vape"] = {
		index = "vape",
		name = "Vape",
		type = "use",
		weight = 3.50
	},
	["dollars"] = {
		index = "dollars",
		name = "Dinheiro",
		type = "use",
		weight = 0.00
	},
	["dollars2"] = {
		index = "dollars2",
		name = "Dinheiro Sujo",
		type = "use",
		weight = 0.00
	},
	["blackcard"] = {
		index = "blackcard",
		name = "Cartão Preto",
		type = "use",
		weight = 0.50
	},
	["bluecard"] = {
		index = "bluecard",
		name = "Cartão Azul",
		type = "use",
		weight = 0.50
	},
	["rose"] = {
		index = "rose",
		name = "Rosa",
		type = "use",
		weight = 0.15
	},
	["teddy"] = {
		index = "teddy",
		name = "Teddy",
		type = "use",
		weight = 3.50
	},
	["absolut"] = {
		index = "absolut",
		name = "Vodka Absolut",
		type = "use",
		weight = 1.00
	},
	["chandon"] = {
		index = "chandon",
		name = "Chandon",
		type = "use",
		weight = 1.50
	},
	["dewars"] = {
		index = "dewars",
		name = "Dewars",
		type = "use",
		weight = 0.50
	},
	["hennessy"] = {
		index = "hennessy",
		name = "Hennessy",
		type = "use",
		weight = 0.50
	},
	["identity"] = {
		index = "identity",
		name = "Identidade",
		type = "use",
		weight = 1.50
	},
	["goldbar"] = {
		index = "goldbar",
		name = "Barra de Ouro",
		type = "use",
		weight = 10.00
	},
	["binoculars"] = {
		index = "binoculars",
		name = "Binóculos",
		type = "use",
		weight = 5.00
	},
	["camera"] = {
		index = "camera",
		name = "Câmera",
		type = "use",
		weight = 3.50
	},
	["playstation"] = {
		index = "playstation",
		name = "Playstation",
		type = "use",
		weight = 5.00
	},
	["xbox"] = {
		index = "xbox",
		name = "Xbox",
		type = "use",
		weight = 6.00
	},
	["legos"] = {
		index = "legos",
		name = "Legos",
		type = "use",
		weight = 2.50
	},
	["ominitrix"] = {
		index = "ominitrix",
		name = "Ominitrix",
		type = "use",
		weight = 2.50
	},
	["bracelet"] = {
		index = "bracelet",
		name = "Bracelete",
		type = "use",
		weight = 3.50
	},
	["dildo"] = {
		index = "dildo",
		name = "Vibrador",
		type = "use",
		weight = 1.50
	},
	["WEAPON_KNIFE"] = {
		index = "knife",
		name = "Faca",
		type = "equip",
		weight = 1.50
	},
	["WEAPON_HATCHET"] = {
		index = "hatchet",
		name = "Machado",
		type = "equip",
		weight = 7.50
	},
	["WEAPON_BAT"] = {
		index = "bat",
		name = "Bastão de Beisebol",
		type = "equip",
		weight = 5.50
	},
	["WEAPON_BATTLEAXE"] = {
		index = "battleaxe",
		name = "Machado de Batalha",
		type = "equip",
		weight = 8.50
	},
	["WEAPON_BOTTLE"] = {
		index = "bottle",
		name = "Garrafa",
		type = "equip",
		weight = 2.50
	},
	["WEAPON_CROWBAR"] = {
		index = "crowbar",
		name = "Pé de Cabra",
		type = "equip",
		weight = 3.50
	},
	["WEAPON_DAGGER"] = {
		index = "dagger",
		name = "Adaga",
		type = "equip",
		weight = 1.50
	},
	["WEAPON_GOLFCLUB"] = {
		index = "golfclub",
		name = "Taco de Golf",
		type = "equip",
		weight = 3.00
	},
	["WEAPON_HAMMER"] = {
		index = "hammer",
		name = "Martelo",
		type = "equip",
		weight = 3.50
	},
	["WEAPON_MACHETE"] = {
		index = "machete",
		name = "Facão",
		type = "equip",
		weight = 2.00
	},
	["WEAPON_POOLCUE"] = {
		index = "poolcue",
		name = "Taco de Sinuca",
		type = "equip",
		weight = 2.00
	},
	["WEAPON_STONE_HATCHET"] = {
		index = "stonehatchet",
		name = "Machado de Pedra",
		type = "equip",
		weight = 15.00
	},
	["WEAPON_SWITCHBLADE"] = {
		index = "switchblade",
		name = "Canivete",
		type = "equip",
		weight = 1.50
	},
	["WEAPON_WRENCH"] = {
		index = "wrench",
		name = "Chave Inglesa",
		type = "equip",
		weight = 3.00
	},
	["WEAPON_KNUCKLE"] = {
		index = "knuckle",
		name = "Soco Inglês",
		type = "equip",
		weight = 2.00
	},
	["WEAPON_FLASHLIGHT"] = {
		index = "flashlight",
		name = "Lanterna",
		type = "equip",
		weight = 1.00
	},
	["WEAPON_NIGHTSTICK"] = {
		index = "nightstick",
		name = "Cassetete",
		type = "equip",
		weight = 3.00
	},
	["WEAPON_PETROLCAN"] = {
		index = "gallon",
		name = "Galão",
		type = "equip",
		ammo = "WEAPON_PETROLCAN_AMMO",
		weight = 2.50
	},
	["GADGET_PARACHUTE"] = {
		index = "parachute",
		name = "Paraquedas",
		type = "use",
		weight = 5.00
	},
	["WEAPON_STUNGUN"] = {
		index = "stungun",
		name = "Tazer",
		type = "equip",
		weight = 2.00
	},
	["WEAPON_FIREEXTINGUISHER"] = {
		index = "extinguisher",
		name = "Extintor",
		type = "equip",
		weight = 3.00
	},
	
 -- START PISTOLS
    ["WEAPON_PISTOL"] = {
	    index = "m1911",
		name = "M1911",
		type = "equip",
		ammo = "WEAPON_PISTOL_AMMO",
		weight = 2.00
    },
	["WEAPON_PISTOL_MK2"] = {
		index = "fiveseven",
		name = "FN Five Seven",
		type = "equip",
		ammo = "WEAPON_PISTOL_MK2_AMMO",
		weight = 2.00
	},
	["WEAPON_APPISTOL"] = {
	    index = "kochvp9",
	    name = "Koch Vp9",
		type = "equip",
		ammo = "WEAPON_APPISTOL_AMMO",
		weight = 2.00
	},
    ["WEAPON_HEAVYPISTOL"] = {
		index = "atifx45",
		name = "Ati FX45",
		type = "equip",
		ammo = "WEAPON_HEAVYPISTOL_AMMO",
		weight = 2.00
	},
	["WEAPON_SNSPISTOL"] = {
		index = "amt380",
		name = "AMT 380",
		type = "equip",
		ammo = "WEAPON_SNSPISTOL_AMMO",
		weight = 2.00
	},
	["WEAPON_SNSPISTOL_MK2"] = {
		index = "hkp7m10",
		name = "HK P7M10",
		type = "equip",
		ammo = "WEAPON_SNSPISTOL_MK2_AMMO",
		weight = 2.00
	},
	["WEAPON_VINTAGEPISTOL"] = {
		index = "m1922",
		name = "M1922",
		type = "equip",
		ammo = "WEAPON_VINTAGEPISTOL_AMMO",
		weight = 2.00
	},
	["WEAPON_PISTOL50"] = {
		index = "desert",
		name = "Desert Eagle",
		type = "equip",
		ammo = "WEAPON_PISTOL50_AMMO",
		weight = 2.00
	},
	["WEAPON_REVOLVER"] = {
		index = "magnum",
		name = "Magnum 44",
		type = "equip",
		ammo = "WEAPON_REVOLVER_AMMO",
		weight = 2.00
	},
	["WEAPON_COMBATPISTOL"] = {
		index = "glock",
		name = "Glock",
		type = "equip",
		ammo = "WEAPON_COMBATPISTOL_AMMO",
		weight = 2.00
	},
	["WEAPON_PISTOL_AMMO"] = {
		index = "m1911ammo",
		name = "M. M1911",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_PISTOL_MK2_AMMO"] = {
		index = "fivesevenammo",
		name = "M. Five Seven",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_APPISTOL_AMMO"] = {
		index = "kochvp9ammo",
		name = "M. Koch Vp9",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_HEAVYPISTOL_AMMO"] = {
		index = "atifx45ammo",
		name = "M. Ati FX45",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_SNSPISTOL_AMMO"] = {
		index = "amt380ammo",
		name = "M. AMT 380",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_SNSPISTOL_MK2_AMMO"] = {
		index = "hkp7m10ammo",
		name = "M. HK P7M10",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_VINTAGEPISTOL_AMMO"] = {
		index = "m1922ammo",
		name = "M. M1922",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_PISTOL50_AMMO"] = {
		index = "desertammo",
		name = "M. Desert Eagle",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_REVOLVER_AMMO"] = {
		index = "magnumammo",
		name = "M. Magnum 44",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_COMBATPISTOL_AMMO"] = {
		index = "glockammo",
		name = "M. Glock",
		type = "recharge",
		weight = 0.10
	},
 -- END PISTOLS

 -- START SMG
    ["WEAPON_COMPACTRIFLE"] = {
		index = "akcompact",
		name = "AK Compact",
		type = "equip",
		ammo = "WEAPON_COMPACTRIFLE_AMMO",
		weight = 3.00
	},
	["WEAPON_MICROSMG"] = {
		index = "uzi",
		name = "Uzi",
		type = "equip",
		ammo = "WEAPON_MICROSMG_AMMO",
		weight = 3.00
	},
	["WEAPON_MINISMG"] = {
		index = "skorpionv61",
		name = "Skorpion V61",
		type = "equip",
		ammo = "WEAPON_MINISMG_AMMO",
		weight = 3.00
	},
	["WEAPON_SMG"] = {
		index = "mp5",
		name = "MP5",
		type = "equip",
		ammo = "WEAPON_SMG_AMMO",
		weight = 3.00
	},
	["WEAPON_ASSAULTSMG"] = {
		index = "mtar21",
		name = "MTAR-21",
		type = "equip",
		ammo = "WEAPON_ASSAULTSMG_AMMO",
		weight = 3.00
	},
	["WEAPON_GUSENBERG"] = {
		index = "thompson",
		name = "Thompson",
		type = "equip",
		ammo = "WEAPON_GUSENBERG_AMMO",
		weight = 3.00
	},
	["WEAPON_MACHINEPISTOL"] = {
		index = "tec9",
		name = "Tec-9",
		type = "equip",
		ammo = "WEAPON_MACHINEPISTOL_AMMO",
		weight = 3.00
	},
	["WEAPON_COMPACTRIFLE_AMMO"] = {
		index = "akcompactammo",
		name = "M. AK Compact",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_MICROSMG_AMMO"] = {
		index = "uziammo",
		name = "M. Uzi",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_MINISMG_AMMO"] = {
		index = "skorpionv61ammo",
		name = "M. Skorpion V61",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_SMG_AMMO"] = {
		index = "mp5ammo",
		name = "M. MP5",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_ASSAULTSMG_AMMO"] = {
		index = "mtar21ammo",
		name = "M. MTAR-21",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_GUSENBERG_AMMO"] = {
		index = "thompsonammo",
		name = "M. Thompson",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_MACHINEPISTOL_AMMO"] = {
		index = "tec9ammo",
		name = "M. Tec-9",
		type = "recharge",
		weight = 0.10
	},
 -- END SMG

 -- START RIFLE
    ["WEAPON_CARBINERIFLE"] = {
		index = "m4a1",
		name = "M4A1",
		type = "equip",
		ammo = "WEAPON_ASSAULTRIFLE_AMMO",
		weight = 3.00
	},
	["WEAPON_ASSAULTRIFLE"] = {
		index = "ak103",
		name = "AK-103",
		type = "equip",
		ammo = "WEAPON_ASSAULTRIFLE_AMMO",
		weight = 3.00
	},
	["WEAPON_ASSAULTRIFLE_MK2"] = {
		index = "ak74",
		name = "AK-74",
		type = "equip",
		ammo = "WEAPON_ASSAULTRIFLE_MK2_AMMO",
		weight = 3.00
	},
	["WEAPON_CARBINERIFLE_AMMO"] = {
		index = "m4a1ammo",
		name = "M. M4A1",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_ASSAULTRIFLE_AMMO"] = {
		index = "ak103ammo",
		name = "M. AK-103",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_ASSAULTRIFLE_MK2_AMMO"] = {
		index = "ak74ammo",
		name = "M. AK-74",
		type = "recharge",
		weight = 0.10
	},
 -- END RIFLE

 -- START SHOTGUN
    ["WEAPON_PUMPSHOTGUN"] = {
		index = "remington",
		name = "Remington",
		type = "equip",
		ammo = "WEAPON_PUMPSHOTGUN_AMMO",
		weight = 3.00
	},
	["WEAPON_SAWNOFFSHOTGUN"] = {
		index = "mossberg590",
		name = "Mossberg 590",
		type = "equip",
		ammo = "WEAPON_SAWNOFFSHOTGUN_AMMO",
		weight = 3.00
	},
	["WEAPON_PUMPSHOTGUN_AMMO"] = {
		index = "remingtonammo",
		name = "M. Remington",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_SAWNOFFSHOTGUN_AMMO"] = {
		index = "mossberg590ammo",
		name = "M. Mossberg 590",
		type = "recharge",
		weight = 0.10
	},
 -- END SHOTGUN

 -- START OTHERS
	["WEAPON_PETROLCAN_AMMO"] = {
		index = "fuel",
		name = "Combustível",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_RAYPISTOL"] = {
		index = "raypistol",
		name = "Pistola de Raios",
		type = "equip",
		weight = 1.00
	},
	["WEAPON_RPG"] = {
		index = "rpg",
		name = "RPG-7",
		type = "equip",
		weight = 3.00
	},
	["WEAPON_RPG_AMMO"] = {
		index = "rpgammo",
		name = "M. RPG-7",
		type = "recharge",
		weight = 0.50
	},
 -- END OTHERS

	["pager"] = {
		index = "pager",
		name = "Pager",
		type = "use",
		weight = 1.50
	},
	["firecracker"] = {
		index = "firecracker",
		name = "Fogos de Artificio",
		type = "use",
		weight = 2.50
	},
	["analgesic"] = {
		index = "analgesic",
		name = "Analgésico",
		type = "use",
		weight = 0.50
	},
	["gauze"] = {
		index = "gauze",
		name = "Gazes",
		type = "use",
		weight = 2.50
	},
	["gsrkit"] = {
		index = "gsrkit",
		name = "Kit Residual",
		type = "use",
		weight = 3.50
	},
	["gdtkit"] = {
		index = "gdtkit",
		name = "Kit Químico",
		type = "use",
		weight = 6.50
	},
	["fueltech"] = {
		index = "fueltech",
		name = "Fueltech",
		type = "use",
		weight = 3.50
	},
	["cpuchip"] = {
		index = "cpuchip",
		name = "Processador",
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
		type = "use",
		weight = 5.00
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