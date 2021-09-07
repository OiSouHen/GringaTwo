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
Tunnel.bindInterface("harvest",cRP)
vCLIENT = Tunnel.getInterface("harvest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local collect = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLLECTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.collectMethod()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			Wait(1)
		else

			local random = math.random(100)
			if parseInt(random) >= 76 then
				vRP.giveInventoryItem(user_id,"orange",math.random(3),true)
			elseif parseInt(random) >= 66 and parseInt(random) <= 75 then
				vRP.giveInventoryItem(user_id,"strawberry",math.random(3),true)
			elseif parseInt(random) >= 56 and parseInt(random) <= 65 then
				vRP.giveInventoryItem(user_id,"grape",math.random(3),true)
			elseif parseInt(random) >= 46 and parseInt(random) <= 55 then
				vRP.giveInventoryItem(user_id,"tange",math.random(3),true)
			elseif parseInt(random) >= 36 and parseInt(random) <= 45 then
				vRP.giveInventoryItem(user_id,"banana",math.random(3),true)
			elseif parseInt(random) >= 26 and parseInt(random) <= 35 then
				vRP.giveInventoryItem(user_id,"passion",math.random(3),true)
			elseif parseInt(random) >= 1 and parseInt(random) <= 25 then
				vRP.giveInventoryItem(user_id,"tomato",math.random(4),true)
			end
			
			vRP.upgradeStress(user_id,1)
			
			collect[source] = nil
			return true
		end
		return false
	end
end