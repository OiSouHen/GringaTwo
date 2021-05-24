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
	{ 325.6,-1074.38,29.48,"normalpharmacyStore" },
	{ 306.74,-601.9,43.29,"hospitalpharmacyStore" },
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
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local innerTable = {}
	for k,v in pairs(shopList) do
		table.insert(innerTable,{ v[1],v[2],v[3],1,"E","Loja de Utilidades","Pressione para abrir" })
	end

	TriggerEvent("hoverfy:insertTable",innerTable)
end)
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
				if distance <= 1 then
					timeDistance = 4

					if IsControlJustPressed(1,38) then
						if v[6] then
							if GetClockHours() >= 15 and GetClockHours() <= 20 then
								SetNuiFocus(true,true)
								SendNUIMessage({ action = "showNUI", name = tostring(v[4]), type = vSERVER.getShopType(v[4]) })
							else
								TriggerEvent("Notify","amarelo","Loja fechada, a mesma só funciona das <b>15</b> ás <b>20</b> horas.",3000)
							end
						else
							if vSERVER.requestPerm(v[4]) then
								SetNuiFocus(true,true)
								SendNUIMessage({ action = "showNUI", name = tostring(v[4]), type = vSERVER.getShopType(v[4]) })

								if v[5] then
									TriggerEvent("sounds:source","shop",0.5)
								end
							end
						end
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPSHOPS
-----------------------------------------------------------------------------------------------------------------------------------------
local propShops = {
	{ "prop_vend_coffe_01","coffeeMachine" },
	{ "prop_vend_soda_02","sodaMachine" },
	{ "prop_vend_soda_01","colaMachine" },
	{ "v_ret_247_donuts","donutMachine" },
	{ "prop_burgerstand_01","burgerMachine" },
	{ "prop_hotdogstand_01","burgerMachine" }, --hotdogMachine
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