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
Tunnel.bindInterface("dynamic",cnVRP)
vCLIENT = Tunnel.getInterface("dynamic")
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETINFOS
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.getInfos()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		TriggerClientEvent("Notify",source,"default","<b>Nome:</b> "..identity.name.." "..identity.name2.."<br><b>Passaporte:</b> "..vRP.format(parseInt(identity.id)).."<br><b>RG:</b> "..identity.registration.."<br><b>Telefone:</b> "..identity.phone.."<br><b>Banco:</b> $"..vRP.format(parseInt(identity.bank)).."<br><b>Diamantes:</b> $"..vRP.format(parseInt(vRP.getGmsId(user_id))).."<br><b>Garagens:</b> "..identity.garage,10000)
	end
end