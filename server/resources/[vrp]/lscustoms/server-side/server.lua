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
-- WEBHOOKS
-----------------------------------------------------------------------------------------------------------------------------------------
local serviceLog = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDWEBHOOKMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LSCUSTOMS:SERVICEMECHANIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("lscustoms:serviceMechanic")
AddEventHandler("lscustoms:serviceMechanic",function(serviceMechanic)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Mechanic") then
			vRP.removePermission(source,"Mechanic")
			TriggerEvent("blipsystem:serviceExit",source)
			TriggerClientEvent("Notify",source,"azul","Saiu de serviço.",3000)
			SendWebhookMessage(serviceLog,"```prolog\n[ID]: "..user_id.."\n[ATIVIDADE]: Saiu de serviço(Mecânico)"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			vRP.execute("vRP/upd_group",{ user_id = user_id, permiss = "Mechanic", newpermiss = "waitMechanic" })
			TriggerClientEvent("lscustoms:updateService",source,false)
		elseif vRP.hasPermission(user_id,"waitMechanic") then
			vRP.insertPermission(source,"Mechanic")
			TriggerEvent("blipsystem:serviceEnter",source,"Mecânico",36)
			TriggerClientEvent("Notify",source,"azul","Entrou em serviço.",3000)
			SendWebhookMessage(serviceLog,"```prolog\n[ID]: "..user_id.."\n[ATIVIDADE]: Entrou em serviço(Mecânico)"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			vRP.execute("vRP/upd_group",{ user_id = user_id, permiss = "waitMechanic", newpermiss = "Mechanic" })
			TriggerClientEvent("lscustoms:updateService",source,true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LSCUSTOMS:CALLMECHANIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("lscustoms:callMechanic")
AddEventHandler("lscustoms:callMechanic",function()
	local source = source
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPositions(source)
	if user_id then
		local amountMecs = vRP.numPermission("Mechanic")
		if parseInt(#amountMecs) <= 0 then
			TriggerClientEvent("Notify",source,"amarelo","Sistema indisponível no momento.",5000)
		else
			for k,v in pairs(amountMecs) do
				async(function()
					TriggerClientEvent("NotifyPush",v,{ time = os.date("%H:%M:%S - %d/%m/%Y"), code = 52, title = "Ligação de um orelhão.", criminal = "Precisa-se de um Mecânico.", x = x, y = y, z = z, rgba = {0,150,90} })
				end)
			end
		end
	end
end)
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