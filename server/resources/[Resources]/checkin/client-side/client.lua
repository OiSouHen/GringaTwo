-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("checkin",cnVRP)
vSERVER = Tunnel.getInterface("checkin")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
local checkIn = {
	{ 1146.81,-1542.73,35.39,"Fiacre" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEDSIN
-----------------------------------------------------------------------------------------------------------------------------------------
local bedsIn = {
	["Fiacre"] = {
		{ 1136.13,-1585.39,36.29 },
		{ 1140.24,-1585.38,36.29 },
		{ 1144.46,-1585.38,36.29 },
		{ 1148.84,-1585.37,36.29 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for _,v in pairs(checkIn) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 1.5 then
					timeDistance = 4
					DrawText3D(v[1],v[2],v[3]-1,"~g~E~w~ PARA ATENDIMENTO")
					if distance <= 1.5 and IsControlJustPressed(1,38) and vSERVER.checkServices() then
						if GetEntityHealth(ped) < 200 then
						
						local checkBusy = 0
						local checkSelected = v[4]

						for _,v in pairs(bedsIn[checkSelected]) do
							checkBusy = checkBusy + 1

							local checkPos = nearestPlayer(v[1],v[2],v[3])
							if checkPos == nil then
								if vSERVER.paymentCheckin() then
									SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)

									if GetEntityHealth(ped) <= 101 then
										TriggerEvent("survival:CheckIn")
									end

									DoScreenFadeOut(1000)
									Citizen.Wait(1000)

									SetEntityCoords(ped,v[1],v[2],v[3])

									Citizen.Wait(500)
									TriggerEvent("emotes","checkin")

									Citizen.Wait(5000)
									DoScreenFadeIn(1000)
								end

								break
							end
						end

						if checkBusy >= #bedsIn[checkSelected] then
							TriggerEvent("Notify","vermelho","Todas as macas estão ocupadas no momento.",5000)
							Wait(5000)
						end
					else
						TriggerEvent("Notify","amarelo","Você não precisa de um tratamento.",5000)
							Wait(5000)
						end
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEARESTPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function nearestPlayers(x2,y2,z2)
	local r = {}
	local players = vRP.getPlayers()
	for k,v in pairs(players) do
		local player = GetPlayerFromServerId(k)
		if player ~= PlayerId() and NetworkIsPlayerConnected(player) then
			local oped = GetPlayerPed(player)
			local coords = GetEntityCoords(oped)
			local distance = #(coords - vector3(x2,y2,z2))
			if distance <= 2 then
				r[GetPlayerServerId(player)] = distance
			end
		end
	end
	return r
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEARESTPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function nearestPlayer(x,y,z)
	local p = nil
	local players = nearestPlayers(x,y,z)
	local min = 2.0001
	for k,v in pairs(players) do
		if v < min then
			min = v
			p = k
		end
	end
	return p
end