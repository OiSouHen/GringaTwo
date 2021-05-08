-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("vrp_prison", cRP)
vSERVER = Tunnel.getInterface("vrp_prison")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = nil
local prison = false
local numServices = 1
local prisonTimer = 0
local prisonLocal = 1
local showHud = true
local showSkate = false
local intransport = false

local carrof_hash = GetHashKey("riot")
local seguranca = GetHashKey("s_m_m_security_01")
local carro_segurancas_hash = GetHashKey("police2")
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYSTEMTREAD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local timeDistance = 500
        local ped = PlayerPedId()
        if prison then
            local coords = GetEntityCoords(ped)
            local distance = #(coords - vector3(Config.services[prisonLocal][numServices][1],Config.services[prisonLocal][numServices][2],Config.services[prisonLocal][numServices][3]))

            if distance <= 10 then
                timeDistance = 4
                DrawMarker(21,Config.services[prisonLocal][numServices][1],Config.services[prisonLocal][numServices][2],Config.services[prisonLocal][numServices][3] - 0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,240,202,87,50,0,0,0,1)
                if distance <= 1.5 then
                    if IsControlJustPressed(1, 38) and prisonTimer <= 0 then
                        prisonTimer = 3
                        TriggerEvent("cancelando", true)

                        SetEntityHeading(ped, Config.services[prisonLocal][numServices][4])

                        if Config.services[prisonLocal][numServices][7] == nil then
                            vRP._playAnim(false,
                                {
                                    Config.services[prisonLocal][numServices][5],
                                    Config.services[prisonLocal][numServices][6]
                                },
                                true
                            )
                        else
                            vRP.createObjects(Config.services[prisonLocal][numServices][5],Config.services[prisonLocal][numServices][6],Config.services[prisonLocal][numServices][7],49,28422)
                        end

                        SetEntityCoords(ped,Config.services[prisonLocal][numServices][1],Config.services[prisonLocal][numServices][2],Config.services[prisonLocal][numServices][3] - 1)

                        SetTimeout(15000,function()
                            vRP.removeObjects()
                            vSERVER.reducePrison()
                            TriggerEvent("cancelando", false)
                        end)
                    end
                end
            end

            if GetEntityHealth(ped) <= 101 then
                TriggerEvent("updatePrison")
            end
        end
        local coords = GetEntityCoords(ped)
        local distance = #(coords - vector3(Config.Locations["reclaim_items"]["x"],Config.Locations["reclaim_items"]["y"],Config.Locations["reclaim_items"]["z"]))
        if distance <= 2 then
            timeDistance = 4
            DrawText3D(Config.Locations["reclaim_items"]["x"],Config.Locations["reclaim_items"]["y"],Config.Locations["reclaim_items"]["z"],"[E] Pegar seus pertences")
            if IsControlJustPressed(1, 38) and not prison then
                vSERVER.reclaimItems()
            end
        end
        Citizen.Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        if prisonTimer > 0 then
            prisonTimer = prisonTimer - 1
        end
        Citizen.Wait(1000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.startPrison(status)
    prison = true
    prisonLocal = 2
    numServices = math.random(#Config.services[prisonLocal])
    prisonBlips()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.stopPrison()
    prison = false
    intransport = false
    if DoesBlipExist(blips) then
        RemoveBlip(blips)
        blips = nil
    end
    DoScreenFadeIn(1000)
end

function cRP.stopPrison2()
    TriggerEvent("vrp_hud:toggleHood",false)
    prison = false
    intransport = false
    if DoesBlipExist(blips) then
        RemoveBlip(blips)
        blips = nil
    end
end

function cRP.goJailItem()
    DoScreenFadeOut(1000)
    Wait(1350)
    vRP.teleport(1867.27,2604.87,45.68)
    TaskGoToCoordAnyMeans(PlayerPedId(), 1845.69, 2585.83, 45.68, 1.0, 0, 0, 786603, 0xbf800000)
    DoScreenFadeIn(1000)
end
function cRP.getVehiclePed()
    local ped = PlayerPedId()
	return IsPedInAnyVehicle(ped)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISONBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function prisonBlips()
    if DoesBlipExist(blips) then
        RemoveBlip(blips)
        blips = nil
    end

    blips =
        AddBlipForCoord(
        Config.services[prisonLocal][numServices][1],
        Config.services[prisonLocal][numServices][2],
        Config.services[prisonLocal][numServices][3]
    )
    SetBlipSprite(blips, 1)
    SetBlipColour(blips, 71)
    SetBlipScale(blips, 0.6)
    SetBlipAsShortRange(blips, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Serviço")
    EndTextCommandSetBlipName(blips)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGPS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(
    function()
        while true do
            local ped = PlayerPedId()
            if showSkate then
                if not IsMinimapRendering() then
                    DisplayRadar(true)
                end 
            end 
            if IsPedInAnyVehicle(ped) and showHud or prison then
                if not IsMinimapRendering() then
                    DisplayRadar(true)
                end
            else
                if IsMinimapRendering() and not showSkate then
                    DisplayRadar(false)
                end
            end
            Citizen.Wait(1000)
        end
    end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP_PRISON:SWITCHHUD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_prison:switchHud")
AddEventHandler(
    "vrp_prison:switchHud",
    function(status)
        showHud = status
    end
)

RegisterNetEvent("vrp_prison:showSkate")
AddEventHandler(
    "vrp_prison:showSkate",
    function(status)
        showSkate = status
    end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    SetTextFont(4)
    SetTextScale(0.35, 0.35)
    SetTextColour(255, 255, 255, 100)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 350
    DrawRect(_x, _y + 0.0125, 0.01 + factor, 0.03, 0, 0, 0, 100)
end

function setupModelo(modelo)
    RequestModel(modelo)
    while not HasModelLoaded(modelo) do
        RequestModel(modelo)
        Wait(50)
    end
    SetModelAsNoLongerNeeded(modelo)
end

local carlist = {
    [1] = "carrof_spw",
    [2] = "carros_spw",
    [3] = "carros_spw_2"
}

function cRP.startPrisonLocomove()
    TriggerEvent("Notify","aviso","Voce sera transferido da delegacia para o presidio por este motivo voce sera encapuzado.",7000)
    intransport = true
    Wait(7000)
    TriggerEvent("vrp_hud:toggleHood",true)
    local ped = PlayerPedId()
    --DoScreenFadeOut(1000)
    disableAction()
    --Wait(1350)
    --DoScreenFadeIn(1000)
    --SetFollowVehicleCamViewMode(4)
    --ClearPedTasks(ped)
    setupModelo(carrof_hash)
    setupModelo(carro_segurancas_hash)
    local carrof_spw = CreateVehicle(carrof_hash, 464.52,-673.76,27.27, 88.88, true, false)
    local carros_spw = CreateVehicle(carrof_hash, 480.57, -673.39, 26.18, 93.94, true, false)
    local carros_spw_2 = CreateVehicle(carrof_hash, 496.33,-675.3,25.35, 81.75, true, false)
    carrosinfo(carrof_spw)
    carrosinfo(carros_spw)
    carrosinfo(carros_spw_2)
    setupModelo(seguranca)
    local seguranca_spw = CreatePedInsideVehicle(carrof_spw, 4, seguranca, -1, true, false)
    local seguranca_spw_2 = CreatePedInsideVehicle(carrof_spw, 4, seguranca, 0, true, false)
    local seguranca_spw_3 = CreatePedInsideVehicle(carros_spw, 4, seguranca, -1, true, false)
    local seguranca_spw_4 = CreatePedInsideVehicle(carros_spw, 4, seguranca, 0, true, false)
    local seguranca_spw_5 = CreatePedInsideVehicle(carros_spw, 4, seguranca, 1, true, false)
    local seguranca_spw_12 = CreatePedInsideVehicle(carros_spw, 4, seguranca, 3, true, false)
    local seguranca_spw_14 = CreatePedInsideVehicle(carros_spw, 4, seguranca, 4, true, false)
    local seguranca_spw_7 = CreatePedInsideVehicle(carros_spw_2, 4, seguranca, -1, true, false)
    local seguranca_spw_8 = CreatePedInsideVehicle(carros_spw_2, 4, seguranca, 0, true, false)
    local seguranca_spw_9 = CreatePedInsideVehicle(carros_spw_2, 4, seguranca, 1, true, false)
    local seguranca_spw_13 = CreatePedInsideVehicle(carros_spw_2, 4, seguranca, 3, true, false)
    local seguranca_spw_16 = CreatePedInsideVehicle(carros_spw_2, 4, seguranca, 4, true, false)
    local seguranca_spw_10 = CreatePedInsideVehicle(carrof_spw, 4, seguranca, 1, true, false)
    local seguranca_spw_11 = CreatePedInsideVehicle(carrof_spw, 4, seguranca, 3, true, false)
    local seguranca_spw_15 = CreatePedInsideVehicle(carrof_spw, 4, seguranca, 4, true, false)
    local vehaccent = math.random(1, #carlist)

    if vehaccent == 1 then
        SetPedIntoVehicle(ped, carrof_spw, 2)
    elseif vehaccent == 2 then
        SetPedIntoVehicle(ped, carros_spw, 2)
    elseif vehaccent == 3 then
        SetPedIntoVehicle(ped, carros_spw_2, 2)
    end

    SetEntityAsMissionEntity(seguranca_spw, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_2, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_3, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_4, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_5, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_7, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_8, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_9, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_10, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_11, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_12, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_13, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_14, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_15, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_16, 0, 0)
    guardasinfo(seguranca_spw)
    guardasinfo(seguranca_spw_2)
    guardasinfo(seguranca_spw_3)
    guardasinfo(seguranca_spw_4)
    guardasinfo(seguranca_spw_5)
    guardasinfo(seguranca_spw_7)
    guardasinfo(seguranca_spw_8)
    guardasinfo(seguranca_spw_9)
    guardasinfo(seguranca_spw_10)
    guardasinfo(seguranca_spw_11)
    guardasinfo(seguranca_spw_12)
    guardasinfo(seguranca_spw_13)
    guardasinfo(seguranca_spw_14)
    guardasinfo(seguranca_spw_15)
    guardasinfo(seguranca_spw_16)
    TaskVehicleDriveToCoordLongrange(seguranca_spw, carrof_spw, 1865.92, 2604.73, 45.68, 37.0, 2883621, 1)
    TaskVehicleDriveToCoordLongrange(seguranca_spw_3, carros_spw, 1865.92, 2604.73, 45.68, 37.0, 2883621, 1)
    TaskVehicleDriveToCoordLongrange(seguranca_spw_7, carros_spw_2, 1865.92, 2604.73, 45.68, 37.0, 2883621, 1)
    SetVehicleSiren(carrof_spw, true)
    SetVehicleSiren(carros_spw, true)
    SetVehicleSiren(carros_spw_2, true)
    while true do
        local coords = GetEntityCoords(ped)
        local coordsPed = vector3(1865.92, 2604.73, 45.68)
        local distance = #(coords - coordsPed)
        Wait(0)
        if distance <= 10 then
            intransport = false
            DoScreenFadeOut(1000)
            Wait(1350)
            DoScreenFadeIn(1000)
            DeleteEntity(carrof_spw)
            DeleteEntity(carros_spw)
            DeleteEntity(carros_spw_2)
            DeleteEntity(seguranca_spw)
            DeleteEntity(seguranca_spw_2)
            DeleteEntity(seguranca_spw_3)
            DeleteEntity(seguranca_spw_4)
            DeleteEntity(seguranca_spw_5)
            DeleteEntity(seguranca_spw_7)
            DeleteEntity(seguranca_spw_8)
            DeleteEntity(seguranca_spw_9)
            DeleteEntity(seguranca_spw_10)
            DeleteEntity(seguranca_spw_11)
            DeleteEntity(seguranca_spw_12)
            DeleteEntity(seguranca_spw_13)
            DeleteEntity(seguranca_spw_14)
            DeleteEntity(seguranca_spw_15)
            DeleteEntity(seguranca_spw_16)
            vRP.teleport(1677.72, 2509.68, 45.57)
            cRP.startPrison()
            TriggerEvent("vrp_hud:toggleHood",false)
            vSERVER.saveItems()

            break
        end
        if GetVehicleBodyHealth(ped) < 5.0 then
            break
        end
    end
    return true
end

function guardasinfo(inputPed)
    SetPedShootRate(inputPed, 700)
    AddArmourToPed(inputPed, GetPlayerMaxArmour(seguranca_spw) - GetPedArmour(seguranca_spw))
    SetPedAlertness(inputPed, 3)
    SetPedAccuracy(inputPed, 81)
    SetEntityHealth(inputPed, 200)
    SetPedFleeAttributes(inputPed, false, true)
    SetPedCombatAttributes(inputPed, 46, true)
    SetPedCombatAttributes(inputPed, 0, true)
    SetPedCombatAttributes(inputPed, 2, true)
    SetPedCombatAttributes(inputPed, 52, true)
    SetPedCombatAbility(inputPed, 2)
    SetPedCombatRange(inputPed, 2)
    SetPedPathAvoidFire(inputPed, 0)
    SetPedPathCanUseLadders(inputPed, 1)
    SetPedPathCanDropFromHeight(inputPed, 1)
    SetPedPathPreferToAvoidWater(inputPed, 1)
    SetPedGeneratesDeadBodyEvents(inputPed, 1)
    GiveWeaponToPed(inputPed, GetHashKey("WEAPON_COMBATPISTOL"), 5000, false, true)
    GiveWeaponToPed(inputPed, GetHashKey("WEAPON_CARBINERIFLE"), 5000, false, true)
    SetPedRelationshipGroupHash(inputPed, GetHashKey("security_guard"))
end

function carrosinfo(inputcarro)
    RequestCollisionForModel(inputcarro)
    N_0x06faacd625d80caa(inputcarro)
    SetVehicleDoorsLocked(inputcarro, 7)
    SetEntityAsNoLongerNeeded(inputcarro)
    SetVehicleOnGroundProperly(inputcarro)
end

function disableAction()
    Citizen.CreateThread(
        function()
            while true do
                if intransport then
                    DisableControlAction(1, 75, true)
                else
                    EnableControlAction(1, 75, true)
                end
                Citizen.Wait(5)
            end
        end
    )
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		if prison then
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1700.5,2605.2,45.5,true)
			if distance >= 200 then
				SetEntityCoords(PlayerPedId(),1680.1,2513.0,45.5)
				TriggerEvent("Notify","aviso","O agente penitenciário encontrou você tentando escapar.",5000)
			end
		end
	end
end)