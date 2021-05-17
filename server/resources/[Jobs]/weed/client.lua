local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
yRP = Tunnel.getInterface("utz_weed",yRP)

Keys = {
	['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
	['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
	['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
	['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
	['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
	['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
	['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
	['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

local SpawnedPlants = {}
local InteractedPlant = nil
local HarvestedPlants = {}
local canHarvest = true
local closestPlant = nil
local isDoingAction = false


Citizen.CreateThread(function()
    while true do
    Citizen.Wait(150)

    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)
    local inRange = false

    for i = 1, #Config.Plants do
        local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z, true)

        -- if Config.Plants[i].growth < 100 then
            if dist < 50.0 then
                inRange = true
                local hasSpawned = false
                local needsUpgrade = false
                local upgradeId = nil
                local tableRemove = nil
    
                for z = 1, #SpawnedPlants do
                    local p = SpawnedPlants[z]
    
                    if p.id == Config.Plants[i].id then
                        hasSpawned = true
                        if p.stage ~= Config.Plants[i].stage then
                            needsUpgrade = true
                            upgradeId = p.id
                            tableRemove = z
                        end
                    end
                end
    
                if not hasSpawned then
                    local hash = GetHashKey(Config.WeedStages[Config.Plants[i].stage])
                    RequestModel(hash)
                    local data = {}
                    data.id = Config.Plants[i].id
                    data.stage = Config.Plants[i].stage
    
                    while not HasModelLoaded(hash) do
                        Citizen.Wait(10)
                        RequestModel(hash)
                    end
    
                    data.obj = CreateObject(hash, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z + GetPlantZ(Config.Plants[i].stage), false, false, false) 
                    SetEntityAsMissionEntity(data.obj, true)
                    FreezeEntityPosition(data.obj, true)
                    table.insert(SpawnedPlants, data)
                    hasSpawned = false
                end
    
                if needsUpgrade then
                    for o = 1, #SpawnedPlants do
                        local u = SpawnedPlants[o]
    
                        if u.id == upgradeId then
                            SetEntityAsMissionEntity(u.obj, false)
                            FreezeEntityPosition(u.obj, false)
                            DeleteObject(u.obj)
    
                            local hash = GetHashKey(Config.WeedStages[Config.Plants[i].stage])
                            RequestModel(hash)
                            local data = {}
                            data.id = Config.Plants[i].id
                            data.stage = Config.Plants[i].stage
    
                            while not HasModelLoaded(hash) do
                                Citizen.Wait(10)
                                RequestModel(hash)
                            end
    
                            data.obj = CreateObject(hash, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z + GetPlantZ(Config.Plants[i].stage), false, false, false) 
                            SetEntityAsMissionEntity(data.obj, true)
                            FreezeEntityPosition(data.obj, true)
                            table.remove(SpawnedPlants, o)
                            table.insert(SpawnedPlants, data)
                            needsUpgrade = false
                        end
                    end
                end
            end
        end
  -- end
        if not InRange then
            Citizen.Wait(5000)
        end
    end
end)

function DestroyPlant()
    local plant = GetClosestPlant()
    local hasDone = false

    for k, v in pairs(HarvestedPlants) do
        if v == plant.id then
            hasDone = true
        end
    end

    if not hasDone then
        table.insert(HarvestedPlants, plant.id)
        local ped = GetPlayerPed(-1)
        isDoingAction = true
        TriggerServerEvent('orp:weed:plantHasBeenHarvested', plant.id)

        RequestAnimDict('amb@prop_human_bum_bin@base')
        while not HasAnimDictLoaded('amb@prop_human_bum_bin@base') do
            Citizen.Wait(0)
        end

        TaskPlayAnim(ped, 'amb@prop_human_bum_bin@base', 'base', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
        FreezeEntityPosition(ped, true)
        TriggerEvent("progress",5000,"DESTRUINDO")
        Citizen.Wait(5000)
        TriggerServerEvent('orp:weed:destroyPlant', plant.id)
        isDoingAction = false
        canHarvest = true
        FreezeEntityPosition(ped, false)
        ClearPedTasksImmediately(ped)
    else
        TriggerEvent("Notify","negado","Não Foi Possivel")
    end
end

function HarvestWeedPlant()
    local plant = GetClosestPlant()
    local hasDone = false

    for k, v in pairs(HarvestedPlants) do
        if v == plant.id then
            hasDone = true
        end
    end

    if not hasDone then
        table.insert(HarvestedPlants, plant.id)
        local ped = GetPlayerPed(-1)
        isDoingAction = true
        TriggerServerEvent('orp:weed:plantHasBeenHarvested', plant.id)

        RequestAnimDict('amb@prop_human_bum_bin@base')
        while not HasAnimDictLoaded('amb@prop_human_bum_bin@base') do
            Citizen.Wait(0)
        end

        TaskPlayAnim(ped, 'amb@prop_human_bum_bin@base', 'base', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
        FreezeEntityPosition(ped, true)
        TriggerEvent("progress",5000,"Colheita")
        Citizen.Wait(5000)
        TriggerServerEvent('orp:weed:harvestWeed', plant.id)
        isDoingAction = false
        canHarvest = true
        FreezeEntityPosition(ped, false)
        ClearPedTasksImmediately(ped)
    else
        TriggerEvent("Notify","negado","Não Foi Possivel")
    end
end

function RemovePlantFromTable(plantId)
    for k, v in pairs(Config.Plants) do
        if v.id == plantId then
            table.remove(Config.Plants, k)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
            local InRange = false
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)

            for k, v in pairs(Config.Plants) do
                if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true) < 1.2 and not isDoingAction and not v.beingHarvested and not IsPedInAnyVehicle(GetPlayerPed(-1), false)  then
                        local plant = GetClosestPlant()
                        DrawText3D(v.x, v.y, v.z, 'SEDE: ' .. v.thirst .. '% - FOME: ' .. v.hunger .. '% - Crescimento: ' ..  v.growth .. '% -  Qualidade: ' .. v.quality)
                        DrawText3D(v.x, v.y, v.z - 0.18, '~b~G~w~ - DESTRUIR PLANTA')
                        if IsControlJustReleased(0, Keys["G"])  and yRP.CheckPolice()then
                            if v.id == plant.id then
                                DestroyPlant()
                            end
                        end
                    else
                        if v.growth < 100 then
                            local plant = GetClosestPlant()
                            if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true) < 2 and not isDoingAction and not v.beingHarvested and not IsPedInAnyVehicle(GetPlayerPed(-1), false)  then
                            DrawText3D(v.x, v.y, v.z, 'SEDE: ' .. v.thirst .. '% - FOME: ' .. v.hunger .. '% - Crescimento: ' ..  v.growth .. '% -  Qualidade: ' .. v.quality)
                            DrawText3D(v.x, v.y, v.z - 0.18, '~b~G~w~ - AGUA      ~y~H~w~ - COMIDA')
                            if IsControlJustReleased(0, Keys["G"]) then
                                if v.id == plant.id then
                                    TriggerServerEvent('orp:server:checkPlayerHasThisItem', 'Água', 'orp:weed:client:waterPlant', true)
                                end
                            elseif IsControlJustReleased(0, Keys["H"]) then
                                if v.id == plant.id then
                                    TriggerServerEvent('orp:server:checkPlayerHasThisItem', 'Fertilizante', 'orp:weed:client:feedPlant', true)
                                end
                            end
                        end
                        else
                            if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true) < 2 and not isDoingAction and not v.beingHarvested and not IsPedInAnyVehicle(GetPlayerPed(-1), false)  then
                            DrawText3D(v.x, v.y, v.z, '[QUALIDADE: ' .. v.quality .. ']')
                            DrawText3D(v.x, v.y, v.z - 0.18, '~g~E~w~ - COLHEITA')
                            if IsControlJustReleased(0, Keys["E"]) and canHarvest then
                                local plant = GetClosestPlant()
                                if v.id == plant.id then
                                    HarvestWeedPlant()
                            end
                        end
                    end
                end
            end
        end
    end
end)

local IsSearching = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local InRange = false

            for k, v in pairs(Config.SeedLocations) do
                if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.5 then
                    InRange = true
                end
            end

            if InRange and not IsSearching and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                DrawText3D(pos.x, pos.y, pos.z, '~y~G~w~ - PROCURAR')
                if IsControlJustReleased(0, Keys["G"]) then
                    IsSearching = true
                    RequestAnimDict('amb@prop_human_bum_bin@base')
                    while not HasAnimDictLoaded('amb@prop_human_bum_bin@base') do
                        Citizen.Wait(0)
                    end

                    TaskPlayAnim(ped, 'amb@prop_human_bum_bin@base', 'base', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
                    FreezeEntityPosition(ped, true)
                    TriggerEvent("progress",10000,"PROCURANDO")
                    Citizen.Wait(10000)
                    FreezeEntityPosition(ped, false)
                    IsSearching = false
                    ClearPedTasksImmediately(ped)
                    if math.random(1, 10) == 7 then
                        TriggerServerEvent('orp:weed:server:giveShittySeed')
                            end
                        end
                    else
                Citizen.Wait(3000)
            end
        end
    end)

function GetClosestPlant()
    local dist = 1000
    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)
    local plant = {}

    for i = 1, #Config.Plants do
        local xd = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z, true)
        if xd < dist then
            dist = xd
            plant = Config.Plants[i]
        end
    end

    return plant
end

RegisterNetEvent('orp:weed:client:removeWeedObject')
AddEventHandler('orp:weed:client:removeWeedObject', function(plant)
    for i = 1, #SpawnedPlants do
        local o = SpawnedPlants[i]
        if o.id == plant then
            SetEntityAsMissionEntity(o.obj, false)
            FreezeEntityPosition(o.obj, false)
            DeleteObject(o.obj)
        end
    end
end)

RegisterNetEvent('orp:weed:client:notify')
AddEventHandler('orp:weed:client:notify', function(msg)
    TriggerEvent("Notify","importante",msg)
end)

RegisterNetEvent('orp:weed:client:waterPlant')
AddEventHandler('orp:weed:client:waterPlant', function()
    local entity = nil
    local plant = GetClosestPlant()
    local ped = GetPlayerPed(-1)
    isDoingAction = true

    for k, v in pairs(SpawnedPlants) do
        if v.id == plant.id then
            entity = v.obj
        end
    end

    TaskTurnPedToFaceEntity(GetPlayerPed(-1), entity, -1)

    RequestAnimDict('amb@prop_human_bum_bin@base')
    while not HasAnimDictLoaded('amb@prop_human_bum_bin@base') do
        Citizen.Wait(0)
    end

    TaskPlayAnim(ped, 'amb@prop_human_bum_bin@base', 'base', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
    FreezeEntityPosition(ped, true)
    TriggerEvent("progress",2000,"REGANDO")
    Citizen.Wait(2000)
    FreezeEntityPosition(ped, false)
    TriggerServerEvent('orp:weed:server:waterPlant', plant.id)
    ClearPedTasksImmediately(GetPlayerPed(-1))
    isDoingAction = false
end)

RegisterNetEvent('orp:weed:client:feedPlant')
AddEventHandler('orp:weed:client:feedPlant', function()
    local entity = nil
    local plant = GetClosestPlant()
    isDoingAction = true

    for k, v in pairs(SpawnedPlants) do
        if v.id == plant.id then
            entity = v.obj
        end
    end

    TaskTurnPedToFaceEntity(GetPlayerPed(-1), entity, -1)

    RequestAnimDict('amb@prop_human_bum_bin@base')
    while not HasAnimDictLoaded('amb@prop_human_bum_bin@base') do
        Citizen.Wait(0)
    end

    TaskPlayAnim(ped, 'amb@prop_human_bum_bin@base', 'base', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
    FreezeEntityPosition(ped, false)
    TriggerEvent("progress",2000,"FERTILIZANDO")
    Citizen.Wait(2000)
    TriggerServerEvent('orp:weed:server:feedPlant', plant.id)
    ClearPedTasksImmediately(GetPlayerPed(-1))
    isDoingAction = false
end)

RegisterNetEvent('orp:weed:client:updateWeedData')
AddEventHandler('orp:weed:client:updateWeedData', function(data)
    Config.Plants = data
end)

RegisterNetEvent('orp:weed:client:plantNewSeed')
AddEventHandler('orp:weed:client:plantNewSeed', function(type)
    local pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 1.0, 0.0)

    if CanPlantSeedHere(pos) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        TriggerServerEvent('orp:weed:server:plantNewSeed', type, pos)
    else
        TriggerEvent("Notify","negado","Muito perto de outra planta")
    end
end)

RegisterNetEvent('orp:weed:client:plantSeedConfirm')
AddEventHandler('orp:weed:client:plantSeedConfirm', function()
    RequestAnimDict("pickup_object")
    while not HasAnimDictLoaded("pickup_object") do
        Citizen.Wait(7)
    end
    TaskPlayAnim(GetPlayerPed(-1), "pickup_object" ,"pickup_low" ,8.0, -8.0, -1, 1, 0, false, false, false)
    Citizen.Wait(1800)
    ClearPedTasks(GetPlayerPed(-1))
end)

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function CanPlantSeedHere(pos)
    local canPlant = true

    for i = 1, #Config.Plants do
        if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z, true) < 1.3 then
            canPlant = false
        end
    end

    return canPlant
end

function GetPlantZ(stage)
    if stage == 1 then return -1.0
    else return -3.5
    end
end