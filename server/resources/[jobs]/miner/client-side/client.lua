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
Tunnel.bindInterface("miner",cRP)
vSERVER = Tunnel.getInterface("miner")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local currentStatus = false
local serviceStatus = false
local selected = 0
local blip = nil
local coSelected = 0
local timeSeconds = 0
local initService = { 2964.43,2752.88,43.32 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- POUCHS
-----------------------------------------------------------------------------------------------------------------------------------------
local collect = {
	{ 2973.47,2745.55,43.21,270.88 },
	{ 2983.12,2762.71,43.32,333.34 },
	{ 2992.41,2753.67,43.08,252.75 },
	{ 3002.67,2773.15,43.55,354.43 },
	{ 2992.32,2776.39,43.12,82.3 },
	{ 2980.98,2782.05,40.14,227.03 },
	{ 2979.72,2790.44,41.61,15.65 },
	{ 2976.18,2796.44,41.39,238.56 },
	{ 2964.2,2774.65,39.45,156.76 },
	{ 2959.95,2765.91,41.95,150.43 },
	{ 2953.99,2770.37,39.38,42.67 },
	{ 2957.25,2772.47,40.18,313.1 },
	{ 2942.93,2761.11,41.89,148.98 },
	{ 2938.14,2757.65,44.02,125.6 },
	{ 2929.13,2765.4,44.59,46.62 },
	{ 2939.17,2769.19,39.71,301.87 },
	{ 2937.93,2773.98,39.61,25.62 },
	{ 2931.45,2786.2,39.54,41.55 },
	{ 2927.19,2791.45,40.38,48.26 },
	{ 2925.8,2796.38,41.47,183.42 },
	{ 2922.34,2799.53,41.32,92.45 },
	{ 2925.5,2812.93,44.62,327.95 },
	{ 2936.3,2814.07,43.96,235.51 },
	{ 2943.65,2817.98,42.88,285.65 },
	{ 2947.91,2820.87,43.53,280.21 },
	{ 2956.63,2819.92,43.0,64.33 },
	{ 2959.02,2820.37,43.73,177.92 },
	{ 2972.03,2799.33,42.12,206.54 },
	{ 2976.67,2793.06,41.24,198.72 },
	{ 2980.52,2781.7,39.75,308.95 },
	{ 2990.82,2776.8,43.64,188.35 },
	{ 3002.08,2773.96,43.0,245.23 },
	{ 2981.75,2781.1,39.83,37.01 }
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
						
						if DoesBlipExist(blip) then
						    RemoveBlip(blip)
						    blip = nil
						end
						
						TriggerEvent("Notify","amarelo","Serviço finalizado.",5000)
					else
						currentStatus = false
						serviceStatus = true
						startmineservice()
						startmineserviceseconds()
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
function startmineservice()
	Citizen.CreateThread(function()
		while true do
			local timeDistance = 500
			if serviceStatus then
				local ped = PlayerPedId()
				if not IsPedInAnyVehicle(ped) then
					local coords = GetEntityCoords(ped)
					local collectDis = #(coords - vector3(collect[coSelected][1],collect[coSelected][2],collect[coSelected][3]))
					if collectDis <= 150 then
						timeDistance = 4
						DrawText3D(collect[coSelected][1],collect[coSelected][2],collect[coSelected][3],"~g~E~w~  MINERAR")
						if collectDis <= 1 and IsControlJustPressed(1,38) and timeSeconds <= 0 then
							SetEntityHeading(ped,collect[coSelected][4])
							SetEntityCoords(ped,collect[coSelected][1],collect[coSelected][2],collect[coSelected][3]-1)
							timeSeconds = 2
							TriggerEvent("cancelando",true)
							TriggerEvent("Progress",10000,"Minerando...")
							vRP.createObjects("amb@world_human_const_drill@male@drill@base","base","prop_tool_jackham",15,28422)
							Wait(10000)
							vSERVER.collectMethod()
							TriggerEvent("cancelando",false)
							ClearPedTasks(ped)
							vRP.removeObjects("one")
							coSelected = math.random(#collect)
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
function startmineserviceseconds()
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
	AddTextComponentString("Minério")
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