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
Tunnel.bindInterface("tacos",cRP)
vCLIENT = Tunnel.getInterface("tacos")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local amount = {}
local paymentMin = 85
local paymentMax = 115
local consumeItem = "foodbox"
-----------------------------------------------------------------------------------------------------------------------------------------
-- TACOS:FOODBURGER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tacos:foodBurger")
AddEventHandler("tacos:foodBurger",function(foodBurger)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
	    if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
	        TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
		else
		    if vRP.getInventoryItemAmount(user_id,"foodburger") >= 1 then
	            TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
			else
	            vRP.giveInventoryItem(user_id,"foodburger",1,true)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TACOS:FOODJUICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tacos:foodJuice")
AddEventHandler("tacos:foodJuice",function(foodJuice)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
	    if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
	        TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
		else
		    if vRP.getInventoryItemAmount(user_id,"foodjuice") >= 1 then
	            TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
			else
	            vRP.giveInventoryItem(user_id,"foodjuice",1,true)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TACOS:FOODBOX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tacos:foodBox")
AddEventHandler("tacos:foodBox",function(foodBox)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
	    if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
	        TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
		else
		    if vRP.getInventoryItemAmount(user_id,"foodbox") >= 3 then
                TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
			else
				if vRP.getInventoryItemAmount(user_id,"foodburger") >= 1 and vRP.getInventoryItemAmount(user_id,"foodjuice") >= 1 then
				    vRP.tryGetInventoryItem(user_id,"foodburger",1,false)
				    vRP.tryGetInventoryItem(user_id,"foodjuice",1,false)
				    vRP.giveInventoryItem(user_id,"foodbox",1,true)
					itemCheck[locate] = true
					locates[locate][7] = nil

					TriggerClientEvent("tacos:updateItem",-1,locates)
				else
				    TriggerClientEvent("Notify",source,"amarelo","Você não o necessário para fazer um combo.",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentMethod()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,tostring(consumeItem),1,true) then
			vRP.upgradeStress(user_id,1)
			
			local value = math.random(paymentMin,paymentMax)
			vRP.giveInventoryItem(user_id,"dollars",parseInt(value),true)
			TriggerClientEvent("sounds:source",source,"cash",0.5)
			return true
		else
			TriggerClientEvent("Notify",source,"amarelo","Você precisa de <b>1x "..vRP.itemNameList(consumeItem).."</b>.",5000)
		end

		return false
	end
end