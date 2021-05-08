-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLE
-----------------------------------------------------------------------------------------------------------------------------------------
local RCCar = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- EVENT SKATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('skate')
AddEventHandler('skate',function() 
	local ped = PlayerPedId()
	if DoesEntityExist(RCCar.Entity) then return end
	RCCar.Spawn()
	while DoesEntityExist(RCCar.Entity) and DoesEntityExist(RCCar.Driver) do
		Citizen.Wait(5)
		local distanceCheck = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(RCCar.Entity),true)
		RCCar.HandleKeys(distanceCheck)
		if distanceCheck <= 3 then
			if not NetworkHasControlOfEntity(RCCar.Driver) then
				NetworkRequestControlOfEntity(RCCar.Driver)
			elseif not NetworkHasControlOfEntity(RCCar.Entity) then
				NetworkRequestControlOfEntity(RCCar.Entity)
			end
		else
			TaskVehicleTempAction(RCCar.Driver,RCCar.Entity,6,2500)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION CONTROL SKATE
-----------------------------------------------------------------------------------------------------------------------------------------
Attached = false
function RCCar.HandleKeys(distanceCheck)
	local ped = PlayerPedId()
	if distanceCheck <= 1.5 then
		if IsControlJustPressed(0,38) and IsInputDisabled(0) and not Attached and GetEntityHealth(PlayerPedId()) >= 110 then
			RCCar.Attach("pick")
		end
		if IsControlJustReleased(0,244) and IsInputDisabled(0) and GetEntityHealth(PlayerPedId()) >= 110 then
			if Attached then
				RCCar.AttachPlayer(false)
			else
				RCCar.AttachPlayer(true)
			end
		end
		if not Attached and GetEntityHealth(PlayerPedId()) >= 110 then
			DrawText3Ds(GetEntityCoords(RCCar.Entity).x,GetEntityCoords(RCCar.Entity).y,GetEntityCoords(RCCar.Entity).z+0.5,"~r~E ~w~ PEGAR      ~g~M ~w~ SUBIR",500)
		end
	end
	if distanceCheck <= 1.5 and Attached then
		if IsControlPressed(0,32) and IsInputDisabled(0) and not IsControlPressed(0,33)  and IsInputDisabled(0) then
			TaskVehicleTempAction(RCCar.Driver,RCCar.Entity,9,1)
		end
		if IsControlJustReleased(0,22) and IsInputDisabled(0) and Attached then
			local vel = GetEntityVelocity(RCCar.Entity)
			if not IsEntityInAir(RCCar.Entity) then
				SetEntityVelocity(RCCar.Entity,vel.x,vel.y,vel.z+5.0)
				Citizen.Wait(20)
			end		
		end	
		if IsControlJustReleased(0,32) or IsControlJustReleased(0,33) and IsInputDisabled(0) then
			TaskVehicleTempAction(RCCar.Driver,RCCar.Entity,6,2500)
		end
		if IsControlPressed(0,33) and not IsControlPressed(0,32) and IsInputDisabled(0) then
			TaskVehicleTempAction(RCCar.Driver,RCCar.Entity,22,1)
		end
		if IsControlPressed(0,34) and IsControlPressed(0,33) and IsInputDisabled(0) then
			TaskVehicleTempAction(RCCar.Driver,RCCar.Entity,13,1)
		end
		if IsControlPressed(0,35) and IsControlPressed(0,33) and IsInputDisabled(0) then
			TaskVehicleTempAction(RCCar.Driver,RCCar.Entity,14,1)
		end
		if IsControlPressed(0,32) and IsControlPressed(0,33) and IsInputDisabled(0) then
			TaskVehicleTempAction(RCCar.Driver,RCCar.Entity,30,100)
		end
		if IsControlPressed(0,34) and IsControlPressed(0,32) and IsInputDisabled(0) then
			TaskVehicleTempAction(RCCar.Driver,RCCar.Entity,7,1)
		end
		if IsControlPressed(0,35) and IsControlPressed(0,32) and IsInputDisabled(0) then
			TaskVehicleTempAction(RCCar.Driver,RCCar.Entity,8,1)
		end
		if IsControlPressed(0,34) and not IsControlPressed(0,32) and not IsControlPressed(0,33) and IsInputDisabled(0) then
			TaskVehicleTempAction(RCCar.Driver,RCCar.Entity,4,1)
		end
		if IsControlPressed(0,35) and not IsControlPressed(0,32) and not IsControlPressed(0,33) and IsInputDisabled(0) then
			TaskVehicleTempAction(RCCar.Driver,RCCar.Entity,5,1)
		end	
	end
	Citizen.CreateThread(function()
    	Citizen.Wait(1)
    	if Attached then
	        local x = GetEntityRotation(RCCar.Entity).x
	        local y = GetEntityRotation(RCCar.Entity).y

	        if (-95.0 < x and x > 95.0) or (-95.0 < y and y > 95.0) or (HasEntityCollidedWithAnything(RCCar.Entity) and GetEntitySpeed(RCCar.Entity) > 15.6) then
	        	RCCar.AttachPlayer(false)
				SetPedToRagdoll(ped,4000,4000,0,true,true,false)
	        elseif IsPedArmed(ped,7) or IsEntityInWater(RCCar.Entity) or GetEntityHealth(ped) <= 101 then
	        	RCCar.AttachPlayer(false)
	        	DetachEntity(RCCar.Entity)
			end	
	    end           
    end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION SPAWN SKATE
-----------------------------------------------------------------------------------------------------------------------------------------
function RCCar.Spawn()
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped) then
		RCCar.LoadModels({ GetHashKey("rcbandito"),68070371,GetHashKey("p_defilied_ragdoll_01_s"),"pickup_object","move_strafe@stealth" })
		local spawnCoords,spawnHeading = GetEntityCoords(ped)+GetEntityForwardVector(ped)*2.0,GetEntityHeading(ped)
		RCCar.Entity = CreateVehicle(GetHashKey("rcbandito"),spawnCoords,spawnHeading,true)
		RCCar.Skate = CreateObject(GetHashKey("p_defilied_ragdoll_01_s"),0.0,0.0,0.0,true,true,true)
		while not DoesEntityExist(RCCar.Entity) do
			Citizen.Wait(5)
		end
		while not DoesEntityExist(RCCar.Skate) do
			Citizen.Wait(5)
		end
		--ForceVehicleEngineAudio(RCCar.Entity,"VOLTIC")
		SetVehicleHandlingFloat(RCCar.Entity,"CHandlingData","fSuspensionForce",1.5)
		SetVehicleEngineTorqueMultiplier(RCCar.Entity,0.1)
		SetEntityNoCollisionEntity(RCCar.Entity,ped,false)
		SetEntityVisible(RCCar.Entity,false)
		SetAllVehiclesSpawn(RCCar.Entity,true,true,true,true)
		AttachEntityToEntity(RCCar.Skate,RCCar.Entity,GetPedBoneIndex(ped,28422),0.0,0.0,-0.15,0.0,0.0,90.0,true,true,true,true,1,true)	
		SetEntityCollision(RCCar.Skate,true,true)
		RCCar.Driver = CreatePed(5,68070371,spawnCoords,spawnHeading,true)
		SetEntityInvincible(RCCar.Driver,true)
		SetEntityVisible(RCCar.Driver,false)
		FreezeEntityPosition(RCCar.Driver,true)
		SetPedAlertness(RCCar.Driver,0.0)
		TaskWarpPedIntoVehicle(RCCar.Driver,RCCar.Entity,-1)
		while not IsPedInVehicle(RCCar.Driver,RCCar.Entity) do
			Citizen.Wait(0)
		end
		RCCar.Attach("place")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION ATTACH SKATE
