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
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local amount = {}
local paymentMin = 150
local paymentMax = 250
-----------------------------------------------------------------------------------------------------------------------------------------
-- paymentService
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentService()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
			TriggerClientEvent("Notify",source,"vermelho","Espaço insuficiente.",5000)
			Wait(1)
		else
			
			vRP.upgradeStress(user_id,1)
			local value = math.random(paymentMin,paymentMax) * amount[source]
			vRP.giveInventoryItem(user_id,"dollars",parseInt(value),true)
			TriggerClientEvent("sound:source",source,"coin",0.5)
			
			amount[source] = nil
			return true
		end
		return false
	end
end