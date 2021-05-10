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
Tunnel.bindInterface("vrp_skinshop",cnVRP)
vCLIENT = Tunnel.getInterface("vrp_skinshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkOpen()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.wantedReturn(user_id) and not vRP.reposeReturn(user_id) then
			return true
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.updateClothes(clothes,demand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		-- if demand then
		-- 	local valor = math.random(100,350)
		-- 	if vRP.paymentBank(user_id,valor) then
		-- 		TriggerClientEvent("Notify",source,"sucesso","Voce pagou $"..valor.." em roupas.",5000)
		-- 	else
		-- 		TriggerClientEvent("Notify",source,"negado","Voce nao tem dinheiro.",5000)
		-- 	end
		-- end
		vRP.setUData(user_id,"Clothings",clothes)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("skin",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") and args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.applySkin(nplayer,GetHashKey(args[2]))
				vRP.updateSelectSkin(parseInt(args[1]),GetHashKey(args[2]))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("mascara",function(source,args)
	local user_id = vRP.getUserId(source)
	local action = args[1]
	if user_id then
		if action then
			if action == "true" or action == "1" then
				local item,texture = vCLIENT.getMask(source)
				TriggerClientEvent("vrp_skinshop:setMask",source,{ item,texture })
			elseif action == "false" or action == "0" then
				TriggerClientEvent("vrp_skinshop:setMask",source)
			end
		else
			TriggerClientEvent("vrp_skinshop:setMask",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("chapeu",function(source,args)
	local user_id = vRP.getUserId(source)
	local action = args[1]
	if user_id then
		if action then
			if action == "true" or action == "1" then
				local item,texture = vCLIENT.getHat(source)
				TriggerClientEvent("vrp_skinshop:setHat",source,{ item,texture })
			elseif action == "false" or action == "0" then
				TriggerClientEvent("vrp_skinshop:setHat",source)
			end
		else
			TriggerClientEvent("vrp_skinshop:setHat",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("oculos",function(source,args)
	local user_id = vRP.getUserId(source)
	local action = args[1]
	if user_id then
		if action then
			if action == "true" or action == "1" then
				local item,texture = vCLIENT.getGlasses(source)
				TriggerClientEvent("vrp_skinshop:setGlasses",source,{ item,texture })
			elseif action == "false" or action == "0" then
				TriggerClientEvent("vrp_skinshop:setGlasses",source)
			end
		else
			TriggerClientEvent("vrp_skinshop:setGlasses",source)
		end
	end
end)