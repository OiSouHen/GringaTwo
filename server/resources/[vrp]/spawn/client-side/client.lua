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
local cam = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUPCHARS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:setupChars")
AddEventHandler("spawn:setupChars",function()
	SetEntityVisible(PlayerPedId(),false,false)
	FreezeEntityPosition(PlayerPedId(),true)
	SetEntityInvincible(PlayerPedId(),true)

	cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",667.43,1025.9,378.87,340.0,0.0,342.0,60.0,false,0)
	SetCamActive(cam,true)
	RenderScriptCams(true,false,1,true,true)

	Citizen.Wait(1000)

	SendNUIMessage({ action = "show" })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUPMAXCHARS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:maxChars")
AddEventHandler("spawn:maxChars",function()
	SendNUIMessage({ action = "show" })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNCHAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:spawnChar")
AddEventHandler("spawn:spawnChar",function(status)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)

	SetCamActive(cam,false)
	DestroyCam(cam,true)
	cam = nil

	TriggerEvent("login:Spawn",status)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCHARACTERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("GetCharacters",function(data,cb)
	local chars = vSERVER.setupChars()
	Citizen.Wait(1000)
	cb(chars)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("CharacterChosen",function(data,cb)
	TriggerServerEvent("spawn:charChosen",tonumber(data.id))
	SetNuiFocus(false,false)
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCREATED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("CharacterCreated",function(data,cb)
	TriggerServerEvent("spawn:createChar",data.name,data.name2,data.sex)
	SetNuiFocus(false,false)
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETECHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("DeleteCharacter",function(data,cb)
	local chars = vSERVER.deleteChar(tonumber(data.id))
	cb(chars)
end)

CreateThread( function()
	TriggerServerEvent("vRP:playerSpawned")
	Wait(1000)
	ShutdownLoadingScreen()
end)