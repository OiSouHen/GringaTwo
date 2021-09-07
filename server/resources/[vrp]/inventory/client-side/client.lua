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
Tunnel.bindInterface("inventory",cRP)
vSERVER = Tunnel.getInterface("inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local currentWeapon = nil
local currentWeaponModel = nil
local takingWeapon = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKBUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
local blockButtons = false
RegisterNetEvent("inventory:blockButtons")
AddEventHandler("inventory:blockButtons",function(status)
	blockButtons = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKSINVENTS
-----------------------------------------------------------------------------------------------------------------------------------------
function blockInvents()
	return blockButtons
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		local timeDistance = 999
		if blockButtons then
			timeDistance = 1
			DisableControlAction(1,75,true)
			DisableControlAction(1,47,true)
			DisableControlAction(1,257,true)
			DisablePlayerFiring(PlayerPedId(),true)
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKINVENTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("blockInvents",blockInvents)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEWEAPONN
-----------------------------------------------------------------------------------------------------------------------------------------
local AllWeapons = json.decode('{"melee":{"dagger":"0x92A27487","bat":"0x958A4A8F","bottle":"0xF9E6AA4B","crowbar":"0x84BD7BFD","unarmed":"0xA2719263","flashlight":"0x8BB05FD7","golfclub":"0x440E4788","hammer":"0x4E875F73","hatchet":"0xF9DCBF2D","knuckle":"0xD8DF3C3C","knife":"0x99B507EA","machete":"0xDD5DF8D9","switchblade":"0xDFE37640","nightstick":"0x678B81B1","wrench":"0x19044EE0","battleaxe":"0xCD274149","poolcue":"0x94117305","stone_hatchet":"0x3813FC08"},"handguns":{"PISTOL":"0x1B06D571","PISTOL_MK2":"0xBFE256D4","COMBATPISTOL":"0x5EF9FEC4","APPISTOL":"0x22D8FE39","STUNGUN":"0x3656C8C1","PISTOL50":"0x99AEEB3B","SNSPISTOL":"0xBFD21232","SNSPISTOL_MK2":"0x88374054","HEAVYPISTOL":"0xD205520E","VINTAGEPISTOL":"0x83839C4","FLAREGUN":"0x47757124","MARKSMANPISTOL":"0xDC4DB296","REVOLVER":"0xC1B3C3D1","REVOLVER_MK2":"0xCB96392F","DOUBLEACTION":"0x97EA20B8","RAYPISTOL":"0xAF3696A1"},"smg":{"MICROSMG":"0x13532244","SMG":"0x2BE6766B","SMG_MK2":"0x78A97CD0","ASSAULTSMG":"0xEFE7E2DF","COMBATPDW":"0xA3D4D34","MACHINEPISTOL":"0xDB1AA450","MINISMG":"0xBD248B55","RAYCARBINE":"0x476BF155"},"shotguns":{"pumpshotgun":"0x1D073A89","pumpshotgun_mk2":"0x555AF99A","sawnoffshotgun":"0x7846A318","assaultshotgun":"0xE284C527","bullpupshotgun":"0x9D61E50F","musket":"0xA89CB99E","heavyshotgun":"0x3AABBBAA","dbshotgun":"0xEF951FBB","autoshotgun":"0x12E82D3D"},"assault_rifles":{"ASSAULTRIFLE":"0xBFEFFF6D","ASSAULTRIFLE_MK2":"0x394F415C","CARBINERIFLE":"0x83BF0278","CARBINERIFLE_MK2":"0xFAD1F1C9","ADVANCEDRIFLE":"0xAF113F99","SPECIALCARBINE":"0xC0A3098D","SPECIALCARBINE_MK2":"0x969C3D67","BULLPUPRIFLE":"0x7F229F94","BULLPUPRIFLE_MK2":"0x84D6FAFD","COMPACTRIFLE":"0x624FE830"},"MACHINE_GUNS":{"mg":"0x9D07F764","combatmg":"0x7FD62962","combatmg_mk2":"0xDBBD7280","gusenberg":"0x61012683"},"sniper_rifles":{"sniperrifle":"0x5FC3C11","heavysniper":"0xC472FE2","heavysniper_mk2":"0xA914799","marksmanrifle":"0xC734385A","marksmanrifle_mk2":"0x6A6C02E0"},"heavy_weapons":{"rpg":"0xB1CA77B1","grenadelauncher":"0xA284510B","grenadelauncher_smoke":"0x4DD2DC56","minigun":"0x42BF8A85","firework":"0x7F7497E5","railgun":"0x6D544C99","hominglauncher":"0x63AB0442","compactlauncher":"0x781FE4A","rayminigun":"0xB62D1F67"},"throwables":{"grenade":"0x93E220BD","bzgas":"0xA0973D5E","smokegrenade":"0xFDBC8A50","flare":"0x497FACC3","molotov":"0x24B17070","stickybomb":"0x2C3731D9","proxmine":"0xAB564B93","snowball":"0x787F0BB","pipebomb":"0xBA45E8B8","ball":"0x23C9F95C"},"misc":{"petrolcan":"0x34A67B97","fireextinguisher":"0x60EC506","parachute":"0xFBAB5776"}}')
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADUPDATEWEAPONN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local slyphe = 500
		local ped = PlayerPedId()
		local player = GetPlayerPed(-1)
		local status = {}
		if IsPedArmed(ped,1) or IsPedArmed(ped,2) or IsPedArmed(ped,4) then
			slyphe = 1
			if IsPedShooting(player) then
				local weapon = GetSelectedPedWeapon(player)
				local ammoTotal = GetAmmoInPedWeapon(player,weapon)

				for key,value in pairs(AllWeapons) do
					for keyTwo,valueTwo in pairs(AllWeapons[key]) do
						if weapon == GetHashKey('weapon_'..keyTwo) then
							vSERVER.updateWeaponAmmo("WEAPON_"..keyTwo,ammoTotal)
						end
					end
				end
			end
		end
		
		Citizen.Wait(slyphe)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function(data,cb)
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ action = "hideMenu" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSEINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.closeInventory()
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ action = "hideMenu" })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTERVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.enterVehicle()
	local ped = PlayerPedId()
	if GetVehiclePedIsTryingToEnter(ped) > 0 then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("moc",function(source,args)
	if GetEntityHealth(PlayerPedId()) > 101 and not blockButtons then
		if not exports["player"]:blockCommands() and not exports["player"]:handCuff() and not IsPlayerFreeAiming(PlayerId()) then
			SetNuiFocus(true,true)
			SetCursorLocation(0.5,0.5)
			SendNUIMessage({ action = "showMenu" })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("moc","Abrir a mochila","keyboard","oem_3")
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUI:DROPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dropItem",function(data)
	local ped = GetPlayerPed(-1)
	if IsPedArmed(ped,1) or IsPedArmed(ped,2) or IsPedArmed(ped,4) then
		currentWeapon = nil
		currentWeaponModel = nil
		TriggerServerEvent("inventory:dropItem",data.item,data.amount,true)
	else
		TriggerServerEvent("inventory:dropItem",data.item,data.amount,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION:DROPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.dropItem(item,amount)
	TriggerServerEvent("inventory:dropItem",item,amount,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PICKUPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("pickupItem",function(data)
	if data.amount > 0 then
		TriggerServerEvent("itemdrop:Pickup",data.id,data.target,data.amount)
	else
		TriggerEvent("Notify","vermelho","Não é possível pegar um valor negativo.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local droplist = {}
local cooldown = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDROP:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("itemdrop:Remove")
AddEventHandler("itemdrop:Remove",function(id)
	if droplist[id] ~= nil then
		droplist[id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDROP:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("itemdrop:Players")
AddEventHandler("itemdrop:Players",function(id,marker)
	droplist[id] = marker
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDROP:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("itemdrop:Update")
AddEventHandler("itemdrop:Update",function(status)
	droplist = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDROPBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
        local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		
		for k,v in pairs(droplist) do
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
            local distance = #(coords - vector3(v.x,v.y,cdz))
            if distance <= 50 then
				timeDistance = 1
				DrawMarker(23,v.x,v.y,cdz+ 0.05,0.0,0.0,0.0,0.0,180.0,0.0,0.15,0.15,0.0,255,255,255,50,0,0,0,0)
				DrawMarker(21,v.x,v.y,cdz+ 0.25,0.0,0.0,0.0,0.0,180.0,0.0,0.20,0.20,0.20,42,137,255,125,0,0,0,1)
			end
        end

        Citizen.Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("useItem",function(data)
	TriggerServerEvent("inventory:useItem",data.slot,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUBMIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sendItem",function(data)
	local ped = GetPlayerPed(-1)
	if IsPedArmed(ped,1) or IsPedArmed(ped,2) or IsPedArmed(ped,4) then
		currentWeapon = nil
		currentWeaponModel = nil
		TriggerServerEvent("inventory:sendItem",data.item,data.amount)
	else
		TriggerServerEvent("inventory:sendItem",data.item,data.amount)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data,cb)
	local ped = GetPlayerPed(-1)
	if IsPedArmed(ped) or IsPedArmed(ped,2) or IsPedArmed(ped,4) then
		currentWeapon = nil
		currentWeaponModel = nil
		TriggerServerEvent("inventory:updateSlot",data.item,data.slot,data.target,data.amount)
	else
		TriggerServerEvent("inventory:updateSlot",data.item,data.slot,data.target,data.amount)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestBackpack",function(data,cb)
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local dropItems = {}
	for k,v in pairs(droplist) do
		local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
		if GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true) <= 1.5 then
			table.insert(dropItems,{economy = v.economy, unity = v.unity, tipo = v.tipo, desc = v.desc, name = v.name, key = v.name, durability = v.durability, amount = v.count, index = v.index, peso = v.peso, desc = v.desc, id = k })
		end
	end

	local inventario,peso,maxpeso,infos = vSERVER.Backpack()
	if inventario then
		cb({ inventario = inventario, drop = dropItems, peso = peso, maxpeso = maxpeso, infos = infos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Update")
AddEventHandler("inventory:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.plateDistance()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)
		if GetPedInVehicleSeat(vehicle,-1) == ped then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(plateX,plateY,plateZ))
			if distance <= 3.0 then
				FreezeEntityPosition(vehicle,true)
				return true
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.plateVehicle()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)
		if GetPedInVehicleSeat(vehicle,-1) == ped then
			FreezeEntityPosition(vehicle,true)
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEAPPLY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.plateApply(plate)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)

		SetVehicleNumberPlateText(vehicle,plate)
		FreezeEntityPosition(vehicle,false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKBURSTTYRES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkBurstTyres(index)
    if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			local tires_burst = false
			for i=0,8 do
				local burst = IsVehicleTyreBurst(v,i,false)
				if burst then tires_burst = true return end
			end

			if not tires_burst then
				return true
			else
				TriggerEvent("Notify","vermelho","Você precisa arrumar os pneus primeiro.")
				return false
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairVehicle")
AddEventHandler("inventory:repairVehicle",function(index,status)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			if status then
				local vehTyres = {}
				local fuel = GetVehicleFuelLevel(v)

				for i = 0,7 do
					local tyre_state = 2
					if IsVehicleTyreBurst(v,i,true) then
						tyre_state = 1
					elseif IsVehicleTyreBurst(v,i,false) then
						tyre_state = 0
					end

					vehTyres[i] = tyre_state
				end

				SetVehicleFixed(v)
				SetVehicleFuelLevel(v,fuel)

				for k,vs in pairs(vehTyres) do
					if vs < 2 then
						SetVehicleTyreBurst(v,k,(vs == 1),1000.0)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRTIRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairTires")
AddEventHandler("inventory:repairTires",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			for i = 0,8 do
				SetVehicleTyreFixed(v,i)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCKPICKVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:lockpickVehicle")
AddEventHandler("inventory:lockpickVehicle",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			SetEntityAsMissionEntity(v,true,true)
			if GetVehicleDoorsLockedForPlayer(v,PlayerId()) == 1 then
				SetVehicleDoorsLocked(v,false)
				SetVehicleDoorsLockedForAllPlayers(v,false)
			else
				SetVehicleDoorsLocked(v,true)
				SetVehicleDoorsLockedForAllPlayers(v,true)
			end
			SetVehicleLights(v,2)
			Wait(200)
			SetVehicleLights(v,0)
			Wait(200)
			SetVehicleLights(v,2)
			Wait(200)
			SetVehicleLights(v,0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARACHUTECOLORS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.parachuteColors()
	local ped = PlayerPedId()
	GiveWeaponToPed(ped,"GADGET_PARACHUTE",1,false,true)
	SetPedParachuteTintIndex(ped,math.random(7))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKFOUNTAIN
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkFountain()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	if DoesObjectOfTypeExistAtCoords(coords,0.7,GetHashKey("prop_watercooler"),true) or DoesObjectOfTypeExistAtCoords(coords,0.7,GetHashKey("prop_watercooler_dark"),true) then
		return true,"fountain"
	end

	if IsEntityInWater(ped) then
		return true,"floor"
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CASHREGISTER
-----------------------------------------------------------------------------------------------------------------------------------------
local registerCoords = {}
function cRP.cashRegister()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	for k,v in pairs(registerCoords) do
		local distance = #(coords - vector3(v[1],v[2],v[3]))
		if distance <= 1 then
			return false,v[1],v[2],v[3]
		end
	end

	local object = GetClosestObjectOfType(coords,0.4,GetHashKey("prop_till_01"),0,0,0)
	if DoesEntityExist(object) then
		SetEntityHeading(ped,GetEntityHeading(object)-360.0)
		local coords = GetEntityCoords(object)
		return true,coords.x,coords.y,coords.z
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEREGISTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:updateRegister")
AddEventHandler("inventory:updateRegister",function(status)
	registerCoords = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHINGCDS
-----------------------------------------------------------------------------------------------------------------------------------------
local fishingcds = {
	{ -3418.14,967.56,8.34 },
	{ -273.63,6633.67,7.4 },
	{ 713.39,4101.04,35.79 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHINGSTATUS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.fishingStatus()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	for k,v in pairs(fishingcds) do
		local distance = #(coords - vector3(v[1],v[2],v[3]))
		if distance <= 25 then
			return true
		end
	end
	
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHINGANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.fishingAnim()
	local ped = PlayerPedId()
	if IsEntityPlayingAnim(ped,"amb@world_human_stand_fishing@idle_a","idle_c",3) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WCOMPONENTS
-----------------------------------------------------------------------------------------------------------------------------------------
local wComponents = {
	["WEAPON_PISTOL"] = {
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_HEAVYPISTOL"] = {
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_PISTOL_MK2"] = {
		"COMPONENT_AT_PI_RAIL",
		"COMPONENT_AT_PI_FLSH_02",
		"COMPONENT_AT_PI_COMP"
	},
	["WEAPON_COMBATPISTOL"] = {
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_APPISTOL"] = {
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_MICROSMG"] = {
		"COMPONENT_AT_PI_FLSH",
		"COMPONENT_AT_SCOPE_MACRO"
	},
	["WEAPON_SMG"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO_02",
		"COMPONENT_AT_PI_SUPP"
	},
	["WEAPON_ASSAULTSMG"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO",
		"COMPONENT_AT_AR_SUPP_02"
	},
	["WEAPON_COMBATPDW"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_AR_AFGRIP",
		"COMPONENT_AT_SCOPE_SMALL"
	},
	["WEAPON_PUMPSHOTGUN"] = {
		"COMPONENT_AT_AR_FLSH"
	},
	["WEAPON_CARBINERIFLE"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MEDIUM",
		"COMPONENT_AT_AR_AFGRIP"
	},
	["WEAPON_ASSAULTRIFLE"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO",
		"COMPONENT_AT_AR_AFGRIP"
	},
	["WEAPON_MACHINEPISTOL"] = {
		"COMPONENT_AT_PI_SUPP"
	},
	["WEAPON_ASSAULTRIFLE_MK2"] = {
		"COMPONENT_AT_AR_AFGRIP_02",
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MEDIUM_MK2",
		"COMPONENT_AT_MUZZLE_01"
	},
	["WEAPON_PISTOL50"] = {
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_SNSPISTOL_MK2"] = {
		"COMPONENT_AT_PI_FLSH_03",
		"COMPONENT_AT_PI_RAIL_02",
		"COMPONENT_AT_PI_COMP_02"
	},
	["WEAPON_SMG_MK2"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO_02_SMG_MK2",
		"COMPONENT_AT_MUZZLE_01"
	},
	["WEAPON_BULLPUPRIFLE"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_SMALL",
		"COMPONENT_AT_AR_SUPP"
	},
	["WEAPON_BULLPUPRIFLE_MK2"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO_02_MK2",
		"COMPONENT_AT_MUZZLE_01"
	},
	["WEAPON_SPECIALCARBINE"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MEDIUM",
		"COMPONENT_AT_AR_AFGRIP"
	},
	["WEAPON_SPECIALCARBINE_MK2"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MEDIUM_MK2",
		"COMPONENT_AT_MUZZLE_01"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("attachs",function(source,args)
	local ped = PlayerPedId()
	for k,v in pairs(wComponents) do
		if GetSelectedPedWeapon(ped) == GetHashKey(k) then
			for k2,v2 in pairs(v) do
				GiveWeaponComponentToPed(ped,GetHashKey(k),GetHashKey(v2))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTWEAPONHANDS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.putWeaponHands(weaponName,weaponAmmo)
	if not putWeaponHands then
		if weaponAmmo > 0 then
			weaponActive = true
		end

		putWeaponHands = true
		TriggerEvent("cancelando",true)

		local ped = PlayerPedId()
		if HasPedGotWeapon(ped,GetHashKey("GADGET_PARACHUTE"),false) then
			RemoveAllPedWeapons(ped,true)
			GiveWeaponToPed(ped,"GADGET_PARACHUTE",1,false,true)
			SetPedParachuteTintIndex(ped,math.random(7))
		else
			RemoveAllPedWeapons(ped,true)
		end

		if not IsPedInAnyVehicle(ped) then
			loadAnimDict("rcmjosh4")

			TaskPlayAnim(ped,"rcmjosh4","josh_leadout_cop2",3.0,2.0,-1,48,10,0,0,0)

			Citizen.Wait(200)

			GiveWeaponToPed(ped,weaponName,weaponAmmo,false,true)

			Citizen.Wait(300)

			ClearPedTasks(ped)
		else
			GiveWeaponToPed(ped,weaponName,weaponAmmo,true,true)
		end

		TriggerEvent("cancelando",false)
		useWeapon = weaponName
		putWeaponHands = false

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREWEAPONHANDS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.storeWeaponHands()
	if not storeWeaponHands then
		storeWeaponHands = true
		TriggerEvent("cancelando",true)

		local ped = PlayerPedId()
		local lastWeapon = useWeapon
		local weaponAmmo = GetAmmoInPedWeapon(ped,useWeapon)

		if not IsPedInAnyVehicle(ped) then
			loadAnimDict("weapons@pistol@")

			TaskPlayAnim(ped,"weapons@pistol@","aim_2_holster",3.0,2.0,-1,48,10,0,0,0)

			Citizen.Wait(450)

			ClearPedTasks(ped)
		end

		if HasPedGotWeapon(ped,GetHashKey("GADGET_PARACHUTE"),false) then
			RemoveAllPedWeapons(ped,true)
			GiveWeaponToPed(ped,"GADGET_PARACHUTE",1,false,true)
			SetPedParachuteTintIndex(ped,math.random(7))
		else
			RemoveAllPedWeapons(ped,true)
		end

		weaponActive = false
		useWeapon = ""

		storeWeaponHands = false
		TriggerEvent("cancelando",false)

		return true,weaponAmmo,lastWeapon
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPON_AMMOS
-----------------------------------------------------------------------------------------------------------------------------------------
local weapon_ammos = {
	["WEAPON_PISTOL_AMMO"] = {
		"WEAPON_PISTOL"
	},
	["WEAPON_PISTOL_MK2_AMMO"] = {
		"WEAPON_PISTOL_MK2"
	},
	["WEAPON_APPISTOL_AMMO"] = {
		"WEAPON_APPISTOL"
	},
	["WEAPON_HEAVYPISTOL_AMMO"] = {
		"WEAPON_HEAVYPISTOL"
	},
	["WEAPON_SNSPISTOL_AMMO"] = {
		"WEAPON_SNSPISTOL"
	},
	["WEAPON_SNSPISTOL_MK2_AMMO"] = {
		"WEAPON_SNSPISTOL_MK2"
	},
	["WEAPON_VINTAGEPISTOL_AMMO"] = {
		"WEAPON_VINTAGEPISTOL"
	},
	["WEAPON_PISTOL50_AMMO"] = {
		"WEAPON_PISTOL50"
	},
	["WEAPON_REVOLVER_AMMO"] = {
		"WEAPON_REVOLVER"
	},
	["WEAPON_COMBATPISTOL_AMMO"] = {
		"WEAPON_COMBATPISTOL"
	},
	["WEAPON_COMPACTRIFLE_AMMO"] = {
		"WEAPON_COMPACTRIFLE"
	},
	["WEAPON_MICROSMG_AMMO"] = {
		"WEAPON_MICROSMG"
	},
	["WEAPON_MINISMG_AMMO"] = {
		"WEAPON_MINISMG"
	},
	["WEAPON_SMG_AMMO"] = {
		"WEAPON_SMG"
	},
	["WEAPON_ASSAULTSMG_AMMO"] = {
		"WEAPON_ASSAULTSMG"
	},
	["WEAPON_GUSENBERG_AMMO"] = {
		"WEAPON_GUSENBERG"
	},
	["WEAPON_MACHINEPISTOL_AMMO"] = {
		"WEAPON_MACHINEPISTOL"
	},
    ["WEAPON_CARBINERIFLE_AMMO"] = {
		"WEAPON_CARBINERIFLE"
	},
	["WEAPON_ASSAULTRIFLE_AMMO"] = {
		"WEAPON_ASSAULTRIFLE"
	},
	["WEAPON_ASSAULTRIFLE_MK2_AMMO"] = {
		"WEAPON_ASSAULTRIFLE_MK2"
	},
    ["WEAPON_PUMPSHOTGUN_AMMO"] = {
		"WEAPON_PUMPSHOTGUN"
	},
	["WEAPON_SAWNOFFSHOTGUN_AMMO"] = {
		"WEAPON_SAWNOFFSHOTGUN"
	},
	["WEAPON_MUSKET_AMMO"] = {
		"WEAPON_MUSKET"
	},
	["WEAPON_SNIPERRIFLE_AMMO"] = {
		"WEAPON_SNIPERRIFLE"
	},
    ["WEAPON_RPG_AMMO"] = {
		"WEAPON_RPG"
	},
	["WEAPON_PETROLCAN_AMMO"] = {
		"WEAPON_PETROLCAN"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.rechargeCheck(ammoType)
	local ped = PlayerPedId()
	if weapon_ammos[ammoType] then
		for k,v in pairs(weapon_ammos[ammoType]) do
			if HasPedGotWeapon(ped,v) then
				return true
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.rechargeWeapon(ammoType,ammoAmount)
	local ped = PlayerPedId()
	if weapon_ammos[ammoType] then
		for k,v in pairs(weapon_ammos[ammoType]) do
			if HasPedGotWeapon(ped,v) then
				SetPedAmmo(ped, v, ammoAmount)
				return true
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.rechargeWeapon2(ammoType,ammoAmount)
	local ped = PlayerPedId()
	local targetWeapon = GetSelectedPedWeapon(ped)
	local targetWeaponAmmo = GetAmmoInPedWeapon(ped, targetWeapon)
	local currentAmmo = targetWeaponAmmo
	local ped = PlayerPedId()
	SetPedAmmo(ped, targetWeapon, ammoAmount)
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADRENALINECDS
-----------------------------------------------------------------------------------------------------------------------------------------
local adrenalineCds = {
	{ 1978.98,5171.98,47.63 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADRENALINEDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.adrenalineDistance()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	for k,v in pairs(adrenalineCds) do
		local distance = #(coords - vector3(v[1],v[2],v[3]))
		if distance <= 5 then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRECRACKER
-----------------------------------------------------------------------------------------------------------------------------------------
local firecracker = nil
RegisterNetEvent("inventory:Firecracker")
AddEventHandler("inventory:Firecracker",function()
	if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
		RequestNamedPtfxAsset("scr_indep_fireworks")
		while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
			RequestNamedPtfxAsset("scr_indep_fireworks")
			Citizen.Wait(10)
		end
	end

	local mHash = GetHashKey("ind_prop_firework_03")

	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		RequestModel(mHash)
		Citizen.Wait(10)
	end

	local explosives = 35
	local ped = PlayerPedId()
	local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.6,0.0)
	firecracker = CreateObjectNoOffset(mHash,coords.x,coords.y,coords.z,true,false,false)

	PlaceObjectOnGroundProperly(firecracker)
	FreezeEntityPosition(firecracker,true)
	SetModelAsNoLongerNeeded(mHash)

	Citizen.Wait(10000)

	repeat
		UseParticleFxAssetNextCall("scr_indep_fireworks")
		local explode = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst",coords.x,coords.y,coords.z,0.0,0.0,0.0,2.5,false,false,false,false)
		explosives = explosives - 1

		Citizen.Wait(2000)
	until explosives == 0

	TriggerServerEvent("tryDeleteEntity",ObjToNet(firecracker))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TECHDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.techDistance()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local distance = #(coords - vector3(1174.66,2640.45,37.82))
	if distance <= 10 then
		return true
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKWATER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkWater()
	return IsPedSwimming(PlayerPedId())
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLECARRY
-----------------------------------------------------------------------------------------------------------------------------------------
local uCarry = nil
local iCarry = false
local sCarry = false
RegisterNetEvent("toggleCarry")
AddEventHandler("toggleCarry",function(source)
	uCarry = source
	iCarry = not iCarry

	local ped = PlayerPedId()
	if iCarry and uCarry then
		Citizen.InvokeNative(0x6B9BBD38AB0796DF,ped,GetPlayerPed(GetPlayerFromServerId(uCarry)),4103,11816,0.48,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		sCarry = true
	else
		if sCarry then
			DetachEntity(ped,false,false)
			sCarry = false
		end
	end
end)