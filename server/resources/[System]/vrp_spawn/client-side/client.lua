-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("vrp_spawn",cnVRP)
vSERVER = Tunnel.getInterface("vrp_spawn")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
cam = nil

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
RegisterNetEvent("vrp_spawn:setupChars")
AddEventHandler("vrp_spawn:setupChars",function()
	SetEntityVisible(PlayerPedId(),false,false)
	FreezeEntityPosition(PlayerPedId(),true)
	SetEntityInvincible(PlayerPedId(),true)

	cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",648.21,1006.97,377.42,4.7,0.0,140.0,60.0,false,0)
	SetCamActive(cam,true)
	RenderScriptCams(true,false,1,true,true)

	Citizen.Wait(1000)

	SendNUIMessage({ action = "show" })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUPMAXCHARS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_spawn:maxChars")
AddEventHandler("vrp_spawn:maxChars",function()
	SendNUIMessage({ action = "show" })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNCHAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_spawn:spawnChar")
AddEventHandler("vrp_spawn:spawnChar",function(status)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	SetEntityVisible(PlayerPedId(),true,true)
	FreezeEntityPosition(PlayerPedId(),false)
	SetEntityInvincible(PlayerPedId(),false)
	removeCamActive()

	TriggerEvent("vrp_login:Spawn",status)
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
	SetEntityVisible(PlayerPedId(),true,true)
	FreezeEntityPosition(PlayerPedId(),false)
	SetEntityInvincible(PlayerPedId(),false)
	TriggerServerEvent("vrp_spawn:charChosen",tonumber(data.id))
	SetNuiFocus(false,false)
	removeCamActive()
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCREATED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("CharacterCreated",function(data,cb)
	SetEntityVisible(PlayerPedId(),true,true)
	FreezeEntityPosition(PlayerPedId(),false)
	SetEntityInvincible(PlayerPedId(),false)	
	TriggerServerEvent("vrp_spawn:createChar",data.name,data.name2,data.sex)
	SetNuiFocus(false,false)
	removeCamActive()

	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETECHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("DeleteCharacter",function(data,cb)
	local chars = vSERVER.deleteChar(tonumber(data.id))
	cb(chars)
end)