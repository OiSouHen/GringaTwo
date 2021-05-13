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
Tunnel.bindInterface("vrp_shops",cnVRP)
vSERVER = Tunnel.getInterface("vrp_shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(data)
	SetNuiFocus(false,false)
	TransitionFromBlurred(1000)
	SendNUIMessage({ action = "hideNUI" })
	Citizen.Wait(350)
	vRP.removeObjects("one")
	vRP.stopAnim()
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
	TriggerServerEvent("vrp_shops:populateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data,cb)
	TriggerServerEvent("vrp_shops:updateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP_SHOPS:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_shops:Update")
AddEventHandler("vrp_shops:Update",function(action)
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
	{ -710.45,-152.37,37.42,"backpackStore"}, -- Perto da Prefeitura
	{ -163.34,-303.63,39.74,"backpackStore"}, -- No Rockford Plaza
	{ 425.32,-806.39,29.5,"backpackStore"}, -- Perto da Antiga Polícia
	{ -822.17,-1073.73,11.33,"backpackStore" }, -- Perto da Waze News
	{ -1192.84,-768.29,17.32,"backpackStore" }, -- Perto do Bahamas
	{ -1449.85,-236.76,49.82,"backpackStore" }, -- Perto do Cemitério
	{ 4.74,6512.43,31.88,"backpackStore" }, -- Em Paleto Bay
	{ 1693.89,4822.52,42.07,"backpackStore" }, -- Sentido North
	{ 125.53,-223.79,54.56,"backpackStore" }, -- Avenida do Banco Central
	{ 614.47,2762.76,42.09,"backpackStore" }, -- Ao lado do Animal ARK
	{ 1196.71,2710.17,38.23,"backpackStore" }, -- Perto da Prisão
	{ -3170.99,1043.79,20.87,"backpackStore" }, -- Pra cima da Praia
	{ -1101.41,2710.59,19.11,"backpackStore" }, -- Rota 68
	{ -1172.09,-1571.89,4.67,"weedStore" }, -- Loja de Maconha na Praia
	{ 1199.96,-3121.15,5.55,"tireStore" }, -- Loja de Peneus na Zona do Porto
	{ 1987.3,3790.47,32.19,"tireStore" }, -- Loja de Peneus no Norte
	{ 1202.6,2647.85,37.81,"toolStore" }, -- Loja de Ferramentas 69
	{ 286.79,2843.75,44.71,"goldminerStore" }, -- Loja de Minérios
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
	{ -622.37,-229.91,38.06,"premiumStore" },
	{ -1563.58,-975.38,13.02,"fishingStore" },
	{ 991.81,-2176.48,29.98,"fishingSell" }, -- Fábrica de carnes
	{ -819.97,-1243.02,7.34,"hospitalpharmacyStore" }, -- Hospital
	{ 318.27,-1076.7,29.48,"normalpharmacyStore" }, -- Do lado da Praça
	{ 229.39,-369.77,-98.78,"registryStore" },
	{ 46.66,-1749.79,29.64,"megaMallStore" },
	{ -419.15,-1686.59,19.03,"recyclingSell" },
	{ -421.39,-1692.72,19.03,"recyclingSell" },
	{ -88.01,31.93,71.96,"cellphoneStore" },
	{ 11.27,-1599.34,29.38,"foodGrill" },
	{ 988.12,-94.62,74.85,"comedyBar" },
	{ 369.78,-1598.18,29.3,"policeStore" },
	{ 911.13,3644.9,32.68,"drugsSelling" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOURS
-----------------------------------------------------------------------------------------------------------------------------------------
function CalculateTimeToDisplay6()
	hour = GetClockHours()
	if hour <= 9 then
		hour = "0" .. hour
	end
end
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
--					DrawText3D(v[1],v[2],v[3],"~g~E~w~  PARA ABRIR")
					if IsControlJustPressed(1,38) and vSERVER.requestPerm(v[4]) then
						CalculateTimeToDisplay6()
						if parseInt(hour) >= 06 and parseInt(hour) <= 23 then
						SetNuiFocus(true,true)
						TransitionToBlurred(1000)
						SendNUIMessage({ action = "showNUI", name = tostring(v[4]), type = vSERVER.getShopType(v[4]) })
						vRP.createObjects("amb@code_human_in_bus_passenger_idles@female@tablet@base","base","prop_cs_tablet",50,28422)
					else
						TriggerEvent("Notify","shop-time","<div style='opacity: 0.7;'><i>Mensagem do Estabelecimento</i></div>Esse estabelecimento funciona apenas das <b>6h</b> até as <b>23h</b>.",10000)
						TriggerEvent("vrp_sound:source","sharp",0.5)
						Wait(10000)
						end
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
	SetTextColour(176,180,193,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/350
	DrawRect(_x,_y+0.0125,0.01+factor,0.04,50,55,67,150)
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
	{ "prop_vend_water_01","waterMachine" }
}

RegisterCommand("comprar",function(source,args)
	local sleep = 500
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	for k,v in pairs(propShops) do
		if DoesObjectOfTypeExistAtCoords(coords,0.7,GetHashKey(v[1]),true) then
			SetNuiFocus(true,true)
			SendNUIMessage({ action = "showNUI", name = tostring(v[2]), type = vSERVER.getShopType(v[2]) })
			vRP.createObjects("amb@code_human_in_bus_passenger_idles@female@tablet@base","base","prop_cs_tablet",50,28422)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPBADFOODSHOPS
-----------------------------------------------------------------------------------------------------------------------------------------
local propBadfoodShops = {
	{ "p_dumpster_t","badfoodSelling" },
	{ "prop_cs_dumpster_01a","badfoodSelling" },
	{ "prop_dumpster_01a","badfoodSelling" },
	{ "prop_dumpster_02a","badfoodSelling" },
	{ "prop_dumpster_02b","badfoodSelling" },
	{ "prop_dumpster_3a","badfoodSelling" },
	{ "prop_dumpster_4a","badfoodSelling" },
	{ "prop_dumpster_4b","badfoodSelling" }
}

RegisterCommand("lixeira",function(source,args)
	local sleep = 500
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	for k,v in pairs(propBadfoodShops) do
		if DoesObjectOfTypeExistAtCoords(coords,0.7,GetHashKey(v[1]),true) then
			SetNuiFocus(true,true)
			SendNUIMessage({ action = "showNUI", name = tostring(v[2]), type = vSERVER.getShopType(v[2]) })
			vRP.createObjects("amb@code_human_in_bus_passenger_idles@female@tablet@base","base","prop_cs_tablet",50,28422)
		end
	end
end)