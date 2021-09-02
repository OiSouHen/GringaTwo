-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIOVOLUME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("volume", function(source,args)
	if args[1] then
		if tonumber(args[1]) then
			if tonumber(args[1]) <= 200 and tonumber(args[1]) >= 0 then
				exports.tokovoip:setRadioVolume(tonumber(args[1])-100)
			else
				TriggerEvent("Notify","amarelo","Você deve digitar um número entre 0 e 200",5000)
			end
		else
			TriggerEvent("Notify","amarelo","Você deve digitar um número entre 0 e 200",5000)
		end
	else
		TriggerEvent("Notify","amarelo","Você deve digitar um número entre 0 e 200",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYREBURST
-----------------------------------------------------------------------------------------------------------------------------------------
local oldSpeed = 0
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			timeDistance = 1

			SetPedHelmet(ped,false)
			DisableControlAction(0,345,true)

			local veh = GetVehiclePedIsUsing(ped)
			if GetPedInVehicleSeat(veh,-1) == ped then
				if GetVehicleDirtLevel(veh) ~= 0.0 then
					SetVehicleDirtLevel(veh,0.0)
				end

				local speed = GetEntitySpeed(veh) * 2.236936
				if speed ~= oldSpeed then
					if (oldSpeed - speed) >= 60 then
						TriggerServerEvent("upgradeStress",10)

						if GetVehicleClass(veh) ~= 8 and GetEntityModel(veh) ~= 1755270897 then
							SetVehicleEngineOn(veh,false,true,true)
							vehicleTyreBurst(veh)
						end
					end

					oldSpeed = speed
				end
			end
		else
			if oldSpeed ~= 0 then
				oldSpeed = 0
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLETYREBURST
-----------------------------------------------------------------------------------------------------------------------------------------
function vehicleTyreBurst(vehicle)
	local tyre = math.random(4)
	if tyre == 1 then
		if not IsVehicleTyreBurst(vehicle,0,false) then
			SetVehicleTyreBurst(vehicle,0,true,1000.0)
		end
	elseif tyre == 2 then
		if not IsVehicleTyreBurst(vehicle,1,false) then
			SetVehicleTyreBurst(vehicle,1,true,1000.0)
		end
	elseif tyre == 3 then
		if not IsVehicleTyreBurst(vehicle,4,false) then
			SetVehicleTyreBurst(vehicle,4,true,1000.0)
		end
	elseif tyre == 4 then
		if not IsVehicleTyreBurst(vehicle,5,false) then
			SetVehicleTyreBurst(vehicle,5,true,1000.0)
		end
	end

	if math.random(100) < 30 then
		Citizen.Wait(500)
		vehicleTyreBurst(vehicle)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {
	{ 1148.78,-1532.84,35.39,80,38,"Hospital",0.5 },
	{ -247.42,6331.39,32.42,80,38,"Hospital",0.5 },
	{ 859.4,-2363.23,30.0,315,8,"Encontro de Carros",0.4 },
	{ 55.43,-876.19,30.66,357,65,"Garagem",0.6 },
	{ 598.04,2741.27,42.07,357,65,"Garagem",0.6 },
	{ -136.36,6357.03,31.49,357,65,"Garagem",0.6 },
	{ 275.23,-345.54,45.17,357,65,"Garagem",0.6 },
	{ 596.40,90.65,93.12,357,65,"Garagem",0.6 },
	{ -340.76,265.97,85.67,357,65,"Garagem",0.6 },
	{ -2030.01,-465.97,11.60,357,65,"Garagem",0.6 },
	{ -1184.92,-1510.00,4.64,357,65,"Garagem",0.6 },
	{ 214.02,-808.44,31.01,357,65,"Garagem",0.6 },
	{ -348.88,-874.02,31.31,357,65,"Garagem",0.6 },
	{ 67.74,12.27,69.21,357,65,"Garagem",0.6 },
	{ 361.90,297.81,103.88,357,65,"Garagem",0.6 },
	{ 1035.89,-763.89,57.99,357,65,"Garagem",0.6 },
	{ -796.63,-2022.77,9.16,357,65,"Garagem",0.6 },
	{ 453.27,-1146.76,29.52,357,65,"Garagem",0.6 },
	{ 528.66,-146.3,58.38,357,65,"Garagem",0.6 },
	{ -1159.48,-739.32,19.89,357,65,"Garagem",0.6 },
	{ 101.22,-1073.68,29.38,357,65,"Garagem",0.6 },
	{ 1856.54,2607.32,45.68,60,18,"Departamento LSPD",0.6 },
	{ 1851.45,3686.71,34.26,60,16,"Departamento Sheriff",0.6 },
	{ -442.5,6017.18,31.72,60,16,"Departamento Sheriff",0.6 },
	{ 387.0,787.88,187.47,60,43,"Departamento Ranger",0.6 },
	{ 25.68,-1346.6,29.5,52,36,"Loja de Departamento",0.5 },
	{ 2556.47,382.05,108.63,52,36,"Loja de Departamento",0.5 },
	{ 1163.55,-323.02,69.21,52,36,"Loja de Departamento",0.5 },
	{ -707.31,-913.75,19.22,52,36,"Loja de Departamento",0.5 },
	{ -47.72,-1757.23,29.43,52,36,"Loja de Departamento",0.5 },
	{ 373.89,326.86,103.57,52,36,"Loja de Departamento",0.5 },
	{ -3242.95,1001.28,12.84,52,36,"Loja de Departamento",0.5 },
	{ 1729.3,6415.48,35.04,52,36,"Loja de Departamento",0.5 },
	{ 548.0,2670.35,42.16,52,36,"Loja de Departamento",0.5 },
	{ 1960.69,3741.34,32.35,52,36,"Loja de Departamento",0.5 },
	{ 2677.92,3280.85,55.25,52,36,"Loja de Departamento",0.5 },
	{ 1698.5,4924.09,42.07,52,36,"Loja de Departamento",0.5 },
	{ -1820.82,793.21,138.12,52,36,"Loja de Departamento",0.5 },
	{ 1393.21,3605.26,34.99,52,36,"Loja de Departamento",0.5 },
	{ -2967.78,390.92,15.05,52,36,"Loja de Departamento",0.5 },
	{ -3040.14,585.44,7.91,52,36,"Loja de Departamento",0.5 },
	{ 1135.56,-982.24,46.42,52,36,"Loja de Departamento",0.5 },
	{ 1166.0,2709.45,38.16,52,36,"Loja de Departamento",0.5 },
	{ -1487.21,-378.99,40.17,52,36,"Loja de Departamento",0.5 },
	{ -1222.76,-907.21,12.33,52,36,"Loja de Departamento",0.5 },
	{ 1692.62,3759.50,34.70,76,6,"Loja de Armas",0.4 },
	{ 252.89,-49.25,69.94,76,6,"Loja de Armas",0.4 },
	{ 843.28,-1034.02,28.19,76,6,"Loja de Armas",0.4 },
	{ -331.35,6083.45,31.45,76,6,"Loja de Armas",0.4 },
	{ -663.15,-934.92,21.82,76,6,"Loja de Armas",0.4 },
	{ -1305.18,-393.48,36.69,76,6,"Loja de Armas",0.4 },
	{ -1118.80,2698.22,18.55,76,6,"Loja de Armas",0.4 },
	{ 2568.83,293.89,108.73,76,6,"Loja de Armas",0.4 },
	{ -3172.68,1087.10,20.83,76,6,"Loja de Armas",0.4 },
	{ 21.32,-1106.44,29.79,76,6,"Loja de Armas",0.4 },
	{ 811.19,-2157.67,29.61,76,6,"Loja de Armas",0.4 },
	{ -815.12,-184.15,37.57,71,62,"Barbearia",0.5 },
	{ 138.13,-1706.46,29.3,71,62,"Barbearia",0.5 },
	{ -1280.92,-1117.07,7.0,71,62,"Barbearia",0.5 },
	{ 1930.54,3732.06,32.85,71,62,"Barbearia",0.5 },
	{ 1214.2,-473.18,66.21,71,62,"Barbearia",0.5 },
	{ -33.61,-154.52,57.08,71,62,"Barbearia",0.5 },
	{ -276.65,6226.76,31.7,71,62,"Barbearia",0.5 },
	{ 75.35,-1392.92,29.38,366,62,"Loja de Roupas",0.5 },
	{ -710.15,-152.36,37.42,366,62,"Loja de Roupas",0.5 },
	{ -163.73,-303.62,39.74,366,62,"Loja de Roupas",0.5 },
	{ -822.38,-1073.52,11.33,366,62,"Loja de Roupas",0.5 },
	{ -1193.13,-767.93,17.32,366,62,"Loja de Roupas",0.5 },
	{ -1449.83,-237.01,49.82,366,62,"Loja de Roupas",0.5 },
	{ 4.83,6512.44,31.88,366,62,"Loja de Roupas",0.5 },
	{ 1693.95,4822.78,42.07,366,62,"Loja de Roupas",0.5 },
	{ 125.82,-223.82,54.56,366,62,"Loja de Roupas",0.5 },
	{ 614.2,2762.83,42.09,366,62,"Loja de Roupas",0.5 },
	{ 1196.72,2710.26,38.23,366,62,"Loja de Roupas",0.5 },
	{ -3170.53,1043.68,20.87,366,62,"Loja de Roupas",0.5 },
	{ -1101.42,2710.63,19.11,366,62,"Loja de Roupas",0.5 },
	{ 425.6,-806.25,29.5,366,62,"Loja de Roupas",0.5 },
	{ -1082.22,-247.54,37.77,439,73,"Life Invader",0.6 },
	{ -1728.06,-1050.69,1.71,266,62,"Embarcações",0.5 },
	{ 1966.36,3975.86,31.51,266,62,"Embarcações",0.5 },
	{ -776.72,-1495.02,2.29,266,62,"Embarcações",0.5 },
	{ -893.97,5687.78,3.29,266,62,"Embarcações",0.5 },
	{ 452.99,-607.74,28.59,513,62,"Motorista",0.5 },
	{ 356.42,274.61,103.14,67,62,"Transportador",0.5 },
	{ -840.21,5399.25,34.61,285,62,"Lenhador",0.5 },
	{ 132.6,-1305.06,29.2,93,62,"Vanilla Unicorn",0.5 },
	{ -565.14,271.56,83.02,93,62,"Tequi-La-La",0.5 },
	{ -172.21,6385.85,31.49,403,5,"Farmácia",0.7 },
	{ 1690.07,3581.68,35.62,403,5,"Farmácia",0.7 },
	{ 315.12,-1068.58,29.39,403,5,"Farmácia",0.7 },
	{ 114.45,-4.89,67.82,403,5,"Farmácia",0.7 },
	{ 2679.43,3443.93,55.81,38,13,"Circuito",0.5 },
	{ -566.72,-2117.39,5.98,38,13,"Circuito",0.5 },
	{ 1679.4,-1564.53,112.57,38,13,"Circuito",0.5 },
	{ -1732.07,-727.34,10.4,38,13,"Circuito",0.5 },
	{ -1367.59,15.04,53.38,38,13,"Circuito",0.5 },
	{ 636.43,649.9,128.9,38,13,"Circuito",0.5 },
	{ 364.86,-543.57,28.75,38,13,"Circuito",0.5 },
	{ 247.31,-1513.38,29.10,38,13,"Circuito",0.5 },
	{ -324.69,-1098.09,23.03,38,13,"Circuito",0.5 },
	{ 844.67,-1985.39,29.31,38,13,"Circuito",0.5 },
	{ 46.66,-1749.79,29.64,78,11,"Mercado Central",0.5 },
	{ 2747.28,3473.04,55.67,78,11,"Mercado Central",0.5 },
	{ 82.54,-1553.28,29.59,318,62,"Lixeiro",0.6 },
	{ 287.36,2843.6,44.7,318,62,"Lixeiro",0.6 },
	{ -413.97,6171.58,31.48,318,62,"Lixeiro",0.6 },
	{ -428.56,-1728.33,19.79,467,11,"Reciclagem",0.6 },
	{ -741.56,5594.94,41.66,36,62,"Teleférico",0.6 },
	{ 454.46,5571.95,781.19,36,62,"Teleférico",0.6 },
	{ -191.61,-1154.2,23.05,357,9,"Impound",0.6 },
	{ 1724.84,3715.31,34.22,357,9,"Impound",0.6 },
	{ -364.24,6071.16,31.52,357,9,"Impound",0.6 },
	{ -1178.37,-2845.97,13.93,402,26,"Mecânica",0.7 },
	{ 1144.38,-770.17,57.58,402,26,"Mecânica",0.7 },
	{ -1425.48,-436.4,35.79,402,26,"Mecânica",0.7 },
	{ -206.22,-1303.12,31.27,402,26,"Mecânica",0.7 },
	{ -359.81,-133.38,38.67,402,26,"Mecânica",0.7 },
	{ 717.04,-1087.21,22.34,402,26,"Mecânica",0.7 },
	{ -1144.02,-1989.42,13.16,402,26,"Mecânica",0.7 },
	{ 1178.0,2657.85,37.98,402,26,"Mecânica",0.7 },
	{ 116.38,6620.89,31.88,402,26,"Mecânica",0.7 },
	{ -49.34,-1041.79,28.21,402,26,"Mecânica",0.7 },
	{ -594.85,2090.27,131.6,617,62,"Minerador",0.6 },
	{ 1322.93,-1652.29,52.27,75,13,"Loja de Tatuagem",0.5 },
	{ -1154.42,-1425.9,4.95,75,13,"Loja de Tatuagem",0.5 },
	{ 322.84,180.16,103.58,75,13,"Loja de Tatuagem",0.5 },
	{ -3169.62,1075.8,20.83,75,13,"Loja de Tatuagem",0.5 },
	{ 1864.07,3747.9,33.03,75,13,"Loja de Tatuagem",0.5 },
	{ -293.57,6199.85,31.48,75,13,"Loja de Tatuagem",0.5 },
	{ 405.92,6526.12,27.73,89,62,"Colheita",0.4 },
	{ 12.33,-1607.92,32.84,79,62,"Tacos",0.5 },
	{ -162.8,-2130.61,16.7,483,62,"Kartodromo",0.6 },
	{ 895.36,-179.36,74.7,198,62,"Taxista",0.5 },
	{ -1031.05,-2965.67,13.95,307,62,"Táxi Aéreo",0.7 },
	{ -680.9,5832.41,17.32,141,62,"Cabana do Caçador",0.7 },
	{ -773.55,298.51,85.71,475,31,"Eclipse Towers",0.5 },
	{ -1816.74,-1193.84,14.31,68,62,"Pescador",0.5 },
	{ -325.88,6228.43,31.49,68,62,"Pescador",0.5 },
	{ 911.0,3644.85,32.67,68,62,"Pescador",0.5 },
	{ -117.24,-604.57,36.28,408,62,"Escritório",0.6 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for _,v in pairs(blips) do
		local blip = AddBlipForCoord(v[1],v[2],v[3])
		SetBlipSprite(blip,v[4])
		SetBlipAsShortRange(blip,true)
		SetBlipColour(blip,v[5])
		SetBlipScale(blip,v[7])
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v[6])
		EndTextCommandSetBlipName(blip)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALPHAS
-----------------------------------------------------------------------------------------------------------------------------------------
local alphas = {
	{ -3418.14,967.56,8.34,25,2 },
	{ -273.63,6633.67,7.4,25,2 },
	{ 713.39,4101.04,35.79,25,2 },
	{ 1343.03,2233.61,88.43,200,3 },
	{ -1171.5,1454.58,185.28,300,3 },
	{ -852.1,4940.38,235.63,300,3 },
	{ 1311.92,4610.54,131.21,200,3 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADALPHA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for _,v in pairs(alphas) do
		local blip = AddBlipForRadius(v[1],v[2],v[3],v[4] + 0.0)
		SetBlipAlpha(blip,100)
		SetBlipColour(blip,v[5])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPATCH
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for i = 1,25 do
		EnableDispatchService(i,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECOIL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()

		if IsPedArmed(ped,6) then
			DisableControlAction(1,140,true)
			DisableControlAction(1,141,true)
			DisableControlAction(1,142,true)
			Citizen.Wait(1)
		else
			Citizen.Wait(1000)
		end

		if IsPedShooting(ped) then
			local cam = GetFollowPedCamViewMode()
			local veh = IsPedInAnyVehicle(ped)
			
			local speed = math.ceil(GetEntitySpeed(ped))
			if speed > 70 then
				speed = 70
			end

			local _,wep = GetCurrentPedWeapon(ped)
			local class = GetWeapontypeGroup(wep)
			local p = GetGameplayCamRelativePitch()
			local camDist = #(GetGameplayCamCoord() - GetEntityCoords(ped))

			local recoil = math.random(110,120+(math.ceil(speed*0.5)))/100
			local rifle = false

			if class == 970310034 or class == 1159398588 then
				rifle = true
			end

			if camDist < 5.3 then
				camDist = 1.5
			else
				if camDist < 8.0 then
					camDist = 4.0
				else
					camDist =  7.0
				end
			end

			if veh then
				recoil = recoil + (recoil * camDist)
			else
				recoil = recoil * 0.1
			end

			if cam == 4 then
				recoil = recoil * 0.6
				if rifle then
					recoil = recoil * 0.1
				end
			end

			if rifle then
				recoil = recoil * 0.6
			end

			local spread = math.random(4)
			local h = GetGameplayCamRelativeHeading()
			local hf = math.random(10,40+speed) / 100

			if veh then
				hf = hf * 2.0
			end

			if spread == 1 then
				SetGameplayCamRelativeHeading(h+hf)
			elseif spread == 2 then
				SetGameplayCamRelativeHeading(h-hf)
			end

			local set = p + recoil
			SetGameplayCamRelativePitch(set,0.8)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		N_0xf4f2c0d4ee209e20()
		N_0x9e4cfff989258472()
		SetPlayerTargetingMode(2)
		DistantCopCarSirens(false)

		SetCreateRandomCops(false)
		CancelCurrentPoliceReport()
		SetCreateRandomCopsOnScenarios(false)
		SetCreateRandomCopsNotOnScenarios(false)

		SetVehicleModelIsSuppressed(GetHashKey("jet"),true)
		SetVehicleModelIsSuppressed(GetHashKey("blimp"),true)
		SetVehicleModelIsSuppressed(GetHashKey("polmav"),true)
		SetVehicleModelIsSuppressed(GetHashKey("buzzard2"),true)
		SetVehicleModelIsSuppressed(GetHashKey("mammatus"),true)
		SetVehicleModelIsSuppressed(GetHashKey("besra"),true)
		SetVehicleModelIsSuppressed(GetHashKey("luxor"),true)

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if IsPedArmed(PlayerPedId(),6) then
			DisableControlAction(1,140,true)
			DisableControlAction(1,141,true)
			DisableControlAction(1,142,true)
		end

		N_0x4757f00bc6323cfe("WEAPON_BAT",0.25)
		N_0x4757f00bc6323cfe("WEAPON_HAMMER",0.25)
		N_0x4757f00bc6323cfe("WEAPON_WRENCH",0.25)
		N_0x4757f00bc6323cfe("WEAPON_UNARMED",0.25)
		N_0x4757f00bc6323cfe("WEAPON_HATCHET",0.25)
		N_0x4757f00bc6323cfe("WEAPON_CROWBAR",0.25)
		N_0x4757f00bc6323cfe("WEAPON_MACHETE",0.25)
		N_0x4757f00bc6323cfe("WEAPON_POOLCUE",0.25)
		N_0x4757f00bc6323cfe("WEAPON_KNUCKLE",0.25)
		N_0x4757f00bc6323cfe("WEAPON_GOLFCLUB",0.25)
		N_0x4757f00bc6323cfe("WEAPON_BATTLEAXE",0.25)
		N_0x4757f00bc6323cfe("WEAPON_FLASHLIGHT",0.25)
		N_0x4757f00bc6323cfe("WEAPON_NIGHTSTICK",0.35)
		N_0x4757f00bc6323cfe("WEAPON_STONE_HATCHET",0.25)

		RemoveAllPickupsOfType("PICKUP_WEAPON_KNIFE")
		RemoveAllPickupsOfType("PICKUP_WEAPON_PISTOL")
		RemoveAllPickupsOfType("PICKUP_WEAPON_MINISMG")
		RemoveAllPickupsOfType("PICKUP_WEAPON_MICROSMG")
		RemoveAllPickupsOfType("PICKUP_WEAPON_PUMPSHOTGUN")
		RemoveAllPickupsOfType("PICKUP_WEAPON_CARBINERIFLE")
		RemoveAllPickupsOfType("PICKUP_WEAPON_SAWNOFFSHOTGUN")

		HideHudComponentThisFrame(1)
		HideHudComponentThisFrame(3)
		HideHudComponentThisFrame(4)
		HideHudComponentThisFrame(5)
		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(10)
		HideHudComponentThisFrame(11)
		HideHudComponentThisFrame(12)
		HideHudComponentThisFrame(13)
		HideHudComponentThisFrame(15)
		HideHudComponentThisFrame(17)
		HideHudComponentThisFrame(18)
		HideHudComponentThisFrame(21)
		HideHudComponentThisFrame(22)

		SetMaxWantedLevel(0)
		DisableVehicleDistantlights(true)
		ClearPlayerWantedLevel(PlayerId())
		DisablePlayerVehicleRewards(PlayerId())

		SetScenarioPedDensityMultiplierThisFrame(0.5,0.5)
		SetParkedVehicleDensityMultiplierThisFrame(0.5)
		SetRandomVehicleDensityMultiplierThisFrame(0.5)
		SetVehicleDensityMultiplierThisFrame(0.5)
		SetPedDensityMultiplierThisFrame(0.5)
		SetGarbageTrucks(false)
		SetRandomBoats(false)

		Citizen.Wait(0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINIT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_01_STAGE",false)
	SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_02_MAIN_ROOM",false)
	SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_03_BACK_ROOM",false)
    SetRelationshipBetweenGroups(1,GetHashKey("PRISONER"),GetHashKey("PLAYER"))
	SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Disabled_Zones",false,true)
	SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Zones",true,true)
	SetScenarioTypeEnabled("WORLD_VEHICLE_STREETRACE",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_SALTON_DIRT_BIKE",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_SALTON",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_NEXT_TO_CAR",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_CAR",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_BIKE",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_MILITARY_PLANES_SMALL",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_MILITARY_PLANES_BIG",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_MECHANIC",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_EMPTY",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_BUSINESSMEN",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_BIKE_OFF_ROAD_RACE",false)
	StartAudioScene("FBI_HEIST_H5_MUTE_AMBIENCE_SCENE")
	StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
	SetAudioFlag("PoliceScannerDisabled",true)
	SetAudioFlag("DisableFlightMusic",true)
	AddTextEntry("FE_THDR_GTAO","GG RP")
	SetPlayerCanUseCover(PlayerId(),false)
	SetRandomEventFlag(false)
	SetDeepOceanScaler(0.0)
	SetRadarZoom(1100)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL - 10
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		RemoveVehiclesFromGeneratorsInArea(65.95 - 5.0,-1719.34 - 5.0,29.32 - 5.0,65.95 + 5.0,-1719.34 + 5.0,29.32 + 5.0)
		RemoveVehiclesFromGeneratorsInArea(115.57 - 5.0,-1758.6 - 5.0,29.34 - 5.0,115.57 + 5.0,-1758.6 + 5.0,29.34 + 5.0)
		RemoveVehiclesFromGeneratorsInArea(-4.02 - 5.0,-1533.7 - 5.0,29.63 - 5.0,-4.02 + 5.0,-1533.7 + 5.0,29.63 + 5.0)
		RemoveVehiclesFromGeneratorsInArea(100.79 - 5.0,-1605.9 - 5.0,29.52 - 5.0,100.79 + 5.0,-1605.9 + 5.0,29.52 + 5.0)
		RemoveVehiclesFromGeneratorsInArea(43.77 - 5.0,-1288.61 - 5.0,29.15 - 5.0,43.77 + 5.0,-1288.61 + 5.0,29.15 + 5.0)
		RemoveVehiclesFromGeneratorsInArea(326.7 - 5.0,-1473.25 - 5.0,29.8 - 5.0,326.7 + 5.0,-1473.25 + 5.0,29.8 + 5.0)
		RemoveVehiclesFromGeneratorsInArea(366.15 - 5.0,-1453.25 - 5.0,29.44 - 5.0,366.15 + 5.0,-1453.25 + 5.0,29.44 + 5.0)
		RemoveVehiclesFromGeneratorsInArea(403.49 - 5.0,-1425.3 - 5.0,29.46 - 5.0,403.49 + 5.0,-1425.3 + 5.0,29.46 + 5.0)
		RemoveVehiclesFromGeneratorsInArea(296.23 - 5.0,-607.61 - 5.0,43.34 - 5.0,296.23 + 5.0,-607.61 + 5.0,43.34 + 5.0)
		RemoveVehiclesFromGeneratorsInArea(394.52 - 5.0,-570.99 - 5.0,28.69 - 5.0,394.52 + 5.0,-570.99 + 5.0,28.69 + 5.0)
		RemoveVehiclesFromGeneratorsInArea(459.25 - 10.0,-604.23 - 10.0,28.5 - 10.0,459.25 + 10.0,-604.23 + 10.0,28.5 + 10.0)
		RemoveVehiclesFromGeneratorsInArea(-449.8 - 10.0,5998.04 - 10.0,31.35 - 10.0,-449.8 + 10.0,5998.04 + 10.0,31.35 + 10.0)
		RemoveVehiclesFromGeneratorsInArea(-476.6 - 10.0,6030.53 - 10.0,31.34 - 10.0,-476.6 + 10.0,6030.53 + 10.0,31.34 + 10.0)
		RemoveVehiclesFromGeneratorsInArea(407.85 - 10.0,-996.92 - 10.0,29.27 - 10.0,407.85 + 10.0,-996.92 + 10.0,29.27 + 10.0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEADSHOT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
	    local ped = PlayerPedId()
		
        Citizen.Wait(5)
        SetPedSuffersCriticalHits(PlayerPedId(-1), true)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- IPLOADER
-----------------------------------------------------------------------------------------------------------------------------------------
local ipList = {
	{
		props = {
			"swap_clean_apt",
			"layer_debra_pic",
			"layer_whiskey",
			"swap_sofa_A"
		},
		coords = { -1150.7,-1520.7,10.6 }
	},{
		props = {
			"csr_beforeMission",
			"csr_inMission"
		},
		coords = { -47.1,-1115.3,26.5 }
	},{
		props = {
			"V_Michael_bed_tidy",
			"V_Michael_M_items",
			"V_Michael_D_items",
			"V_Michael_S_items",
			"V_Michael_L_Items"
		},
		coords = { -802.3,175.0,72.8 }
	},{
		props = {
			"v_gabz_mrpd_rm1",
			"v_gabz_mrpd_rm2",
			"v_gabz_mrpd_rm3",
			"v_gabz_mrpd_rm4",
			"v_gabz_mrpd_rm5",
			"v_gabz_mrpd_rm6",
			"v_gabz_mrpd_rm7",
			"v_gabz_mrpd_rm8",
			"v_gabz_mrpd_rm9",
			"v_gabz_mrpd_rm10",
			"v_gabz_mrpd_rm11",
			"v_gabz_mrpd_rm12",
			"v_gabz_mrpd_rm13",
			"v_gabz_mrpd_rm14",
			"v_gabz_mrpd_rm15",
			"v_gabz_mrpd_rm16",
			"v_gabz_mrpd_rm17",
			"v_gabz_mrpd_rm18",
			"v_gabz_mrpd_rm19",
			"v_gabz_mrpd_rm20",
			"v_gabz_mrpd_rm21",
			"v_gabz_mrpd_rm22",
			"v_gabz_mrpd_rm23",
			"v_gabz_mrpd_rm24",
			"v_gabz_mrpd_rm25",
			"v_gabz_mrpd_rm26",
			"v_gabz_mrpd_rm27",
			"v_gabz_mrpd_rm28",
			"v_gabz_mrpd_rm29",
			"v_gabz_mrpd_rm30",
			"v_gabz_mrpd_rm31"
		},
		coords = { 451.0129,-993.3741,29.1718 }
	},{
		coords = { -69.18748,72.87926,77.17023 } -- Benefactor
	},{
		coords = { -1685.06,-277.2893,60.31789 } -- Church
	},{
		coords = { 1129.451,-782.8797,59.21406 } -- Rockets
	},{
		coords = { 1152.216,-786.5847,59.33324 } -- Rockets
	},{
		coords = { 322.113,-1075.958,28.3984 } -- Pharmacy Santos
	},{
		coords = { 1174.968,2641.397,36.75007 } -- Harmony
	},{
		coords = { -1419.976,-447.8622,36.62567 } -- Hayes
	},{
		coords = { 338.8661,-582.8466,29.63187 } -- Pillbox
	},{
		coords = { 311.2546,-592.4204,42.32737 } -- Pillbox
	},{
		coords = { -189.059,-1164.32,24.1877 } -- Impound
	},{
		coords = { -37.1869,-1050.44,27.58956 } -- Bennys
	},{
		coords = { -675.3189,5836.144,17.70478 } -- Hunting
	},{
		coords = { -175.6765,6385.318,30.5772 } -- Pharmacy Paleto
	},{
		coords = { -255.972,6321.406,33.116 } -- Paleto Hospital
	},{
		coords = { 562.8,2745.72,41.87698 } -- Petshop
	},{
		coords = { 1783.901,2555.33,46.70935 } -- Prison
	},{
		coords = { 1597.629,2553.452,45.81208 } -- Prison
	},{
		coords = { 1758.084,2486.698,48.78679 } -- Prison
	},{
		coords = { 1767.281,2583.534,46.59865 } -- Prison
	},{
		coords = { 1832.21,2582.68,47.0143 } -- Prison
	},{
		coords = { 1959.688,3844.558,34.54492 } -- Sandy Bar
	},{
		coords = { 1959.688,3844.558,34.54492 } -- Sandy Bar
	},{
		coords = { 1830.509,3679.626,33.2749 } -- Sandypital
	},{
		coords = { -551.0138,-193.8526,45.22602 } -- Towhall
	},{
		coords = { -372.7785,268.4121,85.78004 } -- Train
	},{
		coords = { -582.9611,-922.9904,21.54857 } -- Benefactor
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADIPLOADER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for _k,_v in pairs(ipList) do
		local interiorCoords = GetInteriorAtCoords(_v["coords"][1],_v["coords"][2],_v["coords"][3])
		LoadInterior(interiorCoords)

		if _v["props"] ~= nil then
			for k,v in pairs(_v["props"]) do
				EnableInteriorProp(interiorCoords,v)
				Citizen.Wait(1)
			end
		end

		RefreshInterior(interiorCoords)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASERTIME
-----------------------------------------------------------------------------------------------------------------------------------------
local tasertime = false
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()

		if IsPedBeingStunned(ped) then
			timeDistance = 4
			SetPedToRagdoll(ped,7500,7500,0,0,0,0)
		end

		if IsPedBeingStunned(ped) and not tasertime then
			tasertime = true
			timeDistance = 4
			TriggerEvent("cancelando",true)
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE",1.0)
		elseif not IsPedBeingStunned(ped) and tasertime then
			tasertime = false
			Citizen.Wait(7500)
			StopGameplayCamShaking()
			TriggerEvent("cancelando",false)
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
local teleport = {
	{ 330.19,-601.21,43.29,343.65,-581.77,28.8 },
	{ 343.65,-581.77,28.8,330.19,-601.21,43.29 },

	{ 327.16,-603.53,43.29,338.97,-583.85,74.16 },
	{ 338.97,-583.85,74.16,327.16,-603.53,43.29 },

	{ -117.29,-604.52,36.29,-74.48,-820.8,243.39 },
	{ -74.48,-820.8,243.39,-117.29,-604.52,36.29 },

	{ -741.07,5593.13,41.66,446.19,5568.79,781.19 },
	{ 446.19,5568.79,781.19,-741.07,5593.13,41.66 },

	{ -740.78,5597.04,41.66,446.37,5575.02,781.19 },
	{ 446.37,5575.02,781.19,-740.78,5597.04,41.66 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local innerTable = {}

	for k,v in pairs(teleport) do
		table.insert(innerTable,{ v[1],v[2],v[3],2,"E","Porta de Acesso","Pressione para acessar" })
	end

	TriggerEvent("hoverfy:insertTable",innerTable)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for _,v in pairs(teleport) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 2 then
					timeDistance = 1

					if IsControlJustPressed(1,38) then
						SetEntityCoords(ped,v[4],v[5],v[6],1,0,0,0)
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NPCNOGUNDROP
-----------------------------------------------------------------------------------------------------------------------------------------
function SetWeaponDrops()
    local handle, ped = FindFirstPed()
    local finished = false

    repeat
        if not IsEntityDead(ped) then
            SetPedDropsWeaponsWhenDead(ped, false)
        end
        finished, ped = FindNextPed(handle)
    until not finished

    EndFindPed(handle)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        SetWeaponDrops()
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)

			local distance = #(coords - vector3(254.01,225.21,101.87))
			if distance <= 3.0 then
				timeDistance = 1

				if IsControlJustPressed(1,38) then
					local handle,object = FindFirstObject()
					local finished = false

					repeat
						local heading = GetEntityHeading(object)
						local coordsObj = GetEntityCoords(object)
						local distanceObjs = #(coordsObj - coords)

						if distanceObjs < 3.0 and GetEntityModel(object) == 961976194 then
							if heading > 150.0 then
								SetEntityHeading(object,0.0)
							else
								SetEntityHeading(object,160.0)
							end

							FreezeEntityPosition(object,true)
							finished = true
						end

						finished,object = FindNextObject(handle)
					until not finished

					EndFindObject(handle)
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	TriggerEvent("hoverfy:insertTable",{{ 254.01,225.21,101.87,1.5,"E","Porta do Cofre","Pressione para abrir/fechar" }})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
local fov_max = 80.0
local fov_min = 10.0
local speed_lr = 3.0
local speed_ud = 3.0
local zoomspeed = 2.0
local vehCamera = false
local fov = (fov_max + fov_min) * 0.5
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if IsPedInAnyHeli(ped) then
			timeDistance = 1

			local veh = GetVehiclePedIsUsing(ped)
			SetVehicleRadioEnabled(veh,false)

			if IsControlJustPressed(1,51) then
				TriggerEvent("hudActived",false)
				vehCamera = true
			end

			if IsControlJustPressed(1,154) then
				if GetPedInVehicleSeat(veh,1) == ped or GetPedInVehicleSeat(veh,2) == ped then
					TaskRappelFromHeli(ped,1)
				end
			end

			if vehCamera then
				SetTimecycleModifierStrength(0.3)
				SetTimecycleModifier("heliGunCam")

				local scaleform = RequestScaleformMovie("HELI_CAM")
				while not HasScaleformMovieLoaded(scaleform) do
					Citizen.Wait(1)
				end

				local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA",true)
				AttachCamToEntity(cam,veh,0.0,0.0,-1.5,true)
				SetCamRot(cam,0.0,0.0,GetEntityHeading(veh))
				SetCamFov(cam,fov)
				RenderScriptCams(true,false,0,1,0)
				PushScaleformMovieFunction(scaleform,"SET_CAM_LOGO")
				PushScaleformMovieFunctionParameterInt(0)
				PopScaleformMovieFunctionVoid()

				while vehCamera do
					if IsControlJustPressed(1,51) then
						TriggerEvent("hudActived",true)
						vehCamera = false
					end

					local zoomvalue = (1.0 / (fov_max - fov_min)) * (fov - fov_min)
					CheckInputRotation(cam,zoomvalue)
					HandleZoom(cam)
					HideHudAndRadarThisFrame()
					HideHudComponentThisFrame(19)
					PushScaleformMovieFunction(scaleform,"SET_ALT_FOV_HEADING")
					PushScaleformMovieFunctionParameterFloat(GetEntityCoords(veh).z)
					PushScaleformMovieFunctionParameterFloat(zoomvalue)
					PushScaleformMovieFunctionParameterFloat(GetCamRot(cam,2).z)
					PopScaleformMovieFunctionVoid()
					DrawScaleformMovieFullscreen(scaleform,255,255,255,255)

					Citizen.Wait(1)
				end

				ClearTimecycleModifier()
				fov = (fov_max + fov_min) * 0.5
				RenderScriptCams(false,false,0,1,0)
				SetScaleformMovieAsNoLongerNeeded(scaleform)
				DestroyCam(cam,false)
				SetNightvision(false)
				SetSeethrough(false)
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINPUTROTATION
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckInputRotation(cam,zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0,220)
	local rightAxisY = GetDisabledControlNormal(0,221)
	local rotation = GetCamRot(cam,2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX * -1.0 * (speed_ud) * (zoomvalue + 0.1)
		new_x = math.max(math.min(20.0,rotation.x + rightAxisY * -1.0 * (3.0) * (zoomvalue + 0.1)),-89.5)
		SetCamRot(cam,new_x,0.0,new_z,2)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDLEZOOM
-----------------------------------------------------------------------------------------------------------------------------------------
function HandleZoom(cam)
	if IsControlJustPressed(1,241) then
		fov = math.max(fov - zoomspeed,fov_min)
	end

	if IsControlJustPressed(1,242) then
		fov = math.min(fov + zoomspeed,fov_max)
	end

	local current_fov = GetCamFov(cam)
	if math.abs(fov - current_fov) < 0.1 then
		fov = current_fov
	end

	SetCamFov(cam,current_fov + (fov - current_fov) * 0.05)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUNNYHOP
-----------------------------------------------------------------------------------------------------------------------------------------
local bunnyHope = GetGameTimer()
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			if GetGameTimer() <= bunnyHope then
				timeDistance = 1
				DisableControlAction(1,22,true)
			else
				if IsPedJumping(ped) then
					bunnyHope = GetGameTimer() + 5000
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RICHPRESENCE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
		SetDiscordAppId(848976568952029184)
		SetDiscordRichPresenceAsset("gringapresence")
		SetDiscordRichPresenceAssetSmall("gringa")
--		SetRichPresence(user_id.." - Gringa Roleplay")
		SetDiscordRichPresenceAssetText("Gringa Roleplay")
		SetDiscordRichPresenceAssetSmallText("Gringa Roleplay")
        Citizen.Wait(60000)
    end
end)