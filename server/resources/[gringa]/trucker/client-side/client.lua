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
Tunnel.bindInterface("trucker",cRP)
vSERVER = Tunnel.getInterface("trucker")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inSeconds = 0
local serviceBlip = nil
local initStage = false
local getPackage = false
local deliveryLocates = 1
local packageVehicle = nil
local initCoords = { 1239.87,-3257.2,7.09 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- PACKSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
local packService = {
	{ 1725.68,4701.59,41.91,"tr4" },
	{ 1682.1,4923.7,41.45,"armytanker" },
	{ -688.78,5778.91,16.7,"tvtrailer" },
	{ 154.75,6612.86,31.27,"tanker" },
	{ -576.72,5329.59,69.61,"trailerlogs" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUCKER:INITSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("trucker:initService")
AddEventHandler("trucker:initService",function()
	local ped = PlayerPedId(-1)
	local coords = GetEntityCoords(ped)
	if not IsPedInAnyVehicle(ped) then
		if not getPackage then
			local distance = #(coords - vector3(initCoords[1],initCoords[2],initCoords[3]))
			if distance <= 3 then
				if not initStage then
					if distance <= 1 and inSeconds <= 0 and vSERVER.timersevice() then
						deliveryLocates = math.random(#packService)
						TriggerEvent("Notify","amarelo","Dirija-se até seu caminhão <b>Packer</b> e buzine o mesmo<br>para receber a carga responsável pelo transporte.",5000)
						makeBlipMarked(packService[deliveryLocates][1],packService[deliveryLocates][2],packService[deliveryLocates][3])
						getPackage = true
						inSeconds = 3
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)

			if not getPackage then
				local distance = #(coords - vector3(initCoords[1],initCoords[2],initCoords[3]))
				if distance <= 3 then
					timeDistance = 4

					if initStage then
						DrawText3D(initCoords[1],initCoords[2],initCoords[3],"~g~E~w~   RECEBER PAGAMENTO")

						if IsControlJustPressed(1,38) and distance <= 1 and inSeconds <= 0 and GetEntityModel(GetPlayersLastVehicle()) == 569305213 then
							vSERVER.paymentMethod()
							vSERVER.sdka(500)
							packageVehicle = nil
							initStage = false
							inSeconds = 3

							if DoesBlipExist(serviceBlip) then
								RemoveBlip(serviceBlip)
								serviceBlip = nil
							end
						end
					end
				end
			else
				local distance = #(coords - vector3(packService[deliveryLocates][1],packService[deliveryLocates][2],packService[deliveryLocates][3]))
				if distance <= 200 then
					timeDistance = 4
					DrawMarker(1,packService[deliveryLocates][1],packService[deliveryLocates][2],packService[deliveryLocates][3] - 3,0,0,0,0,0,0,12.0,12.0,8.0,255,255,255,25,0,0,0,0)
					DrawMarker(21,packService[deliveryLocates][1],packService[deliveryLocates][2],packService[deliveryLocates][3] + 1,0,0,0,0,180.0,130.0,3.0,3.0,2.0,42,137,255,100,0,0,0,1)

					if not IsPedInAnyVehicle(ped) and IsControlJustPressed(1,38) and inSeconds <= 0 and distance <= 5 then
						inSeconds = 3

						local _,vehNet,vehPlate,modelVehicle = vRP.vehList(10)
						if modelVehicle == packService[deliveryLocates][4] then
							TriggerEvent("Notify","amarelo","Volte ao ponto de partida e receba o pagamento.",5000)
							TriggerServerEvent("garages:DeleteVehicle",vehNet,vehPlate)
							makeBlipMarked(initCoords[1],initCoords[2],initCoords[3])
							getPackage = false
							initStage = true
						end
					end
				end
			end
		else
			if getPackage and packageVehicle == nil then
				local coords = GetEntityCoords(ped)
				local distance = #(coords - vector3(initCoords[1],initCoords[2],initCoords[3]))
				if distance <= 50 then
					local veh = GetVehiclePedIsUsing(ped)
					if GetEntityModel(veh) == 569305213 then
						timeDistance = 4

						if IsControlJustPressed(1,38) and inSeconds <= 0 then
							inSeconds = 3

							local heading = GetEntityHeading(veh)
							local mHash = GetHashKey(packService[deliveryLocates][4])
							local vehCoords = GetOffsetFromEntityInWorldCoords(veh,0.0,-12.0,0.0)

							RequestModel(mHash)
							while not HasModelLoaded(mHash) do
								Wait(1)
							end

							if HasModelLoaded(mHash) then
								local _,groundZ = GetGroundZAndNormalFor_3dCoord(vehCoords["x"],vehCoords["y"],vehCoords["z"])
								packageVehicle = CreateVehicle(mHash,vehCoords["x"],vehCoords["y"],groundZ,heading,true,false)
								local netveh = NetworkGetNetworkIdFromEntity(packageVehicle)

								NetworkRegisterEntityAsNetworked(packageVehicle)
								while not NetworkGetEntityIsNetworked(packageVehicle) do
									NetworkRegisterEntityAsNetworked(packageVehicle)
									Wait(1)
								end
					
								if NetworkDoesNetworkIdExist(netveh) then
									SetEntitySomething(packageVehicle,true)
					
									if NetworkGetEntityIsNetworked(packageVehicle) then
										SetNetworkIdCanMigrate(netveh,true)
										NetworkSetNetworkIdDynamic(netveh,true)
										SetNetworkIdExistsOnAllMachines(netveh,true)
									end
								end
					
								SetNetworkIdSyncToPlayer(netveh,PlayerId(),true)

								SetEntityInvincible(packageVehicle,true)
								SetVehicleOnGroundProperly(packageVehicle)
								SetEntityAsMissionEntity(packageVehicle,true,true)
								SetVehicleHasBeenOwnedByPlayer(packageVehicle,true)
								SetVehicleNeedsToBeHotwired(packageVehicle,false)

								SetModelAsNoLongerNeeded(mHash)
							end
						end
					end
				end
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSECONDS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if inSeconds > 0 then
			inSeconds = inSeconds - 1
		end

		Wait(1000)
	end
end)
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEBLIPMARKED
-----------------------------------------------------------------------------------------------------------------------------------------
function makeBlipMarked(x,y,z)
	if DoesBlipExist(serviceBlip) then
		RemoveBlip(serviceBlip)
		serviceBlip = nil
	end

	serviceBlip = AddBlipForCoord(x,y,z)
	SetBlipSprite(serviceBlip,12)
	SetBlipColour(serviceBlip,84)
	SetBlipScale(serviceBlip,0.9)
	SetBlipRoute(serviceBlip,true)
	SetBlipAsShortRange(serviceBlip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Caminhoneiro")
	EndTextCommandSetBlipName(serviceBlip)
end