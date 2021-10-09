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
Tunnel.bindInterface("doors",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
local doors = {
--  [Police LS]
    [1] = { ["x"] = 468.97, ["y"] = -1014.46, ["z"] = 26.39, ["hash"] = -692649124, ["lock"] = true, ["text"] = true, ["distance"] = 1.5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = false },
	[2] = { ["x"] = 468.35, ["y"] = -1014.44, ["z"] = 26.39, ["hash"] = -692649124, ["lock"] = true, ["text"] = true, ["distance"] = 1.5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = false },
	[3] = { ["x"] = 441.43, ["y"] = -977.98, ["z"] = 30.69, ["hash"] = -1406685646, ["lock"] = true, ["text"] = true, ["distance"] = 1.5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = false },
	[4] = { ["x"] = 441.42, ["y"] = -986.06, ["z"] = 30.69, ["hash"] = -96679321, ["lock"] = true, ["text"] = true, ["distance"] = 1.5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = false },
	[5] = { ["x"] = 441.5, ["y"] = -999.05, ["z"] = 30.73, ["hash"] = -1547307588, ["lock"] = true, ["text"] = true, ["distance"] = 1.5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = false },
	[6] = { ["x"] = 442.45, ["y"] = -999.05, ["z"] = 30.73, ["hash"] = -1547307588, ["lock"] = true, ["text"] = true, ["distance"] = 1.5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = false },
--  [BurgerShot]
	[7] = { ["x"] = -1181.32, ["y"] = -894.86, ["z"] = 14.30, ["hash"] = 1042741067, ["lock"] = true, ["text"] = true, ["distance"] = 1.5, ["press"] = 1.5, ["perm"] = "BurgerShot", ["sound"] = false }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSSTATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.doorsStatistics(doorNumber,doorStatus)
	local source = source

	doors[parseInt(doorNumber)].lock = doorStatus

	if doors[parseInt(doorNumber)].other ~= nil then
		local doorSecond = doors[parseInt(doorNumber)].other
		doors[doorSecond].lock = doorStatus
	end

	TriggerClientEvent("doors:doorsUpdate",-1,doors)

	if doors[parseInt(doorNumber)].sound then
		TriggerClientEvent("sounds:source",source,"locked",0.5)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSSTATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("doors:doorsStatistics")
AddEventHandler("doors:doorsStatistics",function(doorNumber,doorStatus)
	doors[parseInt(doorNumber)].lock = doorStatus

	if doors[parseInt(doorNumber)].other ~= nil then
		local doorSecond = doors[parseInt(doorNumber)].other
		doors[doorSecond].lock = doorStatus
	end

	TriggerClientEvent("doors:doorsUpdate",-1,doors)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.doorsPermission(doorNumber)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if doors[parseInt(doorNumber)].perm ~= nil then
			if vRP.hasPermission(user_id,doors[parseInt(doorNumber)].perm) then
				return true
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("doors:doorsUpdate",source,doors)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADPLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	Citizen.Wait(1000)
	TriggerClientEvent("doors:doorsUpdate",-1,doors)
end)