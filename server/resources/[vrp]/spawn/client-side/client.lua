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
Tunnel.bindInterface("spawn",cRP)
vSERVER = Tunnel.getInterface("spawn")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
cam = nil
initial_pos = {}

function removeCamActive()
    if cam and IsCamActive(cam) then
        SetCamCoord(cam, GetGameplayCamCoords())
        SetCamRot(cam, GetGameplayCamRot(2), 2)
        RenderScriptCams(0, 0, 0, 0, 0)
        EnableGameplayCam(true)
        SetCamActive(cam, false)
        DestroyCam(cam)
        cam = nil
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUPCHARS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:setupChars")
AddEventHandler("spawn:setupChars",function()
	SetEntityVisible(PlayerPedId(),false,false)
	FreezeEntityPosition(PlayerPedId(),true)
	SetEntityInvincible(PlayerPedId(),true)
	SetEntityCoords(PlayerPedId(),689.48,1076.96,335.36,true,false,false,true)
	cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",689.48,1076.96,335.36,355.0,0.0,343.0,55.0,false,0)
	SetCamActive(cam,true)
	RenderScriptCams(true,false,1,true,true)
	SendNUIMessage({ action = "openSystem" })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUPMAXCHARS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:maxChars")
AddEventHandler("spawn:maxChars",function()
	SetEntityVisible(PlayerPedId(),false,false)
	FreezeEntityPosition(PlayerPedId(),true)
	SetEntityInvincible(PlayerPedId(),true)
	SetEntityCoords(PlayerPedId(),689.48,1076.96,335.36,true,false,false,true)
	cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",689.48,1076.96,335.36,355.0,0.0,343.0,55.0,false,0)
	SetCamActive(cam,true)
	RenderScriptCams(true,false,1,true,true)
	SendNUIMessage({ action = "openSystem" })
	SetNuiFocus(true,true)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCREATED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("newCharacter",function(data)
	-- SetTimeout(2000,function() -- EM TESTE, TEM QUE COLOCAR PRA VER
		DoScreenFadeOut(1000)
		Citizen.Wait(1000)
		removeCamActive()
		SetEntityVisible(PlayerPedId(),true,true)
		FreezeEntityPosition(PlayerPedId(),false)
		SetEntityInvincible(PlayerPedId(),false)
		TriggerServerEvent("spawn:createChar",data.name,data.name2,data.sex)
		SetNuiFocus(false,false)
		SendNUIMessage({ action = "closeNew" })
	-- end)
end)

RegisterNetEvent("spawn:clearcam")
AddEventHandler("spawn:clearcam",function()
	SetEntityVisible(PlayerPedId(),true,true)
	FreezeEntityPosition(PlayerPedId(),false)
	SetEntityInvincible(PlayerPedId(),false)
	removeCamActive()
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)	
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCHARACTERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("generateDisplay",function(data,cb)
	local chars = vSERVER.setupChars()
	cb(chars)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("characterChosen",function(data)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	removeCamActive()
	SetEntityVisible(PlayerPedId(),true,true)
	FreezeEntityPosition(PlayerPedId(),false)
	SetEntityInvincible(PlayerPedId(),false)
	TriggerServerEvent("spawn:charChosen",tonumber(data.id))
	SendNUIMessage({ action = "closeSystem" })
	SetNuiFocus(false,false)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNCHAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:spawnChar")
AddEventHandler("spawn:spawnChar",function(status)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	SetEntityVisible(PlayerPedId(),true,true)
	FreezeEntityPosition(PlayerPedId(),false)
	SetEntityInvincible(PlayerPedId(),false)
	removeCamActive()
	TriggerEvent("spawn:SpawnNui",status)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETECHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("DeleteCharacter",function(data,cb)
	local chars = vSERVER.deleteChar(tonumber(data.id))
	cb(chars)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local cam1 = nil
local new = false
local weight = 270.0

RegisterNetEvent("spawn:SpawnNui")
AddEventHandler("spawn:SpawnNui",function(status)
	local ped = PlayerPedId()
	if status then
		local x,y,z = table.unpack(GetEntityCoords(ped))

		cam1 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",x,y,z+200.0,270.00,0.0,0.0,80.0,0,0)
		SetCamActive(cam1,true)

		RenderScriptCams(true,false,1,true,true)

		SetNuiFocus(true,true)
		SendNUIMessage({ action = "openSpawn" })
	else
		SetEntityVisible(ped,true,false)
		FreezeEntityPosition(ped,false)
		SetEntityInvincible(ped,false)

		RenderScriptCams(false,false,0,true,true)
		SetCamActive(cam1,false)
		DestroyCam(cam1,true)
		cam1 = nil
	end

	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- generateSpawn
-----------------------------------------------------------------------------------------------------------------------------------------
local config = {
	[1] = { name = "Hotel Integrity Way", hash = "coord1"},
    [2] = { name = "San Andreas Avenue", hash = "coord0"},
	[3] = { name = "Paleto Boulevard", hash = "coord2"}
}

local loc = {
	["coord0"] = { 216.85, -811.71, 30.69 },
	["coord1"] = { 265.71, -632.83, 42.03 },
	["coord2"] = { 160.75, 6630.15, 31.71 }
}

RegisterNUICallback("generateSpawn",function(data,cb)
	local coords = {}
	if config then
		coords['result'] = config
	end
	cb(coords)
end)

RegisterNUICallback("spawnChosen",function(data)
	local ped = PlayerPedId()
	if data.hash == "spawn" then
		SetNuiFocus(false)
		SendNUIMessage({ action = "closeSpawn" })

		DoScreenFadeOut(1000)
		Citizen.Wait(1000)

		SetEntityVisible(ped,true,false)
		FreezeEntityPosition(ped,false)
		SetEntityInvincible(ped,false)

		RenderScriptCams(false,false,0,true,true)
		SetCamActive(cam1,false)
		DestroyCam(cam1,true)
		cam1 = nil

		Citizen.Wait(1000)
		DoScreenFadeIn(1000)
	else
    	new = false
		local speed = 0.7

		DoScreenFadeOut(500)
		Citizen.Wait(500)

		SetCamRot(cam1,270.0)
		SetCamActive(cam1,true)
		new = true
		weight = 270.0

		DoScreenFadeIn(500)

		SetEntityCoords(ped,loc[data.hash][1],loc[data.hash][2],loc[data.hash][3]+0.5)
		local x,y,z = table.unpack(GetEntityCoords(ped))

		SetCamCoord(cam1,x,y,z+200.0)
		local i = z + 200.0

		while i > loc[data.hash][3] + 1.5 do
			Citizen.Wait(5)
			i = i - speed
			SetCamCoord(cam1,x,y,i)

			if i <= loc[data.hash][3] + 35.0 and weight < 360.0 then
				if speed - 0.0078 >= 0.05 then
					speed = speed - 0.0078
				end

				weight = weight + 0.75
				SetCamRot(cam1,weight)
			end

			if not new then
				break
			end
		end
	end
end)