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
	["armadillo"] = { 1858.02,3744.29,33.09 },
	["duluoz"] = { -317.45,6273.54,31.5 },
	["eclipse"] = { -774.14,307.75,85.7 },
	["grapeseed"] = { 2562.38,4698.68,33.89 },
	["greatocean"] = { -2194.01,4254.0,48.02 },
	["hawick"] = { -36.02,-98.86,57.4 },
	["integrity"] = { 262.61,-636.64,40.79 },
	["cenora"] = { 1198.98,1849.74,78.88 }
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
	else
		SetEntityVisible(ped,true,false)
		FreezeEntityPosition(ped,false)
		SetEntityInvincible(ped,false)

		RenderScriptCams(false,false,0,true,true)
		SetCamActive(cam,false)
		DestroyCam(cam,true)
		cam = nil
	end

	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("spawn",function(data,cb)
	local ped = PlayerPedId()
	if data.choice == "spawn" then
		SetNuiFocus(false)
		SendNUIMessage({ display = false })

		DoScreenFadeOut(1000)
		Citizen.Wait(1000)

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
		local speed = 0.7

		DoScreenFadeOut(500)
		Citizen.Wait(500)

		SetCamRot(cam,270.0)
		SetCamActive(cam,true)
		new = true
		weight = 270.0

		DoScreenFadeIn(500)

		SetEntityCoords(ped,config[data.choice][1],config[data.choice][2],config[data.choice][3]+0.5)
		local x,y,z = table.unpack(GetEntityCoords(ped))

		SetCamCoord(cam,x,y,z+200.0)
		local i = z + 200.0

		while i > config[data.choice][3] + 1.5 do
			Citizen.Wait(5)
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
		end
	end

	cb("ok")
end)