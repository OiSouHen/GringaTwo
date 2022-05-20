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
Tunnel.bindInterface("hunting",cRP)
vSERVER = Tunnel.getInterface("hunting")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local animalMeat = 0
local blipHunting = nil
local animalHunting = nil
local animalHahs = { "a_c_deer","a_c_coyote","a_c_mtlion","a_c_pig","a_c_panther","a_c_boar" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMALMAP
-----------------------------------------------------------------------------------------------------------------------------------------
local animalMap = {
	{ 1343.03,2233.61,88.43,200 },
	{ -1171.5,1454.58,185.28,300 },
	{ -852.1,4940.38,235.63,400 },
	{ 1311.92,4610.54,131.21,200 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUNTING:ANIMALCALLING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hunting:animalCalling")
AddEventHandler("hunting:animalCalling",function()
	local ped = PlayerPedId()
	local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,5.0,0.0)

	if not IsPedInAnyVehicle(ped) then
		if not animalHunting then
			for k,v in pairs(animalMap) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= v[4] then
					animalMeat = math.random(100)
					local rand = math.random(#animalHahs)
					local mHash = GetHashKey(animalHahs[rand])

					RequestModel(mHash)
					while not HasModelLoaded(mHash) do
						Citizen.Wait(1)
					end

					if HasModelLoaded(mHash) then
						local spawnX = math.random(-200,200)
						local spawnY = math.random(-200,200)

						animalHunting = CreatePed(28,mHash,v[1] + spawnX,v[2] + spawnY,v[3],0.0,false,false)
						TaskGoStraightToCoord(animalHunting,coords["x"],coords["y"],coords["z"],1.5,-1,0.0,0.0)
						SetPedKeepTask(animalHunting,true)
						SetPedCombatMovement(animalHunting,3)
						SetPedCombatAbility(animalHunting,100)
						PlaceObjectOnGroundProperly(animalHunting)
						SetPedCombatAttributes(animalHunting,46,1)
						TriggerEvent("sounds:source","whistle",0.5)

						SetModelAsNoLongerNeeded(mHash)

						blipAnimal()
					end
				end
			end
		else
			TaskGoStraightToCoord(animalHunting,coords["x"],coords["y"],coords["z"],1.5,-1,0.0,0.0)
			TriggerEvent("sounds:source","whistle",0.5)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUNTING:ANIMALCUTING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hunting:animalCutting")
AddEventHandler("hunting:animalCutting",function()
	local ped = PlayerPedId()
	if animalHunting ~= nil then
		local coords = GetEntityCoords(ped)
		local animalCoords = GetEntityCoords(animalHunting)
		local distance = #(coords - animalCoords)

		if distance <= 1.5 then
			if IsPedDeadOrDying(animalHunting) and not IsPedAPlayer(animalHunting) then
				if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SWITCHBLADE") then
					TaskTurnPedToFaceEntity(ped,animalHunting,-1)
					TriggerEvent("player:blockCommands",true)
					TriggerEvent("cancelando",true)

					Citizen.Wait(1000)
					
					TriggerEvent("Progress",15000,"Esfolando...")

					vRP.playAnim(true,{"anim@gangops@facility@servers@bodysearch@","player_search"},true)
					vRP.playAnim(false,{"amb@medic@standing@kneel@base","base"},true)

					Citizen.Wait(15000)

					TriggerEvent("player:blockCommands",false)
					vSERVER.animalPayment()
					TriggerEvent("cancelando",false)
					vRP.removeObjects()

					if DoesBlipExist(blipHunting) then
						RemoveBlip(blipHunting)
						blipHunting = nil
					end

					if DoesEntityExist(animalHunting) then
						DeleteEntity(animalHunting)
						animalHunting = nil
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if animalHunting ~= nil and IsPedInAnyVehicle(ped) then
			if DoesBlipExist(blipHunting) then
				RemoveBlip(blipHunting)
				blipHunting = nil
			end

			if DoesEntityExist(animalHunting) then
				DeleteEntity(animalHunting)
				animalHunting = nil
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPANIMAL
-----------------------------------------------------------------------------------------------------------------------------------------
function blipAnimal()
	if DoesBlipExist(blipHunting) then
		RemoveBlip(blipHunting)
		blipHunting = nil
	end

	blipHunting = AddBlipForEntity(animalHunting)
	SetBlipSprite(blipHunting,141)
	SetBlipColour(blipHunting,41)
	SetBlipScale(blipHunting,0.8)
	SetBlipAsShortRange(blipHunting,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Animal")
	EndTextCommandSetBlipName(blipHunting)
end