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
Tunnel.bindInterface("circuits",cRP)
vSERVER = Tunnel.getInterface("circuits")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inRunners = false
local inSelected = 0
local inCheckpoint = 0
local inLaps = 1
local inTimers = 0
local raceTimers = 0
local Points = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local runners = {
	[1] = {
		["laps"] = 1,
		["raceTimers"] = 140,
		["init"] = { 2679.43,3443.93,55.81 },
		["coords"] = {
			{ 2750.48,3414.08,55.77 },
			{ 2549.74,3056.91,43.42 },
			{ 2250.66,3009.13,44.7 },
			{ 1732.12,3447.2,38.13 },
			{ 1189.73,3536.38,34.54 },
			{ 370.91,3464.73,34.76 },
			{ 270.57,2697.06,43.59 },
			{ 432.97,2674.04,43.34 },
			{ 1406.58,2699.75,37.0 },
			{ 1907.79,2965.44,45.12 },
			{ 2049.76,3063.96,45.95 },
			{ 1886.37,3200.55,45.24 },
			{ 2259.58,3248.1,47.58 },
			{ 2576.37,3270.15,51.17 },
			{ 2685.91,3441.63,55.25 }
		}
	},
	[2] = {
		["laps"] = 1,
		["raceTimers"] = 190,
		["init"] = { -566.72,-2117.39,5.98 },
		["coords"] = {
			{ -566.24,-2065.5,6.25 },
			{ -256.74,-2196.93,9.79 },
			{ -200.51,-1881.79,27.31 },
			{ 16.53,-1694.03,28.76 },
			{ -171.71,-1472.82,31.58 },
			{ 51.95,-1372.56,28.76 },
			{ 69.05,-1178.94,28.75 },
			{ -63.12,-1134.79,25.31 },
			{ -193.62,-1408.0,30.7 },
			{ -406.04,-1791.38,20.98 },
			{ -152.28,-1979.94,22.33 },
			{ -285.66,-2112.61,21.72 },
			{ -513.33,-1916.75,26.94 },
			{ -724.83,-2138.99,12.82 },
			{ -1035.16,-2549.1,13.21 },
			{ -853.76,-2590.61,13.21 },
			{ -790.83,-2322.36,14.2 },
			{ -768.5,-2147.59,8.29 },
			{ -755.31,-2045.03,8.36 },
			{ -788.29,-1980.52,8.49 },
			{ -635.59,-1991.78,5.76 }
		}
	},
	[3] = {
		["laps"] = 1,
		["raceTimers"] = 260,
		["init"] = { 1679.4,-1564.53,112.57 },
		["coords"] = {
			{ 1628.26,-1574.17,102.08 },
			{ 1533.88,-1683.19,83.68 },
			{ 1482.93,-1818.75,70.58 },
			{ 1407.33,-1627.96,58.23 },
			{ 1279.4,-1483.58,37.09 },
			{ 866.52,-1432.02,28.68 },
			{ 793.61,-1076.04,27.97 },
			{ 594.23,-1021.29,36.5 },
			{ 281.12,-1046.65,28.66 },
			{ 182.17,-1347.28,28.76 },
			{ 408.03,-1597.39,28.76 },
			{ 307.26,-1803.13,27.09 },
			{ 438.59,-2022.79,22.81 },
			{ 716.72,-2067.17,28.75 },
			{ 831.91,-1810.98,28.56 },
			{ 1100.99,-1743.61,35.13 },
			{ 1222.7,-1621.49,49.07 },
			{ 1362.82,-1539.0,54.66 },
			{ 1526.84,-1459.91,72.22 },
			{ 1705.1,-1335.23,85.66 },
			{ 1787.15,-1378.23,104.6 },
			{ 1692.44,-1479.9,112.35 }
		}
	},
	[4] = {
		["laps"] = 1,
		["raceTimers"] = 130,
		["init"] = { -1732.07,-727.34,10.4 },
		["coords"] = {
			{ -1687.25,-725.7,10.13 },
			{ -1321.66,-1063.46,6.55 },
			{ -1266.54,-998.04,9.2 },
			{ -1091.11,-756.76,18.8 },
			{ -1344.93,-431.61,34.26 },
			{ -1094.49,-231.7,37.2 },
			{ -1269.32,-63.08,44.89 },
			{ -1614.4,-233.92,53.72 },
			{ -1744.35,-511.75,37.96 },
			{ -1945.5,-427.97,18.21 },
			{ -1888.41,-551.31,11.14 }
		}
	},
	[5] = {
		["laps"] = 1,
		["raceTimers"] = 190,
		["init"] = { -1367.59,15.04,53.38 },
		["coords"] = {
			{ -1364.17,-49.72,51.24 },
			{ -1435.79,-155.72,47.7 },
			{ -1278.39,-398.14,35.38 },
			{ -959.16,-323.14,37.54 },
			{ -707.23,-361.29,33.95 },
			{ -345.0,-199.92,37.47 },
			{ -177.95,-82.47,52.17 },
			{ 19.43,210.7,106.59 },
			{ -68.28,290.18,104.94 },
			{ -187.34,427.57,109.83 },
			{ -403.84,402.7,108.28 },
			{ -531.58,395.15,88.31 },
			{ -709.42,288.86,83.54 },
			{ -856.58,407.08,86.74 },
			{ -1077.65,342.12,66.66 },
			{ -907.13,-79.22,37.37 },
			{ -1207.93,-97.1,41.11 }
		}
	},
	[6] = {
		["laps"] = 1,
		["raceTimers"] = 250,
		["init"] = { 636.43,649.9,128.9 },
		["coords"] = {
			{ 977.0,515.89,105.31 },
			{ 736.79,74.64,81.42 },
			{ 1208.18,-325.41,68.54 },
			{ 962.42,-481.13,61.05 },
			{ 1120.51,-758.95,57.22 },
			{ 1104.8,-836.17,51.81 },
			{ 766.73,-620.24,37.0 },
			{ 389.2,-472.41,40.91 },
			{ 187.44,-761.89,32.12 },
			{ -10.0,-885.34,29.42 },
			{ -413.7,-835.13,30.92 },
			{ -520.68,-918.21,24.42 },
			{ -591.87,-957.69,21.94 },
			{ -1177.59,-1345.46,4.41 },
			{ -1124.65,-1525.95,3.81 },
			{ -1078.36,-1481.84,4.57 },
			{ -825.81,-1156.65,6.79 },
			{ -699.42,-1226.0,10.08 },
			{ -567.34,-1222.98,15.79 },
			{ -513.52,-1298.88,27.13 },
			{ -340.87,-1438.61,29.35 },
			{ -285.09,-1113.67,22.44 },
			{ -339.25,-1089.42,22.44 }
		}
	},
	[7] = {
		["laps"] = 1,
		["raceTimers"] = 140,
		["init"] = { 364.86,-543.57,28.75 },
		["coords"] = {
			{ 533.25,-414.31,31.14 },
			{ 921.26,180.32,74.76 },
			{ 966.95,518.44,108.04 },
			{ 719.2,339.06,112.22 },
			{ 448.88,420.81,139.67 },
			{ 303.33,586.04,153.65 },
			{ 240.08,475.68,125.26 },
			{ 53.07,310.46,110.64 },
			{ 130.74,213.78,106.63 },
			{ 94.49,-104.61,58.28 },
			{ -12.92,-127.54,56.19 },
			{ -169.55,-390.98,32.82 },
			{ -170.7,-705.57,33.88 },
			{ -165.81,-825.46,30.51 },
			{ 157.93,-1026.31,28.78 },
			{ 362.35,-669.27,28.73 }
		}
	},
	[8] = {
		["laps"] = 1,
		["raceTimers"] = 140,
		["init"] = { 247.31,-1513.38,29.10 },
		["coords"] = {
			{ 204.64,-1573.6,28.75 },
			{ -74.43,-1723.62,28.75 },
			{ 6.18,-1857.65,23.51 },
			{ 243.72,-1710.35,28.54 },
			{ 420.14,-1789.33,28.26 },
			{ 499.28,-1740.73,28.37 },
			{ 769.56,-1746.88,28.96 },
			{ 820.75,-1504.11,27.8 },
			{ 280.67,-1297.54,29.17 },
			{ 218.93,-1105.09,28.75 },
			{ 165.16,-1018.15,28.78 },
			{ 117.6,-1377.83,28.75 },
			{ 269.36,-1481.18,28.75 }
		}
	},
	[9] = {
		["laps"] = 1,
		["raceTimers"] = 275,
		["init"] = { -324.69,-1098.09,23.03 },
		["coords"] = {
			{ -221.61,-1143.07,22.25 },
			{ -46.12,-1002.0,28.33 },
			{ 162.85,-1025.49,28.55 },
			{ 272.71,-916.87,28.21 },
			{ 591.82,-856.78,40.5 },
			{ 1047.93,-843.98,48.01 },
			{ 1169.25,-256.18,68.3 },
			{ 751.36,-19.63,81.35 },
			{ 540.67,-93.28,65.28 },
			{ 78.13,-6.03,67.74 },
			{ 7.37,-90.2,57.58 },
			{ 46.45,-154.45,54.42 },
			{ -88.78,-607.33,35.48 },
			{ -17.16,-688.15,31.5 },
			{ 51.47,-630.38,30.8 },
			{ 247.27,-625.05,27.75 },
			{ 440.21,-679.98,27.95 },
			{ 498.0,-1099.74,28.28 },
			{ 378.53,-1155.03,28.46 },
			{ 266.63,-1185.26,37.41 },
			{ -284.7,-1184.21,36.46 },
			{ -383.94,-760.1,36.43 },
			{ 195.94,-524.66,33.25 },
			{ 850.35,-721.44,41.71 },
			{ 971.68,-838.28,44.75 },
			{ 914.7,-909.6,32.69 },
			{ 857.22,-886.36,24.6 }
		}
	},
	[10] = {
		["laps"] = 1,
		["raceTimers"] = 175,
		["init"] = { 844.67,-1985.39,29.31 },
		["coords"] = {
			{ 817.8,-1892.41,28.49,350.28 },
			{ 499.55,-1652.9,28.48,50.55 },
			{ 83.52,-1313.07,28.5,31.85 },
			{ 62.22,-1062.52,28.54,50.66 },
			{ 27.69,-1088.88,37.32,221.62 },
			{ 51.07,-1262.51,28.5,175.42 },
			{ 90.45,-1477.94,28.51,157.51 },
			{ 233.67,-1637.34,28.49,230.82 },
			{ 209.84,-1740.37,28.13,110.33 },
			{ 78.37,-1882.45,22.03,141.43 },
			{ -73.15,-1790.83,27.24,51.11 },
			{ -5.82,-1703.57,28.49,291.54 },
			{ 238.85,-1842.78,25.78,230.32 },
			{ 292.57,-2007.22,19.42,140.23 },
			{ 334.51,-2169.72,13.38,243.38 },
			{ 326.02,-2492.78,4.61,188.58 },
			{ 124.63,-2551.88,5.16,89.57 },
			{ -100.39,-2440.36,5.17,89.63 },
			{ -203.15,-2669.09,5.16,180.78 }
		}
	},
	[11] = {
		["laps"] = 1,
		["raceTimers"] = 220,
		["init"] = { -2179.39,-382.35,13.35 },
		["coords"] = {
			{ -2269.87,-326.79,12.81,72.96 },
			{ -3029.86,214.76,15.46,6.94 },
			{ -3074.47,347.38,6.51,343.69 },
			{ -3066.56,672.28,11.68,39.54 },
			{ -3006.89,614.21,19.6,194.09 },
			{ -2683.75,-55.23,15.49,217.85 },
			{ -2217.69,-343.97,12.72,264.43 },
			{ -1893.73,-213.35,36.22,229.65 },
			{ -1635.35,-332.52,49.81,316.02 },
			{ -1482.75,-417.43,36.07,228.49 },
			{ -1178.28,-298.45,37.04,280.96 },
			{ -880.58,-597.81,29.01,206.72 },
			{ -598.58,-665.15,31.37,270.44 },
			{ -351.31,-732.82,33.31,180.83 },
			{ -248.04,-879.38,30.04,251.96 },
			{ -259.69,-1059.22,25.54,160.35 },
			{ -32.37,-1141.53,26.01,272.93 },
			{ 86.96,-1067.53,28.72,336.5 },
			{ 19.04,-959.33,28.74,70.49 },
			{ -108.92,-1287.87,28.68,179.03 }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRUNNERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()

		if IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)

			if inRunners then
				timeDistance = 4
				
				SoftPoints = (GetGameTimer() - Points)
				CountPoints = (SoftPoints / 1000)
				
				SendNUIMessage({ show = true })
				SendNUIMessage({ laps = Laps, maxlaps = runners[inSelected]["laps"], checkpoint = inCheckpoint, maxcheckpoint = #runners[inSelected]["coords"], points = SoftPoints, explosive = raceTime })

		
				local distance = #(coords - vector3(runners[inSelected]["coords"][inCheckpoint][1],runners[inSelected]["coords"][inCheckpoint][2],runners[inSelected]["coords"][inCheckpoint][3]))
				if distance <= 200 then
						DrawMarker(1,runners[inSelected]["coords"][inCheckpoint][1],runners[inSelected]["coords"][inCheckpoint][2],runners[inSelected]["coords"][inCheckpoint][3] - 3,0,0,0,0,0,0,12.0,12.0,8.0,255,255,255,25,0,0,0,0)
						DrawMarker(21,runners[inSelected]["coords"][inCheckpoint][1],runners[inSelected]["coords"][inCheckpoint][2],runners[inSelected]["coords"][inCheckpoint][3] + 1,0,0,0,0,180.0,130.0,3.0,3.0,2.0,42,137,255,100,0,0,0,1)

					if distance <= 10 then
						if inCheckpoint >= #runners[inSelected]["coords"] then
							if inLaps >= runners[inSelected]["laps"] then
								PlaySoundFrontend(-1,"CHECKPOINT_UNDER_THE_BRIDGE","HUD_MINI_GAME_SOUNDSET",false)
								SendNUIMessage({ show = false })
								
								vSERVER.finishRaces()
								vSERVER.finishRacesDatabase(inSelected,SoftPoints / 10)
								
								SoftPoints = 0
								Points = 0
								cleanBlips()
								inRunners = false
							else
								inCheckpoint = 1
								inLaps = inLaps + 1
								makeBlips()
								SendNUIMessage({ show = true })
							end
						else
							inCheckpoint = inCheckpoint + 1
							makeBlips()
						end
					end
				end
			else
				for k,v in pairs(runners) do
					local distance = #(coords - vector3(v["init"][1],v["init"][2],v["init"][3]))
					if distance <= 50 then
						timeDistance = 1
						DrawMarker(23,v["init"][1],v["init"][2],v["init"][3]-1,0.0,0.0,0.0,0.0,0.0,0.0,10.0,10.0,0.0,42,137,255,100,0,0,0,0)

						if IsControlJustPressed(1,38) and distance <= 5 and vSERVER.checkTicket() then
							inSelected = parseInt(k)
							Points = GetGameTimer()
							SoftPoints = 0
							inRunners = true
							inCheckpoint = 1
							inTimers = 0
							inLaps = 1
							raceTime = parseInt(runners[inSelected]["raceTimers"])
							makeBlips()
						end
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if inRunners then
			timeDistance = 1
			inTimers = inTimers + 1
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRACETIME
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if inRunners then
			if raceTime > 0 then
				raceTime = raceTime - 1

				if (raceTime <= 0 or not IsPedInAnyVehicle(PlayerPedId())) then
					TriggerServerEvent("raceTime:explosivePlayers")
					raceTime = 0
					Points = 0
					cleanBlips()
					inRunners = false
					SendNUIMessage({ show = false })

					Citizen.Wait(3000)
					
					AddExplosion(GetEntityCoords(GetPlayersLastVehicle()),2,1.0,true,true,true)
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- makeBlips
-----------------------------------------------------------------------------------------------------------------------------------------
function makeBlips()
	if DoesBlipExist(CheckBlip) then
		RemoveBlip(CheckBlip)
		CheckBlip = nil
	end

	CheckBlip = AddBlipForCoord(runners[inSelected]["coords"][inCheckpoint][1],runners[inSelected]["coords"][inCheckpoint][2],runners[inSelected]["coords"][inCheckpoint][3])
	SetBlipSprite(CheckBlip,1)
	SetBlipAsShortRange(CheckBlip,true)
	SetBlipScale(CheckBlip,0.5)
	SetBlipColour(CheckBlip,3)
	SetBlipRoute(CheckBlip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Checkpoint")
	EndTextCommandSetBlipName(CheckBlip)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function cleanBlips()
	if DoesBlipExist(CheckBlip) then
		RemoveBlip(CheckBlip)
		CheckBlip = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CIRCUITS:INATIVERACES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("circuits:insertList")
AddEventHandler("circuits:insertList",function(status)
	inRunners = status
end)