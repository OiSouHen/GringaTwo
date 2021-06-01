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
Tunnel.bindInterface("bdonate",cnVRP)
vSERVER = Tunnel.getInterface("bdonate")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local typeCars = {}
local typeBikes = {}
local localVehicles = {}
local vehicles = {}
local vehIds = {}
local open = vector3(-73.1,-2004.25,18.28)
local zone = vector3(-73.1,-2004.25,18.28)

local coords = {
	[1] = { cds = vector3(-81.93,-2009.63,18.09), h = 172.65 },
	[2] = { cds = vector3(-85.82,-2009.14,18.1), h = 172.65 },
	[3] = { cds = vector3(-89.56,-2008.61,18.1), h = 172.65 },
	[4] = { cds = vector3(-93.5,-2008.19,18.1), h = 172.65 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("bdonate:syncVehicles")
AddEventHandler("bdonate:syncVehicles",function(vehs)
	if #vehIds > 0 then
		for k,v in pairs(vehs) do
			if v.model ~= vehicles[k].model then
				swapVehicle(v.model,k)
			end
		end
	else
		vehicles = vehs
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCLIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("bdonate:syncList")
AddEventHandler("bdonate:syncList",function(cars,bikes)
	typeCars = cars
	typeBikes = bikes
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATEBENEFACTORPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
local locateBenefactorPremium = {
	{ -73.1,-2004.25,18.28 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local innerTable = {}
	for k,v in pairs(locateBenefactorPremium) do
		table.insert(innerTable,{ v[1],v[2],v[3],2,"E","Benefactor Premium","Pressione para abrir" })
	end

	TriggerEvent("hoverfy:insertTable",innerTable)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - open)
			if distance <= 1 then
				timeDistance = 4
				if IsControlJustPressed(1,38) then
					SetNuiFocus(true,true)
					SendNUIMessage({ action = "show" })
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inside = false
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local distance = #(coords - zone)
		if distance <= 32.1 then
			if not inside then
				inside = true
				spawnVehicles()
			end
		else
			if inside then
				inside = false
				despawnVehicles()
			end
		end
		

		Citizen.Wait(500)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function spawnVehicles()
	ClearAreaOfVehicles(-79.12,-1083.11,26.82,14.9)
	for k,v in pairs(vehicles) do
		local hash = GetHashKey(v.model)

		RequestModel(hash)
		while not HasModelLoaded(hash) do
			RequestModel(hash)
			Citizen.Wait(10)
		end

		local id = CreateVehicle(hash,coords[k].cds.x,coords[k].cds.y,coords[k].cds.z,coords[k].h,false,false)
		SetVehicleOnGroundProperly(id)
		SetVehicleDoorsLocked(id,2)
		SetVehicleDirtLevel(id,0.0)
		FreezeEntityPosition(id,true)
		SetEntityAsMissionEntity(id,true,true)
		SetVehicleNumberPlateText(id,"PDMSALE"..k)
		vehIds[k] = id
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SWAPVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function swapVehicle(veh,slot)
	if slot > 0 and slot < 5 then
		if vehIds[slot] then
			if DoesEntityExist(vehIds[slot]) then
				DeleteEntity(vehIds[slot])
			end
		end

		local hash = GetHashKey(veh)

		RequestModel(hash)
		while not HasModelLoaded(hash) do
			RequestModel(hash)
			Citizen.Wait(10)
		end

		local id = CreateVehicle(hash,coords[slot].cds.x,coords[slot].cds.y,coords[slot].cds.z,coords[slot].h,false,false)
		SetVehicleDoorsLocked(id,2)
		SetVehicleDirtLevel(id,0.0)
		FreezeEntityPosition(id,true)
		SetEntityAsMissionEntity(id,true,true)
		SetVehicleNumberPlateText(id,"PDMSALE"..slot)
		vehIds[slot] = id
		vehicles[slot].model = veh
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESPAWNVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function despawnVehicles()
	for k,v in pairs(vehIds) do
		if DoesEntityExist(v) then
			DeleteEntity(v)
		end
	end
	vehIds = {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSEAPP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("CloseApp",function(data,cb)
	SetNuiFocus(false,false)
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDLESPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("HandleSpawn",function(data,cb)
	TriggerServerEvent("bdonate:setVehicles",data.vehicle,data.slot)
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCARS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("GetCars",function(data,cb)
	cb(typeCars)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETBIKES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("GetBikes",function(data,cb)
	cb(typeBikes)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETOWNED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("GetOwned",function(data,cb)
	local vehs = vSERVER.getOwned()
	cb(vehs)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSELL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("RequestSell",function(data,cb)
	vSERVER.requestSell(data.name)
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("RequestBuy",function(data,cb)
	vSERVER.requestBuy(data.name,data.form)
	cb("ok")
end)