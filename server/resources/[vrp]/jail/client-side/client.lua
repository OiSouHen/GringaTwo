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
local inTimer = 0
local intransport = false

local enX,enY,enZ = 1775.57,2551.92,45.57
local exX,exY,exZ = 1820.54,2568.89,45.68
local emX,emY,emZ = 1775.57,2551.92,45.57
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLYPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
local polyPrison = PolyZone:Create({
	vector2(1599.45,2431.56),
	vector2(1543.26,2466.83),
	vector2(1540.58,2465.89),
	vector2(1537.80,2466.93),
	vector2(1536.79,2469.65),
	vector2(1537.92,2472.23),
	vector2(1540.80,2473.48),
	vector2(1536.07,2581.75),
	vector2(1533.29,2581.75),
	vector2(1531.35,2583.62),
	vector2(1531.15,2586.77),
	vector2(1533.02,2588.79),
	vector2(1536.04,2588.89),
	vector2(1568.57,2676.85),
	vector2(1566.71,2678.22),
	vector2(1566.08,2681.34),
	vector2(1567.89,2683.63),
	vector2(1570.29,2684.16),
	vector2(1572.85,2682.63),
	vector2(1647.19,2755.03),
	vector2(1645.70,2757.99),
	vector2(1646.85,2760.73),
	vector2(1649.50,2761.82),
	vector2(1652.07,2760.78),
	vector2(1653.18,2758.50),
	vector2(1769.56,2762.85),
	vector2(1770.16,2765.12),
	vector2(1772.76,2766.68),
	vector2(1775.47,2765.86),
	vector2(1777.09,2763.44),
	vector2(1776.01,2760.06),
	vector2(1836.80,2711.40),
	vector2(1846.36,2702.30),
	vector2(1847.30,2702.94),
	vector2(1849.87,2703.27),
	vector2(1852.21,2701.25),
	vector2(1852.37,2698.60),
	vector2(1850.69,2696.25),
	vector2(1848.18,2695.90),
	vector2(1823.39,2624.75),
	vector2(1825.63,2624.59),
	vector2(1827.44,2622.50),
	vector2(1827.38,2619.79),
	vector2(1823.81,2616.74),
	vector2(1827.65,2612.55),
	vector2(1851.68,2612.47),
	vector2(1851.87,2567.91),
	vector2(1832.34,2567.99),
	vector2(1819.15,2568.87),
	vector2(1817.03,2532.44),
	vector2(1824.94,2479.18),
	vector2(1826.98,2478.19),
	vector2(1828.07,2475.56),
	vector2(1826.83,2472.86),
	vector2(1824.38,2471.87),
	vector2(1821.40,2472.90),
	vector2(1764.08,2413.05),
	vector2(1765.36,2410.49),
	vector2(1764.36,2407.72),
	vector2(1761.70,2406.47),
	vector2(1758.85,2407.50),
	vector2(1757.83,2410.91),
	vector2(1662.19,2396.35),
	vector2(1662.43,2392.94),
	vector2(1660.08,2390.91),
	vector2(1657.42,2391.12),
	vector2(1655.45,2393.29),
	vector2(1655.68,2396.55)
},{ name = "Prison" })
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

            if distance <= 150 then
                timeDistance = 4
				DrawText3D(Config.services[prisonLocal][numServices][1],Config.services[prisonLocal][numServices][2],Config.services[prisonLocal][numServices][3],"~g~E~w~  VASCULHAR")
                if distance <= 1 then
                    if IsControlJustPressed(1,38) and prisonTimer <= 0 then
                        prisonTimer = 3
						TriggerEvent("Progress",10000,"Vasculhando...")
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

                        SetTimeout(10000,function()
                            vRP.removeObjects()
                            vSERVER.reducePrison()
                            TriggerEvent("cancelando", false)
						if math.random(1000) > 975 then
						    vSERVER.giveKey()
						end
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
-- THREAD - SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()

		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(emX,emY,emZ))

			if distance <= 1.5 then
				timeDistance = 4
				DrawText3D(emX,emY,emZ,"~g~E~w~ FUGIR")

				if distance <= 1 and inTimer <= 0 and IsControlJustPressed(1,38) then
					inTimer = 4

					if vSERVER.checkKey() then
						vRP.teleport(exX,exY,exZ)

						if vSERVER.callPolice() then
							vSERVER.stopPrison()
						end
					end
				end
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
    vRP.teleport(1775.57,2551.92,45.57)
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTPRISONLOCOMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTPRISONLOCOMOVE - THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
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