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
Tunnel.bindInterface("tablet",cRP)
vSERVER = Tunnel.getInterface("tablet")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tablet",function(source,args)
	if not exports["player"]:blockCommands() and not exports["player"]:handCuff() then
		local ped = PlayerPedId()
		if not IsEntityInWater(ped) and GetEntityHealth(ped) > 101 then
			SetNuiFocus(true,true)
			SetCursorLocation(0.5,0.5)
			SendNUIMessage({ action = "openSystem" })

			if not IsPedInAnyVehicle(PlayerPedId()) then
				vRP.removeObjects()
				vRP.createObjects("amb@code_human_in_bus_passenger_idles@female@tablet@base","base","prop_cs_tablet",50,28422)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("tablet","Abrir o tablet","keyboard","f1")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeSystem",function(data)
	vRP.removeObjects()
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ action = "closeSystem" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTRANKING
-----------------------------------------------------------------------------------------------------------------------------------------
--RegisterNUICallback("requestRanking",function(data,cb)
--	cb(vSERVER.requestRanking(data["raceId"]))
--	local result = vSERVER.requestRanking(data.raceId)
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTMEDIA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMedia",function(data,cb)
	local result = vSERVER.requestMedia(data.media)
	if result then
		cb(json.encode(result))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("messageMedia",function(data,cb)
	vSERVER.messageMedia(data.message,data.page)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLET:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tablet:Update")
AddEventHandler("tablet:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEMEDIA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tablet:updateMedia")
AddEventHandler("tablet:updateMedia",function(media,data,back)
	SendNUIMessage({ action = "messageMedia", media = media, data = data, back = back })
end)