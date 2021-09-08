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
Tunnel.bindInterface("airforce",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- paymentService
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentService(status)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local value = math.random(175,255)

		if not status then
			vRP.giveInventoryItem(user_id,"dollars",parseInt(value),true)
		else
			vRP.giveInventoryItem(user_id,"dollars",parseInt(value),true)
		end

		TriggerClientEvent("sounds:source",source,"cash",0.5)
	end
end