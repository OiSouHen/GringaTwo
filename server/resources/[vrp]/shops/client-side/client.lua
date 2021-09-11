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
	{ 25.65,-1346.3,29.49,"departamentStore",true,false },
	{ 2556.1,382.04,108.61,"departamentStore",true,false },
	{ 1163.7,-323.9,69.2,"departamentStore",true,false },
	{ -707.32,-914.66,19.21,"departamentStore",true,false },
	{ -48.32,-1757.96,29.42,"departamentStore",true,false },
	{ 374.0,327.3,103.56,"departamentStore",true,false },
	{ -3243.33,1001.25,12.82,"departamentFishs",true,false },
	{ 1729.43,6415.76,35.03,"departamentFishs",true,false },
	{ 548.05,2669.99,42.16,"departamentStore",true,false },
	{ 1960.5,3741.64,32.33,"departamentFishs",true,false },
	{ 2677.6,3281.0,55.23,"departamentStore",true,false },
	{ 1697.91,4924.46,42.06,"departamentStore",true,false },
	{ -1820.33,792.68,138.1,"departamentStore",true,false },
	{ 1392.47,3605.03,34.98,"departamentStore",true,false },
	{ -2967.75,391.55,15.05,"departamentStore",true,false },
	{ -3040.48,585.3,7.9,"departamentStore",true,false },
	{ 1135.65,-982.83,46.4,"departamentStore",true,false },
	{ 1165.38,2709.45,38.15,"departamentStore",true,false },
	{ -1487.64,-378.59,40.15,"departamentStore",true,false },
	{ -1222.29,-906.88,12.32,"departamentStore",true,false },
	{ 1693.2,3760.13,34.69,"ammunationStore",false,false },
	{ 252.61,-50.12,69.94,"ammunationStore",false,false },
	{ 842.37,-1034.01,28.19,"ammunationStore",false,false },
	{ -330.71,6084.1,31.46,"ammunationStore",false,false },
	{ -662.28,-934.85,21.82,"ammunationStore",false,false },
	{ -1305.36,-394.36,36.7,"ammunationStore",false,false },
	{ -1118.1,2698.84,18.55,"ammunationStore",false,false },
	{ 2567.9,293.86,108.73,"ammunationStore",false,false },
	{ -3172.39,1087.88,20.84,"ammunationStore",false,false },
	{ 22.17,-1106.71,29.79,"ammunationStore",false,false },
	{ 810.18,-2157.77,29.62,"ammunationStore",false,false },
	{ -1082.2,-247.51,37.76,"premiumStore",false,false },
	{ -1816.74,-1193.84,14.31,"fishingSell",false,true,{ 8,20 } },
	{ -325.88,6228.45,31.49,"fishingSell",false,true,{ 8,20 } },
	{ 911.1,3644.34,32.67,"fishingSell",false,true,{ 8,20 } },
	{ -695.56,5802.1,17.32,"huntingSell",false,true,{ 8,20 } },
	{ -678.26,5838.62,17.32,"huntingStore",false,true,{ 8,20 } },
	{ -172.5,6380.98,31.48,"pharmacyStore",false,true,{ 8,20 } },
	{ 1690.07,3581.68,35.62,"pharmacyStore",false,true,{ 8,20 } },
	{ 326.5,-1074.43,29.47,"pharmacyStore",false,true,{ 8,20 } },
	{ 114.45,-4.89,67.82,"pharmacyStore",false,true,{ 8,20 } },
	{ 1144.86,-1574.93,35.39,"pharmacyParamedic",false,false },
	{ -254.64,6326.95,32.82,"pharmacyParamedic",false,false },
	{ 45.17,-1750.7,29.64,"mercadoCentral",false,true,{ 6,20 } },
	{ 2748.22,3473.94,55.67,"mercadoCentral",false,true,{ 6,20 } },
	{ -428.57,-1728.35,19.78,"recyclingSell",false,true,{ 6,20 } },
	{ 387.83,799.81,190.5,"policeStore",false,false },
	{ 1843.15,2574.73,46.02,"policeStore",false,false },
	{ -451.87,6013.68,31.72,"policeStore",false,false },
	{ -620.99,-228.69,38.05,"minerShop",false,true,{ 12,18 } },
	{ -732.76,-1737.74,29.17,"ilegalHouse",false,true,{ 18,20 } },
	{ -653.12,-1502.67,5.22,"ilegalHouse",false,true,{ 12,18 } },
	{ -1250.21,-640.39,25.9,"ilegalCosmetics",false,true,{ 20,22 } },
	{ 389.71,-942.61,29.42,"ilegalCosmetics",false,true,{ 20,22 } },
	{ -41.3,-706.57,32.27,"ilegalToys",false,true,{ 12,14 } },
	{ 154.98,-1472.47,29.35,"ilegalToys",false,true,{ 12,14 } },
	{ 488.1,-1456.11,29.28,"ilegalCriminal",false,true,{ 0,2 } },
	{ 1085.31,-1282.5,20.19,"ilegalCriminal",false,true,{ 4,5 } },
	{ 169.76,-1535.88,29.25,"weaponsStore",false,true,{ 4,5 } },
	{ 301.14,-195.75,61.57,"weaponsStore",false,true,{ 4,5 } },
	{ 1154.64,-792.42,57.61,"mechanicTools",false,true,{ 8,20 } },
	{ -345.4,-130.64,39.01,"mechanicTools",false,true,{ 8,20 } },
	{ 737.7,-1089.15,22.16,"mechanicTools",false,true,{ 8,20 } },
	{ 732.52,-1064.08,22.16,"mechanicTools",false,true,{ 8,20 } },
	{ -1146.69,-2002.6,13.18,"mechanicTools",false,true,{ 8,20 } },
	{ 1188.84,2640.88,38.4,"mechanicTools",false,true,{ 8,20 } },
	{ 101.12,6616.41,32.44,"mechanicTools",false,true,{ 8,20 } },
	{ -1421.49,-455.56,35.91,"mechanicTools",false,true,{ 8,20 } },
	{ -1414.6,-451.25,35.91,"mechanicTools",false,true,{ 8,20 } },
	{ -1408.64,-447.52,35.91,"mechanicTools",false,true,{ 8,20 } },
	{ -216.47,-1318.95,30.89,"mechanicTools",false,true,{ 8,20 } },
	{ -197.35,-1320.54,31.09,"mechanicTools",false,true,{ 8,20 } },
	{ -199.41,-1319.8,31.09,"mechanicTools",false,true,{ 8,20 } },
	{ 1112.05,211.53,-49.44,"mcFridge",false,false },
	{ 1109.0,206.14,-49.44,"mcFridge",false,false },
	{ 1115.2,206.59,-49.44,"mcFridge",false,false },
	{ 988.24,-96.46,74.85,"mcFridge",false,false },
	{ 128.42,-1285.49,29.27,"mcFridge",false,false },
	{ -560.24,286.75,82.18,"mcFridge",false,false },
	{ -1636.23,-1091.43,13.52,"oxyStore",false,true,{ 20,22 } },
	{ -801.91,-683.64,29.54,"heroineStore",false,true,{ 04,05 } }
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
	if shopList[shopId][6] then
		if GetClockHours() >= shopList[shopId][7][1] and GetClockHours() <= (shopList[shopId][7][2] - 1) then
			SetNuiFocus(true,true)
			SendNUIMessage({ action = "showNUI", name = shopList[shopId][4], type = vSERVER.getShopType(shopList[shopId][4]) })
		else
			TriggerEvent("Notify","amarelo","Funcionamento das <b>"..shopList[shopId][7][1].."</b> ?s <b>"..shopList[shopId][7][2].."</b> horas.",5000)
		end
	else
		if vSERVER.requestPerm(shopList[shopId][4]) then
			SetNuiFocus(true,true)
			SendNUIMessage({ action = "showNUI", name = shopList[shopId][4], type = vSERVER.getShopType(shopList[shopId][4]) })

			if shopList[shopId][5] then
				TriggerEvent("sounds:source","shop",0.5)
			end
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