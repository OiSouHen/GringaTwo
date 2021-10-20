-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("lscustoms",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Mechanic") then
		    return true
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LSCUSTOMS:UPDATEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("lscustoms:updateVehicle")
AddEventHandler("lscustoms:updateVehicle",function(mods,plate,name)
    local source = source
    local user_id = vRP.getUserId(source)
	local vehicle,vehNet,vehPlate,vehName = vRPclient.vehList(source,2)
    if user_id then
        local plateUserId = vRP.getVehiclePlate(plate)
        vRP.setSData("custom:"..parseInt(plateUserId)..":"..tostring(vehName),json.encode(mods))
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LSCUSTOMS:ATTEMPTPURCHASE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("lscustoms:attemptPurchase")
AddEventHandler("lscustoms:attemptPurchase",function(type,upgradeLevel)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if type == "engines" or type == "brakes" or type == "transmission" or type == "suspension" or type == "shield" then
			if vRP.paymentBank(user_id,parseInt(vehicleCustomisationPrices[type][upgradeLevel])) then
				TriggerClientEvent("lscustoms:purchaseSuccessful",source)
			else
				TriggerClientEvent("lscustoms:purchaseFailed",source)
			end
		else
			if vRP.paymentBank(user_id,parseInt(vehicleCustomisationPrices[type])) then
				TriggerClientEvent("lscustoms:purchaseSuccessful",source)
			else
				TriggerClientEvent("lscustoms:purchaseFailed",source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHEDIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("vehedit",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
			TriggerClientEvent("lscustoms:openAdmin",source)
		end
	end
end)