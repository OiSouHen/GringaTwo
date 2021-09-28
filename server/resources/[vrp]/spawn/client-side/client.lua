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
local cam1 = nil
local new = false
local weight = 270.0
cam = nil
initial_pos = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVECAMACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
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
	cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",667.43,1025.9,378.87,340.0,0.0,342.0,60.0,false,0)
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
	cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",667.43,1025.9,378.87,340.0,0.0,342.0,60.0,false,0)
	SetCamActive(cam,true)
	RenderScriptCams(true,false,1,true,true)
	SendNUIMessage({ action = "openSystem" })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("newCharacter",function(data)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	removeCamActive()
	SetEntityVisible(PlayerPedId(),true,true)
	FreezeEntityPosition(PlayerPedId(),false)
	SetEntityInvincible(PlayerPedId(),false)
	TriggerServerEvent("spawn:createChar",data.name,data.name2,data.sex,data.loc)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "closeNew" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN:CLEARCAM
-----------------------------------------------------------------------------------------------------------------------------------------
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
-- GENERATEDISPLAY
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
-- SPAWN:SPAWNCHAR
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
-- SPAWN:SPAWNNUI
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:SpawnNui")
AddEventHandler("spawn:SpawnNui",function(status)
	local ped = PlayerPedId()
	if status then
		local x,y,z = table.unpack(GetEntityCoords(ped))

		cam1 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",x,y,z + 200.0,270.00,0.0,0.0,80.0,0,0)
		SetCamActive(cam1,true)

		RenderScriptCams(true,false,1,true,true)

		SetNuiFocus(true,true)
		SendNUIMessage({ action = "openSpawn" })
		
		DoScreenFadeIn(1000)
	else
		SetEntityVisible(ped,true,false)
		FreezeEntityPosition(ped,false)
		SetEntityInvincible(ped,false)
		RenderScriptCams(false,false,0,true,true)
		SetCamActive(cam1,false)
		DestroyCam(cam1,true)
		cam1 = nil
		
		Citizen.Wait(1000)

		DoScreenFadeIn(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNCONFIG
-----------------------------------------------------------------------------------------------------------------------------------------
local config = {
	[1] = { name = "Great Ocean Highway", hash = "Great"},
    [2] = { name = "Duluoz Avenue", hash = "Duluoz"},
    [3] = { name = "Eclipse Towers", hash = "Eclipse"},
	[4] = { name = "Grapedseed Avenue", hash = "Grapedseed"},
	[5] = { name = "Armadillo Avenue", hash = "Armadillo"},
	[6] = { name = "Senora Road", hash = "Senora"},
	[7] = { name = "Hawick Avenue", hash = "Hawick"},
	[8] = { name = "Integrity Way", hash = "Integrity"}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNLOC
-----------------------------------------------------------------------------------------------------------------------------------------
local cds = {
	["Great"] = { -2205.92,-370.48,13.29 },
	["Duluoz"] = { -250.35,6209.71,31.49 },
	["Eclipse"] = { -774.14,307.75,85.7 },
	["Grapedseed"] = { 1694.37,4794.66,41.92 },
	["Armadillo"] = { 1858.94,3741.78,33.09 },
	["Senora"] = { 328.0,2617.89,44.48 },
	["Hawick"] = { 308.33,-232.25,54.07 },
	["Integrity"] = { 449.71,-659.27,28.48 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATESPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("generateSpawn",function(data,cb)
	local coords = {}
	if config then
		coords['result'] = config
	end
	
	cb(coords)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
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

		DoScreenFadeOut(0)

		Citizen.Wait(1000)

		SetCamRot(cam1,270.0)
		SetCamActive(cam1,true)
		new = true
		weight = 270.0

		DoScreenFadeIn(500)

		SetEntityCoords(ped,cds[data.hash][1],cds[data.hash][2],cds[data.hash][3]+0.5)
		local x,y,z = table.unpack(GetEntityCoords(ped))

		SetCamCoord(cam1,x,y,z+200.0)
		local i = z + 200.0

		while i > cds[data.hash][3] + 1.5 do
			i = i - speed
			SetCamCoord(cam1,x,y,i)

			if i <= cds[data.hash][3] + 35.0 and weight < 360.0 then
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