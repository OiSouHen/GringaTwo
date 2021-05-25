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
Tunnel.bindInterface("vrp_goldminer",cnVRP)
vSERVER = Tunnel.getInterface("vrp_goldminer")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
local timeSeconds = 0
local goldminerList = {}
local inService = false
local vehModel = 48339065
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGARBAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function startthreadgoldminer()
	Citizen.CreateThread(function()
		while true do
			local timeDistance = 500
			if inService then
				local ped = PlayerPedId()
				if not IsPedInAnyVehicle(ped) then
					local coords = GetEntityCoords(ped)

					for k,v in pairs(goldminerList) do
						local distance = #(coords - vector3(v[1],v[2],v[3]))
						if distance <= 50 then
							timeDistance = 5
							DrawMarker(21,v[1],v[2],v[3]-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,159,67,37,50,0,0,0,1)
							if distance <= 0.6 and IsControlJustPressed(1,38) and timeSeconds <= 0 and GetEntityModel(GetPlayersLastVehicle()) == vehModel then
								timeSeconds = 2
								TriggerEvent("cancelando",true)
--								SetEntityCoords(ped,v[1],v[2],v[3])
								TriggerEvent("Progress",30000,"Minerando...")
								vRP.createObjects("amb@world_human_const_drill@male@drill@base","base","prop_tool_jackham",15,28422)
								Wait(30000)
								vSERVER.paymentMethod(parseInt(k))
								ClearPedTasks(ped)
								vRP._stopAnim(false)
								vRP.removeObjects()
								TriggerEvent("cancelando",false)
							end
						end
					end
				end
			end

			Citizen.Wait(timeDistance)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTGARBAGEMAN
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.getGoldminerStatus()
	return inService
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTGARBAGEMAN
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.startGoldminer()
	startthreadgoldminer()
	startthreadgoldminerseconds()
	inService = true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPGARBAGEMAN
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.stopGoldminer()
	inService = false
	for k,v in pairs(blips) do
		if DoesBlipExist(blips[k]) then
			RemoveBlip(blips[k])
			blips[k] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEGARBAGELIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_goldminer:updateGoldminerList")
AddEventHandler("vrp_goldminer:updateGoldminerList",function(status)
	goldminerList = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEGARBAGELIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_goldminer:removeGoldminerBlips")
AddEventHandler("vrp_goldminer:removeGoldminerBlips",function(number)
	if DoesBlipExist(blips[number]) then
		RemoveBlip(blips[number])
		blips[number] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSERTBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_goldminer:insertBlips")
AddEventHandler("vrp_goldminer:insertBlips",function(statusList)
	if inService then
		for k,v in pairs(blips) do
			if DoesBlipExist(blips[k]) then
				RemoveBlip(blips[k])
				blips[k] = nil
			end
		end

		Citizen.Wait(1000)

		for k,v in pairs(statusList) do
			blips[k] = AddBlipForRadius(v[1],v[2],v[3],10.0)
			SetBlipAlpha(blips[k],255)
			SetBlipColour(blips[k],64)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMESECONDS
-----------------------------------------------------------------------------------------------------------------------------------------
function startthreadgoldminerseconds()
	Citizen.CreateThread(function()
		while true do
			if timeSeconds > 0 then
				timeSeconds = timeSeconds - 1
			end
			Citizen.Wait(1000)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDLOCATION
-----------------------------------------------------------------------------------------------------------------------------------------
local localidades = {
	{ 1077.88,-1955.02,31.04 }
} 
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local sleep = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		for k,v in pairs(localidades) do
			local distance = #(coords - vector3(v[1],v[2],v[3]))
			if distance <= 2 then
				sleep = 4
				if IsControlJustPressed(1,38) then    
					TriggerEvent("Notify","goldminer-job","<div style='opacity: 0.7;'><i>Aviso da Mineradora</i></div>Para <b>Minerar</b> você precisa do caminhão de minérios.<br>Inicie e encerre seu turno de mineração mentalizando <b>/minerar</b>.",15000)
					TriggerEvent("vrp_sound:source","juntos",0.5)
				end
			end
			Citizen.Wait(sleep)
		end
	end
end)