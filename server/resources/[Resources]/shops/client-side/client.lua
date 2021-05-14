-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("shops",cnVRP)
vSERVER = Tunnel.getInterface("shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(data)
	SetNuiFocus(false,false)
	TransitionFromBlurred(1000)
	SendNUIMessage({ action = "hideNUI" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestShop",function(data,cb)
	local inventoryShop,inventoryUser,weight,maxweight,infos = vSERVER.requestShop(data.shop)
	if inventoryShop then
		cb({ inventoryShop = inventoryShop, inventoryUser = inventoryUser, weight = weight, maxweight = maxweight, infos = infos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("functionShops",function(data,cb)
	vSERVER.functionShops(data.shop,data.item,data.amount,data.slot)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("populateSlot",function(data,cb)
	TriggerServerEvent("shops:populateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data,cb)
	TriggerServerEvent("shops:updateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- shops:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:Update")
AddEventHandler("shops:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local shopList = {
	{ 25.76,-1347.49,29.5,"departamentStore" }, -- Perto do Vanilla
	{ 2556.47,382.05,108.63,"departamentStore" }, -- Posto North Avenida
	{ 1163.55,-323.02,69.21,"departamentStore" }, -- Perto da Barragen
	{ -707.31,-913.75,19.22,"departamentStore" }, -- Perto da Waze News
	{ -47.72,-1757.23,29.43,"departamentStore" }, -- Perto dos Ballas
	{ 373.89,326.86,103.57,"departamentStore" }, -- Perto do Banco Central
	{ -3242.95,1001.28,12.84,"departamentStore" }, -- Perto do Deck
	{ 1729.3,6415.48,35.04,"departamentStore" }, -- Perto do Tunel Palleto
	{ 548.0,2670.35,42.16,"departamentStore" }, -- Perto do Animal Ark
	{ 1960.69,3741.34,32.35,"departamentStore" }, -- Perto do North Avenue
	{ 2677.92,3280.85,55.25,"departamentStore" }, -- Perto do Desmanche
	{ 1698.5,4924.09,42.07,"departamentStore" }, -- Perto da Fazenda
	{ -1820.82,793.21,138.12,"departamentStore" }, -- Posto Canyon Drive
	{ 1393.21,3605.26,34.99,"departamentStore" }, -- Loja abandonada no North
	{ -2967.78,390.92,15.05,"departamentStore" }, -- Banco pra cima da Praia
	{ -3040.14,585.44,7.91,"departamentStore" }, -- Na Praia Afastada
	{ 1135.56,-982.24,46.42,"departamentStore" }, -- Depois da Ponte da DP Praça
	{ 1166.0,2709.45,38.16,"departamentStore" }, -- Perto da Prisão
	{ -1487.21,-378.99,40.17,"departamentStore" }, -- Perto do Centro
	{ -1222.76,-907.21,12.33,"departamentStore" }, -- Perto do Pier Príncipal
	{ 75.4,-1393.01,29.38,"backpackStore" }, -- Perto do Vanilla
	{ -1172.09,-1571.89,4.67, "weedStore" } , -- Loja de Maconha na Praia
	{ 1692.62,3759.50,34.70,"ammunationStore" },
	{ 252.89,-49.25,69.94,"ammunationStore" },
	{ 843.28,-1034.02,28.19,"ammunationStore" },
	{ -331.35,6083.45,31.45,"ammunationStore" },
	{ -663.15,-934.92,21.82,"ammunationStore" },
	{ -1305.18,-393.48,36.69,"ammunationStore" },
	{ -1118.80,2698.22,18.55,"ammunationStore" },
	{ 2568.83,293.89,108.73,"ammunationStore" },
	{ -3172.68,1087.10,20.83,"ammunationStore" },
	{ 21.32,-1106.44,29.79,"ammunationStore" },
	{ 811.19,-2157.67,29.61,"ammunationStore" },
	{ -1082.22,-247.54,37.77,"premiumStore" },
	{ -1563.58,-975.38,13.02,"fishingStore" },
	{ -1591.95,-1005.87,13.03,"fishingSell" },
	{ 306.74,-601.9,43.29,"pharmacyStore" },
	{ 229.39,-369.77,-98.78,"registryStore" },
	{ 46.66,-1749.79,29.64,"megaMallStore" },
	{ -428.56,-1728.33,19.79,"recyclingSell" },
	{ -656.84,-857.51,24.5,"digitalDen" },
	{ 392.7,-831.61,29.3,"digitalDen" },
	{ -41.37,-1036.79,28.49,"digitalDen" },
	{ -509.38,278.8,83.33,"digitalDen" },
	{ 1137.52,-470.69,66.67,"digitalDen" },
	{ 11.27,-1599.34,29.38,"foodGrill" },
	{ 988.12,-94.62,74.85,"comedyBar" },
	{ 369.78,-1598.18,29.3,"policeStore" },
	{ 911.13,3644.9,32.68,"drugsSelling" }
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(shopList) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 1.5 then
					timeDistance = 4
--					DrawText3D(v[1],v[2],v[3],"MENTALIZE ~g~E~w~ PARA ABRIR")
					if IsControlJustPressed(1,38) and vSERVER.requestPerm(v[4]) then
						SetNuiFocus(true,true)
						TransitionToBlurred(1000)
						SendNUIMessage({ action = "showNUI", name = tostring(v[4]), type = vSERVER.getShopType(v[4]) })
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 450
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPSHOPS
-----------------------------------------------------------------------------------------------------------------------------------------
local propShops = {
	{ "prop_vend_coffe_01","coffeeMachine" },
	{ "prop_vend_soda_02","sodaMachine" },
	{ "prop_vend_soda_01","colaMachine" },
	{ "v_ret_247_donuts","donutMachine" },
	{ "prop_burgerstand_01","burgerMachine" },
	{ "prop_hotdogstand_01","hotdogMachine" },
	{ "prop_vend_water_01","waterMachine" }
}

RegisterCommand("comprar",function(source,args)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	for k,v in pairs(propShops) do
		if DoesObjectOfTypeExistAtCoords(coords,0.7,GetHashKey(v[1]),true) then
			SetNuiFocus(true,true)
			SendNUIMessage({ action = "showNUI", name = tostring(v[2]), type = vSERVER.getShopType(v[2]) })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local pedlist = {

-- 20 departamentStore 
	{ ['x'] = 24.51, ['y'] = -1347.27, ['z'] = 29.5, ['h'] = 261.02, ['hash'] = 0xD15D7E71, ['hash2'] = "a_m_m_ktown_01"}, -- Perto do Vanilla
	{ ['x'] = 2557.15, ['y'] = 380.71, ['z'] = 108.63, ['h'] = 350.7, ['hash'] = 0xD15D7E71, ['hash2'] = "a_m_m_ktown_01"}, -- Posto North Avenida
	{ ['x'] = 1164.73, ['y'] = -322.66, ['z'] = 69.21, ['h'] = 99.48, ['hash'] = 0xD15D7E71, ['hash2'] = "a_m_m_ktown_01"}, -- Perto da Barragen
	{ ['x'] = -706.16, ['y'] = -913.63, ['z'] = 19.22, ['h'] = 89.09, ['hash'] = 0xD15D7E71, ['hash2'] = "a_m_m_ktown_01"}, -- Perto da Waze News
	{ ['x'] = -46.7, ['y'] = -1757.85, ['z'] = 29.43, ['h'] = 49.43, ['hash'] = 0xD15D7E71, ['hash2'] = "a_m_m_ktown_01"}, -- Perto dos Ballas
	{ ['x'] = 372.56, ['y'] = 326.44, ['z'] = 103.57, ['h'] = 260.89, ['hash'] = 0xD15D7E71, ['hash2'] = "a_m_m_ktown_01"}, -- Perto do Banco Central
	{ ['x'] = -3242.23, ['y'] = 999.97, ['z'] = 12.84, ['h'] = 352.58, ['hash'] = 0xD15D7E71, ['hash2'] = "a_m_m_ktown_01"}, -- Perto do Deck
	{ ['x'] = 1727.86, ['y'] = 6415.3, ['z'] = 35.04, ['h'] = 238.52, ['hash'] = 0xD15D7E71, ['hash2'] = "a_m_m_ktown_01"}, -- Perto do Tunel Palleto
	{ ['x'] = 549.14, ['y'] = 2671.29, ['z'] = 42.16, ['h'] = 92.83, ['hash'] = 0xD15D7E71, ['hash2'] = "a_m_m_ktown_01"}, -- Perto do Animal Ark
	{ ['x'] = 1960.04, ['y'] = 3740.11, ['z'] = 32.35, ['h'] = 300.19, ['hash'] = 0xD15D7E71, ['hash2'] = "a_m_m_ktown_01"}, -- Perto do North Avenue
	{ ['x'] = 2677.9, ['y'] = 3279.42, ['z'] = 55.25, ['h'] = 322.63, ['hash'] = 0xD15D7E71, ['hash2'] = "a_m_m_ktown_01"}, -- Perto do Desmanche
	{ ['x'] = 1698.06, ['y'] = 4922.92, ['z'] = 42.07, ['h'] = 315.58, ['hash'] = 0xD15D7E71, ['hash2'] = "a_m_m_ktown_01"}, -- Perto da Fazenda
	{ ['x'] = -1820.16, ['y'] = 794.29, ['z'] = 138.09, ['h'] = 130.71, ['hash'] = 0xD15D7E71, ['hash2'] = "a_m_m_ktown_01"}, -- Posto Canyon Drive
	{ ['x'] = 1392.74, ['y'] = 3606.39, ['z'] = 34.99, ['h'] = 184.36, ['hash'] = 0x917ED459, ['hash2'] = "mp_m_weed_01"}, -- Loja abandonada no North
	{ ['x'] = -2966.35, ['y'] = 391.02, ['z'] = 15.05, ['h'] = 93.07, ['hash'] = 0xD15D7E71, ['hash2'] = "a_m_m_ktown_01"}, -- Banco pra cima da Praia
	{ ['x'] = -3039.01, ['y'] = 584.45, ['z'] = 7.91, ['h'] = 14.95, ['hash'] = 0xD15D7E71, ['hash2'] = "a_m_m_ktown_01"}, -- Na Praia Afastada
	{ ['x'] = 1134.16, ['y'] = -982.44, ['z'] = 46.42, ['h'] = 279.52, ['hash'] = 0xD15D7E71, ['hash2'] = "a_m_m_ktown_01"}, -- Depois da Ponte da DP Praça
	{ ['x'] = 1165.89, ['y'] = 2710.82, ['z'] = 38.16, ['h'] = 177.46, ['hash'] = 0xB1BB9B59, ['hash2'] = "s_m_y_prisoner_01"}, -- Perto da Prisão
	{ ['x'] = -1486.21, ['y'] = -377.97, ['z'] = 40.17, ['h'] = 136.67, ['hash'] = 0xD15D7E71, ['hash2'] = "a_m_m_ktown_01"}, -- Perto do Centro
	{ ['x'] = -1221.94, ['y'] = -908.37, ['z'] = 12.33, ['h'] = 33.74, ['hash'] = 0xC79F6928, ['hash2'] = "a_f_y_beach_01"}, -- Perto do Pier Príncipal
	
-- 1 fishingSell
    { ['x'] = 991.91, ['y'] = -2175.43, ['z'] = 29.98, ['h'] = 182.48, ['hash'] = 0x4163A158, ['hash2'] = "s_m_y_factory_01"}, -- Fábrica de carnes
	{ ['x'] = 991.23, ['y'] = -2183.83, ['z'] = 30.68, ['h'] = 94.63, ['hash'] = 0x4163A158, ['hash2'] = "s_m_y_factory_01"}, -- Matadouro da fábrica de carnes
	{ ['x'] = 962.0, ['y'] = -2109.92, ['z'] = 31.95, ['h'] = 84.02, ['hash'] = 0x14D7B4E0, ['hash2'] = "s_m_m_dockwork_01"}, -- Pegar veículo na fábrica de carnes
	{ ['x'] = 970.27, ['y'] = -2181.42, ['z'] = 29.98, ['h'] = 165.58, ['hash'] = 0xFCFA9E1E, ['hash2'] = "a_c_cow"}, -- Vaca
	{ ['x'] = 982.85, ['y'] = -2183.34, ['z'] = 30.67, ['h'] = 265.12, ['hash'] = 0xB11BAB56, ['hash2'] = "a_c_pig"}, -- Porco

-- 1 backpackStore
    { ['x'] = 73.99, ['y'] = -1393.05, ['z'] = 29.38, ['h'] = 265.06, ['hash'] = 0x445AC854, ['hash2'] = "a_f_y_bevhills_01"}, -- Perto do Vanilla
	{ ['x'] = -709.02, ['y'] = -151.54, ['z'] = 37.42, ['h'] = 123.5, ['hash'] = 0x445AC854, ['hash2'] = "a_f_y_bevhills_01"}, -- Perto da Prefeitura
	{ ['x'] = -165.09, ['y'] = -303.19, ['z'] = 39.74, ['h'] = 251.93, ['hash'] = 0x445AC854, ['hash2'] = "a_f_y_bevhills_01"}, -- No Rockford Plaza
	{ ['x'] = 427.06, ['y'] = -806.23, ['z'] = 29.5, ['h'] = 85.88, ['hash'] = 0x445AC854, ['hash2'] = "a_f_y_bevhills_01"}, -- Perto da Antiga Polícia
	{ ['x'] = -823.15, ['y'] = -1072.28, ['z'] = 11.33, ['h'] = 205.58, ['hash'] = 0x445AC854, ['hash2'] = "a_f_y_bevhills_01"}, -- Perto da Waze News
	{ ['x'] = -1193.92, ['y'] = -767.02 , ['z'] = 17.32, ['h'] = 209.75, ['hash'] = 0x445AC854, ['hash2'] = "a_f_y_bevhills_01"}, -- Perto do Bahamas
	{ ['x'] = -1448.76, ['y'] = -237.87, ['z'] = 49.82, ['h'] = 47.44, ['hash'] = 0x445AC854, ['hash2'] = "a_f_y_bevhills_01"}, -- Perto do Cemitério
	{ ['x'] = 5.97, ['y'] = 6511.48, ['z'] = 31.88, ['h'] = 44.83, ['hash'] = 0x445AC854, ['hash2'] = "a_f_y_bevhills_01"}, -- Em Paleto Bay
	{ ['x'] = 1695.36, ['y'] = 4822.95, ['z'] = 42.07, ['h'] = 98.0, ['hash'] = 0x445AC854, ['hash2'] = "a_f_y_bevhills_01"}, -- Sentido North
	{ ['x'] = 127.0, ['y'] = -224.2, ['z'] = 54.56, ['h'] = 71.23, ['hash'] = 0x445AC854, ['hash2'] = "a_f_y_bevhills_01"}, -- Avenida do Banco Central
	{ ['x'] = 612.95, ['y'] = 2762.66, ['z'] = 42.09, ['h'] = 266.26, ['hash'] = 0x445AC854, ['hash2'] = "a_f_y_bevhills_01"}, -- Ao lado do Animal ARK
	{ ['x'] = 1196.64, ['y'] = 2711.63, ['z'] = 38.23, ['h'] = 178.79, ['hash'] = 0x445AC854, ['hash2'] = "a_f_y_bevhills_01"}, -- Perto da Prisão
	{ ['x'] = -3169.4, ['y'] = 1043.13, ['z'] = 20.87, ['h'] = 64.8, ['hash'] = 0x445AC854, ['hash2'] = "a_f_y_bevhills_01"}, -- Pra cima da Praia
	{ ['x'] = -1102.35, ['y'] = 2711.72, ['z'] = 19.11, ['h'] = 215.38, ['hash'] = 0x445AC854, ['hash2'] = "a_f_y_bevhills_01"}, -- Rota 68

-- 1 tireStore
    { ['x'] = 1208.58, ['y'] = -3115.36, ['z'] = 5.55, ['h'] = 267.65, ['hash'] = 0x441405EC, ['hash2'] = "s_m_y_xmech_01"}, -- Na zona do porto
	{ ['x'] = 1199.03, ['y'] = -3121.63, ['z'] = 5.55, ['h'] = 300.76, ['hash'] = 0x441405EC, ['hash2'] = "s_m_y_xmech_02"}, -- Na zona do porto
	{ ['x'] = 1986.48, ['y'] = 3789.67, ['z'] = 32.19, ['h'] = 295.75, ['hash'] = 0x441405EC, ['hash2'] = "s_m_y_xmech_01"}, -- No norte

-- 1 toolStore
    { ['x'] = 1203.78, ['y'] = 2647.17, ['z'] = 37.81, ['h'] = 47.87, ['hash'] = 0x441405EC, ['hash2'] = "s_m_y_xmech_01"}, -- Rota 69

-- 1 cellphoneStore
    { ['x'] = -86.31, ['y'] = 31.57, ['z'] = 71.96, ['h'] = 76.27, ['hash'] = 0x445AC854, ['hash2'] = "a_f_y_bevhills_01"}, -- Loja de Eletrônicos

-- 1 premiumStore
    { ['x'] = -623.09, ['y'] = -229.22, ['z'] = 38.06, ['h'] = 200.48, ['hash'] = 0x36DF2D5D, ['hash2'] = "a_f_y_bevhills_04"}, -- Joalheria

-- 1 weedStore
    { ['x'] = -1170.73, ['y'] = -1570.53, ['z'] = 4.67, ['h'] = 123.18, ['hash'] = 0x0DE9A30A, ['hash2'] = "s_m_m_ammucountry"} -- Loja de Maconha na Praia
}

Citizen.CreateThread(function()
	for k,v in pairs(pedlist) do
		RequestModel(GetHashKey(v.hash2))
		
		while not HasModelLoaded(GetHashKey(v.hash2)) do
			Citizen.Wait(100)
		end
		
		local ped = CreatePed(4,v.hash,v.x,v.y,v.z-1,v.h,false,true)
--		FreezeEntityPosition(ped,true) Congelar peds
--		SetEntityInvincible(ped,true) Peds imortais
--		SetBlockingOfNonTemporaryEvents(ped,true) Peds sem reações
	end
end)