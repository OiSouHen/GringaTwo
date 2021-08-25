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
Tunnel.bindInterface("lumberman",cRP)
vCLIENT = Tunnel.getInterface("lumberman")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local collect = {}
local collectMin = 2
local collectMax = 4

local amount = {}
local amountMin = 3
local amountMax = 6

local paymentMin = 125
local paymentMax = 175
local consumeItem = "woodlog"
-----------------------------------------------------------------------------------------------------------------------------------------
-- AMOUNTCOLLECT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.amountCollect()
	local source = source
	if collect[source] == nil then
		collect[source] = math.random(collectMin,collectMax)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- AMOUNTSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.amountService()
	local source = source
	if amount[source] == nil then
		amount[source] = math.random(amountMin,amountMax)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLLECTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.collectMethod()
	cRP.amountCollect()

	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.computeInvWeight(user_id) + vRP.itemWeightList(tostring(consumeItem)) * parseInt(collect[source]) <= vRP.getBackpack(user_id) then
			vRPclient.stopActived(source)
			vRP.giveInventoryItem(user_id,tostring(consumeItem),parseInt(collect[source]),true)
			vRP.upgradeStress(user_id,1)
			collect[source] = nil

			return true
		end
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentMethod()
	cRP.amountService()

	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,tostring(consumeItem),parseInt(amount[source])) then
			vRP.upgradeStress(user_id,1)
			local value = math.random(paymentMin,paymentMax) * amount[source]

			vRP.giveInventoryItem(user_id,"dollars",parseInt(value),true)
			TriggerClientEvent("sound:source",source,"coin",0.5)
			amount[source] = nil

			return true
		else
			TriggerClientEvent("Notify",source,"amarelo","Você precisa de <b>"..vRP.format(parseInt(amount[source])).."x "..vRP.itemNameList(consumeItem).."</b>.",5000)
		end

		return false
	end
end