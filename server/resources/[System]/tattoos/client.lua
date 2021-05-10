local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

L1c = {}
Tunnel.bindInterface("tattoos",L1c)
L1s = Tunnel.getInterface("tattoos")

local cfg = module("tattoos","cfg/tattoos")

local delay = 0

local myTattoos = {}

Citizen.CreateThread(function()
	while true do
		if IsControlJustPressed(0, 38) then
			if delay == 0 then
            	local pCoords = GetEntityCoords(PlayerPedId())
            	for k,v in pairs(cfg.shops) do
					if GetDistanceBetweenCoords(v[1],v[2],v[3], pCoords[1], pCoords[2], pCoords[3], true) <= 1 then
						SetNuiFocus(true, true)
						SendNUIMessage({ action = "openUI" })
					end
				end
			end
		end
		Citizen.Wait(1)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if delay > 0 then
            delay = delay - 1
        end
    end
end)

RegisterNUICallback("L1Tattoos_closeUI",function(data,cb)
	SetNuiFocus(false, false)
	SendNUIMessage({ action = "closeUI" })
end)

RegisterNUICallback("L1Tattoos_getTattoosFromType",function(data,cb)
	local resultTable = L1s.getUserTattooDataAndPrices(data)
	cb({ tattoosList = resultTable})
end)

RegisterNUICallback("L1Tattoos_rotatePed",function(data)
	if data.rotateMais then
		SetEntityHeading(PlayerPedId(-1),(GetEntityHeading(PlayerPedId(-1)))+15)
	elseif data.rotateMenos then
		SetEntityHeading(PlayerPedId(-1),(GetEntityHeading(PlayerPedId(-1)))-15)
	end
end)

RegisterNUICallback("L1Tattoos_getTattooTypeList",function(data,cb)
	if cfg.tattoos then
		cb({ tattooType = cfg.tattoos })
	end
end)

RegisterNUICallback("L1Tattoos_previewTattoo",function(data,cb)
	ClearPedDecorations(GetPlayerPed(-1))
	if myTattoos then
		if myTattoos[data.tattooIndex] then
			for k,v in pairs(myTattoos) do
				if k ~= data.tattooIndex then
					SetPedDecoration(GetPlayerPed(-1),GetHashKey(v),GetHashKey(k))
				end
			end
		else
			for k,v in pairs(myTattoos) do
				if myTattoos[data.tattooIndex] ~= k then
					SetPedDecoration(GetPlayerPed(-1),GetHashKey(v),GetHashKey(k))
				end
			end
			SetPedDecoration(GetPlayerPed(-1),GetHashKey(data.tattooType),GetHashKey(data.tattooIndex))
		end
	else
		SetPedDecoration(GetPlayerPed(-1),GetHashKey(data.tattooType),GetHashKey(data.tattooIndex))
	end
end)

RegisterNUICallback("L1Tattoos_clearLastPreviewTattoo",function(data,cb)
	if data then
		ClearPedDecorations(GetPlayerPed(-1))
		L1c.refreshTattoos()
	end
end)

RegisterNUICallback("L1Tattoos_saveTattoo",function(data,cb)
	if data then
		L1s.buyTattoos(data)
	end
end)

function L1c.setTattoos(custom)
	if custom then
		myTattoos = custom
	end
	L1c.refreshTattoos()
end

function L1c.setSpecifiedTattoo(tattooIndex,tattooType)
	if myTattoos[tattooIndex] then
		myTattoos[tattooIndex] = nil
		L1s.saveTattoos(myTattoos)
		L1c.refreshTattoos()
	else
		if tattooIndex and tattooType then
			myTattoos[tattooIndex] = tattooType
			L1s.saveTattoos(myTattoos)
			L1c.refreshTattoos()
		end
	end
end

function L1c.getTattoosAndCFG()
	if myTattoos then
		return myTattoos,cfg
	end
end

function L1c.refreshTattoos()
	if myTattoos then
		ClearPedDecorations(GetPlayerPed(-1))
		for k,v in pairs(myTattoos) do
			SetPedDecoration(GetPlayerPed(-1), GetHashKey(v), GetHashKey(k))
		end
	end
end

function L1c.refreshNUITattoos()
	SendNUIMessage({ action = "refreshTattoos" })
end