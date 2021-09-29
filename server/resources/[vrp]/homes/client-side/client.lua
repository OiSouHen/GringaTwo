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
Tunnel.bindInterface("homes",cRP)
vSERVER = Tunnel.getInterface("homes")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local houseOpen = ""
local homesList = {}
local homesTheft = {}
local homeObjects = {}
local houseNetwork = {}
local internHouses = {}
local theftOpen = false
local theftLocker = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("chestClose",function(data)
	vSERVER.chestClose()
	SendNUIMessage({ action = "hideMenu" })
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("takeItem",function(data)
	vSERVER.takeItem(tostring(houseOpen),data.item,data.slot,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("storeItem",function(data)
	vSERVER.storeItem(tostring(houseOpen),data.item,data.slot,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("populateSlot",function(data,cb)
	TriggerServerEvent("homes:populateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data,cb)
	TriggerServerEvent("homes:updateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sumSlot",function(data,cb)
	TriggerServerEvent("homes:sumSlot",data.item,data.slot,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- homes:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("homes:Update")
AddEventHandler("homes:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTVAULT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestVault",function(data,cb)
	local inventario,inventario2,peso,maxpeso,peso2,maxpeso2,infos = vSERVER.openChest(tostring(houseOpen))
	if inventario then
		cb({ inventario = inventario, inventario2 = inventario2, peso = peso, maxpeso = maxpeso, peso2 = peso2, maxpeso2 = maxpeso2, infos = infos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PORTACOMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("porta",function(source,args)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	for k,v in pairs(homesList) do
		local distance = #(coords - vector3(v[5],v[6],v[7]))
		if distance <= 1.25 then
			vSERVER.tryUnlock(k)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local timeDistance = 999
        local innerTable = {}
        for k,v in pairs(homesList) do
			table.insert(innerTable,{ v[5],v[6],v[7],1.25,"E","Porta de Acesso","Pressione para entrar" })
        end
		
		Citizen.Wait(timeDistance)
        TriggerEvent("hoverfy:insertTable",innerTable)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADENTER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		for k,v in pairs(homesList) do
			local distance = #(coords - vector3(v[5],v[6],v[7]))
			
			if distance <= 1.25 then
				timeDistance = 1
				
				if IsControlJustPressed(1,38) and vSERVER.checkPermissions(k) then
					removeObjectHomes()
					DoScreenFadeOut(1000)
					houseOpen = tostring(k)
					vSERVER.setNetwork(tostring(k))
					vSERVER.applyHouseOpen(tostring(k))
					TriggerEvent("sounds:source","enterhouse",0.7)
					Citizen.Wait(1000)
					
					if v[1] == "Middle" then
						createMiddle(ped,v[5],v[6],1500.0)
					end
					
					if v[1] == "Mansion" then
						createMiddle(ped,v[5],v[6],1499.0)
					end
					
					if v[1] == "Trailer" then
						createMiddle(ped,v[5],v[6],1500.0)
					end
					
					if v[1] == "Beach" then
						createMiddle(ped,v[5],v[6],1500.0)
					end
					
					if v[1] == "Simple" then
						createMiddle(ped,v[5],v[6],1500.0)
					end
					
					if v[1] == "Motel" then
						createMiddle(ped,v[5],v[6],1500.0)
					end
					
					if v[1] == "Modern" then
						createMiddle(ped,v[5],v[6],1500.0)
					end
					
					if v[1] == "Hotel" then
						createMiddle(ped,v[5],v[6],1500.0)
					end
					
					if v[1] == "Franklin" then
						createMiddle(ped,v[5],v[6],1500.0)
					end
					
					if v[1] == "Container" then
						createMiddle(ped,v[5],v[6],1499.0)
					end
					
					SetTimecycleModifier("AmbientPUSH")
					Citizen.Wait(1000)
					
					if v[1] == "Middle" then
						SetEntityCoords(ped,v[5] + 1.36,v[6] - 14.23,1500.0 - 1,1,0,0,0)
						table.insert(internHouses,{ v[5] + 1.36,v[6] - 14.23,1499.5,"exit","SAIR" })
						table.insert(internHouses,{ v[5] + 7.15,v[6] - 1.00,1499.0,"vault","ABRIR" })
					end
					
					if v[1] == "Mansion" then
						SetEntityCoords(ped,v[5] - 8.68,v[6] - 3.43,1501.0 - 0.5,1,0,0,0)
						table.insert(internHouses,{ v[5] - 8.68,v[6] - 3.43,1501.0,"exit","SAIR" })
						table.insert(internHouses,{ v[5] - 3.97,v[6] - 13.58,1500.5,"vault","ABRIR" })
					end
					
					if v[1] == "Trailer" then
						SetEntityCoords(ped,v[5] - 1.44,v[6] - 2.02,1500.0 - 1,1,0,0,0)
						table.insert(internHouses,{ v[5] - 1.44,v[6] - 2.02,1499.5,"exit","SAIR" })
						table.insert(internHouses,{ v[5] - 4.36,v[6] - 1.97,1499.2,"vault","ABRIR" })
					end
					
					if v[1] == "Beach" then
						SetEntityCoords(ped,v[5] + 0.11,v[6] - 3.68,1500.0 - 1,1,0,0,0)
						table.insert(internHouses,{ v[5] + 0.11,v[6] - 3.68,1499.5,"exit","SAIR" })
						table.insert(internHouses,{ v[5] + 8.36,v[6] - 3.60,1499.8,"vault","ABRIR" })
					end
					
					if v[1] == "Simple" then
						SetEntityCoords(ped,v[5] - 4.89,v[6] - 4.15,1501.0 - 0.5,1,0,0,0)
						table.insert(internHouses,{ v[5] - 4.89,v[6] - 4.15,1501.0,"exit","SAIR" })
						table.insert(internHouses,{ v[5] + 1.43,v[6] - 2.11,1501.2,"vault","ABRIR" })
					end
					
					if v[1] == "Motel" then
						SetEntityCoords(ped,v[5] + 4.6,v[6] - 6.36,1498.5 - 0.5,1,0,0,0)
						table.insert(internHouses,{ v[5] + 4.6,v[6] - 6.36,1498.5,"exit","SAIR" })
						table.insert(internHouses,{ v[5] + 5.08,v[6] + 2.05,1500.3,"vault","ABRIR" })
					end
					
					if v[1] == "Modern" then
						SetEntityCoords(ped,v[5] - 1.63,v[6] - 5.94,1500.0 - 0.75,1,0,0,0)
						table.insert(internHouses,{ v[5] - 1.63,v[6] - 5.94,1499.7,"exit","SAIR" })
						table.insert(internHouses,{ v[5] - 0.59,v[6] + 2.95,1499.8,"vault","ABRIR" })
					end

					if v[1] == "Hotel" then
						SetEntityCoords(ped,v[5] - 1.69,v[6] - 3.91,1500.0 - 0.5,1,0,0,0)
						table.insert(internHouses,{ v[5] - 1.69,v[6] - 3.91,1499.8,"exit","SAIR" })
						table.insert(internHouses,{ v[5] - 2.25,v[6] + 0.95,1499.4,"vault","ABRIR" })
					end
					
					if v[1] == "Franklin" then
						SetEntityCoords(ped,v[5] - 0.47,v[6] - 5.91,1500.0 - 1,1,0,0,0)
						table.insert(internHouses,{ v[5] - 0.47,v[6] - 5.91,1499.6,"exit","SAIR" })
						table.insert(internHouses,{ v[5] - 2.60,v[6] - 5.59,1499.3,"vault","ABRIR" })
					end
					
					if v[1] == "Container" then
						SetEntityCoords(ped,v[5] - 1.14,v[6] - 1.38,1500.0,1,0,0,0)
						table.insert(internHouses,{ v[5] - 1.14,v[6] - 1.38,1500.5,"exit","SAIR" })
						table.insert(internHouses,{ v[5] + 4.47,v[6] - 1.32,1500.5,"vault","ABRIR" })
					end
					
					TriggerEvent("homes:Hours",true)
					FreezeEntityPosition(ped,true)
					SetEntityInvincible(ped,true)
					Citizen.Wait(3000)
					FreezeEntityPosition(ped,false)
					SetEntityInvincible(ped,false)
					DoScreenFadeIn(1000)
				end
			end
		end
	
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADNETWORK
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if houseOpen ~= "" then
			for k,v in ipairs(GetActivePlayers()) do
				if PlayerId() ~= v and houseNetwork[GetPlayerServerId(v)] == nil then
					NetworkFadeOutEntity(GetPlayerPed(v),true)
				end
			end
		end
		
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADUPDATENETWORK
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if houseOpen ~= "" then
			houseNetwork = vSERVER.getNetwork(tostring(houseOpen))
		end
		
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHOMESTATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getHomeStatistics()
	return tostring(houseOpen)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANUPHOMES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.cleanupHomes()
	houseOpen = ""
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHOMESTATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getHomesRejoin()
	if houseOpen ~= "" and not theftOpen then
		vSERVER.removeNetwork(tostring(houseOpen))
		return true
	end
	
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEHOMES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateHomes(status)
	homesList = status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOMES:TOGGLEPROPERTYS:LOCAL
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
local housesmarker = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOMES:TOGGLEPROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("homes:togglePropertys")
AddEventHandler("homes:togglePropertys",function()
	housesmarker = not housesmarker

	if housesmarker then
		TriggerEvent("Notify","amarelo","Marcações ativadas.",3000)
		
		for k,v in pairs(homesList) do
			blips[k] = AddBlipForCoord(v[5],v[6],v[7])
			SetBlipSprite(blips[k],414)
			SetBlipColour(blips[k],2)
			SetBlipScale(blips[k],0.3)
			SetBlipAsShortRange(blips[k],true)
		end
	else
		TriggerEvent("Notify","amarelo","Marcações desativadas.",3000)
		
		for k,v in pairs(blips) do
			if DoesBlipExist(v) then
				RemoveBlip(v)
			end
		end

		blips = {}
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEMIDDLE
-----------------------------------------------------------------------------------------------------------------------------------------
function createMiddle(ped,x,y,z)
	homeObjects[1] = CreateObjectNoOffset(GetHashKey("creative_middle"),x,y,z,false,false,false)

	FreezeEntityPosition(homeObjects[1],true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEMANSION
-----------------------------------------------------------------------------------------------------------------------------------------
function createMansion(ped,x,y,z)
	homeObjects[1] = CreateObjectNoOffset(GetHashKey("creative_mansion"),x,y,z,false,false,false)

	FreezeEntityPosition(homeObjects[1],true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATETRAILER
-----------------------------------------------------------------------------------------------------------------------------------------
function createTrailer(ped,x,y,z)
	homeObjects[1] = CreateObjectNoOffset(GetHashKey("creative_trailer"),x,y,z,false,false,false)

	FreezeEntityPosition(homeObjects[1],true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEBEACH
-----------------------------------------------------------------------------------------------------------------------------------------
function createBeach(ped,x,y,z)
	homeObjects[1] = CreateObjectNoOffset(GetHashKey("creative_beach"),x,y,z,false,false,false)

	FreezeEntityPosition(homeObjects[1],true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATESIMPLE
-----------------------------------------------------------------------------------------------------------------------------------------
function createSimple(ped,x,y,z)
	homeObjects[1] = CreateObjectNoOffset(GetHashKey("creative_simple"),x,y,z,false,false,false)

	FreezeEntityPosition(homeObjects[1],true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEMOTEL
-----------------------------------------------------------------------------------------------------------------------------------------
function createMotel(ped,x,y,z)
	homeObjects[1] = CreateObjectNoOffset(GetHashKey("creative_motel"),x,y,z,false,false,false)

	FreezeEntityPosition(homeObjects[1],true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEMODERN
-----------------------------------------------------------------------------------------------------------------------------------------
function createModern(ped,x,y,z)
	homeObjects[1] = CreateObjectNoOffset(GetHashKey("creative_modern"),x,y,z,false,false,false)

	FreezeEntityPosition(homeObjects[1],true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEHOTEL
-----------------------------------------------------------------------------------------------------------------------------------------
function createHotel(ped,x,y,z)
	homeObjects[1] = CreateObjectNoOffset(GetHashKey("creative_hotel"),x,y,z,false,false,false)

	FreezeEntityPosition(homeObjects[1],true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEFRANKLIN
-----------------------------------------------------------------------------------------------------------------------------------------
function createFranklin(ped,x,y,z)
	homeObjects[1] = CreateObjectNoOffset(GetHashKey("creative_franklin"),x,y,z,false,false,false)

	FreezeEntityPosition(homeObjects[1],true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATECONTAINER
-----------------------------------------------------------------------------------------------------------------------------------------
function createContainer(ped,x,y,z)
	homeObjects[1] = CreateObjectNoOffset(GetHashKey("creative_container"),x,y,z,false,false,false)

	FreezeEntityPosition(homeObjects[1],true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEOBJECTHOMES
-----------------------------------------------------------------------------------------------------------------------------------------
function removeObjectHomes()
	if homeObjects ~= nil then
		for k,v in pairs(homeObjects) do
			SetEntityAsMissionEntity(homeObjects[k],false,false)
			DeleteEntity(homeObjects[k])
			homeObjects[k] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETROTATION
-----------------------------------------------------------------------------------------------------------------------------------------
function getRotation(input)
	return 360 / (10*input)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEHOMESTHEFT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateHomesTheft(status)
	homesTheft = status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLESHOMESTHEFT
-----------------------------------------------------------------------------------------------------------------------------------------
local theftHomesX = 0.0
local theftHomesY = 0.0
local theftPlayers = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THEFTLOCAL
-----------------------------------------------------------------------------------------------------------------------------------------
local theftLocal = {
	["MOBILE01"] = { 3.26,-4.29,0.1 },
	["MOBILE02"] = { 1.27,-3.78,0.4 },
	["MOBILE03"] = { 1.35,-5.46,0.3 },
	["MOBILE04"] = { -1.95,-6.21,0.2 },
	["MOBILE05"] = { -3.56,-6.0,0.1 },
	["MOBILE06"] = { -4.67,0.85,-0.1 },
	["MOBILE07"] = { -2.14,1.22,-0.1 },
	["MOBILE08"] = { 2.59,1.66,0.5 },
	["MOBILE09"] = { 8.39,-1.86,0.0 },
	["MOBILE10"] = { 9.16,-1.43,-0.1 },
	["MOBILE11"] = { 6.38,2.64,0.0 },
	["MOBILE12"] = { 4.43,3.32,0.1 },
	["MOBILE13"] = { 8.48,3.93,0.4 },
	["LOCKER"] = { 7.16,-1.89,0.1 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKHOMESTHEFT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkHomesTheft()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	for k,v in pairs(homesTheft) do
		local distance = #(coords - vector3(v[1],v[2],v[3]))
		if distance <= 1.5 and vSERVER.checkHomeTheft(k) then
			theftPlayers = {}
			theftHomesX = v[1]
			theftHomesY = v[2]
			return true,tostring(k)
		end
	end
	
	return false,nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTERHOMESTHEFT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.enterHomesTheft(homeName)
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped) then
		theftOpen = true
		removeObjectHomes()
		DoScreenFadeOut(1000)
		houseOpen = tostring(homeName)
		vSERVER.setNetwork(tostring(homeName))
		vSERVER.applyHouseOpen(tostring(homeName))
		TriggerEvent("sounds:source","enterhouse",0.7)

		Citizen.Wait(1000)

		createMiddle(ped,theftHomesX,theftHomesY,1500.0)
		SetTimecycleModifier("AmbientPUSH")

		if math.random(100) >= 80 then
			if DoesEntityExist(theftLocker) then
				DeleteEntity(theftLocker)
				theftLocker = nil
			end

			local mHash = GetHashKey("prop_ld_int_safe_01")

			RequestModel(mHash)
			while not HasModelLoaded(mHash) do
				RequestModel(mHash)
				Citizen.Wait(10)
			end

			theftLocker = CreateObjectNoOffset(mHash,theftHomesX+7.17,theftHomesY-2.52,1501.8,false,false,false)
			SetEntityHeading(theftLocker,GetEntityHeading(homeObjects[41]))
			FreezeEntityPosition(theftLocker,true)
			SetModelAsNoLongerNeeded(mHash)
		else
			theftPlayers["LOCKER"] = true
		end

		Citizen.Wait(1000)

		SetEntityCoords(ped,theftHomesX+3.63,theftHomesY-15.43,1502.0)
		table.insert(internHouses,{ theftHomesX+3.63,theftHomesY-15.43,1502.3,"exit","SAIR" })

		TriggerEvent("homes:Hours",true)
		FreezeEntityPosition(ped,true)

		Citizen.Wait(3000)

		FreezeEntityPosition(ped,false)
		DoScreenFadeIn(1000)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADENTERHOMETHEFT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if theftOpen then
			local ped = PlayerPedId()
			if not IsPedInAnyVehicle(ped) then
				local coords = GetEntityCoords(ped)
				for k,v in pairs(theftLocal) do
					if not theftPlayers[k] then
						local distance = #(coords - vector3(theftHomesX+v[1],theftHomesY+v[2],1502.0))
						
						if distance <= 1.25 then
							timeDistance = 1
							DrawText3D(theftHomesX+v[1],theftHomesY+v[2],1500.0+v[3],"~g~E~w~   VASCULHAR")
							
							if IsControlJustPressed(1,38) then
								TriggerEvent("cancelando",true)
								
								if k == "LOCKER" then
									local safeCracking = exports["safecrack"]:safeCraking(3)
									if safeCracking then
										vSERVER.paymentTheft(k)
									end
									
									theftPlayers[k] = true
								else
									TriggerEvent("cancelando",true)
								
									local taskBar = exports["taskbar"]:taskHomes()
									if taskBar then
										vSERVER.paymentTheft(k)
										theftPlayers[k] = true
									end
									
									TriggerEvent("cancelando",false)
								end
							end
						end
					end
				end
			end
		end
		
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) and houseOpen ~= "" then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(internHouses) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 1.5 then
					timeDistance = 1
					DrawText3D(v[1],v[2],v[3],"~g~E~w~  "..v[5])

					if IsControlJustPressed(1,38) then
						if v[4] == "exit" then
							vSERVER.removeNetwork(tostring(houseOpen))
							TriggerEvent("sounds:source","outhouse",0.5)
							DoScreenFadeOut(1000)
							Citizen.Wait(1000)

							SetEntityCoords(ped,homesList[houseOpen][5],homesList[houseOpen][6],homesList[houseOpen][7]+0.1)
							TriggerEvent("homes:Hours",false)
							FreezeEntityPosition(ped,true)

							Citizen.Wait(3000)
							FreezeEntityPosition(ped,false)
							removeObjectHomes()
							DoScreenFadeIn(1000)
							ClearTimecycleModifier()
							vSERVER.removeHouseOpen()
							theftOpen = false
							internHouses = {}
							houseOpen = ""

							if DoesEntityExist(theftLocker) then
								DeleteEntity(theftLocker)
								theftLocker = nil
							end
						elseif v[4] == "vault" then
							if vSERVER.checkIntPermissions(tostring(houseOpen)) then
								SetNuiFocus(true,true)
								SendNUIMessage({ action = "showMenu" })
								TriggerEvent("sounds:source","chest",0.7)
							end
						end
					end
				end
			end
		end
		
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(text)
		SetTextColour(255,255,255,150)
		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x,_y)

		local width = string.len(text) / 160 * 0.45
		DrawRect(_x,_y + 0.0125,width,0.03,38,42,56,200)
	end
end