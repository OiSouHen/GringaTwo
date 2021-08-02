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
Tunnel.bindInterface("atm",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTWANTED
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestWanted()
 	local source = source
 	local user_id = vRP.getUserId(source)
 	if user_id then
 		if not vRP.wantedReturn(user_id) then
 			return true
 		end
 		return false
 	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATMTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
local atmTimers = {}
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(atmTimers) do
			if v[1] > 0 then
				v[1] = v[1] - 10
				if v[1] <= 0 then
					atmTimers[k] = nil
				end
			end
		end
		Citizen.Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANKDEPOSIT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.bankDeposit(amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if parseInt(amount) > 0 then
			if vRP.tryGetInventoryItem(user_id,"dollars",parseInt(amount)) then
				vRP.addBank(user_id,parseInt(amount))
				TriggerClientEvent("bank:Update",source,"hide")
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANWITHDRAW
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.bankWithdraw(amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then

		local getInvoice = vRP.getInvoice(user_id)
		if getInvoice[1] ~= nil then
			TriggerClientEvent("Notify",source,"amarelo","Encontramos faturas pendentes.",5000)
			return
		end

		local getFines = vRP.getFines(user_id)
		if getFines[1] ~= nil then
			TriggerClientEvent("Notify",source,"amarelo","Encontramos multas pendentes.",5000)
			return
		end

		if parseInt(amount) > 0 then
			if vRP.computeInvWeight(user_id) + vRP.itemWeightList("dollars") * parseInt(amount) <= vRP.getBackpack(user_id) then
				if vRP.withdrawCash(user_id,parseInt(amount)) then
					TriggerClientEvent("bank:Update",source,"hide")
				else
					TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente na sua conta bancária.",5000)
				end
			else
				TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",3000)
			end
		end
	end
end