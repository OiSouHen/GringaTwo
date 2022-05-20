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
Tunnel.bindInterface("hunting",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local collect = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMALPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.animalPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			Wait(1)
		else
			
			local random = math.random(100)
			if parseInt(random) >= 86 then
				vRP.giveInventoryItem(user_id,"meatA",math.random(3),true)
				vRP.giveInventoryItem(user_id,"animalpelt",math.random(2),true)
			elseif parseInt(random) >= 61 and parseInt(random) <= 85 then
				vRP.giveInventoryItem(user_id,"meatB",math.random(3),true)
				vRP.giveInventoryItem(user_id,"animalpelt",math.random(1),true)
			elseif parseInt(random) >= 31 and parseInt(random) <= 60 then
				vRP.giveInventoryItem(user_id,"meatC",math.random(3),true)
				vRP.giveInventoryItem(user_id,"animalpelt",math.random(2),true)
			elseif parseInt(random) >= 0 and parseInt(random) <= 30 then
				vRP.giveInventoryItem(user_id,"meatS",math.random(3),true)
				vRP.giveInventoryItem(user_id,"animalpelt",math.random(1),true)
			end
			
			vRP.upgradeStress(user_id,3)
			
			collect[source] = nil
			return true
		end
		return false
	end
end