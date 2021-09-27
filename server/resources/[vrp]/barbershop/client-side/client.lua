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
Tunnel.bindInterface("barbershop",cRP)
vSERVER = Tunnel.getInterface("barbershop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local cam = -1
local myClothes = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSkin",function(data)
	myClothes = {}
	myClothes = { tonumber(data["skinColor"]),tonumber(data["eyesColor"]),tonumber(data["complexionModel"]),tonumber(data["blemishesModel"]),tonumber(data["frecklesModel"]),tonumber(data["ageingModel"]),tonumber(data["hairModel"]),tonumber(data["firstHairColor"]),tonumber(data["secondHairColor"]),tonumber(data["makeupModel"]),tonumber(data["lipstickModel"]),tonumber(data["lipstickColor"]),tonumber(data["eyebrowsModel"]),tonumber(data["eyebrowsColor"]),tonumber(data["beardModel"]),tonumber(data["beardColor"]),tonumber(data["blushModel"]),tonumber(data["blushColor"]) }

	if data["value"] then
		SetNuiFocus(false)
		displayBarbershop(false)
		vSERVER.updateSkin(myClothes)
		SendNUIMessage({ openBarbershop = false })
	end

	TriggerEvent("barbershop:apply",myClothes)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATELEFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotate",function(data,cb)
	local ped = PlayerPedId()
	local heading = GetEntityHeading(ped)
	if data == "left" then
		SetEntityHeading(ped,heading + 10)
	elseif data == "right" then
		SetEntityHeading(ped,heading - 10)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCUSTOMIZATION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("barbershop:apply")
AddEventHandler("barbershop:apply",function(status)
	myClothes = {}
	myClothes = { status[1] or 0, status[2] or 0, status[3] or 0, status[4] or 0, status[5] or 0, status[6] or 0, status[7] or 0, status[8] or 0, status[9] or 0, status[10] or 0, status[11] or 0, status[12] or 0, status[13] or 0, status[14] or 0, status[15] or 0, status[16] or 0, status[17] or 0, status[18] or 0 }

	local ped = PlayerPedId()

    local weightFace = myClothes[2] / 100 + 0.0
    local weightSkin = myClothes[4] / 100 + 0.0

	SetPedHeadOverlay(ped, 2, data.eyebrowsModel, 0.99)
    SetPedHeadOverlayColor(ped, 2, 1, data.eyebrowsColor, data.eyebrowsColor)
    SetPedComponentVariation(ped, 2, tonumber(data.hairModel), 0, 0)
    SetPedHairColor(ped, tonumber(data.firstHairColor), tonumber(data.secondHairColor))
    SetPedHeadOverlay(ped, 1, tonumber(data.beardModel), 0.99)
    SetPedHeadOverlayColor(ped, 1, 1, tonumber(data.beardColor), tonumber(data.beardColor))
    SetPedHeadOverlay(ped, 10, tonumber(data.chestModel), 0.99)
    SetPedHeadOverlayColor(ped, 10, 1, tonumber(data.chestColor), tonumber(data.chestColor))
    SetPedHeadOverlay(ped, 4, tonumber(data.makeupModel), 0.99)
    SetPedHeadOverlayColor(ped, 4, 0, 0, 0)
    SetPedHeadOverlay(ped, 5, tonumber(data.blushModel), 0.99)
    SetPedHeadOverlayColor(ped, 5, 2, tonumber(data.blushColor), tonumber(data.blushColor))
    SetPedHeadOverlay(ped, 8, tonumber(data.lipstickModel), 0.99)
    SetPedHeadOverlayColor(ped, 8, 2, tonumber(data.lipstickColor), tonumber(data.lipstickColor))
    SetPedHeadOverlay(ped, 0, tonumber(data.blemishesModel), 0.99)
    SetPedHeadOverlayColor(ped, 0, 0, 0, 0)
    SetPedHeadOverlay(ped, 3, tonumber(data.ageingModel), 0.99)
    SetPedHeadOverlayColor(ped, 3, 0, 0, 0)
    SetPedHeadOverlay(ped, 6, tonumber(data.complexionModel), 0.99)
    SetPedHeadOverlayColor(ped, 6, 0, 0, 0)
    SetPedHeadOverlay(ped, 7, tonumber(data.sundamageModel), 0.99)
    SetPedHeadOverlayColor(ped, 7, 0, 0, 0)
    SetPedHeadOverlay(ped, 9, tonumber(data.frecklesModel), 0.99)
    SetPedHeadOverlayColor(ped, 9, 0, 0, 0)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPLAYBARBERSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function displayBarbershop(enable)
	local ped = PlayerPedId()

	if enable then
		SetEntityHeading(PlayerPedId(),332.21)
		SetFollowPedCamViewMode(0)
		SetNuiFocus(true,true)
		SendNUIMessage({ openBarbershop = true, skinColor = myClothes[1],eyesColor = myClothes[2],complexionModel = myClothes[3],blemishesModel = myClothes[4],frecklesModel = myClothes[5],ageingModel = myClothes[6],hairModel = myClothes[6],firstHairColor = myClothes[8],secondHairColor = myClothes[9],makeupModel = myClothes[10],lipstickModel = myClothes[11],lipstickColor = myClothes[12],eyebrowsModel = myClothes[13],eyebrowsColor = myClothes[14],beardModel = myClothes[15],beardColor = myClothes[16],blushModel = myClothes[17],blushColor = myClothes[18] })

		if IsDisabledControlJustReleased(0,24) or IsDisabledControlJustReleased(0,142) then
			SendNUIMessage({ type = "click" })
		end

		SetPlayerInvincible(ped,true)

		if not DoesCamExist(cam) then
			cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
			SetCamCoord(cam,GetEntityCoords(ped))
			SetCamRot(cam,0.0,0.0,0.0)
			SetCamActive(cam,true)
			RenderScriptCams(true,false,0,true,true)
			SetCamCoord(cam,GetEntityCoords(ped))
		end

		local x,y,z = table.unpack(GetEntityCoords(ped))
		SetCamCoord(cam,x + 0.2,y + 0.5,z + 0.7)
		SetCamRot(cam,0.0,0.0,150.0)
	else
		SetPlayerInvincible(ped,false)
		RenderScriptCams(false,false,0,1,0)
		DestroyCam(cam,false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false)
	SendNUIMessage({ openBarbershop = false })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local locations = {
	{ -813.37,-183.85,37.57 },
	{ 138.13,-1706.46,29.3 },
	{ -1280.92,-1117.07,7.0 },
	{ 1930.54,3732.06,32.85 },
	{ 1214.2,-473.18,66.21 },
	{ -33.61,-154.52,57.08 },
	{ -276.65,6226.76,31.7 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local innerTable = {}
	for k,v in pairs(locations) do
		table.insert(innerTable,{ v[1],v[2],v[3],2.5,"E","Barbearia","Pressione para abrir" })
	end

	TriggerEvent("hoverfy:insertTable",innerTable)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)

			for k,v in pairs(locations) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 2.5 then
					timeDistance = 1

					if IsControlJustPressed(1,38) and vSERVER.checkShares() then
						displayBarbershop(true)
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("syncarea")
AddEventHandler("syncarea",function(x,y,z,distance)
	ClearAreaOfVehicles(x,y,z,distance + 0.0,false,false,false,false,false)
	ClearAreaOfEverything(x,y,z,distance + 0.0,false,false,false,false)
end)