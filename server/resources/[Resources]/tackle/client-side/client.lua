Citizen.CreateThread(function()
	while true do
		local timeDistance = 100
		local ped = PlayerPedId()
		if IsPedJumping(ped) then
			timeDistance = 4
			if IsControlJustReleased(1,51) then
				if not IsPedInAnyVehicle(ped) then
					local ForwardVector = GetEntityForwardVector(ped)
					local Tackled = {}

					SetPedToRagdollWithFall(ped,1000,1000,0,ForwardVector,1.0,0.0,0.0,0.0,0.0,0.0,0.0)

					while IsPedRagdoll(ped) do
						for Key,Value in ipairs(GetTouchedPlayers()) do
							if not Tackled[Value] then
								Tackled[Value] = true
								TriggerServerEvent("inventory:Cancel")
								TriggerServerEvent("tackle:Update",GetPlayerServerId(Value),ForwardVector.x,ForwardVector.y,ForwardVector.z,GetPlayerName(PlayerId()))
							end
						end
						Citizen.Wait(1)
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)

RegisterNetEvent("tackle:Player")
AddEventHandler("tackle:Player",function(ForwardVectorX,ForwardVectorY,ForwardVectorZ,Tackler)
	SetPedToRagdollWithFall(PlayerPedId(),3000,3000,0,ForwardVectorX,ForwardVectorY,ForwardVectorZ,10.0,0.0,0.0,0.0,0.0,0.0,0.0)
	TriggerServerEvent("inventory:Cancel")
end)

function GetPlayers()
	local players = {}
	for k,v in ipairs(GetActivePlayers()) do
		table.insert(players,v)
	end
	return players
end

function GetTouchedPlayers()
	local players = {}
	for k,v in ipairs(GetPlayers()) do
		if IsEntityTouchingEntity(PlayerPedId(),GetPlayerPed(v)) then
			table.insert(players,v)
		end
	end
	return players
end