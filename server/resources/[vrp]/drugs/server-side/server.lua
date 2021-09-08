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
Tunnel.bindInterface("drugs",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local amount = {}
local hasTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local itemList = {
	{ item = "cocaine", priceMin = 45, priceMax = 95, randMin = 1, randMax = 3 },
	{ item = "joint", priceMin = 35, priceMax = 85, randMin = 1, randMax = 3 },
	{ item = "meth", priceMin = 105, priceMax = 170, randMin = 1, randMax = 3 },
	{ item = "ecstasy", priceMin = 65, priceMax = 95, randMin = 1, randMax = 3 },
	{ item = "lean", priceMin = 75, priceMax = 135, randMin = 1, randMax = 3 },
	{ item = "heroine", priceMin = 95, priceMax = 195, randMin = 1, randMax = 3 },
	{ item = "vest2", priceMin = 95, priceMax = 185, randMin = 1, randMax = 1 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKAMOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkAmount()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(itemList) do
			local rand = math.random(v.randMin,v.randMax)
			local price = math.random(v.priceMin,v.priceMax)
			if vRP.getInventoryItemAmount(user_id,v.item) >= parseInt(rand) then
				amount[user_id] = { v.item,rand,price }
				TriggerClientEvent("drugs:lastItem",source,v.item)
				return true
			end
			
			hasTimer = 0
		end
		
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentMethod()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,amount[user_id][1],amount[user_id][2],true) then
			vRP.upgradeStress(user_id,2)
			local value = amount[user_id][3] * amount[user_id][2]
			vRP.giveInventoryItem(user_id,"dollars2",parseInt(value),true)
			TriggerClientEvent("sounds:source",source,"cash",0.5)
			
			vRP.wantedTimer(user_id,5)
			vRP.upgradeStress(user_id,2)
			
			local x,y,z = vRPclient.getPositions(source)
			local copAmount = vRP.numPermission("Police")
			for k,v in pairs(copAmount) do
				async(function()
					TriggerClientEvent("NotifyPush",v,{ time = os.date("%H:%M:%S - %d/%m/%Y"), code = 20, title = "Denúncia de Venda de Drogas", x = x, y = y, z = z, rgba = {41,76,119} })
				end)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentRobbery()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local random = math.random(100)
		if parseInt(random) >= 50 then
			vRP.giveInventoryItem(user_id,"dollars",math.random(500),true)
		elseif parseInt(random) >= 0 and parseInt(random) <= 49 then
			vRP.giveInventoryItem(user_id,"dollars2",math.random(500),true)
		end
		
		vRP.wantedTimer(user_id,10)
		vRP.upgradeStress(user_id,4)
		
		TriggerClientEvent("sounds:source",source,"cash",0.5)
		
		local x,y,z = vRPclient.getPositions(source)
		local copAmount = vRP.numPermission("Police")
		for k,v in pairs(copAmount) do
			async(function()
				TriggerClientEvent("NotifyPush",v,{ time = os.date("%H:%M:%S - %d/%m/%Y"), code = 20, title = "Denúncia de Roubo a Americano", x = x, y = y, z = z, rgba = {41,76,119} })
			end)
		end
	end
end