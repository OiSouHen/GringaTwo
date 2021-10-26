-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("target",cRP)
vSERVER = Tunnel.getInterface("target")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Zones = {}
local Models = {}
local success = false
local innerEntity = {}
local setDistance = 10.0
local playerActive = true
local targetActive = false
local adminService = false
local policeService = false
local paramedicService = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:UPDATESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("police:updateService")
AddEventHandler("police:updateService",function(status)
	policeService = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:UPDATESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("paramedic:updateService")
AddEventHandler("paramedic:updateService",function(status)
	paramedicService = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:PLAYERACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp:playerActive")
AddEventHandler("vrp:playerActive",function()
	playerActive = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:TOGGLEADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.toggleService()
	if adminService then
		setDistance = 10.0
		adminService = false
		TriggerEvent("Notify","amarelo","Sistema desativado.",5000)
	else
		setDistance = 99.0
		adminService = true
		TriggerEvent("Notify","verde","Sistema ativado.",5000)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	RegisterCommand("+entityTarget",playerTargetEnable)
	RegisterCommand("-entityTarget",playerTargetDisable)
	RegisterKeyMapping("+entityTarget","Target","keyboard","LMENU")
	
	AddCircleZone("polService01",vector3(441.28,-981.95,30.68),0.75,{
		name = "polService01",
		heading = 266.46
	},{
		distance = 1.0,
		options = {
			{
				event = "police:servicePolice",
				label = "Trabalhar",
				tunnel = "server"
			}
		}
	})
	
	AddCircleZone("polService02",vector3(1853.33,3689.93,34.26),0.75,{
		name = "polService02",
		heading = 303.31
	},{
		distance = 1.0,
		options = {
			{
				event = "police:servicePolice",
				label = "Trabalhar",
				tunnel = "server"
			}
		}
	})
	
	AddCircleZone("polService03",vector3(-449.32,6012.61,31.71),0.75,{
		name = "polService03",
		heading = 42.52
	},{
		distance = 1.0,
		options = {
			{
				event = "police:servicePolice",
				label = "Trabalhar",
				tunnel = "server"
			}
		}
	})
	
	AddCircleZone("polService04",vector3(1840.28,2579.19,46.02),0.75,{
		name = "polService04",
		heading = 181.42
	},{
		distance = 1.0,
		options = {
			{
				event = "corrections:initService",
				label = "Trabalhar",
				tunnel = "client"
			}
		}
	})
	
	AddCircleZone("polService05",vector3(384.84,794.0,187.45),0.75,{
		name = "polService05",
		heading = 240.95
	},{
		distance = 1.0,
		options = {
			{
				event = "police:servicePolice",
				label = "Trabalhar",
				tunnel = "server"
			}
		}
	})
	
	AddCircleZone("paraService01",vector3(312.98,-594.52,43.29),0.75,{
		name = "paraService01",
		heading = 331.66
	},{
		distance = 1.0,
		options = {
			{
				event = "paramedic:serviceParamedic",
				label = "Trabalhar",
				tunnel = "server"
			}
		}
	})
	
	AddCircleZone("paraService02",vector3(1830.57,3676.32,34.27),0.75,{
		name = "paraService02",
		heading = 212.6
	},{
		distance = 1.0,
		options = {
			{
				event = "paramedic:serviceParamedic",
				label = "Trabalhar",
				tunnel = "server"
			}
		}
	})
	
	AddCircleZone("paraService03",vector3(349.94,-586.64,28.8),0.75,{
		name = "paraService03",
		heading = 252.29
	},{
		distance = 1.0,
		options = {
			{
				event = "paramedic:serviceParamedic",
				label = "Trabalhar",
				tunnel = "server"
			}
		}
	})
	
	AddCircleZone("paraService04",vector3(-255.44,6330.36,32.42),0.75,{
		name = "paraService04",
		heading = 317.49
	},{
		distance = 1.0,
		options = {
			{
				event = "paramedic:serviceParamedic",
				label = "Trabalhar",
				tunnel = "server"
			}
		}
	})
	
	AddCircleZone("treatment01",vector3(-253.92,6331.07,32.42),0.75,{
		name = "treatment01",
		heading = 136.07
	},{
		distance = 1.0,
		options = {
			{
				event = "checkin:initCheck",
				label = "Tratamento",
				tunnel = "client"
			}
		}
	})
	
	AddCircleZone("treatment02",vector3(1832.67,3677.03,34.27),0.75,{
		name = "treatment02",
		heading = 65.2
	},{
		distance = 1.0,
		options = {
			{
				event = "checkin:initCheck",
				label = "Tratamento",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("treatment03",vector3(307.03,-595.12,43.29),0.75,{
		name = "treatment03",
		heading = 249.45
	},{
		distance = 1.0,
		options = {
			{
				event = "checkin:initCheck",
				label = "Tratamento",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("treatment04",vector3(350.92,-587.68,28.8),0.75,{
		name = "treatment04",
		heading = 70.87
	},{
		distance = 1.0,
		options = {
			{
				event = "checkin:initCheck",
				label = "Tratamento",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("treatment05",vector3(1768.67,2570.59,45.73),0.75,{
		name = "treatment05",
		heading = 314.65
	},{
		distance = 1.0,
		options = {
			{
				event = "checkin:initCheck",
				label = "Tratamento",
				tunnel = "client"
			}
		}
	})
	
	AddCircleZone("mecService01",vector3(126.03,-3007.9,7.05),0.75,{
		name = "mecService01",
		heading = 87.32
	},{
		distance = 1.0,
		options = {
			{
				event = "lscustoms:serviceMechanic",
				label = "Trabalhar",
				tunnel = "server"
			}
		}
	})
	
	AddCircleZone("mecService02",vector3(124.81,-3014.18,7.05),0.75,{
		name = "mecService02",
		heading = 87.32
	},{
		distance = 1.0,
		options = {
			{
				event = "lscustoms:serviceMechanic",
				label = "Trabalhar",
				tunnel = "server"
			}
		}
	})
	
	AddCircleZone("foodJuice01",vector3(-1190.78,-904.23,13.99),0.5,{
		name = "foodJuice01",
		heading = 306.15
	},{
		distance = 1.25,
		options = {
			{
				event = "burgershot:foodJuice",
				label = "Encher Copo",
				tunnel = "server"
			}
		}
	})
	
	AddCircleZone("foodJuice02",vector3(-1190.12,-905.16,13.99),0.5,{
		name = "foodJuice02",
		heading = 306.15
	},{
		distance = 1.0,
		options = {
			{
				event = "burgershot:foodJuice",
				label = "Encher Copo",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("foodBurger01",vector3(-1202.08,-897.21,13.99),0.5,{
		name = "foodBurger01",
		heading = 124.73
	},{
		distance = 1.0,
		options = {
			{
				event = "burgershot:foodBurger",
				label = "Montar Lanche",
				tunnel = "server"
			}
		}
	})
	
	AddCircleZone("foodBurger02",vector3(-1202.55,-896.55,13.99),0.5,{
		name = "foodBurger02",
		heading = 124.73
	},{
		distance = 1.0,
		options = {
			{
				event = "burgershot:foodBurger",
				label = "Montar Lanche",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("foodBox",vector3(-1197.91,-892.21,13.99),0.5,{
		name = "foodBox",
		heading = 34.02
	},{
		distance = 1.25,
		options = {
			{
				event = "burgershot:foodBox",
				label = "Montar Caixa",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("drugsToggle01",vector3(-1174.37,-898.99,13.75),0.5,{
		name = "drugsToggle01",
		heading = 31.19
	},{
		distance = 1.0,
		options = {
			{
				event = "drugs:toggleService1",
				label = "Comercializar",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("drugsToggle02",vector3(121.11,-3021.05,7.04),0.5,{
		name = "drugsToggle02",
		heading = 90.71
	},{
		distance = 1.0,
		options = {
			{
				event = "drugs:toggleService1",
				label = "Comercializar",
				tunnel = "client"
			}
		}
	})
	
	AddCircleZone("drugsToggle03",vector3(-1193.36,-893.96,13.99),0.5,{
		name = "drugsToggle03",
		heading = 90.71
	},{
		distance = 1.0,
		options = {
			{
				event = "drugs:toggleService2",
				label = "Comercializar",
				tunnel = "client"
			}
		}
	})
	
	AddCircleZone("drugsToggle04",vector3(-1194.39,-892.44,13.99),0.5,{
		name = "drugsToggle04",
		heading = 90.71
	},{
		distance = 1.0,
		options = {
			{
				event = "drugs:toggleService2",
				label = "Comercializar",
				tunnel = "client"
			}
		}
	})
	
	AddCircleZone("drugsToggle05",vector3(-1195.42,-890.94,13.99),0.5,{
		name = "drugsToggle05",
		heading = 90.71
	},{
		distance = 1.0,
		options = {
			{
				event = "drugs:toggleService2",
				label = "Comercializar",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("dismantleToggle01",vector3(-86.96,-2233.3,7.82),0.5,{
		name = "dismantleToggle01",
		heading = 90.71
	},{
		distance = 1.0,
		options = {
			{
				event = "dismantle:invokeList",
				label = "Desmanche",
				tunnel = "client"
			}
		}
	})

	AddTargetModel({ 1281992692,1158960338,1511539537 },{
		options = {
		    {
				event = "paramedic:callParamedic",
				label = "Chamar Paramédico",
				tunnel = "server"
			},
			{
				event = "police:callPolice",
				label = "Chamar Polícia",
				tunnel = "server"
			},
			{
				event = "lscustoms:callMechanic",
				label = "Chamar Mecânico",
				tunnel = "server"
			}
		},
		distance = 1.00
	})
	
	AddTargetModel({ 1631638868,2117668672,-1498379115,-1519439119,-289946279 },{
		options = {
			{
				event = "target:animDeitar",
				label = "Deitar",
				tunnel = "client"
			}
		},
		distance = 1.00
	})

	AddTargetModel({ -171943901,-109356459,1805980844,-99500382,1262298127,1737474779,2040839490,1037469683,867556671,-1521264200,-741944541,-591349326,-293380809,-628719744,-1317098115,1630899471,38932324,-523951410,725259233,764848282,2064599526,536071214,589738836,146905321,47332588,-1118419705,538002882,-377849416,96868307,-1195678770,-853526657,652816835 },{
		options = {
			{
				event = "target:animSentar",
				label = "Sentar",
				tunnel = "client"
			}
		},
		distance = 1.00
	})

	AddTargetModel({ 690372739 },{
		options = {
			{
				event = "shops:coffeeMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ -654402915,1421582485 },{
		options = {
			{
				event = "shops:donutMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 992069095,1114264700 },{
		options = {
			{
				event = "shops:sodaMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 1129053052 },{
		options = {
			{
				event = "shops:burgerMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ -1581502570 },{
		options = {
			{
				event = "shops:hotdogMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 1099892058 },{
		options = {
			{
				event = "shops:waterMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ -664053099,1682622302,307287994,-1323586730,-417505688,-832573324 },{
		options = {
			{
				event = "hunting:animalCutting",
				label = "Esfolar",
				tunnel = "client"
			}
		},
		distance = 1.50
	})

	AddTargetModel({ -205311355,-534360227 },{
		options = {
			{
				event = "tryDeleteObject",
				label = "Remover",
				tunnel = "objects"
			}
		},
		distance = 1.50
	})

	AddTargetModel({ 666561306,218085040,-58485588,-1426008804,-228596739,1437508529,-1096777189,1511880420,-468629664,1143474856,-2096124444,682791951,-115771139,1329570871,-130812911, },{
		options = {
			{
				event = "garbageman:searchTrash",
				label = "Vasculhar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})
	
	AddTargetModel({ 1211559620,1363150739,-1186769817,261193082,-756152956,-1383056703,720581693 },{
		options = {
			{
				event = "garbageman:searchObject",
				label = "Vasculhar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})
	
	AddTargetModel({ 322493792,-273279397,10106915,1120812170,-915224107,591265130,929870599,-896997473,2090224559,-1366478936,-52638650,-1748303324,1069797899,1898296526,1434516869 },{
		options = {
			{
				event = "garbageman:searchWaste",
				label = "Sucatear",
				tunnel = "client"
			}
		},
		distance = 0.75
	})
	
	AddTargetModel({ -1940238623,2108567945 },{
		options = {
			{
				event = "garbageman:searchCoins",
				label = "Vasculhar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddCircleZone("jewelry01",vector3(-626.67,-238.58,38.05),0.75,{
		name = "jewelry01",
		heading = 215.44
	},{
		shop = "1",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry02",vector3(-625.66,-237.86,38.05),0.75,{
		name = "jewelry02",
		heading = 218.27
	},{
		shop = "2",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry03",vector3(-626.84,-235.35,38.05),0.75,{
		name = "jewelry03",
		heading = 31.19
	},{
		shop = "3",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry04",vector3(-625.83,-234.6,38.05),0.75,{
		name = "jewelry04",
		heading = 34.02
	},{
		shop = "4",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry05",vector3(-626.9,-233.15,38.05),0.75,{
		name = "jewelry05",
		heading = 215.44
	},{
		shop = "5",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry06",vector3(-627.94,-233.92,38.05),0.75,{
		name = "jewelry06",
		heading = 218.27
	},{
		shop = "6",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry07",vector3(-620.22,-234.44,38.05),0.75,{
		name = "jewelry07",
		heading = 215.44
	},{
		shop = "7",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry08",vector3(-619.16,-233.7,38.05),0.75,{
		name = "jewelry08",
		heading = 215.44
	},{
		shop = "8",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry09",vector3(-617.56,-230.57,38.05),0.75,{
		name = "jewelry09",
		heading = 303.31
	},{
		shop = "9",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry10",vector3(-618.29,-229.49,38.05),0.75,{
		name = "jewelry10",
		heading = 306.15
	},{
		shop = "10",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry11",vector3(-619.68,-227.63,38.05),0.75,{
		name = "jewelry11",
		heading = 306.15
	},{
		shop = "11",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry12",vector3(-620.43,-226.56,38.05),0.75,{
		name = "jewelry12",
		heading = 306.15
	},{
		shop = "12",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry13",vector3(-623.92,-227.06,38.05),0.75,{
		name = "jewelry13",
		heading = 36.86
	},{
		shop = "13",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry14",vector3(-624.97,-227.84,38.05),0.75,{
		name = "jewelry14",
		heading = 36.86
	},{
		shop = "14",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry15",vector3(-624.42,-231.08,38.05),0.75,{
		name = "jewelry15",
		heading = 303.31
	},{
		shop = "15",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry16",vector3(-623.98,-228.18,38.05),0.75,{
		name = "jewelry16",
		heading = 215.44
	},{
		shop = "16",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry17",vector3(-621.08,-228.58,38.05),0.75,{
		name = "jewelry17",
		heading = 121.89
	},{
		shop = "17",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry18",vector3(-619.72,-230.43,38.05),0.75,{
		name = "jewelry18",
		heading = 119.06
	},{
		shop = "18",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry19",vector3(-620.14,-233.31,38.05),0.75,{
		name = "jewelry19",
		heading = 31.19
	},{
		shop = "19",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry20",vector3(-623.05,-232.95,38.05),0.75,{
		name = "jewelry20",
		heading = 303.31
	},{
		shop = "20",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelryHacker",vector3(-631.38,-230.24,38.05),0.75,{
		name = "jewelryHacker",
		heading = 218.27
	},{
		distance = 0.75,
		options = {
			{
				event = "robberys:Jewelry",
				label = "Hackear",
				tunnel = "client"
			}
		}
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDICMENU
-----------------------------------------------------------------------------------------------------------------------------------------
local paramedicMenu = {
	{
		event = "paramedic:Revive",
		label = "Reanimar",
		tunnel = "paramedic"
	},
	{
		event = "paramedic:Diagnostic",
		label = "Diagnóstico",
		tunnel = "paramedic"
	},
	{
		event = "paramedic:Treatment",
		label = "Tratamento",
		tunnel = "paramedic"
	},
	{
		event = "paramedic:Bleeding",
		label = "Sangramento",
		tunnel = "paramedic"
	},
	{
		event = "paramedic:Bed",
		label = "Deitar Paciente",
		tunnel = "paramedic"
	},
	{
		event = "paramedic:presetBurn",
		label = "Roupa de Queimadura",
		tunnel = "paramedic"
	},
	{
		event = "paramedic:presetPlaster",
		label = "Roupa de Gesso",
		tunnel = "paramedic"
	},
	{
		event = "paramedic:extractBlood",
		label = "Extrair Sangue",
		tunnel = "paramedic"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICEVEH
-----------------------------------------------------------------------------------------------------------------------------------------
local policeVeh = {
	{
		event = "inventory:applyPlate",
		label = "Trocar Placa",
		tunnel = "police"
	},
	{
		event = "police:runPlate",
		label = "Verificar Placa",
		tunnel = "police"
	},
	{
		event = "impound:impound",
		label = "Registrar Veículo",
		tunnel = "police"
	},
	{
		event = "police:runArrest",
		label = "Detenção do Veículo",
		tunnel = "police"
	},
	{
		event = "player:enterTrunk",
		label = "Entrar no Porta-Malas",
		tunnel = "client"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERVEH
-----------------------------------------------------------------------------------------------------------------------------------------
local playerVeh = {
	{
		event = "inventory:applyPlate",
		label = "Trocar Placa",
		tunnel = "server"
	},
	{
		event = "inventory:stealTrunk",
		label = "Arrombar Porta-Malas",
		tunnel = "client"
	},
	{
		event = "player:enterTrunk",
		label = "Entrar no Porta-Malas",
		tunnel = "client"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOCKADEVEH
-----------------------------------------------------------------------------------------------------------------------------------------
local stockadeVeh = {
	{
		event = "inventory:applyPlate",
		label = "Trocar Placa",
		tunnel = "server"
	},
	{
		event = "inventory:stealTrunk",
		label = "Arrombar Porta-Malas",
		tunnel = "client"
	},
	{
		event = "player:enterTrunk",
		label = "Entrar no Porta-Malas",
		tunnel = "client"
	},
	{
		event = "stockade:checkStockade",
		label = "Vasculhar",
		tunnel = "client"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLEVEH
-----------------------------------------------------------------------------------------------------------------------------------------
local dismantleVeh = {
	{
		event = "inventory:applyPlate",
		label = "Trocar Placa",
		tunnel = "server"
	},
	{
		event = "inventory:stealTrunk",
		label = "Arrombar Porta-Malas",
		tunnel = "client"
	},
	{
		event = "player:enterTrunk",
		label = "Entrar no Porta-Malas",
		tunnel = "client"
	},
	{
		event = "dismantle:checkVehicle",
		label = "Desmanchar",
		tunnel = "client"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICEPED
-----------------------------------------------------------------------------------------------------------------------------------------
local policePed = {
	{
		event = "police:runInspect",
		label = "Revistar",
		tunnel = "police"
	},
	{
		event = "police:prisonClothes",
		label = "Uniforme do Presídio",
		tunnel = "police"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMINMENU
-----------------------------------------------------------------------------------------------------------------------------------------
local adminMenu = {
	{
		event = "tryDeleteObject",
		label = "Deletar Objeto",
		tunnel = "admin"
	},
	{
		event = "admin:clearArea",
		label = "Limpar Área",
		tunnel = "admin"
	},
	{
		event = "garages:deleteVehicle",
		label = "Deletar Veículo",
		tunnel = "admin"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERTARGETENABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function playerTargetEnable()
	if playerActive then
		if exports["inventory"]:blockInvents() or exports["player"]:blockCommands() or exports["player"]:handCuff() or success or IsPedArmed(PlayerPedId(),6) or IsPedInAnyVehicle(PlayerPedId()) then
			return
		end

		targetActive = true

		SendNUIMessage({ response = "openTarget" })

		while targetActive do
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local hit,entCoords,entity = RayCastGamePlayCamera(setDistance)

			if hit == 1 then
				innerEntity = {}

				if GetEntityType(entity) ~= 0 then
					if adminService then
						if DoesEntityExist(entity) then
							if #(coords - entCoords) <= setDistance then
								success = true

								NetworkRegisterEntityAsNetworked(entity)
								while not NetworkGetEntityIsNetworked(entity) do
									NetworkRegisterEntityAsNetworked(entity)
									Citizen.Wait(1)
								end

								local netObjects = ObjToNet(entity)
								SetNetworkIdCanMigrate(netObjects,true)
								NetworkSetNetworkIdDynamic(netObjects,false)
								SetNetworkIdExistsOnAllMachines(netObjects,true)

								if IsEntityAVehicle(entity) then
									innerEntity = { netObjects,GetVehicleNumberPlateText(entity) }
								else
									innerEntity = { netObjects }
								end

								SendNUIMessage({ response = "validTarget", data = adminMenu })

								while success and targetActive do
									local ped = PlayerPedId()
									local coords = GetEntityCoords(ped)
									local hit,entCoords,entity = RayCastGamePlayCamera(setDistance)

									DisablePlayerFiring(ped,true)

									if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
										SetCursorLocation(0.5,0.5)
										SetNuiFocus(true,true)
									end

									if GetEntityType(entity) == 0 or #(coords - entCoords) > setDistance then
										success = false
									end

									Citizen.Wait(1)
								end

								SendNUIMessage({ response = "leftTarget" })
							end
						end
					elseif IsEntityAVehicle(entity) then
						if #(coords - entCoords) <= 1.0 then
							success = true

							innerEntity = { GetVehicleNumberPlateText(entity),vRP.vehicleModel(GetEntityModel(entity)),entity,VehToNet(entity) }

							if policeService then
								SendNUIMessage({ response = "validTarget", data = policeVeh })
							else
								local distance = #(coords - vector3(-85.3,-2223.71,7.8))
								if distance > 20 then
									local varMenu = playerVeh

									if GetEntityModel(entity) == 1747439474 then
										varMenu = stockadeVeh
									end

									SendNUIMessage({ response = "validTarget", data = varMenu })
								else
									SendNUIMessage({ response = "validTarget", data = dismantleVeh })
								end
							end

							while success and targetActive do
								local ped = PlayerPedId()
								local coords = GetEntityCoords(ped)
								local hit,entCoords,entity = RayCastGamePlayCamera(setDistance)

								DisablePlayerFiring(ped,true)

								if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
									SetCursorLocation(0.5,0.5)
									SetNuiFocus(true,true)
								end

								if GetEntityType(entity) == 0 or #(coords - entCoords) > 1.0 then
									success = false
								end

								Citizen.Wait(1)
							end

							SendNUIMessage({ response = "leftTarget" })
						end
					elseif IsPedAPlayer(entity) and policeService then
						if #(coords - entCoords) <= 1.0 then
							local index = NetworkGetPlayerIndexFromPed(entity)
							local source = GetPlayerServerId(index)

							success = true
							innerEntity = { source }
							SendNUIMessage({ response = "validTarget", data = policePed })

							while success and targetActive do
								local ped = PlayerPedId()
								local coords = GetEntityCoords(ped)
								local hit,entCoords,entity = RayCastGamePlayCamera(setDistance)

								DisablePlayerFiring(ped,true)

								if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
									SetCursorLocation(0.5,0.5)
									SetNuiFocus(true,true)
								end

								if GetEntityType(entity) == 0 or #(coords - entCoords) > 1.0 then
									success = false
								end

								Citizen.Wait(1)
							end

							SendNUIMessage({ response = "leftTarget" })
						end
					elseif IsPedAPlayer(entity) and paramedicService then
						if #(coords - entCoords) <= 1.0 then
							local index = NetworkGetPlayerIndexFromPed(entity)
							local source = GetPlayerServerId(index)

							success = true
							innerEntity = { source,entity }
							SendNUIMessage({ response = "validTarget", data = paramedicMenu })

							while success and targetActive do
								local ped = PlayerPedId()
								local coords = GetEntityCoords(ped)
								local hit,entCoords,entity = RayCastGamePlayCamera(setDistance)

								DisablePlayerFiring(ped,true)

								if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
									SetCursorLocation(0.5,0.5)
									SetNuiFocus(true,true)
								end

								if GetEntityType(entity) == 0 or #(coords - entCoords) > 1.0 then
									success = false
								end

								Citizen.Wait(1)
							end

							SendNUIMessage({ response = "leftTarget" })
						end
					else
						for k,v in pairs(Models) do
							if DoesEntityExist(entity) then
								if k == GetEntityModel(entity) then
									if #(coords - entCoords) <= Models[k]["distance"] then
										success = true

										if GetPedType(entity) == 28 then
											innerEntity = { entity,k,nil,GetEntityCoords(entity) }
										else
											local netObjects = nil
											if k ~= 1281992692 and k ~= 1158960338 and k ~= 1511539537 then
												NetworkRegisterEntityAsNetworked(entity)
												while not NetworkGetEntityIsNetworked(entity) do
													NetworkRegisterEntityAsNetworked(entity)
													Citizen.Wait(1)
												end

												while not NetworkHasControlOfEntity(entity) do
													NetworkRequestControlOfEntity(entity)
													Citizen.Wait(1)
												end

												netObjects = ObjToNet(entity)
												SetNetworkIdCanMigrate(netObjects,true)
												NetworkSetNetworkIdDynamic(netObjects,false)
												SetNetworkIdExistsOnAllMachines(netObjects,true)
											end

											innerEntity = { entity,k,netObjects,GetEntityCoords(entity) }
										end

										SendNUIMessage({ response = "validTarget", data = Models[k]["options"] })

										while success and targetActive do
											local ped = PlayerPedId()
											local coords = GetEntityCoords(ped)
											local hit,entCoords,entity = RayCastGamePlayCamera(setDistance)

											DisablePlayerFiring(ped,true)

											if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
												SetCursorLocation(0.5,0.5)
												SetNuiFocus(true,true)
											end

											if GetEntityType(entity) == 0 or #(coords - entCoords) > Models[k]["distance"] then
												success = false
											end

											Citizen.Wait(1)
										end

										SendNUIMessage({ response = "leftTarget" })
									end
								end
							end
						end
					end
				end

				for k,v in pairs(Zones) do
					if Zones[k]:isPointInside(entCoords) then
						if #(coords - Zones[k]["center"]) <= v["targetoptions"]["distance"] then
							success = true

							SendNUIMessage({ response = "validTarget", data = Zones[k]["targetoptions"]["options"] })

							if v["targetoptions"]["shop"] ~= nil then
								innerEntity = { v["targetoptions"]["shop"] }
							end

							while success and targetActive do
								local ped = PlayerPedId()
								local coords = GetEntityCoords(ped)
								local hit,entCoords,entity = RayCastGamePlayCamera(setDistance)

								DisablePlayerFiring(ped,true)

								if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
									SetCursorLocation(0.5,0.5)
									SetNuiFocus(true,true)
								end

								if not Zones[k]:isPointInside(entCoords) or #(coords - Zones[k]["center"]) > v["targetoptions"]["distance"] then
									success = false
								end

								Citizen.Wait(1)
							end

							SendNUIMessage({ response = "leftTarget" })
						end
					end
				end
			end

			Citizen.Wait(250)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:ANIMDEITAR
-----------------------------------------------------------------------------------------------------------------------------------------
local beds = {
	[1631638868] = { 0.0,0.0 },
	[2117668672] = { 0.0,0.0 },
	[-1498379115] = { 1.0,90.0 },
	[-1519439119] = { 1.0,0.0 },
	[-289946279] = { 1.0,0.0 }
}

RegisterNetEvent("target:animDeitar")
AddEventHandler("target:animDeitar",function()
	if not exports["player"]:blockCommands() and not exports["player"]:handCuff() then
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
			local objCoords = GetEntityCoords(innerEntity[1])

			SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + beds[innerEntity[2]][1],1,0,0,0)
			SetEntityHeading(ped,GetEntityHeading(innerEntity[1]) + beds[innerEntity[2]][2] - 180.0)

			vRP.playAnim(false,{"anim@gangops@morgue@table@","body_search"},true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:PACIENTEDEITAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:pacienteDeitar")
AddEventHandler("target:pacienteDeitar",function()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	for k,v in pairs(beds) do
		local object = GetClosestObjectOfType(coords["x"],coords["y"],coords["z"],0.9,k,0,0,0)
		if DoesEntityExist(object) then
			local objCoords = GetEntityCoords(object)

			SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + v[1],1,0,0,0)
			SetEntityHeading(ped,GetEntityHeading(object) + v[2] - 180.0)

			vRP.playAnim(false,{"anim@gangops@morgue@table@","body_search"},true)
			break
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:SENTAR
-----------------------------------------------------------------------------------------------------------------------------------------
local chairs = {
	[-171943901] = 0.0,
	[-109356459] = 0.5,
	[1805980844] = 0.5,
	[-99500382] = 0.3,
	[1262298127] = 0.0,
	[1737474779] = 0.5,
	[2040839490] = 0.0,
	[1037469683] = 0.4,
	[867556671] = 0.4,
	[-1521264200] = 0.0,
	[-741944541] = 0.4,
	[-591349326] = 0.5,
	[-293380809] = 0.5,
	[-628719744] = 0.5,
	[-1317098115] = 0.5,
	[1630899471] = 0.5,
	[38932324] = 0.5,
	[-523951410] = 0.5,
	[725259233] = 0.5,
	[764848282] = 0.5,
	[2064599526] = 0.5,
	[536071214] = 0.5,
	[589738836] = 0.5,
	[146905321] = 0.5,
	[47332588] = 0.5,
	[-1118419705] = 0.5,
	[538002882] = -0.1,
	[-377849416] = 0.5,
	[96868307] = 0.5,
	[-1195678770] = 0.7
}

RegisterNetEvent("target:animSentar")
AddEventHandler("target:animSentar",function()
	if not exports["player"]:blockCommands() and not exports["player"]:handCuff() then
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
			local objCoords = GetEntityCoords(innerEntity[1])

			FreezeEntityPosition(innerEntity[1],true)
			SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + chairs[innerEntity[2]],1,0,0,0)
			if chairs[innerEntity[2]] == 0.7 then
				SetEntityHeading(ped,GetEntityHeading(innerEntity[1]))
			else
				SetEntityHeading(ped,GetEntityHeading(innerEntity[1]) - 180.0)
			end

			vRP.playAnim(false,{ task = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" },false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERTARGETDISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function playerTargetDisable()
	if success or not targetActive then
		return
	end

	targetActive = false
	SendNUIMessage({ response = "closeTarget" })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELECTTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("selectTarget",function(data,cb)
	success = false
	targetActive = false
	SetNuiFocus(false,false)
	SendNUIMessage({ response = "closeTarget" })

	if data["tunnel"] == "client" then
		TriggerEvent(data["event"],innerEntity)
	elseif data["tunnel"] == "server" then
		TriggerServerEvent(data["event"],innerEntity)
	elseif data["tunnel"] == "shop" then
		TriggerEvent(data["event"],innerEntity[1])
	elseif data["tunnel"] == "paramedic" then
		TriggerServerEvent(data["event"],innerEntity[1])
	elseif data["tunnel"] == "police" then
		TriggerServerEvent(data["event"],innerEntity,data["service"])
	elseif data["tunnel"] == "objects" then
		TriggerServerEvent(data["event"],innerEntity[3])
	elseif data["tunnel"] == "admin" then
		TriggerServerEvent(data["event"],innerEntity[1],innerEntity[2])
	else
		TriggerServerEvent(data["event"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSETARGET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeTarget",function(data,cb)
	success = false
	targetActive = false
	SetNuiFocus(false,false)
	SendNUIMessage({ response = "closeTarget" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETDEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:resetDebug")
AddEventHandler("target:resetDebug",function()
	success = false
	targetActive = false
	SetNuiFocus(false,false)
	SendNUIMessage({ response = "closeTarget" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATIONTODIRECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function RotationToDirection(rotation)
	local adjustedRotation = {
		x = (math.pi / 180) * rotation["x"],
		y = (math.pi / 180) * rotation["y"],
		z = (math.pi / 180) * rotation["z"]
	}

	local direction = {
		x = -math.sin(adjustedRotation["z"]) * math.abs(math.cos(adjustedRotation["x"])),
		y = math.cos(adjustedRotation["z"]) * math.abs(math.cos(adjustedRotation["x"])),
		z = math.sin(adjustedRotation["x"])
	}

	return direction
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RAYCASTGAMEPLAYCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
function RayCastGamePlayCamera(distance)
	local cameraCoord = GetGameplayCamCoord()
	local cameraRotation = GetGameplayCamRot()
	local direction = RotationToDirection(cameraRotation)

	local destination = {
		x = cameraCoord["x"] + direction["x"] * distance,
		y = cameraCoord["y"] + direction["y"] * distance,
		z = cameraCoord["z"] + direction["z"] * distance
	}

	local a,b,c,d,e = GetShapeTestResult(StartShapeTestRay(cameraCoord["x"],cameraCoord["y"],cameraCoord["z"],destination["x"],destination["y"],destination["z"],-1,PlayerPedId(),0))

	return b,c,e
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCIRCLEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function AddCircleZone(name,center,radius,options,targetoptions)
	Zones[name] = CircleZone:Create(center,radius,options)
	Zones[name]["targetoptions"] = targetoptions
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDPOLYZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function AddPolyzone(name,points,options,targetoptions)
	Zones[name] = PolyZone:Create(points,options)
	Zones[name]["targetoptions"] = targetoptions
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTARGETMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function AddTargetModel(models,parameteres)
	for k,v in pairs(models) do
		Models[v] = parameteres
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddPolyzone",AddPolyzone)
exports("AddCircleZone",AddCircleZone)
exports("AddTargetModel",AddTargetModel)