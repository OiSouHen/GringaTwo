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
local insertPedlist = {}
--------------------------------------------------------------------------------------------------------------
-- INSERTPEDLIST
--------------------------------------------------------------------------------------------------------------
function cRP.insertPedlist(npc)
    TriggerClientEvent("drugs:insertList",source,npc)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local itemList = {
	{ item = "cocaine", priceMin = 30, priceMax = 35, randMin = 1, randMax = 3, illegal = 1 },
	{ item = "joint", priceMin = 40, priceMax = 45, randMin = 1, randMax = 3, illegal = 1 },
	{ item = "meth", priceMin = 35, priceMax = 40, randMin = 1, randMax = 3, illegal = 1 },
	{ item = "ecstasy", priceMin = 35, priceMax = 40, randMin = 1, randMax = 3, illegal = 1 },
	{ item = "lean", priceMin = 30, priceMax = 35, randMin = 1, randMax = 3, illegal = 1 },
	{ item = "heroine", priceMin = 275, priceMax = 280, randMin = 1, randMax = 3, illegal = 1 },
	{ item = "heroinea", priceMin = 125, priceMax = 130, randMin = 1, randMax = 3, illegal = 1 },
	{ item = "heroineb", priceMin = 125, priceMax = 130, randMin = 1, randMax = 3, illegal = 1 },
	{ item = "heroinec", priceMin = 125, priceMax = 130, randMin = 1, randMax = 3, illegal = 1 },
	{ item = "heroined", priceMin = 125, priceMax = 130, randMin = 1, randMax = 3, illegal = 1 },
	{ item = "heroinee", priceMin = 125, priceMax = 130, randMin = 1, randMax = 3, illegal = 1 },
	{ item = "vest2", priceMin = 125, priceMax = 135, randMin = 1, randMax = 1, illegal = 1 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKAMOUNT1
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkAmount1()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(itemList) do
			local rand = math.random(v.randMin,v.randMax)
			local price = math.random(v.priceMin,v.priceMax)
			
			if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
			    TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
				return false
			else
			    if vRP.getInventoryItemAmount(user_id,v.item) >= parseInt(rand) then
			    	amount[user_id] = { v.item,rand,price }
			    	TriggerClientEvent("drugs:lastItem",source,v.item)
			    	return true
			    end
			end
			
			hasTimer = 0
		end
		
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLISTLEGAL
-----------------------------------------------------------------------------------------------------------------------------------------
local itemListLegal = {
	{ item = "donut", priceMin = 15, priceMax = 20, randMin = 1, randMax = 1 },
	{ item = "chocolate", priceMin = 15, priceMax = 20, randMin = 1, randMax = 3 },
	{ item = "hamburger", priceMin = 15, priceMax = 20, randMin = 1, randMax = 1 },
	{ item = "hotdog", priceMin = 15, priceMax = 20, randMin = 1, randMax = 1 },
	{ item = "water", priceMin = 30, priceMax = 35, randMin = 1, randMax = 3 },
	{ item = "cola", priceMin = 15, priceMax = 20, randMin = 1, randMax = 3 },
	{ item = "soda", priceMin = 15, priceMax = 20, randMin = 1, randMax = 3 },
	{ item = "coffee", priceMin = 20, priceMax = 25, randMin = 1, randMax = 3 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKAMOUNT2
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkAmount2()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(itemListLegal) do
			local rand = math.random(v.randMin,v.randMax)
			local price = math.random(v.priceMin,v.priceMax)
			
			if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
			    TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
				return false
			else
			    if vRP.getInventoryItemAmount(user_id,v.item) >= parseInt(rand) then
			    	amount[user_id] = { v.item,rand,price }
			    	TriggerClientEvent("drugs:lastItem",source,v.item)
			    	return true
			    end
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
			if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
			    TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			    return false
			else
			    local value = amount[user_id][3] * amount[user_id][2]
				
			    vRP.giveInventoryItem(user_id,"dollars2",parseInt(value),true)
			    TriggerClientEvent("sounds:source",source,"cash",0.5)
			    vRP.wantedTimer(user_id,10)
			    vRP.upgradeStress(user_id,2)
			end
			
			local x,y,z = vRPclient.getPositions(source)
			local copAmount = vRP.numPermission("Police")
			for k,v in pairs(copAmount) do
				async(function()
					TriggerClientEvent("NotifyPush",v,{ time = os.date("%H:%M:%S - %d/%m/%Y"), code = 31, title = "Crime em Progresso.", criminal = "Denúncia de Venda de Drogas.", x = x, y = y, z = z, rgba = {41,76,119} })
				end)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHODLEGAL
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentMethodLegal()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,amount[user_id][1],amount[user_id][2],true) then
			if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
			    TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			    return false
			else
			    local value = amount[user_id][3] * amount[user_id][2]
				
			    vRP.giveInventoryItem(user_id,"dollars",parseInt(value),true)
			    TriggerClientEvent("sounds:source",source,"cash",0.5)
			    vRP.upgradeStress(user_id,1)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERYITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local robberyItens = {
	[1] = "joint",
	[2] = "cellphone",
	[3] = "donut",
	[4] = "water",
	[5] = "emptybottle",
	[6] = "elastic",
	[7] = "backpack",
	[8] = "key",
	[9] = "vest",
	[10] = "lean",
	[11] = "cocaine",
	[12] = "dewars",
	[13] = "cola",
	[14] = "chocolate",
	[15] = "heroine"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentRobbery()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			return false
		else
			vRP.giveInventoryItem(user_id,robberyItens[math.random(#robberyItens)],math.random(1,3),true)
			vRP.wantedTimer(user_id,10)
			vRP.upgradeStress(user_id,4)
		end
		
		local x,y,z = vRPclient.getPositions(source)
		local copAmount = vRP.numPermission("Police")
		for k,v in pairs(copAmount) do
			async(function()
				TriggerClientEvent("NotifyPush",v,{ time = os.date("%H:%M:%S - %d/%m/%Y"), code = 31, title = "Crime em Progresso.", criminal = "Denúncia de Roubo a Americano.", x = x, y = y, z = z, rgba = {41,76,119} })
			end)
		end
	end
end