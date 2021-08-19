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
Tunnel.bindInterface("garbageman",cRP)
vCLIENT = Tunnel.getInterface("garbageman")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local timers = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(timers) do
			if v > 0 then
				timers[k] = v - 1
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHTRASH
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.searchTrash(id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
	    if timers[id] == 0 or not timers[id] then
		    if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
			    TriggerClientEvent("Notify",source,"vermelho","Espaço insuficiente.",5000)
			    Wait(1)
		    else
				
				local random = math.random(100)
				if parseInt(random) >= 87 then
					vRP.giveInventoryItem(user_id,"glassbottle",math.random(3),true)
					timers[id] = 600
				elseif parseInt(random) >= 76 and parseInt(random) <= 86 then
					vRP.giveInventoryItem(user_id,"elastic",math.random(3),true)
					timers[id] = 600
				elseif parseInt(random) >= 56 and parseInt(random) <= 75 then
					vRP.giveInventoryItem(user_id,"plasticbottle",math.random(3),true)
					timers[id] = 600
				elseif parseInt(random) >= 31 and parseInt(random) <= 55 then
					vRP.giveInventoryItem(user_id,"metalcan",math.random(3),true)
					timers[id] = 600
				elseif parseInt(random) >= 11 and parseInt(random) <= 30 then
					vRP.giveInventoryItem(user_id,"battery",math.random(3),true)
					timers[id] = 600
				elseif parseInt(random) >= 6 and parseInt(random) <= 10 then
					vRP.giveInventoryItem(user_id,"wheatflour",math.random(1),true)
					timers[id] = 600
				elseif parseInt(random) >= 0 and parseInt(random) <= 5 then
					vRP.giveInventoryItem(user_id,"titanium",math.random(1),true)
					timers[id] = 600
				end
				
				vRP.upgradeStress(user_id,1)

				return true
			end
			return false
		else
			TriggerClientEvent("Notify",source,"amarelo","Compartimento vazio.",3000)
		end
	end
end