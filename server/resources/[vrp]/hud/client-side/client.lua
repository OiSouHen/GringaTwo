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
Tunnel.bindInterface("hud",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local voice = 2
local stress = 0
local hunger = 100
local thirst = 100
local hardness = {}
local showHud = false
local talking = false
local showMovie = false
local radioDisplay = ""
local homeInterior = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
local beltLock = 0
local beltSpeed = 0
local beltVelocity = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOCKVARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local clockHours = 18
local clockMinutes = 0
local timeDate = GetGameTimer()
local weatherSync = "EXTRASUNNY"
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if GetGameTimer() >= (timeDate + 10000) then
			timeDate = GetGameTimer()
			clockMinutes = clockMinutes + 1

			if clockMinutes >= 60 then
				clockHours = clockHours + 1
				clockMinutes = 0

				if clockHours >= 24 then
					clockHours = 0
				end
			end
		end

		Citizen.Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if homeInterior then
			SetWeatherTypeNow("EXTRASUNNY")
			SetWeatherTypePersist("EXTRASUNNY")
			SetWeatherTypeNowPersist("EXTRASUNNY")
			NetworkOverrideClockTime(00,00,00)
		else
			SetWeatherTypeNow(weatherSync)
			SetWeatherTypePersist(weatherSync)
			SetWeatherTypeNowPersist(weatherSync)
			NetworkOverrideClockTime(clockHours,clockMinutes,00)
		end

		if beltLock >= 1 then
			DisableControlAction(1,75,true)
		end

		Citizen.Wait(0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VOICETALKING
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("hud:VoiceTalking",function(status)
	talking = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROGRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Progress")
AddEventHandler("Progress",function(progressTimer)
	SendNUIMessage({ progress = true, progressTimer = parseInt(progressTimer - 500) })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHUD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if showHud then
			updateDisplayHud()
		end

		Citizen.Wait(500)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEDISPLAYHUD
-----------------------------------------------------------------------------------------------------------------------------------------
local streetLast = 0
local flexDirection = "Norte"
function updateDisplayHud()
	local ped = PlayerPedId()
	local armour = GetPedArmour(ped)
	local coords = GetEntityCoords(ped)
	local heading = GetEntityHeading(ped)
	local health = GetEntityHealth(ped) - 100
	local oxigen = GetPlayerUnderwaterTimeRemaining(PlayerId())
	local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords["x"],coords["y"],coords["z"]))

	if heading >= 315 or heading < 45 then
		flexDirection = "Norte"
	elseif heading >= 45 and heading < 135 then
		flexDirection = "Oeste"
	elseif heading >= 135 and heading < 225 then
		flexDirection = "Sul"
	elseif heading >= 225 and heading < 315 then
		flexDirection = "Leste"
	end

	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)
		local fuel = GetVehicleFuelLevel(vehicle)
		local plate = GetVehicleNumberPlateText(vehicle)
		local speed = GetEntitySpeed(vehicle) * 2.236936

		local showBelt = true
		if GetVehicleClass(vehicle) == 8 and (GetVehicleClass(vehicle) >= 13 and GetVehicleClass(vehicle) <= 16) and GetVehicleClass(vehicle) == 21 then
			showBelt = false
		end

		SendNUIMessage({ vehicle = true, talking = talking, health = health, armour = armour, thirst = thirst, hunger = hunger, stress = stress, street = streetName, direction = flexDirection, radio = radioDisplay, voice = voice, oxigen = oxigen, fuel = fuel, speed = speed, showbelt = showBelt, seatbelt = beltLock, hardness = (hardness[plate] or 0) })
	else
		SendNUIMessage({ vehicle = false, talking = talking, health = health, armour = armour, thirst = thirst, hunger = hunger, stress = stress, street = streetName, direction = flexDirection, radio = radioDisplay, voice = voice, oxigen = oxigen })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hud",function(source,args)
	showHud = not showHud

	updateDisplayHud()
	SendNUIMessage({ hud = showHud })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOVIE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("movie",function(source,args)
	showMovie = not showMovie

	updateDisplayHud()
	SendNUIMessage({ movie = showMovie })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:TOGGLEHOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:toggleHood")
AddEventHandler("hud:toggleHood",function()
	showHood = not showHood

	if showHood then
		SetPedComponentVariation(PlayerPedId(),1,69,0,1)
	else
		SetPedComponentVariation(PlayerPedId(),1,0,0,1)
	end

	SendNUIMessage({ hood = showHood })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:HARDNESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:plateHardness")
AddEventHandler("hud:plateHardness",function(vehPlate,status)
	hardness[vehPlate] = parseInt(status)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:ALLHARDNESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:allHardness")
AddEventHandler("hud:allHardness",function(vehHardness)
	hardness = vehHardness
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:REMOVEHOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:removeHood")
AddEventHandler("hud:removeHood",function()
	if showHood then
		showHood = false
		SendNUIMessage({ hood = showHood })
		SetPedComponentVariation(PlayerPedId(),1,0,0,1)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSHUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("statusHunger")
AddEventHandler("statusHunger",function(number)
	hunger = parseInt(number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSTHIRST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("statusThirst")
AddEventHandler("statusThirst",function(number)
	thirst = parseInt(number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSFOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("statusFoods")
AddEventHandler("statusFoods",function(statusThirst,statusHunger)
	thirst = parseInt(statusThirst)
	hunger = parseInt(statusHunger)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSSTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("statusStress")
AddEventHandler("statusStress",function(number)
	stress = parseInt(number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUDACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hudActived")
AddEventHandler("hudActived",function(status)
	showHud = status

	updateDisplayHud()

	SendNUIMessage({ hud = showHud })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:VOICEMODE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:VoiceMode")
AddEventHandler("hud:VoiceMode",function(status)
	voice = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:RADIODISPLAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:RadioDisplay")
AddEventHandler("hud:RadioDisplay",function(number)
	if parseInt(number) <= 0 then
		radioDisplay = ""
	else
		radioDisplay = parseInt(number).."Mhz <s>:</s>"
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOWARDPED
-----------------------------------------------------------------------------------------------------------------------------------------
function fowardPed(ped)
	local heading = GetEntityHeading(ped) + 90.0
	if heading < 0.0 then
		heading = 360.0 + heading
	end

	heading = heading * 0.0174533

	return { x = math.cos(heading) * 2.0, y = math.sin(heading) * 2.0 }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBELT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			if not IsPedOnAnyBike(ped) and not IsPedInAnyHeli(ped) and not IsPedInAnyPlane(ped) then
				local vehicle = GetVehiclePedIsUsing(ped)
				if GetPedInVehicleSeat(vehicle,-1) == ped then
					timeDistance = 4

					local speed = GetEntitySpeed(vehicle) * 2.236936
					if speed ~= beltSpeed then
						local plate = GetVehicleNumberPlateText(vehicle)

						if ((beltSpeed - speed) >= 35 and beltLock == 0) or ((beltSpeed - speed) >= 85 and beltLock == 1 and hardness[plate] == nil) then
							local fowardVeh = fowardPed(ped)
							local coords = GetEntityCoords(ped)
							SetEntityCoords(ped,coords["x"] + fowardVeh["x"],coords["y"] + fowardVeh["y"],coords["z"] + 1,1,0,0,0)
							SetEntityVelocity(ped,beltVelocity["x"],beltVelocity["y"],beltVelocity["z"])
							ApplyDamageToPed(ped,50,false)

							Citizen.Wait(1)

							SetPedToRagdoll(ped,5000,5000,0,0,0,0)
						end

						beltVelocity = GetEntityVelocity(vehicle)
						beltSpeed = speed
					end
				end
			end
		else
			if beltSpeed ~= 0 then
				beltSpeed = 0
			end

			if beltLock == 1 then
				beltLock = 0
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("seatbelt",function(source,args)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		if not IsPedOnAnyBike(ped) then
			if beltLock == 1 then
				TriggerEvent("sounds:source","unbelt",0.5)
				beltLock = 0
			else
				TriggerEvent("sounds:source","belt",0.5)
				beltLock = 1
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("seatbelt","Colocar/Retirar o cinto.","keyboard","g")
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:SYNCTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:syncTimers")
AddEventHandler("hud:syncTimers",function(timer)
	clockHours = parseInt(timer[2])
	clockMinutes = parseInt(timer[1])
	weatherSync = timer[3]
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOMES:HOURS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("homes:Hours")
AddEventHandler("homes:Hours",function(status)
	homeInterior = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHEALTHREDUCE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
			if hunger >= 6 and hunger <= 15 then
				ApplyDamageToPed(ped,1,false)
				TriggerEvent("Notify","hunger","Sofrendo com a fome.",2000)
			elseif hunger <= 5 then
				ApplyDamageToPed(ped,2,false)
				TriggerEvent("Notify","hunger","Sofrendo com a fome.",2000)
			end

			if thirst >= 6 and thirst <= 15 then
				ApplyDamageToPed(ped,1,false)
				TriggerEvent("Notify","thirst","Sofrendo com a sede.",2000)
			elseif thirst <= 5 then
				ApplyDamageToPed(ped,2,false)
				TriggerEvent("Notify","thirst","Sofrendo com a sede.",2000)
			end
		end

		Citizen.Wait(15000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSHAKESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		local health = GetEntityHealth(ped)

		if health > 101 then
			if stress >= 99 then
				ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.75)
				ApplyDamageToPed(ped,2,false)
				TriggerEvent("Notify","stress","Sofrendo com o estresse.",2000)
			elseif stress >= 80 and stress <= 98 then
				timeDistance = 5000
				ApplyDamageToPed(ped,2,false)
				TriggerEvent("Notify","stress","Sofrendo com o estresse.",2000)
				ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.50)
			elseif stress >= 60 and stress <= 79 then
				timeDistance = 7500
				ApplyDamageToPed(ped,1,false)
				TriggerEvent("Notify","stress","Sofrendo com o estresse.",2000)
				ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.25)
			elseif stress >= 40 and stress <= 59 then
				timeDistance = 10000
				ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.05)
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGPS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) and showHud then
			if not IsMinimapRendering() then
				DisplayRadar(true)
			end
		else
			if IsMinimapRendering() then
				DisplayRadar(false)
			end
		end

		Citizen.Wait(1000)
	end
end)