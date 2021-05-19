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
cnVRP = {}
Tunnel.bindInterface("harvest",cnVRP)
vCLIENT = Tunnel.getInterface("harvest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local collect = {}
local collectMin = 1
local collectMax = 2
local amount = {}
local amountMin = 2
local amountMax = 3
local consumeItem = "pouch"
-----------------------------------------------------------------------------------------------------------------------------------------
-- harvest
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Colheita",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		vCLIENT.toggleService(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AMOUNTCOLLECT
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.amountCollect()
	local source = source
	if collect[source] == nil then
		collect[source] = math.random(collectMin,collectMax)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- AMOUNTSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.amountService()
	local source = source
	if amount[source] == nil then
		amount[source] = math.random(amountMin,amountMax)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLLECTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.collectMethod()
	cnVRP.amountCollect()

	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
			TriggerClientEvent("Notify",source,"vermelho","Espaço insuficiente.",5000)
			Wait(1)
		else
			vRPclient.stopActived(source)
			TriggerClientEvent("Progress",source,4000,"Colhendo...")
			vRP.upgradeStress(user_id,1)
			vRPclient._playAnim(source,false,{"amb@prop_human_movie_bulb@base","base"},false)
			
			local random = math.random(100)
			if parseInt(random) >= 81 then
				vRP.giveInventoryItem(user_id,"plastic",math.random(8),true)
			elseif parseInt(random) >= 61 and parseInt(random) <= 80 then
				vRP.giveInventoryItem(user_id,"glass",math.random(8),true)
			elseif parseInt(random) >= 41 and parseInt(random) <= 60 then
				vRP.giveInventoryItem(user_id,"rubber",math.random(6),true)
			elseif parseInt(random) >= 26 and parseInt(random) <= 40 then
				vRP.giveInventoryItem(user_id,"aluminum",math.random(5),true)
			elseif parseInt(random) >= 10 and parseInt(random) <= 25 then
				vRP.giveInventoryItem(user_id,"copper",math.random(5),true)
			end
			
			collect[source] = nil
			TriggerClientEvent("cancelando",source,true)
			return true
		end
		return false
	end
end