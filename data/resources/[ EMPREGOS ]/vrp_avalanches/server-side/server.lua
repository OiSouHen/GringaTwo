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
Tunnel.bindInterface("vrp_avalanches",cnVRP)
vCLIENT = Tunnel.getInterface("vrp_avalanches")
-----------------------------------------------------------------------------------------------------------------------------------------
-- AVALANCHES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("avalanches",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		vCLIENT.toggleService(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.paymentMethod(status)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not status then
			vRP.giveInventoryItem(user_id,"water",1,true)
			vRP.giveInventoryItem(user_id,"hamburger",1,true)
			vRP.giveInventoryItem(user_id,"vest",1,true)
		else
			vRP.giveInventoryItem(user_id,"water",1,true)
			vRP.giveInventoryItem(user_id,"hamburger",1,true)
			vRP.giveInventoryItem(user_id,"vest",1,true)
		end
--		TriggerClientEvent("vrp_sound:source",source,"coin",0.5)
	end
end