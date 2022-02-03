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
Tunnel.bindInterface("register",cRP)
vCLIENT = Tunnel.getInterface("register")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local registersGlobal = 300
local registerStart = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- startRegister
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.startRegister()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if  parseInt(registersGlobal) > 0 then
			TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..parseInt(registersGlobal).."</b> segundos.",5000)
			return false
		else
			if not registerStart then
				registerStart = true
				registersGlobal = 300
				vRP.upgradeStress(user_id,10)
				return true
			end
		end
	end
	
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentMethod()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.upgradeStress(user_id,3)

		local value = math.random(400,800)
		vRP.giveInventoryItem(user_id,"dollars",parseInt(value),true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if parseInt(registersGlobal) > 0 then
			registersGlobal = parseInt(registersGlobal) - 1
			
			if parseInt(registersGlobal) <= 0 then
				registerStart = false
			end
		end
		
		Citizen.Wait(1000)
	end
end)