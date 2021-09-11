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
Tunnel.bindInterface("crafting",cRP)
vSERVER = Tunnel.getInterface("crafting")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideNUI" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestCrafting",function(data,cb)
	local inventoryCraft,inventoryUser,weight,maxweight,infos = vSERVER.requestCrafting(data["craft"])
	if inventoryCraft then
		cb({ inventoryCraft = inventoryCraft, inventoryUser = inventoryUser, weight = weight, maxweight = maxweight, infos = infos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONCRAFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("functionCraft",function(data,cb)
	vSERVER.functionCrafting(data["index"],data["craft"],data["amount"],data["slot"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONDESTROY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("functionDestroy",function(data,cb)
	vSERVER.functionDestroy(data["index"],data["craft"],data["amount"],data["slot"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("populateSlot",function(data,cb)
	TriggerServerEvent("crafting:populateSlot",data["item"],data["slot"],data["target"],data["amount"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data,cb)
	TriggerServerEvent("crafting:updateSlot",data["item"],data["slot"],data["target"],data["amount"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateCrafting(action)
	SendNUIMessage({ action = action })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:Update")
AddEventHandler("crafting:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local craftList = {
	{ 2431.48,4967.33,42.34,314.65,"blackMarket",{ 1,5 } },
	{ -1196.82,-901.51,13.99,216.02,"makeFoods" },
	{ 713.95,-961.54,30.4,0.0,"dressMaker" },
	{ 82.45,-1553.26,29.59,229.61,"lixeiroShop" },
	{ 287.36,2843.6,44.7,306.15,"lixeiroShop" },
	{ -413.68,6171.99,31.48,136.07,"lixeiroShop" },
	{ 103.64,-1995.3,14.88,68.04,"Ballas" },
	{ 429.46,-2051.93,18.74,232.45,"Vagos" },
	{ -199.52,-1700.26,29.39,36.86,"Families" },
	{ 469.93,-1745.24,25.54,158.75,"Aztecas" },
	{ 228.33,-1752.9,25.24,323.15,"Bloods" },
	{ 986.95,-93.05,74.85,226.78,"TheLost" },
	{ -1001.06,-1025.97,2.19,119.06,"Triads" },
	{ 1145.45,-1660.41,36.48,209.77,"EastSide" },
	{ 1393.8,1131.17,109.74,87.88,"Madrazo" },
	{ 1406.19,-1543.42,54.71,144.57,"Marabunta" },
	{ -1117.68,-1555.83,0.98,215.44,"Crips" },
	{ 1272.26,-1712.57,54.76,204.1,"ilegalWeapons" },
	{ 1160.52,-782.38,57.61,269.3,"mechanicShop" },
	{ -1425.5,-456.98,35.91,124.73,"mechanicShop" },
	{ -196.8,-1314.67,31.09,0.0,"mechanicShop" },
	{ -344.84,-128.0,39.01,70.87,"mechanicShop" },
	{ 735.16,-1063.91,22.16,0.0,"mechanicShop" },
	{ -1144.54,-2004.18,13.18,317.49,"mechanicShop" },
	{ 1181.02,2635.52,37.74,184.26,"mechanicShop" },
	{ 102.99,6625.73,31.78,42.52,"mechanicShop" },
	{ -37.37,-1036.48,28.59,70.87,"mechanicShop" },
	{ 47.16,-1748.32,29.64,235.28,"legalShop" },
	{ 2747.36,3471.78,55.67,62.37,"legalShop" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	for k,v in pairs(craftList) do
		exports["target"]:AddCircleZone("crafting:"..k,vector3(v[1],v[2],v[3]),1.0,{
			name = "crafting:"..k,
			heading = v[4]
		},{
			shop = k,
			distance = 1.0,
			options = {
				{
					event = "crafting:openSystem",
					label = "Abrir",
					tunnel = "shop"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("crafting:openSystem",function(shopId)
	if craftList[shopId][6] then
		if GetClockHours() >= craftList[shopId][6][1] and GetClockHours() <= (craftList[shopId][6][2] - 1) then
			if vSERVER.requestPerm(craftList[shopId][5]) then
				SetNuiFocus(true,true)
				SendNUIMessage({ action = "showNUI", name = craftList[shopId][5] })
			end
		else
			TriggerEvent("Notify","amarelo","Funcionamento das <b>"..craftList[shopId][6][1].."</b> às <b>"..craftList[shopId][6][2].."</b> horas.",5000)
		end
	else
		if vSERVER.requestPerm(craftList[shopId][5]) then
			SetNuiFocus(true,true)
			SendNUIMessage({ action = "showNUI", name = craftList[shopId][5] })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:FUELSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("crafting:fuelShop",function()
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "showNUI", name = "fuelShop" })
end)