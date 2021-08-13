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
Tunnel.bindInterface("garbageman",cRP)
vSERVER = Tunnel.getInterface("garbageman")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local trashCans = {
    {'prop_bin_01a'},
    {'prop_bin_03a'},
    {'prop_bin_05a'},
    {'prop_dumpster_01a'},
    {'prop_dumpster_02a'},
    {'prop_dumpster_02b'},
    {'prop_dumpster_4a'},
    {'prop_dumpster_4b'}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local idle = 1000
        local ped = GetPlayerPed(-1)
        local pedCoords = GetEntityCoords(ped, 0)
        local trashEmpty = false

        for k,v in pairs(trashCans) do
            local trash = GetClosestObjectOfType(pedCoords["x"], pedCoords["y"], pedCoords["z"], 1.0, GetHashKey(v[1]), true, true, true)
            SetEntityAsMissionEntity(trash, true, true)
            if DoesEntityExist(trash) then
                trashCoords = GetEntityCoords(trash, 0)
            end
        end

        if trashCoords ~= nil then
            local distance = GetDistanceBetweenCoords(pedCoords["x"], pedCoords["y"], pedCoords["z"], trashCoords["x"], trashCoords["y"], trashCoords["z"])
            if distance < 1.5 then
                idle = 5   
            end
            if distance > 2 then
                trashCoords = nil
            end
        end

        if trashCoords ~= nil then
            if (GetDistanceBetweenCoords(pedCoords["x"], pedCoords["y"], pedCoords["z"], trashCoords["x"], trashCoords["y"], trashCoords["z"] < 1)) and (not IsPedInAnyVehicle(ped)) then
				DrawText3D(trashCoords["x"], trashCoords["y"], trashCoords["z"]+1.2,"~g~E~w~   VASCULHAR")
                
				if not IsPauseMenuActive() and not exports["inventory"]:blockInvents() and not exports["player"]:blockCommands() and not exports["player"]:handCuff() and GetEntityHealth(ped) > 101 and not IsEntityInWater(ped) then
                    if (GetDistanceBetweenCoords(pedCoords["x"], pedCoords["y"], pedCoords["z"], trashCoords["x"], trashCoords["y"], trashCoords["z"] < 0.5)) then
                        if IsControlPressed(1,38) then 
                            TriggerEvent("cancelando",true)
                            vRP.playAnim(false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
                            TriggerEvent("Progress",5000,"Vasculhando...")
                            Wait(5000)
                            if vSERVER.searchTrash(trashCoords["x"]) then
                            end
                            TriggerEvent("cancelando",false)
                            ClearPedTasks(ped)
                        end
                    end
                end
            end
        end
        Citizen.Wait(idle)
    end 
end)
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