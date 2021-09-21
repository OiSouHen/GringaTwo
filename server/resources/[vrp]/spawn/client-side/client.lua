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
local spawnLocates = {}
local brokenCamera = false
local characterCamera = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN:GENERATEJOIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:generateJoin")
AddEventHandler("spawn:generateJoin",function()
	DoScreenFadeOut(0)

	Citizen.Wait(1000)

	local ped = PlayerPedId()
	characterCamera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",667.43,1025.9,378.87,340.0,0.0,342.0,60.0,false,0)
	SetCamActive(characterCamera,true)
	RenderScriptCams(true,false,1,true,true)
	SendNUIMessage({ action = "openSystem" })
	TriggerEvent("player:playerInvisible",true)
	SetEntityVisible(ped,false,false)
	SetNuiFocus(true,true)

	DoScreenFadeIn(0)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEDISPLAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("generateDisplay",function(data,cb)
	cb({ result = vSERVER.initSystem() })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("characterChosen",function(data)
	vSERVER.characterChosen(data["id"])
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("newCharacter",function(data,cb)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "closeNew" })
	TriggerServerEvent("spawn:createChar",data.name,data.name2,data.sex)
	SetEntityVisible(PlayerPedId(),true,true)
	FreezeEntityPosition(PlayerPedId(),false)
	SetEntityInvincible(PlayerPedId(),false)
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATESPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("generateSpawn",function(data,cb)
	cb({ result = spawnLocates })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSENEW
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.closeNew()
	SendNUIMessage({ action = "closeNew" })
end