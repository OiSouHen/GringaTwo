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
Tunnel.bindInterface("impound",cRP)
vSERVER = Tunnel.getInterface("impound")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local timeSeconds = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICES
-----------------------------------------------------------------------------------------------------------------------------------------
local services = {
	{ 408.03,-1638.37,29.38 },
	{ 1724.84,3715.31,34.22 },
	{ -364.24,6071.16,31.52 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(services) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 30 then
					timeDistance = 1
					DrawMarker(23,v[1],v[2],v[3] - 0.95,0.0,0.0,0.0,0.0,0.0,0.0,10.0,10.0,0.0,42,137,255,100,0,0,0,0)

					if IsControlJustPressed(1,38) and timeSeconds <= 0 and distance <= 5 then
						timeSeconds = 2
						vSERVER.checkImpound()
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("impound",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") then
			local vehicle,vehNet,vehPlate,vehName = vRPclient.vehList(source,7)
			if vehicle then
				local x,y,z = vRPclient.getPositions(source)
				if impoundVehs[vehName.."-"..vehPlate] == nil then
					impoundVehs[vehName.."-"..vehPlate] = true
					TriggerEvent("towdriver:alertPlayers",x,y,z,vRP.vehicleName(vehName).." - "..vehPlate)
					TriggerClientEvent("Notify",source,"verde","Veículo <b>"..vRP.vehicleName(vehName).."</b> foi registrado no <b>DMV</b>.",5000)
				else
					TriggerClientEvent("Notify",source,"amarelo","Veículo <b>"..vRP.vehicleName(vehName).."</b> já está na lista do <b>DMV</b>.",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMESECONDS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if timeSeconds > 0 then
			timeSeconds = timeSeconds - 1
		end

		Citizen.Wait(1000)
	end
end)