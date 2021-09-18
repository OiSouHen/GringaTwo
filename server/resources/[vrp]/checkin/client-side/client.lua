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
Tunnel.bindInterface("checkin",cRP)
vSERVER = Tunnel.getInterface("checkin")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
local checkIn = {
	{ 1147.09,-1543.0,35.39,"Fiacre" },
	{ 1768.75,2570.56,45.73,"Bolingbroke" },
	{ -253.72,6330.93,32.43,"Paleto" }
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
	},
	["Bolingbroke"] = {
		{ 1771.98,2591.79,46.66,87.88 },
		{ 1771.98,2594.88,46.66,87.88 },
		{ 1771.98,2597.95,46.66,87.88 },
		{ 1761.87,2597.73,46.66,272.13 },
		{ 1761.87,2594.64,46.66,272.13 },
		{ 1761.87,2591.56,46.66,272.13 }
	},
	["Paleto"] = {
		{ -252.15,6323.11,33.35,133.23 },
		{ -246.98,6317.95,33.35,133.23 },
		{ -245.27,6316.22,33.35,133.23 },
		{ -251.03,6310.51,33.35,317.49 },
		{ -252.63,6312.12,33.35,317.49 },
		{ -254.39,6313.88,33.35,317.49 },
		{ -256.1,6315.58,33.35,317.49 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("checkin:initCheck")
AddEventHandler("checkin:initCheck",function()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	for _,v in pairs(checkIn) do
		local distance = #(coords - vector3(v[1],v[2],v[3]))
		if distance <= 2 then
			local checkBusy = 0
			local checkSelected = v[4]

			for _,v in pairs(bedsIn[checkSelected]) do
				checkBusy = checkBusy + 1

				local checkPos = nearestPlayer(v[1],v[2],v[3])
				if not checkPos then
					if vSERVER.paymentCheckin() then
						TriggerEvent("player:blockCommands",true)
						SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)

						if GetEntityHealth(ped) <= 101 then
							vRP.revivePlayer(102)
						end

						DoScreenFadeOut(0)
						Citizen.Wait(1000)

						SetEntityCoords(ped,v[1],v[2],v[3],1,0,0,0)

						Citizen.Wait(1000)
						TriggerEvent("emotes","checkinskyz")

						Citizen.Wait(1000)
						DoScreenFadeIn(1000)
					end

					break
				end
			end

			if checkBusy >= #bedsIn[checkSelected] then
				TriggerEvent("Notify","amarelo","Macas ocupadas, aguarde um momento.",5000)
			end
		end
	end
end)
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