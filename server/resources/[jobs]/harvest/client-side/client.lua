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
Tunnel.bindInterface("harvest",cRP)
vSERVER = Tunnel.getInterface("harvest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local currentStatus = false
local serviceStatus = false
local initService = { 406.08,6526.17,27.75 }
local selected = 0
local blip = nil
local coSelected = 0
local timeSeconds = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- POUCHS
-----------------------------------------------------------------------------------------------------------------------------------------
local collect = {
	{ 377.99,6506.41,27.98,154.79 },
	{ 369.9,6506.29,28.45,196.03 },
	{ 363.49,6506.12,28.55,140.57 },
	{ 355.58,6505.52,28.49,142.85 },
	{ 348.11,6505.8,28.81,134.01 },
	{ 340.15,6505.76,28.7,117.29 },
	{ 331.26,6506.03,28.53,138.17 },
	{ 321.68,6505.83,29.22,183.63 },
	{ 378.7,6517.62,28.34,60.6 },
	{ 370.44,6517.58,28.38,83.26 },
	{ 363.0,6517.54,28.28,47.32 },
	{ 356.01,6517.31,28.15,74.51 },
	{ 347.98,6517.31,28.76,64.82 },
	{ 339.44,6517.3,28.95,87.03 },
	{ 330.71,6517.92,28.96,113.39 },
	{ 322.44,6517.45,29.13,79.3 },
	{ 369.83,6531.48,28.39,57.51 },
	{ 361.99,6531.2,28.36,90.89 },
	{ 354.15,6530.48,28.39,55.76 },
	{ 346.51,6531.36,28.68,70.34 },
	{ 339.08,6531.43,28.57,94.57 },
	{ 329.58,6531.5,28.62,170.32 },
	{ 322.34,6531.11,29.13,93.59 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(initService[1],initService[2],initService[3]))
			if distance <= 2 then
				timeDistance = 1

				if serviceStatus then
					DrawText3D(initService[1],initService[2],initService[3],"~g~E~w~   FINALIZAR")
				else
					DrawText3D(initService[1],initService[2],initService[3],"~g~E~w~   INICIAR")
				end

				if IsControlJustPressed(1,38) then
					if serviceStatus then
					    currentStatus = true
						serviceStatus = false
						TriggerEvent("Notify","amarelo","Serviço finalizado.",5000)
						
						if DoesBlipExist(blip) then
							RemoveBlip(blip)
							blip = nil
						end
					else
						currentStatus = false
						serviceStatus = true
						startthreadservice()
						startthreadserviceseconds()
						coSelected = math.random(#collect)
						makeBlipMarked()
						TriggerEvent("Notify","amarelo","Serviço iniciado.",5000)
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function startthreadservice()
	Citizen.CreateThread(function()
		while true do
			local timeDistance = 500
			if serviceStatus then
				local ped = PlayerPedId()
				local coords = GetEntityCoords(ped)
				local collectDis = #(coords - vector3(collect[coSelected][1],collect[coSelected][2],collect[coSelected][3]))
				if collectDis <= 150 then
					timeDistance = 4
					DrawText3D(collect[coSelected][1],collect[coSelected][2],collect[coSelected][3],"~g~E~w~  COLHER")
					if collectDis <= 0.8 and IsControlJustPressed(1,38) and timeSeconds <= 0 then
						timeSeconds = 2
						TriggerEvent("player:blockCommands",true)
						TriggerEvent("cancelando",true)
						TriggerEvent("Progress",5000,"Colhendo...")
						vRP.playAnim(true,{"amb@prop_human_movie_bulb@base","base"},true)
						SetEntityHeading(ped,collect[coSelected][4])
						SetEntityCoords(ped,collect[coSelected][1],collect[coSelected][2],collect[coSelected][3]-1)
						Citizen.Wait(5000)
						TriggerEvent("player:blockCommands",false)
						vSERVER.collectMethod()
						TriggerEvent("cancelando",false)
						vRP.removeObjects()
						coSelected = math.random(#collect)
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
function startthreadserviceseconds()
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
-- MAKEBLIPRACE
-----------------------------------------------------------------------------------------------------------------------------------------
function makeBlipMarked()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
		blip = nil
	end

	blip = AddBlipForCoord(collect[coSelected][1],collect[coSelected][2],collect[coSelected][3])
	SetBlipSprite(blip,1)
	SetBlipColour(blip,84)
	SetBlipScale(blip,0.4)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Colheita")
	EndTextCommandSetBlipName(blip)
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