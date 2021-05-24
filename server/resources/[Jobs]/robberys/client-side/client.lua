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
Tunnel.bindInterface("robberys",cnVRP)
vSERVER = Tunnel.getInterface("robberys")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local startRobbery = false
local robberyTimer = 0
local robberyId = 0
local vars = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINIT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(vars) do
				local distance = #(coords - vector3(v.x,v.y,v.z))
				if distance <= v.distance then
					timeDistance = 4

					if not startRobbery then
						if distance <= 2 then
							if distance <= 1 and IsControlJustPressed(1,38) and vSERVER.checkPolice(k,coords) then
								robberyId = k
								startRobbery = true
								robberyTimer = v.time
							end
						end
					else
						DrawText3D(v.x,v.y,v.z-0.4,"AGUARDE ~y~"..robberyTimer.."~w~ SEGUNDOS",370)
					end
				end
			end

			if startRobbery then
				local distance = #(coords - vector3(vars[robberyId].x,vars[robberyId].y,vars[robberyId].z))
				if distance > vars[robberyId].distance or GetEntityHealth(ped) <= 101 then
					startRobbery = false
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if startRobbery then
			if robberyTimer > 0 then
				robberyTimer = robberyTimer - 1
				if robberyTimer <= 0 then
					startRobbery = false
					vSERVER.paymentMethod(robberyId)
				end
			end
		end
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEVARS
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.updateVars(status)
	vars = status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text,height)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / height
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INPUTROBBERYS
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.inputRobberys(robberyTables)
	robberys = robberyTables

	local innerTable = {}
	for k,v in pairs(robberys) do
		table.insert(innerTable,{ v["coords"][1],v["coords"][2],v["coords"][3],1,"E",v["name"],"Pressione para iniciar o roubo" })
	end

	TriggerEvent("hoverfy:insertTable",innerTable)
end