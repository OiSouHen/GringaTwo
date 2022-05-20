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
Tunnel.bindInterface("player",cRP)
vSERVER = Tunnel.getInterface("player")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKCOMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
local blockCommands = false
RegisterNetEvent("player:blockCommands")
AddEventHandler("player:blockCommands",function(status)
	blockCommands = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKS
-----------------------------------------------------------------------------------------------------------------------------------------
function blocks()
	if exports["player"]:handCuff() then
		return false
	end

	return blockCommands
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKCOMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("blockCommands",blocks)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECEIVESALARY
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local salaryTimers = GetGameTimer()

	while true do
		if GetGameTimer() >= salaryTimers then
			salaryTimers = GetGameTimer() + (30 * 60000)
			TriggerServerEvent("player:salary")
		end

		Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AWAYSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
local awayTimers = GetGameTimer()
local awaySystem = { 0.0,0.0,1800 }

CreateThread(function()
	while true do
		if GetGameTimer() >= awayTimers then
			awayTimers = GetGameTimer() + 10000

			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			if coords["x"] == awaySystem[1] and coords["y"] == awaySystem[2] then
				if awaySystem[3] > 0 then
					awaySystem[3] = awaySystem[3] - 10

					if awaySystem[3] == 60 or awaySystem[3] == 30 then
						TriggerEvent("Notify","amarelo","Mova-se e evite ser desconectado.",3000)
					end
				else
					TriggerServerEvent("player:kickSystem","Desconectado, muito tempo ausente.")
				end
			else
				awaySystem[1] = coords["x"]
				awaySystem[2] = coords["y"]
				awaySystem[3] = 1800
			end
		end

		Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATSHUFFLE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) and not IsPedOnAnyBike(ped) then
			local veh = GetVehiclePedIsUsing(ped)
			if GetPedInVehicleSeat(veh,0) == ped then
				if not GetIsTaskActive(ped,164) and GetIsTaskActive(ped,165) then
					SetPedIntoVehicle(ped,veh,0)
					SetPedConfigFlag(ped,184,true)
					SetVehicleCloseDoorDeferedAction(veh,0)
				end
			end
		end

		Wait(100)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELANDO
-----------------------------------------------------------------------------------------------------------------------------------------
local cancelando = false
RegisterNetEvent("cancelando")
AddEventHandler("cancelando",function(status)
	cancelando = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCANCELANDO
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 500
		if cancelando then
			timeDistance = 4
			DisableControlAction(1,73,true)
			DisableControlAction(1,29,true)
			DisableControlAction(1,47,true)
			DisableControlAction(1,187,true)
			DisableControlAction(1,189,true)
			DisableControlAction(1,190,true)
			DisableControlAction(1,188,true)
			DisableControlAction(1,311,true)
			DisableControlAction(1,245,true)
			DisableControlAction(1,257,true)
			DisableControlAction(1,167,true)
			DisableControlAction(1,140,true)
			DisableControlAction(1,141,true)
			DisableControlAction(1,142,true)
			DisableControlAction(1,137,true)
--			DisableControlAction(1,37,true)
			DisableControlAction(1,38,true)
			DisablePlayerFiring(PlayerPedId(),true)
		end
		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIVING
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.setDiving()
	local ped = PlayerPedId()
	if IsPedSwimming(ped) then
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedComponentVariation(ped,8,123,0,2)
			SetPedPropIndex(ped,1,26,0,2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(ped,8,153,0,2)
			SetPedPropIndex(ped,1,28,0,2)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:REMOVEOUTFIT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.setRemoveoutfit()
	local ped = PlayerPedId()
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedComponentVariation(ped,1,-1,0,1)
			SetPedComponentVariation(ped,3,15,0,1)
			SetPedComponentVariation(ped,4,61,0,1)
			SetPedComponentVariation(ped,5,-1,0,1)
			SetPedComponentVariation(ped,6,34,0,1)
			SetPedComponentVariation(ped,7,-1,0,1)
			SetPedComponentVariation(ped,8,15,0,1)
			SetPedComponentVariation(ped,9,-1,0,1)
			SetPedComponentVariation(ped,10,-1,0,1)
			SetPedComponentVariation(ped,11,15,0,1)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(ped,1,-1,0,1)
			SetPedComponentVariation(ped,3,15,0,1)
			SetPedComponentVariation(ped,4,17,0,1)
			SetPedComponentVariation(ped,5,-1,0,1)
			SetPedComponentVariation(ped,6,35,0,1)
			SetPedComponentVariation(ped,7,-1,0,1)
			SetPedComponentVariation(ped,8,7,0,1)
			SetPedComponentVariation(ped,9,-1,0,1)
			SetPedComponentVariation(ped,10,-1,0,1)
			SetPedComponentVariation(ped,11,18,0,1)
		end
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETENERGETIC
-----------------------------------------------------------------------------------------------------------------------------------------
local energetic = 0
RegisterNetEvent("setEnergetic")
AddEventHandler("setEnergetic",function(timers,number)
	energetic = energetic + timers
	SetRunSprintMultiplierForPlayer(PlayerId(),number)
end)

CreateThread(function()
	while true do
		if energetic > 0 then
			RestorePlayerStamina(PlayerId(),1.0)
		end

		Wait(1000)
	end
end)

CreateThread(function()
	while true do
		if energetic > 0 then
			energetic = energetic - 1

			if energetic <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
				energetic = 0
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETECSTASY
-----------------------------------------------------------------------------------------------------------------------------------------
local ecstasy = 0
RegisterNetEvent("setEcstasy")
AddEventHandler("setEcstasy",function()
	ecstasy = ecstasy + 10

	if not GetScreenEffectIsActive("MinigameTransitionIn") then
		StartScreenEffect("MinigameTransitionIn",0,true)
	end
end)

CreateThread(function()
	while true do
		if ecstasy > 0 then
			ecstasy = ecstasy - 1
			ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.05)

			if ecstasy <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				ecstasy = 0

				TriggerServerEvent("upgradeStress",50)
				if GetScreenEffectIsActive("MinigameTransitionIn") then
					StopScreenEffect("MinigameTransitionIn")
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMETH
-----------------------------------------------------------------------------------------------------------------------------------------
local methanfetamine = 0
RegisterNetEvent("setMeth")
AddEventHandler("setMeth",function()
	methanfetamine = methanfetamine + 30

	if not GetScreenEffectIsActive("DMT_flight") then
		StartScreenEffect("DMT_flight",0,true)
	end
end)

CreateThread(function()
	while true do
		if methanfetamine > 0 then
			methanfetamine = methanfetamine - 1

			if methanfetamine <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				methanfetamine = 0

				if GetScreenEffectIsActive("DMT_flight") then
					StopScreenEffect("DMT_flight")
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCOCAINE
-----------------------------------------------------------------------------------------------------------------------------------------
local cocaine = 0
RegisterNetEvent("setCocaine")
AddEventHandler("setCocaine",function()
	cocaine = cocaine + 30

	if not GetScreenEffectIsActive("MinigameTransitionIn") then
		StartScreenEffect("MinigameTransitionIn",0,true)
	end
end)

CreateThread(function()
	while true do
		if cocaine > 0 then
			cocaine = cocaine - 1

			if cocaine <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				cocaine = 0

				if GetScreenEffectIsActive("MinigameTransitionIn") then
					StopScreenEffect("MinigameTransitionIn")
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANEFFECTDRUGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("cleanEffectDrugs")
AddEventHandler("cleanEffectDrugs",function()
	if GetScreenEffectIsActive("MinigameTransitionIn") then
		StopScreenEffect("MinigameTransitionIn")
	end

	if GetScreenEffectIsActive("DMT_flight") then
		StopScreenEffect("DMT_flight")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETDRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
local drunkTime = 0
RegisterNetEvent("setDrunkTime")
AddEventHandler("setDrunkTime",function(timers)
	drunkTime = drunkTime + timers

	TriggerEvent("vrp:blockDrunk",true)
	RequestAnimSet("move_m@drunk@verydrunk")
	while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
		Wait(1)
	end

	SetPedMovementClipset(PlayerPedId(),"move_m@drunk@verydrunk",0.25)
end)

CreateThread(function()
	while true do
		if drunkTime > 0 then
			drunkTime = drunkTime - 1

			if drunkTime <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				ResetPedMovementClipset(PlayerPedId(),0.25)
				TriggerEvent("vrp:blockDrunk",false)
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCHOODOPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncHoodOptions")
AddEventHandler("player:syncHoodOptions",function(vehIndex,options)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local v = NetToEnt(vehIndex)
		if DoesEntityExist(v) then
			if options == "open" then
				SetVehicleDoorOpen(v,4,0,0)
			elseif options == "close" then
				SetVehicleDoorShut(v,4,0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:deleteVehicle")
AddEventHandler("player:deleteVehicle",function(vehIndex,vehPlate)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local v = NetToEnt(vehIndex)
		if DoesEntityExist(v) and GetVehicleNumberPlateText(v) == vehPlate then
			SetEntityAsMissionEntity(v,false,false)
			DeleteEntity(v)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEOBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:deleteObject")
AddEventHandler("player:deleteObject",function(entIndex)
	if NetworkDoesNetworkIdExist(entIndex) then
		local v = NetToEnt(entIndex)
		if DoesEntityExist(v) then
			SetEntityAsMissionEntity(v,false,false)
			DeleteEntity(v)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDOORSOPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncDoorsOptions")
AddEventHandler("player:syncDoorsOptions",function(vehIndex,options)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local v = NetToEnt(vehIndex)
		if DoesEntityExist(v) then
			if options == "open" then
				SetVehicleDoorOpen(v,5,0,0)
			elseif options == "close" then
				SetVehicleDoorShut(v,5,0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCWINS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncWins")
AddEventHandler("player:syncWins",function(vehIndex,status)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local v = NetToEnt(vehIndex)
		if DoesEntityExist(v) then
			if status == "1" then
				RollUpWindow(v,0)
				RollUpWindow(v,1)
				RollUpWindow(v,2)
				RollUpWindow(v,3)
			else
				RollDownWindow(v,0)
				RollDownWindow(v,1)
				RollDownWindow(v,2)
				RollDownWindow(v,3)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncDoors")
AddEventHandler("player:syncDoors",function(vehIndex,door)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local v = NetToEnt(vehIndex)
		if DoesEntityExist(v) and GetVehicleDoorsLockedForPlayer(v,PlayerId()) ~= 1 then
			if door == "1" then
				if GetVehicleDoorAngleRatio(v,0) == 0 then
					SetVehicleDoorOpen(v,0,0,0)
				else
					SetVehicleDoorShut(v,0,0)
				end
			elseif door == "2" then
				if GetVehicleDoorAngleRatio(v,1) == 0 then
					SetVehicleDoorOpen(v,1,0,0)
				else
					SetVehicleDoorShut(v,1,0)
				end
			elseif door == "3" then
				if GetVehicleDoorAngleRatio(v,2) == 0 then
					SetVehicleDoorOpen(v,2,0,0)
				else
					SetVehicleDoorShut(v,2,0)
				end
			elseif door == "4" then
				if GetVehicleDoorAngleRatio(v,3) == 0 then
					SetVehicleDoorOpen(v,3,0,0)
				else
					SetVehicleDoorShut(v,3,0)
				end
			elseif door == "5" then
				if GetVehicleDoorAngleRatio(v,5) == 0 then
					SetVehicleDoorOpen(v,5,0,0)
				else
					SetVehicleDoorShut(v,5,0)
				end
			elseif door == "6" then
				if GetVehicleDoorAngleRatio(v,4) == 0 then
					SetVehicleDoorOpen(v,4,0,0)
				else
					SetVehicleDoorShut(v,4,0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inTrunk = false
local playerInvisible = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PLAYERINVISIBLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:playerInvisible")
AddEventHandler("player:playerInvisible",function(status)
	playerInvisible = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ENTERTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:enterTrunk")
AddEventHandler("player:enterTrunk",function(entity)
	if not inTrunk then
		local vehicle = entity[3]
		local vehPlate = entity[1]
		if GetVehicleDoorsLockedForPlayer(vehicle,PlayerId()) ~= 1 then
			local trunk = GetEntityBoneIndexByName(vehicle,"boot")
			if trunk ~= -1 then
				if GetVehicleDoorAngleRatio(vehicle,5) < 0.9 then
					local ped = PlayerPedId()
					local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.5,0.0)
					local coordsEnt = GetWorldPositionOfEntityBone(vehicle,trunk)
					local distance = #(coords - coordsEnt)
					if distance <= 2.0 then
						playerInvisible = true
						SetCarBootOpen(vehicle)
						TriggerEvent("hud:toggleHood")
						SetEntityVisible(ped,false,false)
						Wait(750)
						AttachEntityToEntity(ped,vehicle,-1,0.0,-2.2,0.5,0.0,0.0,0.0,false,false,false,false,20,true)
						Wait(500)
						SetVehicleDoorShut(vehicle,5)
						blockCommands = true
						inTrunk = true
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:checkTrunk")
AddEventHandler("player:checkTrunk",function(checkTrunk)
	local ped = PlayerPedId()
	if inTrunk then
		local vehicle = GetEntityAttachedTo(ped)
		if DoesEntityExist(vehicle) then
			SetCarBootOpen(vehicle)
			Wait(750)
			inTrunk = false
			blockCommands = false
			playerInvisible = false
			DetachEntity(ped,false,false)
			TriggerEvent("hud:toggleHood")
			SetEntityVisible(ped,true,false)
			SetEntityCoords(ped,GetOffsetFromEntityInWorldCoords(ped,0.0,-1.25,-0.25),1,0,0,0)
			Wait(500)
			SetVehicleDoorShut(vehicle,5)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999

		if inTrunk then
			local ped = PlayerPedId()
			local vehicle = GetEntityAttachedTo(ped)
			if DoesEntityExist(vehicle) then
				timeDistance = 1

				DisablePlayerFiring(ped,true)

				if IsEntityVisible(ped) then
					SetEntityVisible(ped,false,false)
					playerInvisible = true
				end

				if IsControlJustPressed(1,38) then
					SetCarBootOpen(vehicle)
					Wait(750)
					inTrunk = false
					blockCommands = false
					playerInvisible = false
					DetachEntity(ped,false,false)
					TriggerEvent("hud:toggleHood")
					SetEntityVisible(ped,true,false)
					SetEntityCoords(ped,GetOffsetFromEntityInWorldCoords(ped,0.0,-1.25,-0.25),1,0,0,0)
					Wait(500)
					SetVehicleDoorShut(vehicle,5)
				end
			else
				inTrunk = false
				blockCommands = false
				playerInvisible = false
				DetachEntity(ped,false,false)
				TriggerEvent("hud:toggleHood")
				SetEntityVisible(ped,true,false)
				SetEntityCoords(ped,GetOffsetFromEntityInWorldCoords(ped,0.0,-1.25,-0.25),1,0,0,0)
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fps",function(source,args)
	if args[1] == "on" then
		SetTimecycleModifier("cinema")
	else
		ClearTimecycleModifier()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:seatPlayer")
AddEventHandler("player:seatPlayer",function(vehIndex)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)

		if vehIndex == "0" then
			if IsVehicleSeatFree(vehicle,-1) then
				SetPedIntoVehicle(ped,vehicle,-1)
			end
		else
			if IsVehicleSeatFree(vehicle,parseInt(vehIndex - 1)) then
				SetPedIntoVehicle(ped,vehicle,parseInt(vehIndex - 1))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLEHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
local handcuff = false
function cRP.toggleHandcuff()
	if not handcuff then
		handcuff = true
		TriggerEvent("radio:outServers")
	else
		handcuff = false
		vRP.stopAnim(false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.removeHandcuff()
	if handcuff then
		handcuff = false
		vRP.stopAnim(false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getHandcuff()
	return handcuff
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
function handcuffs()
	return handcuff
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
exports("handCuff",handcuffs)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("resetHandcuff")
AddEventHandler("resetHandcuff",function()
	if handcuff then
		handcuff = false
		vRP.stopAnim(false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOVEMENTCLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.movementClip(dict)
	RequestAnimSet(dict)
	while not HasAnimSetLoaded(dict) do
		Wait(1)
	end

	SetPedMovementClipset(PlayerPedId(),dict,0.25)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if handcuff then
			timeDistance = 1
			DisableControlAction(1,18,true)
			DisableControlAction(1,21,true)
			DisableControlAction(1,55,true)
			DisableControlAction(1,102,true)
			DisableControlAction(1,179,true)
			DisableControlAction(1,203,true)
			DisableControlAction(1,76,true)
			DisableControlAction(1,23,true)
			DisableControlAction(1,24,true)
			DisableControlAction(1,25,true)
			DisableControlAction(1,140,true)
			DisableControlAction(1,142,true)
			DisableControlAction(1,143,true)
			DisableControlAction(1,75,true)
			DisableControlAction(1,22,true)
			DisableControlAction(1,243,true)
			DisableControlAction(1,257,true)
			DisableControlAction(1,263,true)
			DisablePlayerFiring(ped,true)
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYROPE
-----------------------------------------------------------------------------------------------------------------------------------------
local startRope = false
RegisterNetEvent("player:applyRope")
AddEventHandler("player:applyRope",function(status)
	startRope = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if handcuff and GetEntityHealth(ped) > 101 and not startRope then
			if not IsEntityPlayingAnim(ped,"mp_arresting","idle",3) then
				RequestAnimDict("mp_arresting")
				while not HasAnimDictLoaded("mp_arresting") do
					Wait(1)
				end

				TaskPlayAnim(ped,"mp_arresting","idle",3.0,3.0,-1,49,0,0,0,0)
				timeDistance = 1
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLACKWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
local blackWeapons = {
	"WEAPON_UNARMED",
	"WEAPON_FLASHLIGHT",
	"WEAPON_NIGHTSTICK",
	"WEAPON_STUNGUN",
	"GADGET_PARACHUTE",
	"WEAPON_PETROLCAN",
	"WEAPON_FIREEXTINGUISHER",
	"WEAPON_BAT",
	"WEAPON_BATTLEAXE",
	"WEAPON_BOTTLE",
	"WEAPON_CROWBAR",
	"WEAPON_DAGGER",
	"WEAPON_GOLFCLUB",
	"WEAPON_HAMMER",
	"WEAPON_MACHETE",
	"WEAPON_POOLCUE",
	"WEAPON_STONE_HATCHET",
	"WEAPON_SWITCHBLADE",
	"WEAPON_WRENCH",
	"WEAPON_KNUCKLE"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSHOTSFIRED
-----------------------------------------------------------------------------------------------------------------------------------------
local gsrTime = 0
local coolTimers = 0
local bWeapons = false
local sprayTimers = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSHOTSFIRED - THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if GetSelectedPedWeapon(ped) ~= GetHashKey("WEAPON_UNARMED") and GetSelectedPedWeapon(ped) ~= GetHashKey("WEAPON_PETROLCAN") then
			timeDistance = 1
			
			if IsPedShooting(ped) then
				for k,v in ipairs(blackWeapons) do
					if GetSelectedPedWeapon(ped) == GetHashKey(v) then
						bWeapons = true
					end
				end

				if not bWeapons and GetGameTimer() >= sprayTimers then
					vSERVER.shotsFired()
					gsrTime = 60
					coolTimers = 3
					sprayTimers = GetGameTimer() + 60000
				end

				bWeapons = false
			end
		end
		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GSRTIME
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if gsrTime > 0 then
			gsrTime = gsrTime - 1
		end
		Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GSRCHECK
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.gsrCheck()
	return gsrTime
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOTDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
local shotDistance = {
--  {losSantos}
	{ -2154.0,-3132.0,-0.39 },
	{ -1581.99,-2092.99,-0.63 },
	{ -3272.0,275.0,-0.85 },
	{ -3461.0,967.0,-0.59 },
	{ -3203.0,1555.0,-0.8 },
	{ -1648.5,995.5,152.8 },
	{ 305.94,1055.38,212.4 },
	{ 1258.5,270.25,81.85 },
	{ 1740.5,-1280.0,85.37 },
	{ 1427.01,-3440.99,-0.46 },
	{ -738.0,-3774.0,-0.41 },
	{ -186.99,-894.0,29.34 },
--  {sandyShores}
	{ -374.25,2910.5,34.04 },
	{ 309.39,3667.43,29.58 },
	{ 2325.69,4126.47,29.61 },
	{ 2348.24,4572.29,29.49 },
	{ 1699.83,4471.91,30.75 },
	{ 1567.54,4957.51,65.51 },
	{ 1972.0,5137.25,43.17 },
	{ 2381.75,5217.25,56.41 },
	{ 2727.5,4388.75,48.26, },
	{ 2416.5,3747.0,41.78 },
	{ 1671.01,3390.0,37.9 },
	{ 254.51,2920.25,43.06 },
--  {paletoBay}
	{ -542.24,5750.25,36.26 },
	{ -275.24,6035.75,31.58 },
	{ 269.76,6416.25,32.16 },
	{ 666.0,6452.75,31.7 },
	{ 699.01,6877.01,-0.22 },
	{ 256.01,7058.01,1.24 },
	{ 17.0,7053.98,1.39 },
	{ -489.51,6453.2,1.57 },
	{ -714.67,6033.24,3.65 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOTDISTANCE - THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.shotDistance(x,y,z)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	for k,v in pairs(shotDistance) do
		local distance = #(coords - vector3(v[1],v[2],v[3]))
		if distance <= 2500 then
			return true
		end
	end
	
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDISABLECTRL
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999
		if coolTimers > 0 then
			timeDistance = 1
			DisableControlAction(1,36,true)
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COOLTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if coolTimers > 0 then
			coolTimers = coolTimers - 1
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHAKESHOTTING
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) and IsPedArmed(ped,6) then
			timeDistance = 1

			if IsPedShooting(ped) then
				ShakeGameplayCam("SMALL_EXPLOSION_SHAKE",0.10)
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:UPDATESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("police:updateService")
AddEventHandler("police:updateService",function(status)
	policeService = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYGSR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:applyGsr")
AddEventHandler("player:applyGsr",function()
	residual = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GSRCHECK
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.gsrCheck()
	return residual
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSOAP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkSoap()
	local ped = PlayerPedId()
	if IsEntityInWater(ped) and residual then
		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANRESIDUAL
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.cleanResidual()
	residual = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLECARRY
-----------------------------------------------------------------------------------------------------------------------------------------
local uCarry = nil
local iCarry = false
local sCarry = false
function cRP.toggleCarry(source)
	uCarry = source
	iCarry = not iCarry

	local ped = PlayerPedId()
	if iCarry and uCarry then
		AttachEntityToEntity(ped,GetPlayerPed(GetPlayerFromServerId(uCarry)),11816,0.6,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		sCarry = true
	else
		if sCarry then
			DetachEntity(ped,false,false)
			sCarry = false
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.removeVehicle()
	local ped = PlayerPedId()
	if IsPedSittingInAnyVehicle(ped) then
		iCarry = false
		DetachEntity(GetPlayerPed(GetPlayerFromServerId(uCarry)),false,false)
		TaskLeaveVehicle(ped,GetVehiclePedIsUsing(ped),4160)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.putVehicle()
	local veh = vRP.nearVehicle(11)
	if IsEntityAVehicle(veh) then
		local vehSeats = 5
		local ped = PlayerPedId()

		repeat
			vehSeats = vehSeats - 1

			if IsVehicleSeatFree(veh,vehSeats) then
				ClearPedTasks(ped)
				ClearPedSecondaryTask(ped)
				SetPedIntoVehicle(ped,veh,vehSeats)

				if iCarry then
					iCarry = false
					DetachEntity(GetPlayerPed(GetPlayerFromServerId(uCarry)),false,false)
				end

				vehSeats = true
			end
		until vehSeats == true or vehSeats == 0
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:SPAWNSEAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:spawnSeat")
AddEventHandler("player:spawnSeat",function(vehIndex)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local v = NetToEnt(vehIndex)
		if DoesEntityExist(v) then
			SetPedIntoVehicle(PlayerPedId(),v,-1)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.toggleLivery(number)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		SetVehicleLivery(GetVehiclePedIsUsing(ped),number)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXTRAS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.extraVehicle(data)
	local vehicle = vRP.nearVehicle(11)
	if data == "1" then
		if DoesExtraExist(vehicle,1) then
			if IsVehicleExtraTurnedOn(vehicle,1) then
				SetVehicleExtra(vehicle,1,true)
			else
				SetVehicleExtra(vehicle,1,false)
			end
		end
	elseif data == "2" then
		if DoesExtraExist(vehicle,2) then
			if IsVehicleExtraTurnedOn(vehicle,2) then
				SetVehicleExtra(vehicle,2,true)
			else
				SetVehicleExtra(vehicle,2,false)
			end
		end
	elseif data == "3" then
		if DoesExtraExist(vehicle,3) then
			if IsVehicleExtraTurnedOn(vehicle,3) then
				SetVehicleExtra(vehicle,3,true)
			else
				SetVehicleExtra(vehicle,3,false)
			end
		end
	elseif data == "4" then
		if DoesExtraExist(vehicle,4) then
			if IsVehicleExtraTurnedOn(vehicle,4) then
				SetVehicleExtra(vehicle,4,true)
			else
				SetVehicleExtra(vehicle,4,false)
			end
		end
	elseif data == "5" then
		if DoesExtraExist(vehicle,5) then
			if IsVehicleExtraTurnedOn(vehicle,5) then
				SetVehicleExtra(vehicle,5,true)
			else
				SetVehicleExtra(vehicle,5,false)
			end
		end
	elseif data == "6" then
		if DoesExtraExist(vehicle,6) then
			if IsVehicleExtraTurnedOn(vehicle,6) then
				SetVehicleExtra(vehicle,6,true)
			else
				SetVehicleExtra(vehicle,6,false)
			end
		end
	elseif data == "7" then
		if DoesExtraExist(vehicle,7) then
			if IsVehicleExtraTurnedOn(vehicle,7) then
				SetVehicleExtra(vehicle,7,true)
			else
				SetVehicleExtra(vehicle,7,false)
			end
		end
	elseif data == "8" then
		if DoesExtraExist(vehicle,8) then
			if IsVehicleExtraTurnedOn(vehicle,8) then
				SetVehicleExtra(vehicle,8,true)
			else
				SetVehicleExtra(vehicle,8,false)
			end
		end
	elseif data == "9" then
		if DoesExtraExist(vehicle,9) then
			if IsVehicleExtraTurnedOn(vehicle,9) then
				SetVehicleExtra(vehicle,9,true)
			else
				SetVehicleExtra(vehicle,9,false)
			end
		end
	elseif data == "10" then
		if DoesExtraExist(vehicle,10) then
			if IsVehicleExtraTurnedOn(vehicle,10) then
				SetVehicleExtra(vehicle,10,true)
			else
				SetVehicleExtra(vehicle,10,false)
			end
		end
	elseif data == "11" then
		if DoesExtraExist(vehicle,11) then
			if IsVehicleExtraTurnedOn(vehicle,11) then
				SetVehicleExtra(vehicle,11,true)
			else
				SetVehicleExtra(vehicle,11,false)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRUISER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cr",function(source,args)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local veh = GetVehiclePedIsUsing(ped)
		if GetPedInVehicleSeat(veh,-1) == ped and not IsEntityInAir(veh) then
			local speed = GetEntitySpeed(veh) * 2.236936

			if speed >= 10 then
				if args[1] == nil then
					SetEntityMaxSpeed(veh,GetVehicleEstimatedMaxSpeed(veh))
					TriggerEvent("Notify","amarelo","Controle de cruzeiro desativado.",3000)
				else
					if parseInt(args[1]) > 10 then
						SetEntityMaxSpeed(veh,0.45*args[1])
						TriggerEvent("Notify","verde","Controle de cruzeiro ativado.",3000)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered",function(name,args)
	if name == "CEventNetworkEntityDamage" then
		if (GetEntityHealth(args[1]) <= 101 and PlayerPedId() == args[2] and IsPedAPlayer(args[1])) then
			local index = NetworkGetPlayerIndexFromPed(args[1])
			local source = GetPlayerServerId(index)
			TriggerServerEvent("player:deathLogs",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WECOLORS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.weColors(number)
	local ped = PlayerPedId()
	local weapon = GetSelectedPedWeapon(ped)
	SetPedWeaponTintIndex(ped,weapon,parseInt(number))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WELUX
-----------------------------------------------------------------------------------------------------------------------------------------
local wLux = {
	["WEAPON_PISTOL"] = {
		"COMPONENT_PISTOL_VARMOD_LUXE"
	},
	["WEAPON_APPISTOL"] = {
		"COMPONENT_APPISTOL_VARMOD_LUXE"
	},
	["WEAPON_HEAVYPISTOL"] = {
		"COMPONENT_HEAVYPISTOL_VARMOD_LUXE"
	},
	["WEAPON_MICROSMG"] = {
		"COMPONENT_MICROSMG_VARMOD_LUXE"
	},
	["WEAPON_SNSPISTOL"] = {
		"COMPONENT_SNSPISTOL_VARMOD_LOWRIDER"
	},
	["WEAPON_PISTOL50"] = {
		"COMPONENT_PISTOL50_VARMOD_LUXE"
	},
	["WEAPON_COMBATPISTOL"] = {
		"COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER"
	},
	["WEAPON_CARBINERIFLE"] = {
		"COMPONENT_CARBINERIFLE_VARMOD_LUXE"
	},
	["WEAPON_PUMPSHOTGUN"] = {
		"COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER"
	},
	["WEAPON_SAWNOFFSHOTGUN"] = {
		"COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE"
	},
	["WEAPON_SMG"] = {
		"COMPONENT_SMG_VARMOD_LUXE"
	},
	["WEAPON_ASSAULTRIFLE"] = {
		"COMPONENT_ASSAULTRIFLE_VARMOD_LUXE"
	},
	["WEAPON_ASSAULTRIFLE_MK2"] = {
		"COMPONENT_ASSAULTRIFLE_MK2_CAMO_IND_01"
	},
	["WEAPON_ASSAULTSMG"] = {
		"COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WELUX
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.weLux()
	local ped = PlayerPedId()
	for k,v in pairs(wLux) do
		if GetSelectedPedWeapon(ped) == GetHashKey(k) then
			for k2,v2 in pairs(v) do
				GiveWeaponComponentToPed(ped,GetHashKey(k),GetHashKey(v2))
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAM
-----------------------------------------------------------------------------------------------------------------------------------------
local inCamera = false
local camSelect = nil
local coords = nil
local cameras = {
	["1"] = { 433.72,-978.4,34.71,112.67 },
	["2"] = { 424.59,-996.6,34.72,119.06 },
	["3"] = { 438.16,-999.32,33.72,192.76 },
	["4"] = { 148.99,-1036.29,32.34,306.15 },
	["5"] = { 1171.59,-1499.12,40.85,138.9 },
	["6"] = { 1145.03,-1529.39,37.38,144.57 },
	["7"] = { 73.09,-964.68,35.35,133.23 }
}

RegisterNetEvent("player:serviceCamera")
AddEventHandler("player:serviceCamera",function(num)
	local ped = PlayerPedId()

	if not IsPedInAnyVehicle(ped) then
		if inCamera then
			ClearTimecycleModifier()
			DestroyCam(camSelect,false)
			SetEntityInvincible(ped,false)
			SetEntityVisible(ped,true,false)
			SetEntityCoords(ped,coords,1,0,0,0)
			FreezeEntityPosition(ped,false)
			TriggerEvent("hudActived",true)
			RenderScriptCams(false,false,0,1,0)
			PlaySoundFrontend(-1,"HACKING_SUCCESS",false)

			inCamera = false
			camSelect = nil
		else
			if cameras[num] then
				inCamera = true
				coords = GetEntityCoords(ped)
				SetEntityInvincible(ped,true)
				SetEntityVisible(ped,false,false)
				SetEntityCoords(ped,cameras[num][1],cameras[num][2],cameras[num][3],1,0,0,0)
				FreezeEntityPosition(ped,true)
				TriggerEvent("hudActived",false)
				SetTimecycleModifier("heliGunCam")
				PlaySoundFrontend(-1,"HACKING_SUCCESS",false)
				camSelect = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
				SetCamCoord(camSelect,cameras[num][1],cameras[num][2],cameras[num][3])
				SetCamRot(camSelect,-20.0,0.0,cameras[num][4])
				RenderScriptCams(true,false,0,1,0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLEEXTRAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:toggleExtras")
AddEventHandler("player:toggleExtras",function(index,extra)
	if NetworkDoesNetworkIdExist(index) then
		local vehicle = NetToEnt(index)
		if DoesEntityExist(vehicle) then
			local engine = GetVehicleEngineHealth(vehicle)
			local body = GetVehicleBodyHealth(vehicle)
			local fuel = GetVehicleFuelLevel(vehicle)
			local vehWindows = {}
			local vehTyres = {}
			local vehDoors = {}

			for i = 0,7 do
				local tyre_state = 2
				if IsVehicleTyreBurst(vehicle,i,true) then
					tyre_state = 1
				elseif IsVehicleTyreBurst(vehicle,i,false) then
					tyre_state = 0
				end
				vehTyres[i] = tyre_state
			end

			for i = 0,5 do
				vehDoors[i] = IsVehicleDoorDamaged(vehicle,i)
			end

			for i = 0,5 do
				vehWindows[i] = IsVehicleWindowIntact(vehicle,i)
			end

			if extra == "on" then
				for i = 0,12 do
					if DoesExtraExist(vehicle,i) then
						SetVehicleExtra(vehicle,i,false)
					end
				end
			elseif extra == "off" then
				for i = 0,12 do
					if DoesExtraExist(vehicle,i) then
						SetVehicleExtra(vehicle,i,true)
					end
				end
			else
				if IsVehicleExtraTurnedOn(vehicle,parseInt(extra)) then
					SetVehicleExtra(vehicle,parseInt(extra),true)
				else
					SetVehicleExtra(vehicle,parseInt(extra),false)
				end
			end

			SetVehicleEngineHealth(vehicle,engine)
			SetVehicleBodyHealth(vehicle,body)
			SetVehicleFuelLevel(vehicle,fuel)

			for k,v in pairs(vehTyres) do
				if v < 2 then
					SetVehicleTyreBurst(vehicle,k,(v == 1),1000.0)
				end
			end

			for k,v in pairs(vehWindows) do
				if not v then
					SmashVehicleWindow(vehicle,k)
				end
			end

			for k,v in pairs(vehDoors) do
				if v then
					SetVehicleDoorBroken(vehicle,k,v)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:PLAYERACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
local playerActive = false
RegisterNetEvent("vrp:playerActive")
AddEventHandler("vrp:playerActive",function()
	playerActive = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHACKER
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local ped = PlayerPedId()

		if not IsEntityVisible(ped) and not playerInvisible then
			TriggerServerEvent("player:hackerDisplay","está invisível")
		end

		if ForceSocialClubUpdate == nil then
			TriggerServerEvent("player:hackerDisplay","forçou a social club.")
		end

		if ShutdownAndLaunchSinglePlayerGame == nil then
			TriggerServerEvent("player:hackerDisplay","entrou no modo single player.")
		end

		if ActivateRockstarEditor == nil then
			TriggerServerEvent("player:hackerDisplay","ativou o rockstar editor.")
		end

		Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONRESOURCESTOP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onResourceStop",function(resource)
	TriggerServerEvent("player:hackerDisplay","deu stop no resource **"..resource.."**")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETDISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.setDiscord(status)
    SetDiscordAppId(867398054348849202)
    SetDiscordRichPresenceAsset("logo")
    SetDiscordRichPresenceAssetText("Gringa Roleplay")
    SetDiscordRichPresenceAssetSmall("logo")
    SetDiscordRichPresenceAssetSmallText("Gringa Roleplay")
    SetRichPresence(status)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(text)
		SetTextColour(255,255,255,150)
		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x,_y)

		local width = string.len(text) / 160 * 0.45
		DrawRect(_x,_y + 0.0125,width,0.03,38,42,56,200)
	end
end