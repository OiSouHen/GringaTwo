-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP UTILS
-----------------------------------------------------------------------------------------------------------------------------------------	
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPNames = {}
Tunnel.bindInterface("wall",vRPNames)
Proxy.addInterface("wall",vRPNames)
KSRPserver = Tunnel.getInterface("wall")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARS
-----------------------------------------------------------------------------------------------------------------------------------------
local cDistance = 500
local showIds = false
local players = {}
local admin = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- CORE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
	    for _, id in ipairs(GetActivePlayers()) do
	    	if id == -1 or id == nil then return end
			local pid, userIdentity = KSRPserver.getId(GetPlayerServerId(id))
			if pid == -1 then
				return
			end
			if players[id] ~= pid or not players[id] then
				players[id] = pid
			end
		end
		Citizen.Wait(1500)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("wall",function()
	admin = KSRPserver.isAdmin()
	if not admin then
		return
	end

	if admin then
		showIds = not showIds
	end

	if showIds then
		
		KSRPserver.reportLog("ON")
		TriggerEvent('chatMessage',"PLAYERS IDS:",{0,213,189},"ON")
	else
		KSRPserver.reportLog("OFF")
		TriggerEvent('chatMessage',"PLAYERS IDS:",{0,213,189},"OFF")
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- INFOS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
    	local kswait = 1000
		  if showIds then
			pedAdm = PlayerPedId()
			kswait = 7
			if not IsEntityVisible(pedAdm) then
	        	for k, id in ipairs(GetActivePlayers()) do
	        		if  ((NetworkIsPlayerActive( id )) and GetPlayerPed(id) ~= PlayerPedId()) then
				        x1, y1, z1 = table.unpack( GetEntityCoords( PlayerPedId(), true ) )
				        x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
				        distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
						if admin then
					    	if ((distance < cDistance)) then
					    		if GetPlayerPed(id) ~= -1 and players[id] ~= nil then
									local playerName = GetPlayerName(id)
									if playerName == nil or playerName == "" or playerName == -1 then
										playerName = "Sem Steam"
									end
									
					    			local playerHealth = GetEntityHealth(GetPlayerPed(id))
									if playerHealth == 1 then
										playerHealth = 0
									end

									local playerArmour = GetPedArmour(GetPlayerPed(id))
									if playerArmour == 1 then
										playerArmour = 0
									end

					    			local playerHealthPercent = playerHealth / 2
					    			local playerArmourPercent = playerArmour
					    			playerHealthPercent = math.floor(playerHealthPercent)
					    			playerArmourPercent = math.floor(playerArmourPercent)
					    			DrawText3D(x2, y2, z2+1, "~p~ID: ~w~" .. players[id] .. "\n~g~VIDA:~w~ "..playerHealth.. " (" .. playerHealthPercent .. "%)\n~r~COLETE:~w~ "..playerArmour.. " (" .. playerArmourPercent .. "%)\n~b~STEAM:~w~ " .. playerName, 255, 255, 255)
					    		end
					    	end
					    end
					end
				end
			end
		end
		Citizen.Wait(kswait)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- 3D TEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z, text, r,g,b)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextFont(0)
        SetTextProportional(1)
        SetTextScale(0.0, 0.25)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end