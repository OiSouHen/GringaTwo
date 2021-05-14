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
vSERVER = Tunnel.getInterface("hud")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local ped = 0
local voice = 2
local armour = 0
local street = ""
local health = 200
local talking = false
local x,y,z = 0.0,0.0,0.0
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local stress = 0
local hunger = 100
local thirst = 100
local showHud = false
local showMovie = false
local radioDisplay = ""
local direction = "Norte"
-----------------------------------------------------------------------------------------------------------------------------------------
-- DATE
-----------------------------------------------------------------------------------------------------------------------------------------
local hours = 20
local minutes = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
local beltSpeed = 0
local entVelocity = 0
local beltLock = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATETALKING
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
-- THREADUPDATE - 100
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		if showHud then
			health = GetEntityHealth(ped) - 100
            x,y,z = table.unpack(GetEntityCoords(ped))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADUPDATE - 500
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		if showHud then

			ped = PlayerPedId()
			armour = GetPedArmour(ped)
			heading = GetEntityHeading(ped)
			street = GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z))

			if heading >= 315 or heading < 45 then
				direction = "Norte"
			elseif heading >= 45 and heading < 135 then
				direction = "Oeste"
			elseif heading >=135 and heading < 225 then
				direction = "Sul"
			elseif heading >= 225 and heading < 315 then
				direction = "Leste"
			end

		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHUD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		if showHud then
			updateDisplayHud(PlayerPedId())
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEDISPLAYHUD
-----------------------------------------------------------------------------------------------------------------------------------------
function updateDisplayHud(ped)
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)
		local fuel = GetVehicleFuelLevel(vehicle)
		local speed = GetEntitySpeed(vehicle) * 2.236936

		SendNUIMessage({ vehicle = true, talking = talking, health = health, armour = armour, thirst = thirst, hunger = hunger, stress = stress, oxigen = GetPlayerUnderwaterTimeRemaining(PlayerId()), street = street, radio = radioDisplay, hours = hours, minutes = minutes, direction = direction, voice = voice, fuel = fuel, speed = speed, seatbelt = beltLock })
	else
		SendNUIMessage({ vehicle = false, talking = talking, health = health, armour = armour, thirst = thirst, hunger = hunger, stress = stress, oxigen = GetPlayerUnderwaterTimeRemaining(PlayerId()), street = street, radio = radioDisplay, hours = hours, minutes = minutes, direction = direction, voice = voice })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hud",function(source,args)
	showHud = not showHud
	SendNUIMessage({ hud = showHud })
	updateDisplayHud(PlayerPedId())
	TriggerEvent("vrp_prison:switchHud",showHud)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOVIE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("movie",function(source,args)
	showMovie = not showMovie
	SendNUIMessage({ movie = showMovie })
	updateDisplayHud(PlayerPedId())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:toggleHood")
AddEventHandler("hud:toggleHood",function()
	showHood = not showHood
	SendNUIMessage({ hood = showHood })

	if showHood then
		SetPedComponentVariation(PlayerPedId(),1,69,0,2)
	else
		SetPedComponentVariation(PlayerPedId(),1,0,0,2)
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
	SendNUIMessage({ hud = showHud })
	updateDisplayHud(PlayerPedId())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOKOVOIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:VoiceMode")
AddEventHandler("hud:VoiceMode",function(status)
	voice = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOKOVOIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:RadioDisplay")
AddEventHandler("hud:RadioDisplay",function(number)
	if parseInt(number) <= 0 then
		radioDisplay = ""
	else
		if parseInt(number) == 911 then
			radioDisplay = "Policia"
		elseif parseInt(number) == 912 then
			radioDisplay = "Policia"
		elseif parseInt(number) == 112 then
			radioDisplay = "Paramédico"
		elseif parseInt(number) == 704 then
			radioDisplay = "Reboque"
		else
			radioDisplay = parseInt(number).."Mhz"
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local timeDistance = 500
        if IsPedInAnyVehicle(ped) then
            timeDistance = 4
            local veh = GetVehiclePedIsUsing(ped)
            local vehClass = GetVehicleClass(veh)
            if (vehClass >= 0 and vehClass <= 7) or (vehClass >= 9 and vehClass <= 12) or (vehClass >= 17 and vehClass <= 20) then
                local speed = GetEntitySpeed(veh) * 2.236936
                if speed ~= beltSpeed then
                    if (beltSpeed - speed) >= 30 and not beltLock then
                        SetEntityHealth(ped,GetEntityHealth(ped)-10)
						vRP.upgradeStress(ped,10)
						SetVehicleUndriveable(vehicle,true)
						ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",5.0)
						TaskLeaveVehicle(ped,GetVehiclePedIsIn(ped),4160)
						vRP._playAnim(false,{{"amb@world_human_sunbathe@female@back@idle_a","idle_a"}},true)
					end
                    
                    beltSpeed = speed
                    entVelocity = GetEntityVelocity(veh)
                end

                if beltLock then
                    DisableControlAction(1,75,true)
                end

                if IsControlJustReleased(1,73) then
                    beltLock = not beltLock

                    if not beltLock then
                        TriggerEvent("vrp_sound:source","unbelt",0.5)
                    else
                        TriggerEvent("vrp_sound:source","belt",0.5)
                    end
                end
            end
        else
            if beltSpeed ~= 0 then
                beltSpeed = 0
            end

            if beltLock then
                beltLock = false
            end
        end

        Citizen.Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:syncTimers")
AddEventHandler("hud:syncTimers",function(timer)
	minutes = parseInt(timer[1])
	hours = parseInt(timer[2])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
local homeInterior = false
RegisterNetEvent("vrp_homes:Hours")
AddEventHandler("vrp_homes:Hours",function(status)
	homeInterior = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
--Citizen.CreateThread(function()
--	while true do
--		SetWeatherTypeNow("CLEAR")
--		SetWeatherTypePersist("CLEAR")
--		SetWeatherTypeNowPersist("CLEAR")
--
--		if homeInterior then
--			NetworkOverrideClockTime(00,00,00)
--		else
--			NetworkOverrideClockTime(hours,minutes,00)
--		end
--		Citizen.Wait(0)
--	end
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHEALTHREDUCE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local health = GetEntityHealth(ped)

		if health > 101 then
			if hunger >= 0 and hunger <= 15 then
				TriggerEvent("Notify","hunger","Sofrendo com a fome.",2000)
			elseif hunger <= 5 then
				TriggerEvent("Notify","hunger","Sofrendo com a fome.",2000)
				SetEntityHealth(ped,health-1)
			end

			if thirst >= 0 and thirst <= 15 then
				TriggerEvent("Notify","thirst","Sofrendo com a sede.",2000)
			elseif thirst <= 5 then
				TriggerEvent("Notify","thirst","Sofrendo com a sede.",2000)
				SetEntityHealth(ped,health-1)
			end
		end

		Citizen.Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHEALTHREDUCE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local health = GetEntityHealth(ped)

		if health > 101 then
			if stress >= 80 then
				ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.2)
				TriggerEvent("Notify","stress","Sofrendo com o estresse.",2000)
				if parseInt(math.random(3)) >= 3 and not IsPedInAnyVehicle(ped) then
					SetPedToRagdoll(ped,5000,5000,0,0,0,0)
				end
			elseif stress >= 60 and stress <= 79 then
				ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.1)
				TriggerEvent("Notify","stress","Sofrendo com o estresse.",2000)
			end
		end

		Citizen.Wait(10000)
	end
end)