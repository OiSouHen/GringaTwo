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
myClothes = {}
local canStartTread = 0

function f(n)
    n = n + 0.00000
    return n
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSkin", function(data)
	myClothes.skinColor = tonumber(data.skinColor)
	myClothes.eyesColor = tonumber(data.eyesColor)
    myClothes.complexionModel = tonumber(data.complexionModel)
    myClothes.blemishesModel = tonumber(data.blemishesModel)
    myClothes.frecklesModel = tonumber(data.frecklesModel)
    myClothes.ageingModel = tonumber(data.ageingModel)
    myClothes.hairModel = tonumber(data.hairModel)
    myClothes.firstHairColor = tonumber(data.firstHairColor)
    myClothes.secondHairColor = tonumber(data.secondHairColor)
    myClothes.makeupModel = tonumber(data.makeupModel)
    myClothes.lipstickModel = tonumber(data.lipstickModel)
    myClothes.lipstickColor = tonumber(data.lipstickColor)
    myClothes.eyebrowsModel = tonumber(data.eyebrowsModel)
    myClothes.eyebrowsColor = tonumber(data.eyebrowsColor)
    myClothes.beardModel = tonumber(data.beardModel)
    myClothes.beardColor = tonumber(data.beardColor)    
    myClothes.blushModel = tonumber(data.blushModel)
    myClothes.blushColor = tonumber(data.blushColor)

    if data.value then
        SetNuiFocus(false)
        displayBarbershop(false)
        vSERVER.updateSkin(myClothes)
        SendNUIMessage({ openBarbershop = false })
    end

    updateHead()
    updateFace()
    updateGenetics()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATELEFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotate", function(data, cb)
    local ped = PlayerPedId()
    local heading = GetEntityHeading(ped)
    if data == "left" then
        SetEntityHeading(ped, heading + 10)
    elseif data == "right" then
        SetEntityHeading(ped, heading - 10)
    end
end)

function updateGenetics()
    local data = myClothes
    local ped = PlayerPedId()    
    SetPedHeadBlendData(PlayerPedId(), tonumber(data.fathersID), tonumber(data.mothersID), 0, tonumber(data.skinColor), 0, 0, f(data.shapeMix), 0, 0, false)
    SetPedEyeColor(ped, data.eyesColor)
end

function updateFace()
    local ped = PlayerPedId()
    local data = myClothes
    -- Olhos
    -- Sobrancelha
    SetPedFaceFeature(ped, 6, tonumber(data.eyebrowsHeight))
    SetPedFaceFeature(ped, 7, tonumber(data.eyebrowsWidth))
    -- -- Nariz
    SetPedFaceFeature(ped, 0, tonumber(data.noseWidth))
    SetPedFaceFeature(ped, 1, tonumber(data.noseHeight))
    SetPedFaceFeature(ped, 2, tonumber(data.noseLength))
    SetPedFaceFeature(ped, 3, tonumber(data.noseBridge))
    SetPedFaceFeature(ped, 4, tonumber(data.noseTip))
    -- SetPedFaceFeature(ped, 5, data.noseShift)
    -- Bochechas
    SetPedFaceFeature(ped, 8, tonumber(data.cheekboneHeight))
    SetPedFaceFeature(ped, 9, tonumber(data.cheekboneWidth))
    SetPedFaceFeature(ped, 10, tonumber(data.cheeksWidth))
    -- -- Boca/Mandibula
    SetPedFaceFeature(ped, 12, tonumber(data.lips))
    SetPedFaceFeature(ped, 13, tonumber(data.jawWidth))
    SetPedFaceFeature(ped, 14, tonumber(data.jawHeight))
    -- -- Queixo
    SetPedFaceFeature(ped, 15, tonumber(data.chinLength))
    SetPedFaceFeature(ped, 16, tonumber(data.chinPosition))
    SetPedFaceFeature(ped, 17, tonumber(data.chinWidth))
    SetPedFaceFeature(ped, 18, tonumber(data.chinShape))
    -- -- Pescoço
    SetPedFaceFeature(ped, 19, tonumber(data.neckWidth))

