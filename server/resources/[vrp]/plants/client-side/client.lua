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
Tunnel.bindInterface("plants",cRP)
vSERVER = Tunnel.getInterface("plants")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local wePlants = {}
local weObjects = {}
local weHashsA = "bkr_prop_weed_01_small_01c"
local weHashsB = "bkr_prop_weed_01_small_01a"
local weHashsC = "bkr_prop_weed_med_01a"
local weHashsD = "bkr_prop_weed_lrg_01a"
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		for k,v in pairs(wePlants) do
			local distance = #(coords - vector3(v[1],v[2],v[3]))
			if distance < 25 then
				if weObjects[k] == nil then
					if v[4] <= 39 then
						createModels(k,weHashsA,v[1],v[2],v[3])
					elseif v[4] >= 40 and v[4] <= 69 then
						createModels(k,weHashsB,v[1],v[2],v[3])
					elseif v[4] >= 70 and v[4] <= 99 then
						createModels(k,weHashsC,v[1],v[2],v[3])
					elseif v[4] >= 100 then
						createModels(k,weHashsD,v[1],v[2],v[3])
					end
				else
					timeDistance = 4

					if distance <= 2 then
						if parseInt(v[4]) >= 100 then
							DrawText3D(v[1],v[2],v[3]-0.5,"~g~E~w~   COLETAR")
						else
							DrawText3D(v[1],v[2],v[3]-0.5,"~y~"..v[4].."%~w~   PROGRESSO")
						end
					end

					if distance <= 0.7 then
						if IsControlJustPressed(1,38) and vSERVER.checkTimers(k) then
							if DoesEntityExist(weObjects[k]) then
								vSERVER.removePlants(k)
							end
						end
					end
				end
			else
				if weObjects[k] then
					TriggerEvent("weplants:removeExists",k)
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSPLANTS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.pressPlants(x,y,z)
	vSERVER.pressPlants(x,y,z)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLEUPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("weplants:tableUpdate")
AddEventHandler("weplants:tableUpdate",function(status)
	wePlants = status

	for k,v in pairs(wePlants) do
		if DoesEntityExist(weObjects[k]) then
			if v[4] == 40 then
				TriggerEvent("weplants:removeExists",k)
			elseif v[4] == 70 then
				TriggerEvent("weplants:removeExists",k)
			elseif v[4] == 100 then
				TriggerEvent("weplants:removeExists",k)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOGIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("weplants:tableUpdateLogin")
AddEventHandler("weplants:tableUpdateLogin",function(status)
	wePlants = status

	for k,v in pairs(wePlants) do
		if DoesEntityExist(weObjects[k]) then
			if v[4] <= 40 then
				TriggerEvent("weplants:removeExists",k)
				createModels(k,weHashsB,v[1],v[2],v[3])
			elseif v[4] <= 70 and v[4] >= 40 then
				TriggerEvent("weplants:removeExists",k)
				createModels(k,weHashsC,v[1],v[2],v[3])
			elseif v[4] >= 100 then
				TriggerEvent("weplants:removeExists",k)
				createModels(k,weHashsD,v[1],v[2],v[3])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEMODELS
-----------------------------------------------------------------------------------------------------------------------------------------
function createModels(id,hash,x,y,z)
	local mHash = GetHashKey(hash)

	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		RequestModel(mHash)
		Citizen.Wait(10)
	end

	weObjects[id] = CreateObjectNoOffset(mHash,x,y,z,false,true,true)
	SetEntityAsMissionEntity(weObjects[id],true,true)
	PlaceObjectOnGroundProperly(weObjects[id])
	FreezeEntityPosition(weObjects[id],true)
	SetModelAsNoLongerNeeded(mHash)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEEXISTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("weplants:removeExists")
AddEventHandler("weplants:removeExists",function(id)
	if DoesEntityExist(weObjects[id]) then
		SetEntityAsMissionEntity(weObjects[id],false,false)
		DeleteEntity(weObjects[id])
		weObjects[id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTITYINWORLDCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.entityInWorldCoords()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	if DoesObjectOfTypeExistAtCoords(x,y,z,0.6,GetHashKey(weHashsA),true) or DoesObjectOfTypeExistAtCoords(x,y,z,0.6,GetHashKey(weHashsB),true) or DoesObjectOfTypeExistAtCoords(x,y,z,0.6,GetHashKey(weHashsC),true) or DoesObjectOfTypeExistAtCoords(x,y,z,0.6,GetHashKey(weHashsD),true) then
		return false
	end
	
	return true,x,y,z
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKWATER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkWater()
	return IsEntityInWater(PlayerPedId())
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