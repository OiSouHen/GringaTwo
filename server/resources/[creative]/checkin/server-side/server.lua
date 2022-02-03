-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("checkin",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTCHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentCheckin()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local value = 500
		if GetEntityHealth(GetPlayerPed(source)) <= 101 then
			value = value + 1000
		end
		
		local status = vRP.request(source,"Realizar o tratamento por <b>$"..vRP.format(parseInt(value)).." dólares</b>?",60)
		if status then
			if vRP.paymentBank(user_id,parseInt(value)) then
				return true
			else
				TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
			end
		end
	end
	
	return false
end