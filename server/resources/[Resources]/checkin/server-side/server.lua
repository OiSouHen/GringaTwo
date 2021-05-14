-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("checkin",cnVRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSERVICES
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkServices()
	local amountMedics = vRP.numPermission("Paramedic")
	if parseInt(#amountMedics) > 1 then
		TriggerClientEvent("Notify",source,"vermelho","Existem médicos em serviço.",5000)
		Wait(5000)
		return false
	end
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTCHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.paymentCheckin()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
	  --if vRP.hasPermission(user_id,"Police") then
	  --   return true
	  --end

		local value = 500
		if GetEntityHealth(GetPlayerPed(source)) <= 101 then
			value = value + 1000
		end

		if vRP.tryGetInventoryItem(user_id,"dollars",parseInt(value)) then
		    TriggerClientEvent("Notify",source,"verde","Você pagou <b>$"..value.."</b> dólares pelo atendimento.",5000)
			return true
		else
			TriggerClientEvent("Notify",source,"vermelho","Você não tem <b>$"..value.."</b> dólares.",5000)
			Wait(5000)
		end
	end
	return false
end