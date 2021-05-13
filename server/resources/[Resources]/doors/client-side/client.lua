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
Tunnel.bindInterface("doors",cnVRP)
vSERVER = Tunnel.getInterface("doors")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local doors = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSUPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("doors:doorsUpdate")
AddEventHandler("doors:doorsUpdate",function(status)
	doors = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		if doors ~= nil then
			for k,v in pairs(doors) do
				local distance = #(coords - vector3(v.x,v.y,v.z))
				if distance <= v.distance then
					local door = GetClosestObjectOfType(v.x,v.y,v.z,1.0,v.hash,false,false,false)
					if doors ~= 0 then
						if v.lock then
							local _,h = GetStateOfClosestDoorOfType(v.hash,v.x,v.y,v.z,_,h)
							if h > -0.02 and h < 0.02 then
								FreezeEntityPosition(door,true)
							end
						else
							FreezeEntityPosition(door,false)
						end

						if distance <= v.press then
							timeDistance = 1
							if v.text then
								if v.lock then
									DrawText3D(v.x,v.y,v.z,"~r~Fechada~w~")
								else
									DrawText3D(v.x,v.y,v.z,"~g~Aberta~w~")
								end
							end

							if IsControlJustPressed(1,38) and vSERVER.doorsPermission(k) then
								v.lock = not v.lock
								vSERVER.doorsStatistics(k,v.lock)
								vRP._playAnim(true,{"anim@heists@keycard@","exit"},false)
								Citizen.Wait(350)
								vRP.stopAnim()
							end
						end
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DWTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.30,0.30)
	SetTextColour(176,180,193,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 450
	DrawRect(_x,_y+0,1+factor,0,0,0,0,150)
end