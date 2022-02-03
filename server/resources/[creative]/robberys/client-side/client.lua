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
Tunnel.bindInterface("robberys",cRP)
vSERVER = Tunnel.getInterface("robberys")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local activeTimers = GetGameTimer()
local startRobbery = false
local robberyTimer = 0
local robberyId = 0
local vars = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINIT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)

			for k,v in pairs(vars) do
				local distance = #(coords - vector3(v.x,v.y,v.z))
				if distance <= v.distance then
					timeDistance = 1
					
					if not startRobbery then
						if distance <= 1 then
							DrawText3D(v.x,v.y,v.z-0.4,"~g~E~w~  ROUBAR",400)
							if distance <= 1 and IsControlJustPressed(1,38) and vSERVER.checkPolice(k,coords) then
								exports["memory"]:StartMinigame({ success = "robberys:startRobbery", fail = nil })
							end
						end
					end
				end
			end
			
			if startRobbery then
				local distance = #(coords - vector3(vars[robberyId].x,vars[robberyId].y,vars[robberyId].z))
				if distance > vars[robberyId].distance or GetEntityHealth(ped) <= 101 then
					SendNUIMessage({ show = false })
					startRobbery = false
					TriggerEvent("Notify","amarelo","Você se afastou demais.",5000)
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERYS:STARTROBBRY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("robberys:startRobbery")
AddEventHandler("robberys:startRobbery",function()
	local timeDistance = 500
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped) then
		local coords = GetEntityCoords(ped)
		
		for k,v in pairs(vars) do
			local distance = #(coords - vector3(v.x,v.y,v.z))
			if distance <= v.distance then
				timeDistance = 1
				
				if not startRobbery then
					if distance <= 1 then
						robberyId = k
						robberyTimer = v["timer"]
						activeTimers = GetGameTimer()
						SendNUIMessage({ show = true, timer = "AGUARDE "..robberyTimer.." SEGUNDOS" })
						startRobbery = true
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if startRobbery then
			if GetGameTimer() >= activeTimers then
				robberyTimer = robberyTimer - 1
				activeTimers = GetGameTimer() + 1000
				SendNUIMessage({ timer = "AGUARDE "..robberyTimer.." SEGUNDOS" })

				if robberyTimer <= 0 then
					vSERVER.paymentRobbery(robberyId)
					SendNUIMessage({ show = false })
					startRobbery = false
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEVARS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateVars(status)
	vars = status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text,height)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(176,180,193,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/height
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,50,55,67,200)
end