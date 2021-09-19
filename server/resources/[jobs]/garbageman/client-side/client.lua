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
-- VARIABLESTRASHS
-----------------------------------------------------------------------------------------------------------------------------------------
local trashCans = {
    {"prop_dumpster_02a"},
    {"prop_dumpster_01a"},
    {"prop_dumpster_02b"},
    {"prop_bin_07c"},
    {"prop_bin_07a"},
    {"prop_bin_01a"},
    {"prop_bin_08a"},
    {"prop_dumpster_4a"},
    {"prop_bin_07b"},
    {"prop_bin_06a"},
    {"prop_bin_12a"},
    {"prop_dumpster_4b"},
    {"prop_recyclebin_01a"},
    {"prop_bin_05a"},
    {"prop_bin_03a"}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSEARCHTRASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garbageman:searchTrash")
AddEventHandler("garbageman:searchTrash",function(searchTrash)
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
            
            if not IsPauseMenuActive() and not exports["inventory"]:blockInvents() and not exports["player"]:blockCommands() and not exports["player"]:handCuff() and GetEntityHealth(ped) > 101 and not IsEntityInWater(ped) then
                if (GetDistanceBetweenCoords(pedCoords["x"], pedCoords["y"], pedCoords["z"], trashCoords["x"], trashCoords["y"], trashCoords["z"] < 0.5)) then
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
	
    Citizen.Wait(idle)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLESOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
local objectsCans = {
    {"prop_news_disp_02a"},
    {"prop_postbox_01a"},
    {"prop_news_disp_01a"},
    {"prop_news_disp_02e"},
    {"prop_news_disp_03a"},
    {"prop_news_disp_03c"},
    {"prop_news_disp_02c"}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSEARCHTRASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garbageman:searchObject")
AddEventHandler("garbageman:searchObject",function(searchObject)
    local idle = 1000
    local ped = GetPlayerPed(-1)
    local pedCoords = GetEntityCoords(ped, 0)
    local objectEmpty = false
    
    for k,v in pairs(objectsCans) do
        local object = GetClosestObjectOfType(pedCoords["x"], pedCoords["y"], pedCoords["z"], 1.0, GetHashKey(v[1]), true, true, true)
        SetEntityAsMissionEntity(object, true, true)
        if DoesEntityExist(object) then
            objectCoords = GetEntityCoords(object, 0)
        end
    end
    
    if objectCoords ~= nil then
        local distance = GetDistanceBetweenCoords(pedCoords["x"], pedCoords["y"], pedCoords["z"], objectCoords["x"], objectCoords["y"], objectCoords["z"])
        if distance < 1.5 then
            idle = 5   
        end

        if distance > 2 then
            objectCoords = nil
        end
    end
    
    if objectCoords ~= nil then
        if (GetDistanceBetweenCoords(pedCoords["x"], pedCoords["y"], pedCoords["z"], objectCoords["x"], objectCoords["y"], objectCoords["z"] < 1)) and (not IsPedInAnyVehicle(ped)) then
            
            if not IsPauseMenuActive() and not exports["inventory"]:blockInvents() and not exports["player"]:blockCommands() and not exports["player"]:handCuff() and GetEntityHealth(ped) > 101 and not IsEntityInWater(ped) then
                if (GetDistanceBetweenCoords(pedCoords["x"], pedCoords["y"], pedCoords["z"], objectCoords["x"], objectCoords["y"], objectCoords["z"] < 0.5)) then
                    TriggerEvent("cancelando",true)
                    vRP.playAnim(false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
                    TriggerEvent("Progress",5000,"Vasculhando...")
                    Wait(5000)
                    if vSERVER.searchObject(objectCoords["x"]) then
                    end
                    TriggerEvent("cancelando",false)
                    ClearPedTasks(ped)
                end
            end
        end
    end
	
    Citizen.Wait(idle)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLESWASTE
-----------------------------------------------------------------------------------------------------------------------------------------
local wasteCans = {
    {"prop_rub_carwreck_7"},
    {"prop_rub_carwreck_5"},
    {"prop_rub_carwreck_8"},
    {"prop_rub_carwreck_9"},
    {"prop_rub_carwreck_3"},
    {"prop_rub_carwreck_2"},
    {"prop_rub_buswreck_06"},
    {"prop_rub_carwreck_13"},
    {"prop_rub_carwreck_16"},
    {"prop_rub_carwreck_15"},
    {"prop_rub_carwreck_17"},
    {"prop_rub_carwreck_14"},
    {"prop_rub_carwreck_11"},
    {"prop_rub_carwreck_10"},
    {"prop_rub_carwreck_12"}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSEARCHWASTE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garbageman:searchWaste")
AddEventHandler("garbageman:searchWaste",function(searchWaste)
    local idle = 1000
    local ped = GetPlayerPed(-1)
    local pedCoords = GetEntityCoords(ped, 0)
    local objectEmpty = false
    
    for k,v in pairs(wasteCans) do
        local object = GetClosestObjectOfType(pedCoords["x"], pedCoords["y"], pedCoords["z"], 1.0, GetHashKey(v[1]), true, true, true)
        SetEntityAsMissionEntity(object, true, true)
        if DoesEntityExist(object) then
            wasteCoords = GetEntityCoords(object, 0)
        end
    end
    
    if wasteCoords ~= nil then
        local distance = GetDistanceBetweenCoords(pedCoords["x"], pedCoords["y"], pedCoords["z"], wasteCoords["x"], wasteCoords["y"], wasteCoords["z"])
        if distance < 1.5 then
            idle = 5   
        end

        if distance > 2 then
            wasteCoords = nil
        end
    end
    
    if wasteCoords ~= nil then
        if (GetDistanceBetweenCoords(pedCoords["x"], pedCoords["y"], pedCoords["z"], wasteCoords["x"], wasteCoords["y"], wasteCoords["z"] < 1)) and (not IsPedInAnyVehicle(ped)) then
            
            if not IsPauseMenuActive() and not exports["inventory"]:blockInvents() and not exports["player"]:blockCommands() and not exports["player"]:handCuff() and GetEntityHealth(ped) > 101 and not IsEntityInWater(ped) then
                if (GetDistanceBetweenCoords(pedCoords["x"], pedCoords["y"], pedCoords["z"], wasteCoords["x"], wasteCoords["y"], wasteCoords["z"] < 0.5)) then
                    TriggerEvent("cancelando",true)
                    vRP.playAnim(false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
                    TriggerEvent("Progress",60000,"Vasculhando...")
                    Wait(60000)
                    if vSERVER.searchWaste(wasteCoords["x"]) then
                    end
                    TriggerEvent("cancelando",false)
                    ClearPedTasks(ped)
                end
            end
        end
    end
	
    Citizen.Wait(idle)
end)