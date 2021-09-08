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
Tunnel.bindInterface("impound",cRP)
vRPRAGE = Tunnel.getInterface("garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local impoundVehs = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("impound",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") then
			local vehicle,vehNet,vehPlate,vehName = vRPclient.vehList(source,7)
			if vehicle then
				local x,y,z = vRPclient.getPositions(source)
				if impoundVehs[vehName.."-"..vehPlate] == nil then
					impoundVehs[vehName.."-"..vehPlate] = true
					TriggerEvent("towdriver:alertPlayers",x,y,z,vRP.vehicleName(vehName).." - "..vehPlate)
					TriggerClientEvent("Notify",source,"verde","<b>"..vRP.vehicleName(vehName).."</b> foi registrado.",3000)
				else
					TriggerClientEvent("Notify",source,"amarelo","<b>"..vRP.vehicleName(vehName).."</b> já está registrado.",6000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKIMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkImpound()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vehNet,vehPlate,vehName = vRPclient.vehList(source,7)
		if vehicle then
			if impoundVehs[vehName.."-"..vehPlate] == nil then
				return
			else
				local value = math.random(1500,2500)

				impoundVehs[vehName.."-"..vehPlate] = nil
				vRP.giveInventoryItem(user_id,"dollars",parseInt(value),true)
				TriggerClientEvent("sounds:source",source,"cash",0.5)
				vRPRAGE.deleteVehicle(source,vehicle)
			end
		end
	end
end