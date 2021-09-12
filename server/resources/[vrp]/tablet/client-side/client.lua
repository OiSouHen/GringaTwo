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
Tunnel.bindInterface("tablet",cRP)
vSERVER = Tunnel.getInterface("tablet")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSENUI
-----------------------------------------------------------------------------------------------------------------------------------------
function closeNui()
	vRP.removeObjects("one")
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "closeSystem" })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tablet:openSystem")
AddEventHandler("tablet:openSystem",function()
	local ped = PlayerPedId()
	if not IsPauseMenuActive() and not exports["inventory"]:blockInvents() and not exports["player"]:blockCommands() and not exports["player"]:handCuff() and GetEntityHealth(ped) > 101 and not IsEntityInWater(ped) then
		SetNuiFocus(true,true)
		SetCursorLocation(0.5,0.5)
		SendNUIMessage({ action = "openSystem" })

		if not IsPedInAnyVehicle(PlayerPedId()) then
			vRP.removeObjects()
			vRP.createObjects("amb@code_human_in_bus_passenger_idles@female@tablet@base","base","prop_cs_tablet",50,28422)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeSystem",function(data)
	vRP.removeObjects()
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ action = "closeSystem" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCARROS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestCarros",function(data,cb)
	local veiculos = vSERVER.Carros()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTMOTOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMotos",function(data,cb)
	local veiculos = vSERVER.Motos()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTALUGUEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestAluguel",function(data,cb)
	local veiculos = vSERVER.Aluguel()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPOSSUIDOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestPossuidos",function(data,cb)
	local veiculos = vSERVER.Possuidos()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUYDEALERVARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local benbCoords = { -59.61,68.66,71.91 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUYDEALER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("buyDealer",function(data)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local distance = #(coords - vector3(benbCoords[1],benbCoords[2],benbCoords[3]))
	if distance <= 6 then
		if data.name ~= nil then
			vSERVER.buyDealer(data.name)
		end
	else
		TriggerEvent("Notify","amarelo","Vá até a <b>Benefactor</b> para efetuar a compra.",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELLDEALER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sellDealer",function(data)
	if data.name ~= nil then
		vSERVER.sellDealer(data.name)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSELL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("RequestSell",function(data,cb)
	vSERVER.requestSell(data.name)
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIVEVARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local vehDrive = nil
local benDrive = false
local benCoords = { -61.8,69.86,71.84 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestDrive",function(data,cb)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local distance = #(coords - vector3(benCoords[1],benCoords[2],benCoords[3]))
	
	if distance <= 5 then
		vRP.removeObjects()
		SetNuiFocus(false,false)
		SetCursorLocation(0.5,0.5)
		SendNUIMessage({ action = "closeSystem" })
		vRP.removeObjects()
		
		local driveIn,vehPlate = vSERVER.startDrive()
		if driveIn then
			TriggerEvent("races:insertList",true)
			TriggerEvent("player:blockCommands",true)
			TriggerEvent("Notify","azul","Você tem <b>60 segundos</b> para testar o veículo.<br>Caso saia do veículo o teste será encerrado.",15000)
			vehCreate(data["name"],vehPlate)
			SetPedIntoVehicle(ped,vehDrive,-1)
			benDrive = true
			
			local plate = GetVehicleNumberPlateText(vehDrive)
			local modelName = vRP.vehicleModel(GetEntityModel(vehDrive))
			TriggerServerEvent("setPlateEveryone",plate,modelName)
			TriggerEvent("Progress",60000,"Testando...")
			Citizen.Wait(60000)
			benDrive = false
			vSERVER.removeDrive()
			DeleteEntity(vehDrive)
			TriggerEvent("races:insertList",false)
			TriggerEvent("player:blockCommands",false)
			SetEntityCoords(ped,benCoords[1],benCoords[2],benCoords[3],1,0,0,0)
		end
	else
		TriggerEvent("Notify","amarelo","Vá até a <b>Benefactor</b> para efetuar o Teste.",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHCREATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vehCreate(vehName,vehPlate)
	local mHash = GetHashKey(vehName)

	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		Citizen.Wait(1)
	end

	if HasModelLoaded(mHash) then
		vehDrive = CreateVehicle(mHash,-72.49,84.59,71.6,64.87,false,false)
		SetVehicleDoorsLockedForAllPlayers(vehDrive,4)
        SetVehicleNumberPlateText(vehDrive,"GRINGARP") 
        SetVehicleDirtLevel(vehDrive,0.0)
        SetVehRadioStation(vehDrive,"OFF")
        SetVehicleFuelLevel(vehDrive,100.0)
        SetEntityInvincible(vehDrive,true)
        vSERVER.startDrive()
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADREQUESTDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if benDrive then
			timeDistance = 1
			DisableControlAction(1,69,false)

			local ped = PlayerPedId()
			if not IsPedInAnyVehicle(ped) then
				Citizen.Wait(1000)

				benDrive = false
				vSERVER.removeDrive()
				DeleteEntity(vehDrive)
				TriggerEvent("races:insertList",false)
				TriggerEvent("player:blockCommands",false)
				SetEntityCoords(ped,benCoords[1],benCoords[2],benCoords[3],1,0,0,0)
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABOUTINFORMATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("aboutInformations",function(data,cb)
	local inventario,peso,maxpeso,infos = vSERVER.aboutInformations()
	if inventario then
		cb({ inventario = inventario, drop = dropItems, peso = peso, maxpeso = maxpeso, infos = infos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEMEDIA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tablet:updateMedia")
AddEventHandler("tablet:updateMedia",function(media,data)
	SendNUIMessage({ action = "messageMedia", media = media, data = data })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("syncarea")
AddEventHandler("syncarea",function(x,y,z,distance)
	ClearAreaOfVehicles(x,y,z,distance + 0.0,false,false,false,false,false)
	ClearAreaOfEverything(x,y,z,distance + 0.0,false,false,false,false)
end)