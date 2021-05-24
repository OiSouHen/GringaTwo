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
	{ 25.65,-1346.3,29.49,"departamentStore" },
	{ 2556.1,382.04,108.61,"departamentStore" },
	{ 1163.7,-323.9,69.2,"departamentStore" },
	{ -707.32,-914.66,19.21,"departamentStore" },
	{ -48.32,-1757.96,29.42,"departamentStore" },
	{ 374.0,327.3,103.56,"departamentStore" },
	{ -3243.33,1001.25,12.82,"departamentFishs" },
	{ 1729.43,6415.76,35.03,"departamentStore" },
	{ 548.05,2669.99,42.16,"departamentStore" },
	{ 1960.5,3741.64,32.33,"departamentStore" },
	{ 2677.6,3281.0,55.23,"departamentStore" },
	{ 1697.91,4924.46,42.06,"departamentStore" },
	{ -1820.33,792.68,138.1,"departamentStore" },
	{ 1392.47,3605.03,34.98,"departamentStore" },
	{ -2967.75,391.55,15.05,"departamentStore" },
	{ -3040.48,585.3,7.9,"departamentStore" },
	{ 1135.65,-982.83,46.4,"departamentStore" },
	{ 1165.38,2709.45,38.15,"departamentStore" },
	{ -1487.64,-378.59,40.15,"departamentStore" },
	{ -1222.29,-906.88,12.32,"departamentStore" },
	{ 1693.2,3760.13,34.69,"ammunationStore" },
	{ 252.61,-50.12,69.94,"ammunationStore" },
	{ 842.37,-1034.01,28.19,"ammunationStore" },
	{ -330.71,6084.1,31.46,"ammunationStore" },
	{ -662.28,-934.85,21.82,"ammunationStore" },
	{ -1305.36,-394.36,36.7,"ammunationStore" },
	{ -1118.1,2698.84,18.55,"ammunationStore" },
	{ 2567.9,293.86,108.73,"ammunationStore" },
	{ -3172.39,1087.88,20.84,"ammunationStore" },
	{ 22.17,-1106.71,29.79,"ammunationStore" },
	{ 810.18,-2157.77,29.62,"ammunationStore" },
	{ -1082.2,-247.51,37.76,"premiumStore" },
	{ -1816.74,-1193.84,14.31,"fishingSell" },
	{ -695.56,5802.1,17.32,"huntingSell" },
	{ -678.26,5838.62,17.32,"huntingStore" },
	{ -172.32,6385.85,31.49,"pharmacyStore" },
	{ 1690.07,3581.68,35.62,"pharmacyStore" },
	{ 326.47,-1074.43,29.47,"pharmacyStore" },
	{ 114.45,-4.89,67.82,"pharmacyStore" },
	{ 311.97,-597.66,43.29,"pharmacyParamedic" },
	{ 1825.6,3667.98,34.27,"pharmacyParamedic" },
	{ -254.64,6326.95,32.82,"pharmacyParamedic" },
	{ 46.69,-1749.77,29.62,"mercadoCentral" },
	{ 2747.31,3473.08,55.67,"mercadoCentral" },
	{ -428.57,-1728.35,19.78,"recyclingSell" },
	{ 988.24,-96.46,74.85,"mcFridge" },
	{ 128.42,-1285.49,29.27,"mcFridge" },
	{ -560.24,286.75,82.18,"mcFridge" },
	{ 487.3,-997.08,30.68,"policeStore" },
	{ 1845.67,3692.58,34.26,"policeStore" },
	{ -449.8,6010.25,31.71,"policeStore" },
	{ -620.99,-228.69,38.05,"minerShop" },
	{ 719.03,-961.58,30.4,"ilegalSelling" },
	{ -1636.23,-1091.43,13.52,"oxyStore" },
	{ 1154.64,-792.42,57.61,"mechanicTools" },
	{ -345.4,-130.64,39.01,"mechanicTools" },
	{ 737.7,-1089.15,22.16,"mechanicTools" },
	{ 732.52,-1064.08,22.16,"mechanicTools" },
	{ -1146.69,-2002.6,13.18,"mechanicTools" },
	{ 1188.84,2640.88,38.4,"mechanicTools" },
	{ 101.12,6616.41,32.44,"mechanicTools" },
	{ -1421.49,-455.56,35.91,"mechanicTools" },
	{ -1414.6,-451.25,35.91,"mechanicTools" },
	{ -1408.64,-447.52,35.91,"mechanicTools" },
	{ -40.06,-1056.43,28.39,"mechanicTools" },
	{ -32.09,-1039.12,28.59,"mechanicTools" },
	{ -33.48,-1040.76,28.59,"mechanicTools" },
	{ -216.47,-1318.95,30.89,"mechanicTools" },
	{ -197.35,-1320.54,31.09,"mechanicTools" },
	{ -199.41,-1319.8,31.09,"mechanicTools" },
	{ 562.45,2741.11,42.82,"animalStore" }
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
					if IsControlJustPressed(1,38) and vSERVER.requestPerm(v[4]) then
						if GetClockHours() >= 15 and GetClockHours() <= 20 then
						SetNuiFocus(true,true)
						SendNUIMessage({ action = "showNUI", name = tostring(v[4]), type = vSERVER.getShopType(v[4]) })
						TriggerEvent("sounds:source","shop",0.5)
					else
						TriggerEvent("Notify","amarelo","Loja fechada, a mesma só funciona das <b>15</b> ás <b>20</b> horas.",3000)
						end
					end
				end
			end
		end
		
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:COFFEEMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:coffeeMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("coffeeMachine"), type = vSERVER.getShopType("coffeeMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:SODAMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:sodaMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("sodaMachine"), type = vSERVER.getShopType("sodaMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:DONUTMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:donutMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("donutMachine"), type = vSERVER.getShopType("donutMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:BURGERMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:burgerMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("burgerMachine"), type = vSERVER.getShopType("burgerMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:HOTDOGMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:hotdogMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("hotdogMachine"), type = vSERVER.getShopType("hotdogMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:WATERMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:waterMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("waterMachine"), type = vSERVER.getShopType("waterMachine") })
	SetNuiFocus(true,true)
end)