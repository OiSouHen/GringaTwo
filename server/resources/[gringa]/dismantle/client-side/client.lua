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
Tunnel.bindInterface("dismantle",cRP)
vSERVER = Tunnel.getInterface("dismantle")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inService = false
local timeDismantle = 0
local disX,disY,disZ = -85.3,-2223.71,7.8
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dismantle:checkVehicle")
AddEventHandler("dismantle:checkVehicle",function(checkVehicle)
	local timeDistance = 500
	if inService then
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(disX,disY,disZ))
			if distance <= 20 then
				timeDistance = 4
				if timeDismantle <= 0 then
					timeDismantle = 3
					local status,vehicle = vSERVER.checkVehlist()
					if status then
						TaskTurnPedToFaceEntity(ped,vehicle,1000)
						Wait(2000)
						SetEntityInvincible(ped,true)
						FreezeEntityPosition(ped,true)
						TriggerEvent("cancelando",true)
						TriggerEvent("player:blockCommands",true)
						FreezeEntityPosition(vehicle,true)
						vRP._playAnim(false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)
						
						for i = 0,5 do
							Wait(10000)
							SetVehicleDoorBroken(vehicle,i,false)
						end
						
						for i = 0,7 do
							Wait(10000)
							SetVehicleTyreBurst(vehicle,i,1,1000.01)
						end
						
						vRP.removeObjects()
						SetEntityInvincible(ped,false)
						FreezeEntityPosition(ped,false)
						TriggerEvent("cancelando",false)
						TriggerEvent("player:blockCommands",false)
						vSERVER.paymentMethod(vehicle)
					end
				end
			end
		end
	else
		TriggerEvent("Notify","amarelo","Você precisa iniciar o serviço.",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if timeDismantle > 0 then
			timeDismantle = timeDismantle - 1
		end
		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLE:INVOKELIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dismantle:invokeList")
AddEventHandler("dismantle:invokeList",function(invokeList)
    local timeDistance = 500
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped) then
		timeDistance = 4
		vSERVER.acessList()
		inService = true
	end
end)