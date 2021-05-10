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
Tunnel.bindInterface("vrp_avalanches",cnVRP)
vSERVER = Tunnel.getInterface("vrp_avalanches")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local blip = nil
local inService = false
local startX = 1599.48
local startY = 6457.97
local startZ = 25.32
local avalanchesPosition = 1
local timeSeconds = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- COORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local coords = {
	[1] = { 29.11,-1356.58,29.21 },
	[2] = { 2564.41,385.36,108.47 },
	[3] = { 1158.48,-356.47,67.25 },
	[4] = { -710.05,-952.63,18.81 },
	[5] = { -73.87,-1783.49,28.17 },
	[6] = { 374.79,316.29,103.3 },
	[7] = { -3235.22,1004.55,12.26 },
	[8] = { 1717.86,6386.78,33.57 },
	[9] = { 542.33,2683.49,42.36 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.toggleService()
	local ped = PlayerPedId()

	if not inService then
		startthreadservice()
		startthreadtimeseconds()
		inService = true
		makeBlipMarked()
		TriggerEvent("Notify","avalanches-start","<div style='opacity: 0.7;'><i>Aviso do Avalanches</i></div>Você iniciou o seu turno de colher ingredientes.",5000)
		TriggerEvent("vrp_sound:source","quite",0.5)
	else
		inService = false
		TriggerEvent("Notify","avalanches-end","<div style='opacity: 0.7;'><i>Aviso do Avalanches</i></div>Você encerrou o seu turno de colher ingredientes.",5000)
		TriggerEvent("vrp_sound:source","juntos",0.5)
		if DoesBlipExist(blip) then
			RemoveBlip(blip)
			blip = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function startthreadservice()
	Citizen.CreateThread(function()
		while true do
			local timeDistance = 500
			if inService then
				local ped = PlayerPedId()
				if IsPedInAnyVehicle(ped) then
					local veh = GetVehiclePedIsUsing(ped)
					local coordsPed = GetEntityCoords(ped)
					local distance = #(coordsPed - vector3(coords[avalanchesPosition][1],coords[avalanchesPosition][2],coords[avalanchesPosition][3]))
					if distance <= 300 and IsVehicleModel(veh,GetHashKey("taco")) then
						timeDistance = 4
						DrawMarker(21,coords[avalanchesPosition][1],coords[avalanchesPosition][2],coords[avalanchesPosition][3]+0.60,0,0,0,0,180.0,130.0,2.0,2.0,1.0,121,206,121,100,1,0,0,1)
						if distance <= 15 then
							local speed = GetEntitySpeed(veh) * 2.236936
							if IsControlJustPressed(1,38) and speed <= 40 and timeSeconds <= 0 then
								timeSeconds = 2
								if avalanchesPosition == #coords then
									avalanchesPosition = 1
									vSERVER.paymentMethod(true)
								else
									avalanchesPosition = avalanchesPosition + 1
									vSERVER.paymentMethod(false)
								end
								makeBlipMarked()
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
-- TIMESECONDS
-----------------------------------------------------------------------------------------------------------------------------------------
function startthreadtimeseconds()
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
-- MAKEBLIPMARKED
-----------------------------------------------------------------------------------------------------------------------------------------
function makeBlipMarked()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
		blip = nil
	end

	blip = AddBlipForCoord(coords[avalanchesPosition][1],coords[avalanchesPosition][2],coords[avalanchesPosition][3])
	SetBlipSprite(blip,1)
	SetBlipColour(blip,84)
	SetBlipScale(blip,0.5)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Ingredientes")
	EndTextCommandSetBlipName(blip)
end