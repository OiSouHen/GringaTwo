-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Shooting = false
local Running = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAFEZONES
-----------------------------------------------------------------------------------------------------------------------------------------
local SafeZones = {
    {x = 450.5966, y = -998.9636, z = 28.4284, radius = 80.0},-- Mission Row
    {x = 1853.6666, y = 3688.0222, z = 33.2777, radius = 40.0},-- Sandy Shores
    {x = -104.1444, y = 6469.3888, z = 30.6333, radius = 60.0}-- Paleto Bay
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DECOR
-----------------------------------------------------------------------------------------------------------------------------------------
DecorRegister("RegisterZombie",2)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RELATIONSHIPS
-----------------------------------------------------------------------------------------------------------------------------------------
AddRelationshipGroup("ZOMBIE")
SetRelationshipBetweenGroups(0,GetHashKey("ZOMBIE"),GetHashKey("PLAYER"))
SetRelationshipBetweenGroups(5,GetHashKey("PLAYER"),GetHashKey("ZOMBIE"))
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISPLAYERSHOOTINH
-----------------------------------------------------------------------------------------------------------------------------------------
function IsPlayerShooting()
    return Shooting
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISPLAYERRUNNING
-----------------------------------------------------------------------------------------------------------------------------------------
function IsPlayerRunning()
    return Running
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADONE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		
        SetPedDensityMultiplierThisFrame(0.5)
        SetScenarioPedDensityMultiplierThisFrame(0.5,0.5)
        SetRandomVehicleDensityMultiplierThisFrame(0.0)
        SetParkedVehicleDensityMultiplierThisFrame(0.2)
        SetVehicleDensityMultiplierThisFrame(0.0)
		
		SetArtificialLightsState(true)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTWO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if IsPedShooting(PlayerPedId()) then
	        Shooting = true
	        Citizen.Wait(5000)
	        Shooting = false
	    end

	    if IsPedSprinting(PlayerPedId()) or IsPedRunning(PlayerPedId()) then
	        if Running == false then
	            Running = true
	        end
	    else
	        if Running == true then
	            Running = false
	        end
	    end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSAFEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for _, zone in pairs(SafeZones) do
    	local Blip = AddBlipForRadius(zone.x,zone.y,zone.z,zone.radius)
		SetBlipHighDetail(Blip, true)
    	SetBlipColour(Blip,2)
    	SetBlipAlpha(Blip,128)
	end

    while true do
        Citizen.Wait(0)

    	for _, zone in pairs(SafeZones) do
	        local Zombie = -1
	        local Success = false
	        local Handler,Zombie = FindFirstPed()

	        repeat
	            if IsPedHuman(Zombie) and not IsPedAPlayer(Zombie) and not IsPedDeadOrDying(Zombie,true) then
	                local pedcoords = GetEntityCoords(Zombie)
	              	local zonecoords = vector3(zone.x, zone.y, zone.z)
	                local distance = #(zonecoords - pedcoords)

	                if distance <= zone.radius then
	                    DeleteEntity(Zombie)
	                end
	            end

	            Success,Zombie = FindNextPed(Handler)
	        until not (Success)

	        EndFindPed(Handler)
	    end
	        
		local Zombie = -1
	 	local Success = false
		local Handler,Zombie = FindFirstPed()

	    repeat
        	Citizen.Wait(10)

	        if IsPedHuman(Zombie) and not IsPedAPlayer(Zombie) and not IsPedDeadOrDying(Zombie, true) then
	            if not DecorExistOn(Zombie,"RegisterZombie") then
	                ClearPedTasks(Zombie)
	                ClearPedSecondaryTask(Zombie)
	                ClearPedTasksImmediately(Zombie)
	                TaskWanderStandard(Zombie,10.0,10)
	                SetPedRelationshipGroupHash(Zombie,"ZOMBIE")
	                ApplyPedDamagePack(Zombie,"BigHitByVehicle",0.0,1.0)
	                SetEntityHealth(Zombie,200)

	                RequestAnimSet("move_m@drunk@verydrunk")
					
	                while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
	                    Citizen.Wait(0)
	                end
					
	                SetPedMovementClipset(Zombie,"move_m@drunk@verydrunk",1.0)

	                SetPedConfigFlag(Zombie,100,false)
	                DecorSetBool(Zombie,"RegisterZombie",true)
	            end

	            SetPedRagdollBlockingFlags(Zombie,1)
			    SetPedCanRagdollFromPlayerImpact(Zombie,false)
			    SetPedSuffersCriticalHits(Zombie,true)
			    SetPedEnableWeaponBlocking(Zombie,true)
			    DisablePedPainAudio(Zombie,true)
			    StopPedSpeaking(Zombie,true)
			    SetPedDiesWhenInjured(Zombie,false)
			    StopPedRingtone(Zombie)
			    SetPedMute(Zombie)
			    SetPedIsDrunk(Zombie,true)
			    SetPedConfigFlag(Zombie,166,false)
			    SetPedConfigFlag(Zombie,170,false)
			    SetBlockingOfNonTemporaryEvents(Zombie,true)
			    SetPedCanEvasiveDive(Zombie,false)
			    RemoveAllPedWeapons(Zombie,true)

	            local PlayerCoords = GetEntityCoords(PlayerPedId())
	            local PedCoords = GetEntityCoords(Zombie)
	            local Distance = #(PedCoords - PlayerCoords)
	            local DistanceTarget

	           	if IsPlayerShooting() then
	                DistanceTarget = 120.0
	            elseif IsPlayerRunning() then
	                DistanceTarget = 50.0
	            else
	                DistanceTarget = 20.0
	            end

	            if Distance <= DistanceTarget and not IsPedInAnyVehicle(PlayerPedId(),false) then
	                TaskGoToEntity(Zombie,PlayerPedId(),-1,0.0,2.0,1073741824,0)
	            end

	            if Distance <= 1.3 then
	                if not IsPedRagdoll(Zombie) and not IsPedGettingUp(Zombie) then
	                	local health = GetEntityHealth(PlayerPedId())
	                    if health == 0 then
	                        ClearPedTasks(Zombie)
	                        TaskWanderStandard(Zombie,10.0,10)
	                    else
	                        RequestAnimSet("melee@unarmed@streamed_core_fps")
	                        while not HasAnimSetLoaded("melee@unarmed@streamed_core_fps") do
	                            Citizen.Wait(10)
	                        end

	                        TaskPlayAnim(Zombie,"melee@unarmed@streamed_core_fps","ground_attack_0_psycho",8.0,1.0,-1,48,0.001,false,false,false)

	                        ApplyDamageToPed(PlayerPedId(),5,false)
	                    end
	                end
	            end
	            
	            if not NetworkGetEntityIsNetworked(Zombie) then
	                DeleteEntity(Zombie)
	            end
	        end
	        
	        Success,Zombie = FindNextPed(Handler)
	   	until not (Success)

    	EndFindPed(Handler)
   	end
end)