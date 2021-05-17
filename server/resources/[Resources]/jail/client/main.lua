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
Tunnel.bindInterface("jail", cRP)
vSERVER = Tunnel.getInterface("jail")
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

            if distance <= 3 then
                timeDistance = 4
				DrawText3D(Config.services[prisonLocal][numServices][1],Config.services[prisonLocal][numServices][2],Config.services[prisonLocal][numServices][3],"~g~E~w~  VASCULHAR")
                if distance <= 1.5 then
                    if IsControlJustPressed(1, 38) and prisonTimer <= 0 then
                        prisonTimer = 3
						TriggerEvent("Progress",15000,"Vasculhando...")
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
        if distance <= 1.5 then
            timeDistance = 4
            DrawText3D(Config.Locations["reclaim_items"]["x"],Config.Locations["reclaim_items"]["y"],Config.Locations["reclaim_items"]["z"],"~g~E~w~  PEGAR PERTENCES")
            if IsControlJustPressed(1,38) and not prison then
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
    vRP.teleport(1853.21,2586.03,45.68)
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
    SetBlipSprite(blips,1)
    SetBlipColour(blips,71)
    SetBlipScale(blips,0.6)
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
-- DRAWTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(176,180,193,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/350
	DrawRect(_x,_y+0.0125,0.01+factor,0.04,50,55,67,150)
end

function cRP.startPrisonLocomove()
    intransport = false
    Wait(1000)
    local ped = PlayerPedId()
    while true do
        local coords = GetEntityCoords(ped)
            cRP.startPrison()
            SetEntityCoords(PlayerPedId(),1720.22,2566.4,45.57)
			TriggerEvent("Notify","amarelo","Você está privado de liberdade.",5000)
            break
        return true
    end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if prison then
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1700.5,2605.2,45.5,true)
			if distance >= 200 then
				SetEntityCoords(PlayerPedId(),1720.22,2566.4,45.57)
			end
		end
	end
end)