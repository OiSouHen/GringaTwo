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
				vRPRAGE.deleteVehicle(source,vehicle)
			end
		end
	end
end