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
Tunnel.bindInterface("paramedic",cRP)
vCLIENT = Tunnel.getInterface("paramedic")
vSURVIVAL = Tunnel.getInterface("survival")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLEEDING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("sangramento",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"Paramedic") then
        local nplayer = vRPclient.nearestPlayer(source,3)
        if nplayer then
            TriggerClientEvent("resetBleeding",nplayer)
            TriggerClientEvent("Notify",source,"sucesso","O sangramento parou.",5000)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TREAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tratamento",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"Paramedic") then
		local nplayer = vRPclient.nearestPlayer(source,5)
		if nplayer then
			if not vSURVIVAL.deadPlayer(nplayer) then
				vSURVIVAL._startCure(nplayer)
				TriggerClientEvent("resetBleeding",nplayer)
				TriggerClientEvent("resetDiagnostic",nplayer)
				TriggerClientEvent("Notify",source,"sucesso","O tratamento começou.",5000)
			end
		end
	end
end)