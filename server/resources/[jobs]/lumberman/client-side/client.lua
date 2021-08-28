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
Tunnel.bindInterface("lumberman",cRP)
vSERVER = Tunnel.getInterface("lumberman")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local currentStatus = false
local serviceStatus = false
local selected = 0
local timeSeconds = 0
local collectBlip = nil
local deliverBlip = nil
local coSelected = 0
local deSelected = 0
local vehModel = -667151410
local initService = { -840.64,5398.94,34.61 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVER
-----------------------------------------------------------------------------------------------------------------------------------------
local deliver = {
	[1] = { -513.92,-1019.31,23.47 },
	[2] = { -1604.18,-832.26,10.08 },
	[3] = { -536.48,-45.61,42.57 },
	[4] = { -53.01,79.35,71.62 },
	[5] = { 581.16,139.13,99.48 },
	[6] = { 814.39,-93.48,80.6 },
	[7] = { 1106.93,-355.03,67.01 },
	[8] = { 1070.71,-780.46,58.36 },
	[9] = { 1142.82,-986.58,45.91 },
	[10] = { 1200.55,-1276.6,35.23 },
	[11] = { 967.81,-1829.29,31.24 },
	[12] = { 809.16,-2222.61,29.65 },
	[13] = { 684.61,-2741.62,6.02 },
	[14] = { 263.47,-2506.62,6.45 },
	[15] = { 94.66,-2676.38,6.01 },
	[16] = { -43.87,-2519.91,7.4 },
	[17] = { 182.93,-2027.68,18.28 },
	[18] = { -306.86,-2191.84,10.84 },
	[19] = { -570.95,-1775.95,23.19 },
	[20] = { -428.6,-1728.32,19.79 },
	[21] = { -350.03,-1569.9,25.23 },
	[22] = { -128.36,-1394.12,29.57 },
	[23] = { 67.84,-1399.02,29.37 },
	[24] = { 343.13,-1297.91,32.51 },
	[25] = { 485.92,-1477.41,29.29 },
	[26] = { 139.81,-1337.41,29.21 },
	[27] = { 263.82,-1346.16,31.93 },
	[28] = { -723.33,-1112.41,10.66 },
	[29] = { -842.54,-1128.21,7.02 },
	[30] = { 488.46,-898.56,25.94 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POUCHS
-----------------------------------------------------------------------------------------------------------------------------------------
local collect = {
	[1] = { -642.97,5461.49,53.42,161.0 },
	[2] = { -632.4,5466.41,53.66,283.15 },
	[3] = { -629.19,5470.14,53.64,312.44 },
	[4] = { -625.47,5474.39,53.31,131.34 },
	[5] = { -620.03,5488.33,51.58,312.19 },
	[6] = { -633.65,5505.16,51.26,33.24 },
	[7] = { -637.87,5503.96,51.48,57.04 },
	[8] = { -662.4,5496.55,48.73,120.35 },
	[9] = { -666.62,5497.73,47.89,88.0 },
	[10] = { -660.21,5490.28,49.71,293.86 },
	[11] = { -637.85,5441.62,52.52,192.87 },
	[12] = { -616.07,5433.55,53.41,228.47 },
	[13] = { -615.3,5424.46,51.07,102.64 },
	[14] = { -595.79,5450.51,58.97,315.87 },
	[15] = { -586.94,5447.71,60.17,265.4 },
	[16] = { -597.49,5472.95,56.5,23.67 },
	[17] = { -583.59,5490.44,55.83,24.95 },
	[18] = { -588.84,5493.79,54.45,32.45 },
	[19] = { -617.65,5489.06,51.64,93.35 },
	[20] = { -619.22,5498.12,51.31,122.45 }
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
						
						if DoesBlipExist(collectBlip) then
						    RemoveBlip(collectBlip)
						    collectBlip = nil
						end

						if DoesBlipExist(deliverBlip) then
						    RemoveBlip(deliverBlip)
						    deliverBlip = nil
						end
						
						TriggerEvent("Notify","amarelo","Serviço finalizado.",5000)
					else
						currentStatus = false
						serviceStatus = true
						
						startthreadservice()
						startthreadserviceseconds()
						coSelected = math.random(#collect)
						deSelected = math.random(#deliver)
						makeCollectMarked()
						makeDeliveryMarked()
						
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
				if not IsPedInAnyVehicle(ped) then
					local coords = GetEntityCoords(ped)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLLECTDIS
-----------------------------------------------------------------------------------------------------------------------------------------
					local collectDis = #(coords - vector3(collect[coSelected][1],collect[coSelected][2],collect[coSelected][3]))
					if collectDis <= 250 then
						timeDistance = 4
						DrawText3D(collect[coSelected][1],collect[coSelected][2],collect[coSelected][3],"~g~E~w~   CORTAR")
						if collectDis <= 0.6 and IsControlJustPressed(1,38) and GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_HATCHET") and timeSeconds <= 0 then
							timeSeconds = 2
							SetEntityHeading(ped,collect[coSelected][4])
							SetEntityCoords(ped,collect[coSelected][1],collect[coSelected][2],collect[coSelected][3]-1)
							TriggerEvent("cancelando",true)
							TriggerEvent("Progress",10000,"Cortando...")
							vRP.playAnim(false,{"amb@world_human_hammering@male@base","base"},true)
							Wait(10000)
							
							if vSERVER.collectMethod() then
								SetEntityHeading(ped,collect[coSelected][4])
								SetEntityCoords(ped,collect[coSelected][1],collect[coSelected][2],collect[coSelected][3]-1)
								TriggerEvent("cancelando",false)
								ClearPedTasks(ped)
								vRP.removeObjects()
								coSelected = math.random(#collect)
								makeCollectMarked()
							end
						end
					end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVERDIS
-----------------------------------------------------------------------------------------------------------------------------------------
					local deliverDis = #(coords - vector3(deliver[deSelected][1],deliver[deSelected][2],deliver[deSelected][3]))
					if deliverDis <= 50 then
						timeDistance = 4
						DrawText3D(deliver[deSelected][1],deliver[deSelected][2],deliver[deSelected][3],"~g~E~w~   ENTREGAR")
						if deliverDis <= 0.6 and IsControlJustPressed(1,38) and GetEntityModel(GetPlayersLastVehicle()) == vehModel and timeSeconds <= 0 then
							timeSeconds = 2
							if vSERVER.paymentMethod() then
								deSelected = math.random(#deliver)
								makeDeliveryMarked()
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
-- COLLECTBLIPRACE
-----------------------------------------------------------------------------------------------------------------------------------------
function makeCollectMarked(x,y,z)
	if DoesBlipExist(blipCollect) then
		RemoveBlip(blipCollect)
		blipCollect = nil
	end

	blipCollect = AddBlipForCoord(collect[coSelected][1],collect[coSelected][2],collect[coSelected][3])
	SetBlipSprite(blipCollect,12)
	SetBlipColour(blipCollect,5)
	SetBlipScale(blipCollect,0.9)
	SetBlipAsShortRange(blipCollect,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Coletar")
	EndTextCommandSetBlipName(blipCollect)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEDELIVERYMARKED
-----------------------------------------------------------------------------------------------------------------------------------------
function makeDeliveryMarked(x,y,z)
	if DoesBlipExist(blipDelivery) then
		RemoveBlip(blipDelivery)
		blipDelivery = nil
	end

	blipDelivery = AddBlipForCoord(deliver[deSelected][1],deliver[deSelected][2],deliver[deSelected][3])
	SetBlipSprite(blipDelivery,12)
	SetBlipColour(blipDelivery,5)
	SetBlipScale(blipDelivery,0.9)
	SetBlipAsShortRange(blipDelivery,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entregar")
	EndTextCommandSetBlipName(blipDelivery)
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