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
Tunnel.bindInterface("survival",cRP)
vSERVER = Tunnel.getInterface("survival")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local deadPlayer = false
local deathtimer = 300
local blockControls = false
local emergencyButton = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 100
		local ped = PlayerPedId()
		if GetEntityHealth(ped) <= 101 and deathtimer >= 0 then
			if not deadPlayer then
				timeDistance = 100
				deadPlayer = true
				emergencyButton = false
				SendNUIMessage({ death = true })

				local coords = GetEntityCoords(ped)
				NetworkResurrectLocalPlayer(coords,true,true,false)
				deathtimer = 300

				if not IsEntityPlayingAnim(ped,"dead","dead_a",3) and not IsPedInAnyVehicle(ped) then
					vRP.playAnim(false,{"dead","dead_a"},true)
				end
				
				if IsPedInAnyVehicle(ped) then
					local vehicle = GetVehiclePedIsUsing(ped)
					if GetPedInVehicleSeat(vehicle,-1) == ped then
						SetVehicleEngineOn(vehicle,false,true,true)
					end
				end
				
				SetEntityHealth(ped,101)
				SetEntityInvincible(ped,true)

				TriggerEvent("radio:outServers")
				TriggerServerEvent("inventory:Cancel")
			else
				if deathtimer > 0 then
					timeDistance = 4
					emergencyButton = true
					SetEntityHealth(ped,101)
					TriggerEvent("hudActived",false)
					SendNUIMessage({ deathtext = "DIGITE <color>/GG</color> PARA DESISTIR IMEDIATAMENTE<br><i>OU AGUARDE <color>"..deathtimer.." SEGUNDOS</color></i>" })
					
					if not IsEntityPlayingAnim(ped,"dead","dead_a",3) and not IsPedInAnyVehicle(ped) then
						vRP.playAnim(false,{"dead","dead_a"},true)
					end
				else
					timeDistance = 4
					SendNUIMessage({ deathtext = "SEU TEMPO ACABOU, DIGITE <color>/GG</color>" })
					
					if not IsEntityPlayingAnim(ped,"dead","dead_a",3) and not IsPedInAnyVehicle(ped) then
						vRP.playAnim(false,{"dead","dead_a"},true)
					end
				
				end
			end
		end
		
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEATHTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if deadPlayer and deathtimer > 0 then
			deathtimer = deathtimer - 1
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("gg",function(source,args,rawCommand)
	if deathtimer <= 300 then
		vSERVER.ResetPedToHospital()
		TriggerEvent("hudActived",true)
		SendNUIMessage({ death = false })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISHDEATH
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.finishDeath()
	local ped = PlayerPedId()
	if GetEntityHealth(ped) <= 101 then
		deadPlayer = false
		TriggerEvent("hudActived",true)
		ClearPedBloodDamage(ped)
		SetEntityHealth(ped,200)
		SetEntityInvincible(ped,false)
		ClearPedTasks(ped)
		SendNUIMessage({ death = false })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEALTHRECHARGE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		SetPlayerHealthRechargeMultiplier(PlayerId(),0)
		SetPlayerHealthRechargeLimit(PlayerId(),0)

		if GetEntityMaxHealth(PlayerPedId()) ~= 200 then
			SetEntityMaxHealth(PlayerPedId(),200)
			SetPedMaxHealth(PlayerPedId(),200)
		end

		Citizen.Wait(100)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEADPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.deadPlayer()
	return deadPlayer
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVIVEPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.revivePlayer(health)
	SetEntityHealth(PlayerPedId(),health)
	SetEntityInvincible(PlayerPedId(),false)
	TriggerEvent("hudActived",true)
	SendNUIMessage({ death = false })
	
	if deadPlayer then
		deadPlayer = false
		ClearPedTasks(PlayerPedId())
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("survival:CheckIn")
AddEventHandler("survival:CheckIn",function()
	SetEntityHealth(PlayerPedId(),102)
	SetEntityInvincible(PlayerPedId(),false)

	Citizen.Wait(500)

	deadPlayer = false
	blockControls = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("updatePrison")
AddEventHandler("updatePrison",function()
	SetEntityHealth(PlayerPedId(),110)
	SetEntityInvincible(PlayerPedId(),false)

	if deadPlayer then
		deadPlayer = false
		blockControls = true
		ClearPedTasks(PlayerPedId())
		TriggerEvent("resetBleeding")
		TriggerEvent("resetDiagnostic")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKCONTROLS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 100
		local ped = PlayerPedId()
		if blockControls or deadPlayer then
			timeDistance = 4
			DisablePlayerFiring(ped,true)
			DisableControlAction(1,22,true)
			DisableControlAction(1,56,true)
			DisableControlAction(1,73,true)
			DisableControlAction(1,167,true)
			DisableControlAction(1,29,true)
			DisableControlAction(1,182,true)
			DisableControlAction(1,187,true)
			DisableControlAction(1,189,true)
			DisableControlAction(1,190,true)
			DisableControlAction(1,188,true)
			DisableControlAction(1,311,true)
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTCURE
-----------------------------------------------------------------------------------------------------------------------------------------
local cure = false
function cRP.startCure()
	local ped = PlayerPedId()

	if cure then
		return
	end

	cure = true
	TriggerEvent("Notify","verde","Tratamento iniciado.",3000)

	if cure then
		repeat
			Citizen.Wait(5000)
			if GetEntityHealth(ped) > 101 then
				SetEntityHealth(ped,GetEntityHealth(ped)+1)
			end
		until GetEntityHealth(ped) >= 200 or GetEntityHealth(ped) <= 101
		TriggerEvent("Notify","verde","Tratamento concluído.",3000)
			ClearPedTasks(ped)
			cure = false
			blockControls = false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local beds = {
	{ GetHashKey("v_med_bed1"),0.0,0.0 },
	{ GetHashKey("v_med_bed2"),0.0,0.0 },
	{ -1498379115,1.0,90.0 },
	{ -1519439119,1.0,0.0 },
	{ -289946279,1.0,0.0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPEDINBED
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.SetPedInBed()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))

	for k,v in pairs(beds) do
		local object = GetClosestObjectOfType(x,y,z,0.9,v[1],0,0,0)
		if DoesEntityExist(object) then
			local x2,y2,z2 = table.unpack(GetEntityCoords(object))
			
			SetEntityCoords(ped,x2,y2,z2+v[2])
			SetEntityHeading(ped,GetEntityHeading(object)+v[3]-180.0)

			vRP.playAnim(false,{"dead","dead_a"},true)

			SetTimeout(7000,function()
				TriggerServerEvent("inventory:Cancel")
			end)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SCREENFADEINOUT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("survival:FadeOutIn")
AddEventHandler("survival:FadeOutIn",function()
	DoScreenFadeOut(1000)
	Citizen.Wait(5000)
	DoScreenFadeIn(1000)
end)