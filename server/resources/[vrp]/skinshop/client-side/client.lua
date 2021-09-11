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
Tunnel.bindInterface("skinshop",cRP)
vSERVER = Tunnel.getInterface("skinshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local cam = -1
local skinData = {}
local heading = 332.219879
local previousSkinData = {}
local customCamLocation = nil
local creatingCharacter = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINDATA
-----------------------------------------------------------------------------------------------------------------------------------------
local skinData = {
	["pants"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
	["arms"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
	["t-shirt"] = { item = 1, texture = 0, defaultItem = 1, defaultTexture = 0 },
	["torso2"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
	["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
	["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
	["shoes"] = { item = 0, texture = 0, defaultItem = 1, defaultTexture = 0 },
	["mask"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
	["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
	["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
	["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
	["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
	["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
	["accessory"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
	["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINDATA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:skinData")
AddEventHandler("skinshop:skinData",function(status)
	if status ~= "clean" then
		skinData = status
		resetClothing(skinData)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:apply")
AddEventHandler("skinshop:apply",function(status)
	if status["pants"] ~= nil then
		skinData = status
	end

	resetClothing(skinData)
	vSERVER.updateClothes(json.encode(skinData))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("updateRoupas")
AddEventHandler("updateRoupas",function(custom)
	skinData = custom
	resetClothing(custom)
	vSERVER.updateClothes(json.encode(custom),true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATETATTOO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:updateTattoo")
AddEventHandler("skinshop:updateTattoo",function()
	resetClothing(skinData)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATESHOPS
-----------------------------------------------------------------------------------------------------------------------------------------
local locateShops = {
	{ 75.40,-1392.92,29.37 },
	{ -709.40,-153.66,37.41 },
	{ -163.20,-302.03,39.73 },
	{ 425.58,-806.23,29.49 },
	{ -822.34,-1073.49,11.32 },
	{ -1193.81,-768.49,17.31 },
	{ -1450.85,-238.15,49.81 },
	{ 4.90,6512.47,31.87 },
	{ 1693.95,4822.67,42.06 },
	{ 126.05,-223.10,54.55 },
	{ 614.26,2761.91,42.08 },
	{ 1196.74,2710.21,38.22 },
	{ -3170.18,1044.54,20.86 },
	{ -1101.46,2710.57,19.10 },
	{ 461.85,-999.75,30.68 },
	{ 461.87,-995.88,30.68 },
	{ 301.9,-599.55,43.29 },
	{ 298.54,-598.2,43.29 },
	{ 1834.73,2571.71,46.02 },
	{ 1825.88,3675.0,34.27 },
	{ 105.66,-1303.04,28.8 },
	{ 1101.26,197.48,-49.44 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local innerTable = {}
	for k,v in pairs(locateShops) do
		table.insert(innerTable,{ v[1],v[2],v[3],2,"E","Loja de Roupas","Pressione para abrir" })
	end

	TriggerEvent("hoverfy:insertTable",innerTable)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) and not creatingCharacter then
			local coords = GetEntityCoords(ped)

			for k,v in pairs(locateShops) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 2 then
					timeDistance = 1

					if IsControlJustPressed(0,38) and vSERVER.checkShares() then
						customCamLocation = nil

						openMenu({
							{ menu = "character", label = "Roupas", selected = true },
							{ menu = "accessoires", label = "Utilidades", selected = false }
						})
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:OPENSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:openShop")
AddEventHandler("skinshop:openShop",function()
	if not creatingCharacter and vSERVER.checkShares() then
		customCamLocation = nil

		openMenu({
			{ menu = "character", label = "Roupas", selected = true },
			{ menu = "accessoires", label = "Utilidades", selected = false }
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETOUTFIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("resetOutfit",function()
	resetClothing(json.decode(previousSkinData))
	skinData = json.decode(previousSkinData)
	previousSkinData = {}
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATERIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotateRight",function()
	local ped = PlayerPedId()
	local heading = GetEntityHeading(ped)
	SetEntityHeading(ped,heading + 30)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATELEFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotateLeft",function()
	local ped = PlayerPedId()
	local heading = GetEntityHeading(ped)
	SetEntityHeading(ped,heading - 30)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOTHINGCATEGORYS
-----------------------------------------------------------------------------------------------------------------------------------------
local clothingCategorys = {
	["arms"] = { type = "variation", id = 3 },
	["t-shirt"] = { type = "variation", id = 8 },
	["torso2"] = { type = "variation", id = 11 },
	["pants"] = { type = "variation", id = 4 },
	["vest"] = { type = "variation", id = 9 },
	["shoes"] = { type = "variation", id = 6 },
	["bag"] = { type = "variation", id = 5 },
	["mask"] = { type = "mask", id = 1 },
	["hat"] = { type = "prop", id = 0 },
	["glass"] = { type = "prop", id = 1 },
	["ear"] = { type = "prop", id = 2 },
	["watch"] = { type = "prop", id = 6 },
	["bracelet"] = { type = "prop", id = 7 },
	["accessory"] = { type = "variation", id = 7 },
	["decals"] = { type = "variation", id = 10 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETMAXVALUES
-----------------------------------------------------------------------------------------------------------------------------------------
function GetMaxValues()
	maxModelValues = {
		["arms"] = { type = "character", item = 0, texture = 0 },
		["t-shirt"] = { type = "character", item = 0, texture = 0 },
		["torso2"] = { type = "character", item = 0, texture = 0 },
		["pants"] = { type = "character", item = 0, texture = 0 },
		["shoes"] = { type = "character", item = 0, texture = 0 },
		["vest"] = { type = "character", item = 0, texture = 0 },
		["accessory"] = { type = "character", item = 0, texture = 0 },
		["decals"] = { type = "character", item = 0, texture = 0 },
		["bag"] = { type = "character", item = 0, texture = 0 },
		["mask"] = { type = "accessoires", item = 0, texture = 0 },
		["hat"] = { type = "accessoires", item = 0, texture = 0 },
		["glass"] = { type = "accessoires", item = 0, texture = 0 },
		["ear"] = { type = "accessoires", item = 0, texture = 0 },
		["watch"] = { type = "accessoires", item = 0, texture = 0 },
		["bracelet"] = { type = "accessoires", item = 0, texture = 0 }
	}

	local ped = PlayerPedId()
	for k,v in pairs(clothingCategorys) do
		if v["type"] == "variation" then
			maxModelValues[k]["item"] = GetNumberOfPedDrawableVariations(ped,v["id"]) - 1
			maxModelValues[k]["texture"] = GetNumberOfPedTextureVariations(ped,v["id"],GetPedDrawableVariation(ped,v["id"])) - 1
			
			if maxModelValues[k]["texture"] <= 0 then
				maxModelValues[k]["texture"] = 0
			end
		end

		if v["type"] == "mask" then
			maxModelValues[k]["item"] = GetNumberOfPedDrawableVariations(ped,v["id"]) - 1
			maxModelValues[k]["texture"] = GetNumberOfPedTextureVariations(ped,v["id"],GetPedDrawableVariation(ped,v["id"])) - 1
			
			if maxModelValues[k]["texture"] <= 0 then
				maxModelValues[k]["texture"] = 0
			end
		end

		if v["type"] == "overlay" then
			maxModelValues[k].item = GetNumHeadOverlayValues(v.id)
			maxModelValues[k].texture = 45
		end

		if v["type"] == "prop" then
			maxModelValues[k]["item"] = GetNumberOfPedDrawableVariations(ped,v["id"]) - 1
			maxModelValues[k]["texture"] = GetNumberOfPedTextureVariations(ped,v["id"],GetPedDrawableVariation(ped,v["id"])) - 1
			
			if maxModelValues[k]["texture"] <= 0 then
				maxModelValues[k]["texture"] = 0
			end
		end
	end

	SendNUIMessage({ action = "updateMax", maxValues = maxModelValues })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENMENU
-----------------------------------------------------------------------------------------------------------------------------------------
function openMenu(allowedMenus)
	creatingCharacter = true
	previousSkinData = json.encode(skinData)

	GetMaxValues()

	SendNUIMessage({ action = "open", menus = allowedMenus, currentClothing = skinData })

	SetNuiFocus(true,true)
	SetCursorLocation(0.9,0.25)

	enableCam()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENABLECAM
-----------------------------------------------------------------------------------------------------------------------------------------
function enableCam()
	local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,2.0,0)
	RenderScriptCams(false,false,0,1,0)
	DestroyCam(cam,false)

	if not DoesCamExist(cam) then
		cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
		SetCamActive(cam,true)
		RenderScriptCams(true,false,0,true,true)
		SetCamCoord(cam,coords["x"],coords["y"],coords["z"] + 0.5)
		SetCamRot(cam,0.0,0.0,GetEntityHeading(PlayerPedId()) + 180)
	end

	if customCamLocation ~= nil then
		SetCamCoord(cam,customCamLocation["x"],customCamLocation["y"],customCamLocation["z"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATECAM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotateCam",function(data)
	local ped = PlayerPedId()
	local rotType = data["type"]
	local coords = GetOffsetFromEntityInWorldCoords(ped,0,2.0,0)

	if rotType == "left" then
		SetEntityHeading(ped,GetEntityHeading(ped) - 10)
		SetCamCoord(cam,coords["x"],coords["y"],coords["z"] + 0.5)
		SetCamRot(cam,0.0,0.0,GetEntityHeading(ped) + 180)
	else
		SetEntityHeading(ped,GetEntityHeading(ped) + 10)
		SetCamCoord(cam,coords["x"],coords["y"],coords["z"] + 0.5)
		SetCamRot(cam,0.0,0.0,GetEntityHeading(ped) + 180)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUPCAM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("setupCam",function(data)
	local value = data["value"]

	if value == 1 then
		local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,0.75,0)
		SetCamCoord(cam,coords["x"],coords["y"],coords["z"] + 0.6)
	elseif value == 2 then
		local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,1.0,0)
		SetCamCoord(cam,coords["x"],coords["y"],coords["z"] + 0.2)
	elseif value == 3 then
		local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,1.0,0)
		SetCamCoord(cam,coords["x"],coords["y"],coords["z"] - 0.5)
	else
		local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,2.0,0)
		SetCamCoord(cam,coords["x"],coords["y"],coords["z"] + 0.5)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSEMENU
-----------------------------------------------------------------------------------------------------------------------------------------
function closeMenu()
	SendNUIMessage({ action = "close" })
	RenderScriptCams(false,true,250,1,0)
	DestroyCam(cam,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISABLECAM
-----------------------------------------------------------------------------------------------------------------------------------------
function disableCam()
	RenderScriptCams(false,true,250,1,0)
	DestroyCam(cam,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETCLOTHING
-----------------------------------------------------------------------------------------------------------------------------------------
function resetClothing(data)
	local ped = PlayerPedId()

	SetPedComponentVariation(ped,4,data["pants"].item,data["pants"].texture,2)
	SetPedComponentVariation(ped,3,data["arms"].item,data["arms"].texture,2)
	SetPedComponentVariation(ped,8,data["t-shirt"].item,data["t-shirt"].texture,2)
	SetPedComponentVariation(ped,9,data["vest"].item,data["vest"].texture,2)
	SetPedComponentVariation(ped,11,data["torso2"].item,data["torso2"].texture,2)
	SetPedComponentVariation(ped,6,data["shoes"].item,data["shoes"].texture,2)
	SetPedComponentVariation(ped,1,data["mask"].item,data["mask"].texture,2)
	SetPedComponentVariation(ped,10,data["decals"].item,data["decals"].texture,2)
	SetPedComponentVariation(ped,7,data["accessory"].item,data["accessory"].texture,2)
	SetPedComponentVariation(ped,5,data["bag"].item,data["bag"].texture,2)

	if data["hat"].item ~= -1 and data["hat"].item ~= 0 then
		SetPedPropIndex(ped,0,data["hat"].item,data["hat"].texture,2)
	else
		ClearPedProp(ped,0)
	end

	if data["glass"].item ~= -1 and data["glass"].item ~= 0 then
		SetPedPropIndex(ped,1,data["glass"].item,data["glass"].texture,2)
	else
		ClearPedProp(ped,1)
	end

	if data["ear"].item ~= -1 and data["ear"].item ~= 0 then
		SetPedPropIndex(ped,2,data["ear"].item,data["ear"].texture,2)
	else
		ClearPedProp(ped,2)
	end

	if data["watch"].item ~= -1 and data["watch"].item ~= 0 then
		SetPedPropIndex(ped,6,data["watch"].item,data["watch"].texture,2)
	else
		ClearPedProp(ped,6)
	end

	if data["bracelet"].item ~= -1 and data["bracelet"].item ~= 0 then
		SetPedPropIndex(ped,7,data["bracelet"].item,data["bracelet"].texture,2)
	else
		ClearPedProp(ped,7)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function()
	RenderScriptCams(false,true,250,1,0)
	creatingCharacter = false
	SetNuiFocus(false,false)
	DestroyCam(cam,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSkin",function(data)
	ChangeVariation(data)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKINONINPUT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSkinOnInput",function(data)
	ChangeVariation(data)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHANGEVARIATION
-----------------------------------------------------------------------------------------------------------------------------------------
function ChangeVariation(data)
	local ped = PlayerPedId()
	local clothingCategory = data.clothingType
	local type = data.type
	local item = data.articleNumber

	if clothingCategory == "pants" then
		if type == "item" then
			SetPedComponentVariation(ped,4,item,0,2)
			skinData["pants"].item = item
		elseif type == "texture" then
			local curItem = GetPedDrawableVariation(ped,4)
			SetPedComponentVariation(ped,4,curItem,item,2)
			skinData["pants"].texture = item
		end
	elseif clothingCategory == "arms" then
		if type == "item" then
			SetPedComponentVariation(ped,3,item,0,2)
			skinData["arms"].item = item
		elseif type == "texture" then
			local curItem = GetPedDrawableVariation(ped,3)
			SetPedComponentVariation(ped,3,curItem,item,2)
			skinData["arms"].texture = item
		end
	elseif clothingCategory == "t-shirt" then
		if type == "item" then
			SetPedComponentVariation(ped,8,item,0,2)
			skinData["t-shirt"].item = item
		elseif type == "texture" then
			local curItem = GetPedDrawableVariation(ped,8)
			SetPedComponentVariation(ped,8,curItem,item,2)
			skinData["t-shirt"].texture = item
		end
	elseif clothingCategory == "vest" then
		if type == "item" then
			SetPedComponentVariation(ped,9,item,0,2)
			skinData["vest"].item = item
		elseif type == "texture" then
			SetPedComponentVariation(ped,9,skinData["vest"].item,item,2)
			skinData["vest"].texture = item
		end
	elseif clothingCategory == "bag" then
		if type == "item" then
			SetPedComponentVariation(ped,5,item,0,2)
			skinData["bag"].item = item
		elseif type == "texture" then
			SetPedComponentVariation(ped,5,skinData["bag"].item,item,2)
			skinData["bag"].texture = item
		end
	elseif clothingCategory == "decals" then
		if type == "item" then
			SetPedComponentVariation(ped,10,item,0,2)
			skinData["decals"].item = item
		elseif type == "texture" then
			SetPedComponentVariation(ped,10,skinData["decals"].item,item,2)
			skinData["decals"].texture = item
		end
	elseif clothingCategory == "accessory" then
		if type == "item" then
			SetPedComponentVariation(ped,7,item,0,2)
			skinData["accessory"].item = item
		elseif type == "texture" then
			SetPedComponentVariation(ped,7,skinData["accessory"].item,item,2)
			skinData["accessory"].texture = item
		end
	elseif clothingCategory == "torso2" then
		if type == "item" then
			SetPedComponentVariation(ped,11,item,0,2)
			skinData["torso2"].item = item
		elseif type == "texture" then
			local curItem = GetPedDrawableVariation(ped,11)
			SetPedComponentVariation(ped,11,curItem,item,2)
			skinData["torso2"].texture = item
		end
	elseif clothingCategory == "shoes" then
		if type == "item" then
			SetPedComponentVariation(ped,6,item,0,2)
			skinData["shoes"].item = item
		elseif type == "texture" then
			local curItem = GetPedDrawableVariation(ped,6)
			SetPedComponentVariation(ped,6,curItem,item,2)
			skinData["shoes"].texture = item
		end
	elseif clothingCategory == "mask" then
		if type == "item" then
			SetPedComponentVariation(ped,1,item,0,2)
			skinData["mask"].item = item
		elseif type == "texture" then
			local curItem = GetPedDrawableVariation(ped,1)
			SetPedComponentVariation(ped,1,curItem,item,2)
			skinData["mask"].texture = item
		end
	elseif clothingCategory == "hat" then
		if type == "item" then
			if item ~= -1 then
				SetPedPropIndex(ped,0,item,skinData["hat"].texture,2)
			else
				ClearPedProp(ped,0)
			end
			skinData["hat"].item = item
		elseif type == "texture" then
			SetPedPropIndex(ped,0,skinData["hat"].item,item,2)
			skinData["hat"].texture = item
		end
	elseif clothingCategory == "glass" then
		if type == "item" then
			if item ~= -1 then
				SetPedPropIndex(ped,1,item,skinData["glass"].texture,2)
				skinData["glass"].item = item
			else
				ClearPedProp(ped,1)
			end
		elseif type == "texture" then
			SetPedPropIndex(ped,1,skinData["glass"].item,item,2)
			skinData["glass"].texture = item
		end
	elseif clothingCategory == "ear" then
		if type == "item" then
			if item ~= -1 then
				SetPedPropIndex(ped,2,item,skinData["ear"].texture,2)
			else
				ClearPedProp(ped,2)
			end
			skinData["ear"].item = item
		elseif type == "texture" then
			SetPedPropIndex(ped,2,skinData["ear"].item,item,2)
			skinData["ear"].texture = item
		end
	elseif clothingCategory == "watch" then
		if type == "item" then
			if item ~= -1 then
				SetPedPropIndex(ped,6,item,skinData["watch"].texture,2)
			else
				ClearPedProp(ped,6)
			end
			skinData["watch"].item = item
		elseif type == "texture" then
			SetPedPropIndex(ped,6,skinData["watch"].item,item,2)
			skinData["watch"].texture = item
		end
	elseif clothingCategory == "bracelet" then
		if type == "item" then
			if item ~= -1 then
				SetPedPropIndex(ped,7,item,skinData["bracelet"].texture,2)
			else
				ClearPedProp(ped,7)
			end
			skinData["bracelet"].item = item
		elseif type == "texture" then
			SetPedPropIndex(ped,7,skinData["bracelet"].item,item,2)
			skinData["bracelet"].texture = item
		end
	end

	GetMaxValues()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVECLOTHING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("saveClothing",function(data)
	SaveSkin()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function SaveSkin()
	vSERVER.updateClothes(json.encode(skinData),true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMASK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setMask")
AddEventHandler("skinshop:setMask",function()
	if GetPedDrawableVariation(PlayerPedId(),1) == skinData["mask"]["item"] then
		vRP.playAnim(true,{"missfbi4","takeoff_mask"},true)
		Citizen.Wait(900)
		SetPedComponentVariation(PlayerPedId(),1,0,0,1)
	else
		vRP.playAnim(true,{"mp_masks@on_foot","put_on_mask"},true)
		Citizen.Wait(700)
		SetPedComponentVariation(PlayerPedId(),1,skinData["mask"]["item"],skinData["mask"]["texture"],1)
	end

	vRP.removeObjects("one")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETHAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setHat")
AddEventHandler("skinshop:setHat",function()
	vRP.playAnim(true,{"mp_masks@standard_car@ds@","put_on_mask"},true)

	Citizen.Wait(900)

	if GetPedPropIndex(PlayerPedId(),0) == skinData["hat"]["item"] then
		ClearPedProp(PlayerPedId(),0)
	else
		SetPedPropIndex(PlayerPedId(),0,skinData["hat"]["item"],skinData["hat"]["texture"],1)
	end

	vRP.removeObjects("one")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETGLASSES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setGlasses")
AddEventHandler("skinshop:setGlasses",function()
	vRP.playAnim(true,{"clothingspecs","take_off"},true)

	Citizen.Wait(1000)

	if GetPedPropIndex(PlayerPedId(),1) == skinData["glass"]["item"] then
		ClearPedProp(PlayerPedId(),1)
	else
		SetPedPropIndex(PlayerPedId(),1,skinData["glass"]["item"],skinData["glass"]["texture"],2)
	end

	vRP.removeObjects("one")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETARMS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setArms")
AddEventHandler("skinshop:setArms", function()
	if GetPedDrawableVariation(PlayerPedId(),3) == skinData["arms"]["item"] then
		SetPedComponentVariation(PlayerPedId(),3,15,0,1)
	else
		SetPedComponentVariation(PlayerPedId(),3,skinData["arms"]["item"],skinData["arms"]["texture"],1)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHAT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getHat()
	return skinData["hat"].item,skinData["hat"].texture
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETGLASSES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getGlasses()
	return skinData["glass"].item,skinData["glass"].texture
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETMASK
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getMask()
	return skinData["mask"].item,skinData["mask"].texture
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCUSTOMIZATION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getCustomization()
	return skinData
end