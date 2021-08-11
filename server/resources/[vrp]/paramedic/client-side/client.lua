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
Tunnel.bindInterface("paramedic",cRP)
vSERVER = Tunnel.getInterface("paramedic")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local damaged = {}
local bleeding = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSEDDIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()

		if GetEntityHealth(ped) > 110 and not IsPedInAnyVehicle(ped) then
			if not damaged.vehicle and HasEntityBeenDamagedByAnyVehicle(ped) then
				ClearEntityLastDamageEntity(ped)
				damaged.vehicle = true
				bleeding = bleeding + 2
				TriggerServerEvent("dna:dropDna",80,190,40)
			end

			if HasEntityBeenDamagedByWeapon(ped,0,2) then
				ClearEntityLastDamageEntity(ped)
				damaged.bullet = true
				bleeding = bleeding + 1
				TriggerServerEvent("dna:dropDna",30,100,200)
			end

			if not damaged.taser and IsPedBeingStunned(ped) then
				ClearEntityLastDamageEntity(ped)
				damaged.taser = true
			end
		end

		local hit,bone = GetPedLastDamageBone(ped)
		if hit and not damaged[bone] and bone ~= 0 then
			damaged[bone] = true
		end

		Citizen.Wait(500)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLEEDING
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local bleedingTimers = GetGameTimer()

	while true do
		if GetGameTimer() >= bleedingTimers then
			bleedingTimers = GetGameTimer() + 15000

			local ped = PlayerPedId()
			if GetEntityHealth(ped) > 101 and bleeding >= 3 then
				if bleeding >= 7 then
					ApplyDamageToPed(ped,5,false)
				else
					ApplyDamageToPed(ped,bleeding - 2,false)
				end

				TriggerEvent("Notify","blood","Sangramento encontrado.",3000)
				TriggerServerEvent("dna:dropDna",255,0,0)
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETDIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("resetDiagnostic")
AddEventHandler("resetDiagnostic",function()
	local ped = PlayerPedId()
	ClearPedBloodDamage(ped)

	damaged = {}
	bleeding = 0
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETDIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("resetBleeding")
AddEventHandler("resetBleeding",function()
	bleeding = 0
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWINJURIES
-----------------------------------------------------------------------------------------------------------------------------------------
local exit = true
RegisterNetEvent("drawInjuries")
AddEventHandler("drawInjuries",function(ped,injuries)
	local function draw3dtext(x,y,z,text)
		local onScreen,_x,_y = World3dToScreen2d(x,y,z)
		SetTextFont(4)
		SetTextScale(0.35,0.35)
		SetTextColour(255,255,255,100)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
		local factor = (string.len(text))/300
		DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
	end

	Citizen.CreateThread(function()
		local counter = 0
		exit = not exit

		while true do
			if counter > 1000 or exit then
				exit = true
				break
			end

			for k,v in pairs(injuries) do
				local x,y,z = table.unpack(GetPedBoneCoords(GetPlayerPed(GetPlayerFromServerId(ped)),k))
				draw3dtext(x,y,z,"~w~"..string.upper(v))
			end

			counter = counter + 1
			Citizen.Wait(0)
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETDIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getDiagnostic()
	return damaged,bleeding
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETBLEEDING
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getBleeding()
	return bleeding
end