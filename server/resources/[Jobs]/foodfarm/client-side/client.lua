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
Tunnel.bindInterface("foodfarm",cnVRP)
vSERVER = Tunnel.getInterface("foodfarm")
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
	[1] = { 51.55,6640.2,31.39 }
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
		makeBlipsPosition()
		TriggerEvent("Notify","sucesso","Você começou a trabalhar de <b>Motorista de Ônibus</b>.",5000)
		TriggerEvent("vrp_sound:source","quite",0.5)
	else
		inService = false
		TriggerEvent("Notify","aviso","Você parou de trabalhar de <b>Motorista de Ônibus</b>.",5000)
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
								makeBlipsPosition()
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
-- MAKEBLIPSPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function makeBlipsPosition()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
		blip = nil
	end

	if not DoesBlipExist(blip) then
		blip = AddBlipForRadius(coords[avalanchesPosition][1],coords[avalanchesPosition][2],coords[avalanchesPosition][3],50.0)
		SetBlipHighDetail(blip,true)
		SetBlipColour(blip,69)
		SetBlipAlpha(blip,150)
		SetBlipAsShortRange(blip,true)
	end
end