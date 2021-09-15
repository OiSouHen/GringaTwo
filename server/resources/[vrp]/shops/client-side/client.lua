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
Tunnel.bindInterface("shops",cRP)
vSERVER = Tunnel.getInterface("shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(data)
	SetNuiFocus(false,false)
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
-- UPDATESHOPS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateShops(action)
	SendNUIMessage({ action = action })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:Update")
AddEventHandler("shops:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local shopList = {
	{ 25.65,-1346.3,29.49,"departamentStore",true },
	{ 2556.1,382.04,108.61,"departamentStore",true },
	{ 1163.7,-323.9,69.2,"departamentStore",true },
	{ -707.32,-914.66,19.21,"departamentStore",true },
	{ -48.32,-1757.96,29.42,"departamentStore",true },
	{ 374.0,327.3,103.56,"departamentStore",true },
	{ -3243.33,1001.25,12.82,"departamentStore",true },
	{ 1729.43,6415.76,35.03,"departamentStore",true },
	{ 548.05,2669.99,42.16,"departamentStore",true },
	{ 1960.5,3741.64,32.33,"departamentStore",true },
	{ 2677.6,3281.0,55.23,"departamentStore",true },
	{ 1697.91,4924.46,42.06,"departamentStore",true },
	{ -1820.33,792.68,138.1,"departamentStore",true },
	{ 1392.47,3605.03,34.98,"departamentStore",true },
	{ -2967.75,391.55,15.05,"departamentStore",true },
	{ -3040.48,585.3,7.9,"departamentStore",true },
	{ 1135.65,-982.83,46.4,"departamentStore",true },
	{ 1165.38,2709.45,38.15,"departamentStore",true },
	{ -1487.64,-378.59,40.15,"departamentStore",true },
	{ -1222.29,-906.88,12.32,"departamentStore",true },
	{ 1693.2,3760.13,34.69,"ammunationStore",false },
	{ 252.61,-50.12,69.94,"ammunationStore",false },
	{ 842.37,-1034.01,28.19,"ammunationStore",false },
	{ -330.71,6084.1,31.46,"ammunationStore",false },
	{ -662.28,-934.85,21.82,"ammunationStore",false },
	{ -1305.36,-394.36,36.7,"ammunationStore",false },
	{ -1118.1,2698.84,18.55,"ammunationStore",false },
	{ 2567.9,293.86,108.73,"ammunationStore",false },
	{ -3172.39,1087.88,20.84,"ammunationStore",false },
	{ 22.17,-1106.71,29.79,"ammunationStore",false },
	{ 810.18,-2157.77,29.62,"ammunationStore",false },
	{ -1082.2,-247.51,37.76,"premiumStore",false },
	{ 1524.68,3782.23,34.51,"fishingSell",false },
	{ -695.56,5802.1,17.32,"huntingSell",false },
	{ -678.26,5838.62,17.32,"huntingStore",false },
	{ -172.5,6380.98,31.48,"pharmacyStore",false },
	{ 1690.07,3581.68,35.62,"pharmacyStore",false },
	{ 326.5,-1074.43,29.47,"pharmacyStore",false },
	{ 114.45,-4.89,67.82,"pharmacyStore",false },
	{ 311.97,-597.66,43.29,"pharmacyParamedic",false },
	{ 1825.6,3667.98,34.27,"pharmacyParamedic",false },
	{ -254.64,6326.95,32.82,"pharmacyParamedic",false },
	{ 45.17,-1750.7,29.64,"mercadoCentral",false },
	{ 2748.22,3473.94,55.67,"mercadoCentral",false },
	{ -428.57,-1728.35,19.78,"recyclingSell",false },
	{ 487.3,-997.08,30.68,"policeStore",false },
	{ 1845.67,3692.58,34.26,"policeStore",false },
	{ -449.8,6010.25,31.71,"policeStore",false },
	{ 385.5,799.94,190.49,"policeStore",false },
	{ -620.99,-228.69,38.05,"minerShop",false },
	{ -732.76,-1737.74,29.17,"ilegalHouse",false },
	{ -1250.21,-640.39,25.9,"ilegalCosmetics",false },
	{ -41.3,-706.57,32.27,"ilegalToys",false },
	{ 1085.31,-1282.5,20.19,"ilegalCriminal",false },
	{ -653.12,-1502.67,5.22,"ilegalHouse",false },
	{ 389.71,-942.61,29.42,"ilegalCosmetics",false },
	{ 154.98,-1472.47,29.35,"ilegalToys",false },
	{ 488.1,-1456.11,29.28,"ilegalCriminal",false },
	{ 169.76,-1535.88,29.25,"weaponsStore",false },
	{ 301.14,-195.75,61.57,"weaponsStore",false },
	{ 1154.64,-792.42,57.61,"mechanicTools",false },
	{ -345.4,-130.64,39.01,"mechanicTools",false },
	{ 737.7,-1089.15,22.16,"mechanicTools",false },
	{ 732.52,-1064.08,22.16,"mechanicTools",false },
	{ -1146.69,-2002.6,13.18,"mechanicTools",false },
	{ 1188.84,2640.88,38.4,"mechanicTools",false },
	{ 101.12,6616.41,32.44,"mechanicTools",false },
	{ -1421.49,-455.56,35.91,"mechanicTools",false },
	{ -1414.6,-451.25,35.91,"mechanicTools",false },
	{ -1408.64,-447.52,35.91,"mechanicTools",false },
	{ -216.47,-1318.93,30.89,"mechanicTools",false },
	{ -197.35,-1320.54,31.09,"mechanicTools",false },
	{ -199.41,-1319.8,31.09,"mechanicTools",false },
	{ 121.8,-3024.81,7.04,"mechanicTools",false },
	{ 128.7,-3050.9,7.04,"mechanicTools",false },
	{ 1523.69,3782.48,34.51,"fishDepartament",true },
	{ 563.32,2751.7,42.87,"animalStore",false },
	{ 1112.05,211.53,-49.44,"mcFridge",false },
	{ 1109.0,206.14,-49.44,"mcFridge",false },
	{ 1115.2,206.59,-49.44,"mcFridge",false },
	{ 988.24,-96.46,74.85,"mcFridge",false },
	{ 128.42,-1285.49,29.27,"mcFridge",false },
	{ -560.24,286.75,82.18,"mcFridge",false },
	{ 148.04,-3014.7,7.04,"mcFridge",false },
	{ -1636.23,-1091.43,13.52,"oxyStore",false }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	for k,v in pairs(shopList) do
		exports["target"]:AddCircleZone("shops:"..k,vector3(v[1],v[2],v[3]),1.25,{
			name = "shops:"..k,
			heading = 0.0
		},{
			shop = k,
			distance = 1.0,
			options = {
				{
					event = "shops:openSystem",
					label = "Abrir",
					tunnel = "shop"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:openSystem",function(shopId)
	if vSERVER.requestPerm(shopList[shopId][4]) then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "showNUI", name = shopList[shopId][4], type = vSERVER.getShopType(shopList[shopId][4]) })

		if shopList[shopId][5] then
			TriggerEvent("sounds:source","shop",0.5)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:COFFEEMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:coffeeMachine",function()
	SendNUIMessage({ action = "showNUI", name = "coffeeMachine", type = vSERVER.getShopType("coffeeMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:SODAMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:sodaMachine",function()
	SendNUIMessage({ action = "showNUI", name = "sodaMachine", type = vSERVER.getShopType("sodaMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:COLAMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:colaMachine",function()
	SendNUIMessage({ action = "showNUI", name = "colaMachine", type = vSERVER.getShopType("colaMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:DONUTMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:donutMachine",function()
	SendNUIMessage({ action = "showNUI", name = "donutMachine", type = vSERVER.getShopType("donutMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:BURGERMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:burgerMachine",function()
	SendNUIMessage({ action = "showNUI", name = "burgerMachine", type = vSERVER.getShopType("burgerMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:HOTDOGMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:hotdogMachine",function()
	SendNUIMessage({ action = "showNUI", name = "hotdogMachine", type = vSERVER.getShopType("hotdogMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:WATERMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:waterMachine",function()
	SendNUIMessage({ action = "showNUI", name = "waterMachine", type = vSERVER.getShopType("waterMachine") })
	SetNuiFocus(true,true)
end)