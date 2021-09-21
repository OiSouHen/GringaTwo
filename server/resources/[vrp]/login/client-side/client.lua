-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local cam = nil
local new = false
local weight = 270.0
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIG
-----------------------------------------------------------------------------------------------------------------------------------------
local config = {
	["armadillo"] = { 1858.94,3741.78,33.09 },
	["duluoz"] = { -250.35,6209.71,31.49 },
	["eclipse"] = { -774.14,307.75,85.7 },
	["grapeseed"] = { 1694.37,4794.66,41.92 },
	["greatocean"] = { -2205.92,-370.48,13.29 },
	["hawick"] = { 308.33,-232.25,54.07 },
	["integrity"] = { 449.71,-659.27,28.48 },
	["cenora"] = { 328.0,2617.89,44.48 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("login:Spawn")
AddEventHandler("login:Spawn",function(status)
	local ped = PlayerPedId()
	if status then
		local x,y,z = table.unpack(GetEntityCoords(ped))

		cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",x,y,z + 200.0,270.00,0.0,0.0,80.0,0,0)
		SetCamActive(cam,true)

		RenderScriptCams(true,false,1,true,true)

		SetNuiFocus(true,true)
		SendNUIMessage({ display = true })
		
		DoScreenFadeIn(1000)
	else
		SetEntityVisible(ped,true,false)
		FreezeEntityPosition(ped,false)
		SetEntityInvincible(ped,false)
		RenderScriptCams(false,false,0,true,true)
		SetCamActive(cam,false)
		DestroyCam(cam,true)
		cam = nil
		
		Citizen.Wait(1000)

		DoScreenFadeIn(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("spawn",function(data,cb)
	local ped = PlayerPedId()
	if data.choice == "spawn" then
	    DoScreenFadeOut(0)
		
		SendNUIMessage({ display = false })
		TriggerEvent("hudActived",true)
		SetNuiFocus(false,false)
		
		TriggerEvent("player:playerInvisible",false)
		SetEntityVisible(ped,true,false)
		FreezeEntityPosition(ped,false)
		SetEntityInvincible(ped,false)
		RenderScriptCams(false,false,0,true,true)
		SetCamActive(cam,false)
		DestroyCam(cam,true)
		cam = nil

		Citizen.Wait(1000)
		
		DoScreenFadeIn(1000)
	else
    	new = false
		DoScreenFadeOut(0)

		Citizen.Wait(1000)

		SetCamRot(cam,270.0)
		SetCamActive(cam,true)
		new = true
		local speed = 0.7
		weight = 270.0

		DoScreenFadeIn(1000)

		SetEntityCoords(ped,config[data.choice][1],config[data.choice][2],config[data.choice][3]+0.5)
		local x,y,z = table.unpack(GetEntityCoords(ped))

		SetCamCoord(cam,x,y,z + 200.0)
		local i = z + 200.0

		while i > config[data.choice][3] + 1.5 do
			i = i - speed
			SetCamCoord(cam,x,y,i)

			if i <= config[data.choice][3] + 35.0 and weight < 360.0 then
				if speed - 0.0078 >= 0.05 then
					speed = speed - 0.0078
				end

				weight = weight + 0.75
				SetCamRot(cam,weight)
			end

			if not new then
				break
			end
			
			Citizen.Wait(0)
		end
	end
	
	cb("ok")
end)