-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("radio",cRP)
vSERVER = Tunnel.getInterface("radio")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local myFrequency = 0
local activeRadio = false
local timeCheck = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIOCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("radioClose",function(data,cb)
	SetNuiFocus(false,false)
	vRP.removeObjects("one")
    SendNUIMessage({ action = "hideMenu" })
	cb("cb")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /INV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("radio:openSystem")
AddEventHandler("radio:openSystem",function()
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "showMenu" })

	if not IsPedInAnyVehicle(PlayerPedId()) then
		vRP.createObjects("cellphone@","cellphone_text_in","prop_cs_hand_radio",50,28422)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("activeFrequency",function(data)
	if parseInt(data["freq"]) >= 1 and parseInt(data["freq"]) <= 999 then
		vSERVER.activeFrequency(data["freq"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("inativeFrequency",function(data)
	if myFrequency ~= 0 then
		TriggerEvent("radio:outServers")
		TriggerEvent("Notify","amarelo","Rádio desativado.",3000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.startFrequency(frequency)
	if exports.tokovoip:isPlayerInChannel(myFrequency) then
		exports.tokovoip:removePlayerFromRadio(myFrequency)
	end

	myFrequency = frequency
	exports.tokovoip:addPlayerToRadio(myFrequency)
	activeRadio = true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTSERVERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("radio:outServers")
AddEventHandler("radio:outServers",function()
	if myFrequency ~= 0 then
		TriggerEvent("Notify","amarelo","Rádio desativado.",5000)
		
		if exports.tokovoip:isPlayerInChannel(myFrequency) then
			exports.tokovoip:removePlayerFromRadio(myFrequency)
		end
		
		TriggerEvent("hud:RadioDisplay",0)
		myFrequency = 0
		activeRadio = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIO:THREADCHECKRADIO
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		if GetGameTimer() >= timeCheck and activeRadio then
			timeCheck = GetGameTimer() + 60000

			local ped = PlayerPedId()
			if vSERVER.checkRadio() or IsPedSwimming(ped) then
				TriggerEvent("radio:outServers")
			end
		end

		Wait(10000)
	end
end)