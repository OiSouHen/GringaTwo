-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("police",cRP)
vSERVER = Tunnel.getInterface("police")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeSystem",function(data)
	SendNUIMessage({ action = "closeSystem" })
	SetNuiFocus(false,false)
	vRP.removeObjects()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("initPrison",function(data)
	vSERVER.initPrison(data)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITFINE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("initFine",function(data)
	vSERVER.initFine(data)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updatePort",function(data)
	vSERVER.updatePort(data["passaporte"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHUSER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("searchUser",function(data,cb)
	cb({ result = vSERVER.searchUser(data) })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("police:openSystem")
AddEventHandler("police:openSystem",function()
	local ped = PlayerPedId()
	if not IsPedSwimming(ped) then
		SendNUIMessage({ action = "openSystem" })
		TriggerEvent("dynamic:closeSystem")
		SetNuiFocus(true,true)

		if not IsPedInAnyVehicle(ped) then
			vRP.removeObjects()
			vRP.createObjects("amb@code_human_in_bus_passenger_idles@female@tablet@base","base","prop_cs_tablet",50,28422)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:INSERTBARRIER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("police:insertBarrier")
AddEventHandler("police:insertBarrier",function()
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped) then
		local heading = GetEntityHeading(ped)
		local mHash = GetHashKey("prop_mp_barrier_02b")
		local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.5,0.0)

		RequestModel(mHash)
		while not HasModelLoaded(mHash) do
			Citizen.Wait(1)
		end

		if HasModelLoaded(mHash) then
			local newObject = CreateObject(mHash,coords["x"],coords["y"],coords["z"],true,true,false)
			local netObjs = ObjToNet(newObject)

			SetNetworkIdCanMigrate(netObjs,true)

			PlaceObjectOnGroundProperly(newObject)
			SetEntityAsMissionEntity(newObject,true,false)
			SetEntityHeading(newObject,heading - 180)
			FreezeEntityPosition(newObject,true)

			SetModelAsNoLongerNeeded(mHash)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("police:Update")
AddEventHandler("police:Update",function(action,data)
	SendNUIMessage({ action = action, data = data })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inSelect = 1
local inDeath = false
local inPrison = false
local inTimer = GetGameTimer()
local timeDeath = GetGameTimer()
local coordsIntern = { 1775.61,2495.13,50.43 }
local coordsExtern = { 1846.49,2586.14,45.68 }
local coordsLeaver = { 1765.64,2566.06,45.57 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function checkPrison()
	return inPrison
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("checkPrison",checkPrison)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICES
-----------------------------------------------------------------------------------------------------------------------------------------
local inLocates = {
	{ 1760.62,2518.97,45.57,263.87 },
	{ 1761.51,2540.38,45.57,346.44 },
	{ 1737.4,2504.7,45.57,168.01 },
	{ 1718.52,2527.86,45.57,102.38 },
	{ 1695.74,2536.44,45.57,88.68 },
	{ 1699.42,2533.41,45.57,85.89 },
	{ 1707.09,2481.28,45.57,224.82 },
	{ 1700.16,2474.84,45.57,214.08 },
	{ 1679.62,2480.33,45.57,135.63 },
	{ 1685.97,2553.62,45.57,2.6 },
	{ 1652.46,2564.32,45.57,3.59 },
	{ 1629.88,2564.3,45.57,343.84 },
	{ 1634.9,2553.61,45.57,349.24 },
	{ 1627.8,2538.38,45.57,0.27 },
	{ 1632.52,2529.44,45.57,217.16 },
	{ 1630.35,2527.02,45.57,235.76 },
	{ 1609.79,2539.75,45.57,135.99 },
	{ 1609.04,2566.99,45.57,32.84 },
	{ 1624.49,2577.59,45.57,254.3 }
}
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
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		local timeDistance = 999
		if inPrison then
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(inLocates[inSelect][1],inLocates[inSelect][2],inLocates[inSelect][3]))

			if distance <= 150 then
				timeDistance = 1
				DrawText3D(inLocates[inSelect][1],inLocates[inSelect][2],inLocates[inSelect][3],"~g~E~w~   VASCULHAR")

				if distance <= 1 and GetGameTimer() >= inTimer and IsControlJustPressed(1,38) and not IsPedInAnyVehicle(ped) then
					inTimer = GetGameTimer() + 3000

					TriggerEvent("cancelando",true)
					TriggerEvent("player:blockCommands",true)
					SetEntityHeading(ped,inLocates[inSelect][4])
					vRP.playAnim(false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
					SetEntityCoords(ped,inLocates[inSelect][1],inLocates[inSelect][2],inLocates[inSelect][3] - 1,1,0,0,0)
					TriggerEvent("Progress",10000,"Vasculhando...")

					Citizen.Wait(10000)

					TriggerEvent("player:blockCommands",false)
					TriggerEvent("cancelando",false)
					vSERVER.reducePrison()
					vRP.removeObjects()
				end
			end

			if GetEntityHealth(ped) <= 101 then
				if not inDeath then
					timeDeath = GetGameTimer() + 60000
					inDeath = true
				else
					if GetGameTimer() >= timeDeath then
						vRP.revivePlayer(125)
						inDeath = false
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RUNAWAY
-----------------------------------------------------------------------------------------------------------------------------------------
local runAway = {
	{ 1647.26,2763.14,45.76 },
	{ 1565.97,2682.8,45.53 },
	{ 1529.94,2585.13,45.53 },
	{ 1535.6,2467.81,45.58 },
	{ 1658.73,2390.01,45.51 },
	{ 1763.9,2405.9,45.6 },
	{ 1829.03,2473.42,45.31 },
	{ 1851.78,2703.64,45.76 },
	{ 1774.36,2767.32,45.66 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRUNAWAY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if inPrison then
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(coordsLeaver[1],coordsLeaver[2],coordsLeaver[3]))

			if distance <= 5 then
				timeDistance = 1
				DrawText3D(coordsLeaver[1],coordsLeaver[2],coordsLeaver[3],"~g~E~w~   FUGIR")

				if distance <= 1 and GetGameTimer() >= inTimer and IsControlJustPressed(1,38) then
					inTimer = GetGameTimer() + 3000

					if vSERVER.checkKey() then
						local rand = math.random(#runAway)
						SetEntityCoords(ped,runAway[rand][1],runAway[rand][2],runAway[rand][3],1,0,0,0)
					end
				end
			end

			if not polyPrison:isPointInside(coords) then
				SetEntityCoords(ped,coordsIntern[1],coordsIntern[2],coordsIntern[3],1,0,0,0)
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.syncPrison(status,teleport)
	if teleport then
		if status then
			SetEntityCoords(PlayerPedId(),coordsIntern[1],coordsIntern[2],coordsIntern[3],1,0,0,0)
		else
			SetEntityCoords(PlayerPedId(),coordsExtern[1],coordsExtern[2],coordsExtern[3],1,0,0,0)
		end
	end

	inPrison = status
	inSelect = math.random(#inLocates)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ASYNCSERVICES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.asyncServices()
	inSelect = math.random(#inLocates)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.stopPrison()
    inPrison = false
    inDeath = false
    DoScreenFadeIn(1000)
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