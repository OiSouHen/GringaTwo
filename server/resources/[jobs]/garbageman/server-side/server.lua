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
			    TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			    Wait(1)
		    else
				if vRP.hasPermission(user_id,"TheLost") then
					local random = math.random(80)
					if parseInt(random) >= 71 then
						vRP.giveInventoryItem(user_id,"glassbottle",math.random(4),true)
						timers[id] = 600
					elseif parseInt(random) >= 61 and parseInt(random) <= 70 then
						vRP.giveInventoryItem(user_id,"elastic",math.random(4),true)
						timers[id] = 600
					elseif parseInt(random) >= 51 and parseInt(random) <= 60 then
						vRP.giveInventoryItem(user_id,"plasticbottle",math.random(4),true)
						timers[id] = 600
					elseif parseInt(random) >= 41 and parseInt(random) <= 50 then
						vRP.giveInventoryItem(user_id,"metalcan",math.random(4),true)
						timers[id] = 600
					elseif parseInt(random) >= 30 and parseInt(random) <= 40 then
						vRP.giveInventoryItem(user_id,"battery",math.random(4),true)
						timers[id] = 600
					elseif parseInt(random) >= 24 and parseInt(random) <= 29 then
						vRP.giveInventoryItem(user_id,"scrapmetal",math.random(6),true)
						timers[id] = 600
					elseif parseInt(random) >= 18 and parseInt(random) <= 23 then
						vRP.giveInventoryItem(user_id,"wheatflour",math.random(2),true)
						timers[id] = 600
					elseif parseInt(random) >= 12 and parseInt(random) <= 17 then
						vRP.giveInventoryItem(user_id,"titanium",math.random(2),true)
						timers[id] = 600
					elseif parseInt(random) >= 6 and parseInt(random) <= 11 then
						vRP.giveInventoryItem(user_id,"syringe",math.random(2),true)
						timers[id] = 600
					elseif parseInt(random) >= 1 and parseInt(random) <= 5 then
						vRP.giveInventoryItem(user_id,"fabric",math.random(3),true)
						timers[id] = 600
					end
				else
					local random = math.random(80)
					if parseInt(random) >= 71 then
						vRP.giveInventoryItem(user_id,"glassbottle",math.random(3),true)
						timers[id] = 600
					elseif parseInt(random) >= 61 and parseInt(random) <= 70 then
						vRP.giveInventoryItem(user_id,"elastic",math.random(3),true)
						timers[id] = 600
					elseif parseInt(random) >= 51 and parseInt(random) <= 60 then
						vRP.giveInventoryItem(user_id,"plasticbottle",math.random(3),true)
						timers[id] = 600
					elseif parseInt(random) >= 41 and parseInt(random) <= 50 then
						vRP.giveInventoryItem(user_id,"metalcan",math.random(3),true)
						timers[id] = 600
					elseif parseInt(random) >= 30 and parseInt(random) <= 40 then
						vRP.giveInventoryItem(user_id,"battery",math.random(3),true)
						timers[id] = 600
					elseif parseInt(random) >= 24 and parseInt(random) <= 29 then
						vRP.giveInventoryItem(user_id,"scrapmetal",math.random(3),true)
						timers[id] = 600
					elseif parseInt(random) >= 18 and parseInt(random) <= 23 then
						vRP.giveInventoryItem(user_id,"wheatflour",math.random(1),true)
						timers[id] = 600
					elseif parseInt(random) >= 12 and parseInt(random) <= 17 then
						vRP.giveInventoryItem(user_id,"titanium",math.random(1),true)
						timers[id] = 600
					elseif parseInt(random) >= 6 and parseInt(random) <= 11 then
						vRP.giveInventoryItem(user_id,"syringe",math.random(1),true)
						timers[id] = 600
					elseif parseInt(random) >= 1 and parseInt(random) <= 5 then
						vRP.giveInventoryItem(user_id,"fabric",math.random(2),true)
						timers[id] = 600
					end
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHOBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.searchObject(id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
	    if timers[id] == 0 or not timers[id] then
		    if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
			    TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			    Wait(1)
		    else
				local random = math.random(100)
				vRP.giveInventoryItem(user_id,"newspaper",math.random(2),true)
				timers[id] = 600
				vRP.upgradeStress(user_id,1)
				return true
			end
			return false
		else
			TriggerClientEvent("Notify",source,"amarelo","Compartimento vazio.",3000)
		end
	end
end