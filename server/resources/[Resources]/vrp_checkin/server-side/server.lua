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
Tunnel.bindInterface("vrp_checkin",cnVRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSERVICES
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkServices()
	local amountMedics = vRP.numPermission("Paramedic")
	if parseInt(#amountMedics) > 1 then
		TriggerClientEvent("Notify",source,"life-hospital2","<div style='opacity: 0.7;'><i>Aviso do Hospital</i></div>Você não pode fazer um autoatendimento porque existem médicos em serviço.",5000)
		TriggerClientEvent("vrp_sound:source",source,"when",0.5)
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
		if vRP.hasPermission(user_id,"Police") then
			return true
		end

		local value = 500
		if GetEntityHealth(GetPlayerPed(source)) <= 101 then
			value = value + 1000
		end

		if vRP.tryGetInventoryItem(user_id,"dollars",parseInt(value)) then
			return true
		else
			TriggerClientEvent("Notify",source,"life-hospital1","<div style='opacity: 0.7;'><i>Aviso do Hospital</i></div>O autoatendimento custa <b>$"..value.."</b> dólares, e você não tem isso em suas mãos.",5000)
			TriggerClientEvent("vrp_sound:source",source,"juntos",0.5)
		end
	end
	return false
end