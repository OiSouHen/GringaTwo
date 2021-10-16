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
	[1] = { "glassbottle",math.random(3,4) },
	[2] = { "elastic",math.random(3,4) },
	[3] = { "plasticbottle",math.random(3,4) },
	[4] = { "metalcan",math.random(3,4) },
	[5] = { "battery",math.random(3,4) },
	[6] = { "scrapmetal",math.random(1) },
	[7] = { "titanium",math.random(2) },
	[8] = { "syringe",math.random(1) },
	[9] = { "fabric",math.random(2) },
	[10] = { "metalfragments",math.random(2) }
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
			    return false
		    else
			    local randItem = math.random(#searchTrashItens)
				if math.random(100) <= 90 then
					vRP.giveInventoryItem(user_id,searchTrashItens[randItem][1],parseInt(searchTrashItens[randItem][2]),true)
				else
					TriggerClientEvent("Notify",source,"amarelo","Compartimento vazio.",3000)
				end
				
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
			    return false
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
			    return false
		    else
				vRP.giveInventoryItem(user_id,searchWasteItens[math.random(#searchWasteItens)],math.random(5,6),true)
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHCOINSITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local searchCoinsItens = {
	[1] = "silvercoin",
	[2] = "dollars",
	[3] = "goldcoin"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHCOINS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.searchCoins(id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
	    if timers[id] == 0 or not timers[id] then
		    if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
			    TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			    return false
		    else
				vRP.giveInventoryItem(user_id,searchCoinsItens[math.random(#searchCoinsItens)],math.random(3,6),true)
				timers[id] = 600
				
				vRP.wantedTimer(user_id,10)
				vRP.upgradeStress(user_id,2)
				
				local x,y,z = vRPclient.getPositions(source)
				local copAmount = vRP.numPermission("Police")
				for k,v in pairs(copAmount) do
				    async(function()
				        TriggerClientEvent("NotifyPush",v,{ time = os.date("%H:%M:%S - %d/%m/%Y"), code = 31, title = "Crime em Progresso.", criminal = "Roubo a Parquímetros.", x = x, y = y, z = z, rgba = {41,76,119} })
				    end)
				end
				return true
			end
			
			return false
		else
			TriggerClientEvent("Notify",source,"amarelo","Compartimento vazio.",3000)
		end
	end
end