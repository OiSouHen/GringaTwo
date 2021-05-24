-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local timeDeath = 600
local treatment = false
local deathStatus = false
local invencibleCount = 0
local playerActive = false
local emergencyButton = false
local updateFoods = GetGameTimer()
local updateTimers = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:PLAYERACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp:playerActive")
AddEventHandler("vrp:playerActive",function()
	playerActive = true

	SetDiscordAppId(494493006418673703)
	SetDiscordRichPresenceAsset("logotive")
	SetRichPresence("Creative Roleplay")

	SetEntityInvincible(PlayerPedId(),true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADUPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if playerActive then
			if GetGameTimer() >= (updateTimers + 10000) then
				local ped = PlayerPedId()
				updateTimers = GetGameTimer()
				vRPS.userUpdate(GetPedArmour(ped),GetEntityHealth(ped),GetEntityCoords(ped))

				if invencibleCount < 3 then
					invencibleCount = invencibleCount + 1

					if invencibleCount >= 3 then
						SetEntityInvincible(ped,false)
						TriggerEvent("paramedic:playerActive")
					end
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOODS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if playerActive then
			if GetGameTimer() >= (updateFoods + 90000) then
				updateFoods = GetGameTimer()
				vRPS.clientFoods()
			end
		end

		Citizen.Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if playerActive then
			local ped = PlayerPedId()
			if GetEntityHealth(ped) <= 101 then
				if not deathStatus then
					timeDeath = 600
					deathStatus = true
					emergencyButton = false

					SendNUIMessage({ death = true })

					TriggerEvent("inventory:preventWeapon",false)

					local coords = GetEntityCoords(ped)
					NetworkResurrectLocalPlayer(coords,true,true,false)

					SetEntityHealth(ped,101)
					SetEntityInvincible(ped,true)

					ClearExtraTimecycleModifier()
					TriggerEvent("hud:removeHood")
					TriggerEvent("radio:outServers")
					TriggerEvent("inventory:removeScuba")
					TriggerServerEvent("inventory:Cancel")
					exports["smartphone"]:closeSmartphone()
				else
					SetEntityHealth(ped,101)

					if timeDeath <= 0 then
						SendNUIMessage({ deathtext = "DIGITE <color>/GG</color> E DESISTA IMEDIATAMENTE" })
					else
						SendNUIMessage({ deathtext = "NOCAUTEADO, AGUARDE <color>"..timeDeath.." SEGUNDOS</color>" })
					end

					if not IsEntityPlayingAnim(ped,"dead","dead_a",3) and not IsPedInAnyVehicle(ped) then
						tvRP.playAnim(false,{"dead","dead_a"},true)
					end
				end
			end
		end

		Citizen.Wait(500)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEALTHRECHARGE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		SetPlayerHealthRechargeMultiplier(PlayerId(),0)
		SetEntityMaxHealth(PlayerPedId(),200)
		SetPedMaxHealth(PlayerPedId(),200)

		Citizen.Wait(100)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKDEATH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.checkDeath()
	if deathStatus and timeDeath <= 0 then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESPAWNPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.respawnPlayer()
	timeDeath = 600
	deathStatus = false

	ClearPedTasks(PlayerPedId())
	ClearPedBloodDamage(PlayerPedId())
	SetEntityHealth(PlayerPedId(),200)
	SetEntityInvincible(PlayerPedId(),false)

	TriggerEvent("resetHandcuff")
	TriggerEvent("resetBleeding")
	TriggerEvent("resetDiagnostic")

	DoScreenFadeOut(0)
	SetEntityCoordsNoOffset(PlayerPedId(),-1041.25,-2744.99,21.35,false,false,false,true)
	SendNUIMessage({ death = false })
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVIVEPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.revivePlayer(health)
	SetEntityHealth(PlayerPedId(),health)
	SetEntityInvincible(PlayerPedId(),false)

	if deathStatus then
		timeDeath = 600
		deathStatus = false

		ClearPedTasks(PlayerPedId())

		TriggerEvent("resetBleeding")
		SendNUIMessage({ death = false })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.startTreatment()
	if not treatment then
		TriggerEvent("player:blockCommands",true)
		TriggerEvent("resetDiagnostic")
		TriggerEvent("resetBleeding")
		treatment = true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local treatmentTimers = GetGameTimer()

	while true do
		if GetGameTimer() >= (treatmentTimers + 1000) then
			treatmentTimers = GetGameTimer()

			if treatment then
				local ped = PlayerPedId()
				local health = GetEntityHealth(ped)

				if health < 200 then
					SetEntityHealth(ped,health + 1)
				else
					treatment = false
					TriggerEvent("player:blockCommands",false)
					TriggerEvent("Notify","amarelo","Tratamento concluido.",5000)
				end
			end
		end

		Citizen.Wait(500)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMEDEATH
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local deathTimers = GetGameTimer()

	while true do
		if GetGameTimer() >= (deathTimers + 1000) then
			deathTimers = GetGameTimer()

			if deathStatus then
				if timeDeath > 0 then
					timeDeath = timeDeath - 1
				end
			end
		end

		Citizen.Wait(500)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if deathStatus then
			timeDistance = 4
			DisableControlAction(1,18,true)
			DisableControlAction(1,22,true)
			DisableControlAction(1,24,true)
			DisableControlAction(1,25,true)
			DisableControlAction(1,68,true)
			DisableControlAction(1,70,true)
			DisableControlAction(1,91,true)
			DisableControlAction(1,69,true)
			DisableControlAction(1,75,true)
			DisableControlAction(1,140,true)
			DisableControlAction(1,142,true)
			DisableControlAction(1,257,true)
			DisablePlayerFiring(PlayerPedId(),true)
		end

		Citizen.Wait(timeDistance)
	end
end)