-----------------------------------------------------------------------------------------------------------------------------------------
function RCCar.Attach(param)
	local ped = PlayerPedId()
	if not DoesEntityExist(RCCar.Entity) or GetEntityHealth(ped) <= 101 then
		return
	end
	if param == "place" then
		AttachEntityToEntity(RCCar.Entity,ped,GetPedBoneIndex(ped,28422),-0.1,0.0,-0.2,70.0,0.0,270.0,1,1,0,0,2,1)
		TaskPlayAnim(ped,"pickup_object","pickup_low",8.0,-8.0,-1,0,0,false,false,false)
		Citizen.Wait(800)
		DetachEntity(RCCar.Entity,false,true)
		PlaceObjectOnGroundProperly(RCCar.Entity)
	elseif param == "pick" then
		Citizen.Wait(100)
		TaskPlayAnim(ped,"pickup_object","pickup_low",8.0,-8.0,-1,0,0,false,false,false)
		Citizen.Wait(600)
		AttachEntityToEntity(RCCar.Entity,ped,GetPedBoneIndex(ped,28422),-0.1,0.0,-0.2,70.0,0.0,270.0,1,1,0,0,2,1)
		Citizen.Wait(900)
		DetachEntity(RCCar.Entity)
		DeleteEntity(RCCar.Skate)
		DeleteVehicle(RCCar.Entity)
		DeleteEntity(RCCar.Driver)
		for modelIndex = 1,#RCCar.CachedModels do
			local model = RCCar.CachedModels[modelIndex]
			if IsModelValid(model) then
				SetModelAsNoLongerNeeded(model)
			else
				RemoveAnimDict(model)   
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION LOADMODEL SKATE
-----------------------------------------------------------------------------------------------------------------------------------------
function RCCar.LoadModels(models)
	for modelIndex = 1, #models do
		local model = models[modelIndex]
		if not RCCar.CachedModels then
			RCCar.CachedModels = {}
		end
		table.insert(RCCar.CachedModels,model)
		if IsModelValid(model) then
			while not HasModelLoaded(model) do
				RequestModel(model)	
				Citizen.Wait(10)
			end
		else
			while not HasAnimDictLoaded(model) do
				RequestAnimDict(model)
				Citizen.Wait(10)
			end    
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION ATTACH SKATE TO PLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function RCCar.AttachPlayer(toggle)
	local ped = PlayerPedId()
	if toggle then
		TaskPlayAnim(ped,"move_strafe@stealth","idle",8.0,8.0,-1,1,1.0,false,false,false)
		AttachEntityToEntity(ped,RCCar.Entity,20,0.0,0.0,0.98,0.0,0.0,-15.0,true,true,true,true,true,true)
		SetEntityCollision(ped,true,false)
		Attached = true		
		
		TriggerEvent("vrp_prison:showSkate",true)
		
		TriggerEvent("cancelando",true)
	elseif not toggle then
		DetachEntity(ped,false,false)
		Attached = false
		TriggerEvent("cancelando",false)

		TriggerEvent("vrp_prison:showSkate",false)
		StopAnimTask(ped,"move_strafe@stealth","idle",1.0)	
	end	
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3Ds(x,y,z,text,size)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/size
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
end