end

function updateHead()
    local ped = PlayerPedId()
    local data = myClothes
    -- sobrancelhas
    SetPedHeadOverlay(ped, 2, data.eyebrowsModel, 0.99)
    SetPedHeadOverlayColor(ped, 2, 1, data.eyebrowsColor, data.eyebrowsColor)
    -- Cabelo
    SetPedComponentVariation(ped, 2, tonumber(data.hairModel), 0, 0)
    SetPedHairColor(ped, tonumber(data.firstHairColor), tonumber(data.secondHairColor))
    -- -- Barba
    SetPedHeadOverlay(ped, 1, tonumber(data.beardModel), 0.99)
    SetPedHeadOverlayColor(ped, 1, 1, tonumber(data.beardColor), tonumber(data.beardColor))
    -- -- Pelo Corporal
    SetPedHeadOverlay(ped, 10, tonumber(data.chestModel), 0.99)
    SetPedHeadOverlayColor(ped, 10, 1, tonumber(data.chestColor), tonumber(data.chestColor))
    -- -- Maquiagem
    SetPedHeadOverlay(ped, 4, tonumber(data.makeupModel), 0.99)
    SetPedHeadOverlayColor(ped, 4, 0, 0, 0)
    -- -- Blush
    SetPedHeadOverlay(ped, 5, tonumber(data.blushModel), 0.99)
    SetPedHeadOverlayColor(ped, 5, 2, tonumber(data.blushColor), tonumber(data.blushColor))
    -- -- Battom
    SetPedHeadOverlay(ped, 8, tonumber(data.lipstickModel), 0.99)
    SetPedHeadOverlayColor(ped, 8, 2, tonumber(data.lipstickColor), tonumber(data.lipstickColor))

    -- Manchas
    SetPedHeadOverlay(ped, 0, tonumber(data.blemishesModel), 0.99)
    SetPedHeadOverlayColor(ped, 0, 0, 0, 0)
    -- Envelhecimento
    SetPedHeadOverlay(ped, 3, tonumber(data.ageingModel), 0.99)
    SetPedHeadOverlayColor(ped, 3, 0, 0, 0)
    -- Aspecto
    SetPedHeadOverlay(ped, 6, tonumber(data.complexionModel), 0.99)
    SetPedHeadOverlayColor(ped, 6, 0, 0, 0)
    -- Pele
    SetPedHeadOverlay(ped, 7, tonumber(data.sundamageModel), 0.99)
    SetPedHeadOverlayColor(ped, 7, 0, 0, 0)
    -- Sardas
    SetPedHeadOverlay(ped, 9, tonumber(data.frecklesModel), 0.99)
    SetPedHeadOverlayColor(ped, 9, 0, 0, 0)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCUSTOMIZATION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("barbershop:setCustomization")
AddEventHandler("barbershop:setCustomization", function(dbCharacter)
    myClothes = dbCharacter	
    canStartTread = 20
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if canStartTread > 0 then
			while not IsPedModel(PlayerPedId(),"mp_m_freemode_01") and not IsPedModel(PlayerPedId(),"mp_f_freemode_01") do
				Citizen.Wait(10)
			end
            updateHead()
            updateFace()
            updateGenetics()
            canStartTread = canStartTread - 1
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPLAYBARBERSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function displayBarbershop(enable)
    local ped = PlayerPedId()

    if enable then
        SetEntityHeading(PlayerPedId(),332.21)
        SetNuiFocus(true,true)
        SendNUIMessage({ openBarbershop = true, myclothes = myClothes })

        FreezeEntityPosition(ped,true)

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
	    FreezeEntityPosition(ped,false)
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
--	{ 1143.76,-1551.53,35.39 }, -- Hospital
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
					    SetEntityHeading(PlayerPedId(),332.21)
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