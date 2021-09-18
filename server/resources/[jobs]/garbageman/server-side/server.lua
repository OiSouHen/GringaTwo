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
-- SEARCHTRASHITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local searchTrashItens = {
	[1] = "glassbottle",
	[2] = "elastic",
	[3] = "plasticbottle",
	[4] = "metalcan",
	[5] = "battery",
	[6] = "scrapmetal",
	[7] = "titanium",
	[8] = "syringe",
	[9] = "fabric",
	[10] = "metalfragments"
}
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
			    vRP.giveInventoryItem(user_id,searchTrashItens[math.random(#searchTrashItens)],math.random(1,3),true)
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHOBJECTITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local searchObjectItens = {
	[1] = "newspaper"
}
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
				vRP.giveInventoryItem(user_id,searchObjectItens[math.random(#searchObjectItens)],math.random(1,3),true)
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHWASTEITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local searchWasteItens = {
	[1] = "scrapmetal"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHWASTE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.searchWaste(id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
	    if timers[id] == 0 or not timers[id] then
		    if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
			    TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			    Wait(1)
		    else
				vRP.giveInventoryItem(user_id,searchWasteItens[math.random(#searchWasteItens)],math.random(3,6),true)
				timers[id] = 600
				
				vRP.upgradeStress(user_id,3)
				return true
			end
			return false
		else
			TriggerClientEvent("Notify",source,"amarelo","Compartimento vazio.",3000)
		end
	end
end