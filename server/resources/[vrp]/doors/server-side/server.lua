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
	[1] = { ["x"] = 361.77, ["y"] = -1584.5, ["z"] = 29.3, ["hash"] = -1501157055, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true, ["other"] = 2 },
	[2] = { ["x"] = 360.95, ["y"] = -1585.57, ["z"] = 29.3, ["hash"] = -1501157055, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true, ["other"] = 1 },
	[3] = { ["x"] = 365.63, ["y"] = -1588.71, ["z"] = 29.3, ["hash"] = -1320876379, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[4] = { ["x"] = 361.9, ["y"] = -1593.08, ["z"] = 29.3, ["hash"] = -1320876379, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[5] = { ["x"] = 368.3, ["y"] = -1596.09, ["z"] = 29.3, ["hash"] = -1320876379, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[6] = { ["x"] = 370.03, ["y"] = -1590.86, ["z"] = 29.3, ["hash"] = -1320876379, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[7] = { ["x"] = 379.03, ["y"] = -1598.43, ["z"] = 29.3, ["hash"] = -1320876379, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[8] = { ["x"] = 374.72, ["y"] = -1603.75, ["z"] = 29.3, ["hash"] = -1320876379, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[9] = { ["x"] = 383.35, ["y"] = -1603.82, ["z"] = 29.3, ["hash"] = -1320876379, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[10] = { ["x"] = 368.52, ["y"] = -1607.82, ["z"] = 29.3, ["hash"] = -1501157055, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true, ["other"] = 11 },
	[11] = { ["x"] = 369.58, ["y"] = -1606.65, ["z"] = 29.3, ["hash"] = -1501157055, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true, ["other"] = 10 },
	[12] = { ["x"] = 366.45, ["y"] = -1608.44, ["z"] = 29.3, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[13] = { ["x"] = 364.12, ["y"] = -1606.44, ["z"] = 29.3, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[14] = { ["x"] = 355.22, ["y"] = -1599.09, ["z"] = 29.3, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[15] = { ["x"] = 352.74, ["y"] = -1597.14, ["z"] = 29.3, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[16] = { ["x"] = 360.6, ["y"] = -1611.01, ["z"] = 29.3, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[17] = { ["x"] = 362.92, ["y"] = -1612.79, ["z"] = 29.3, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[18] = { ["x"] = 351.48, ["y"] = -1603.33, ["z"] = 29.3, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[19] = { ["x"] = 349.17, ["y"] = -1601.64, ["z"] = 29.3, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },

	[20] = { ["x"] = -630.81, ["y"] = -237.96, ["z"] = 38.1, ["hash"] = 9467943, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Admin", ["other"] = 21 },
	[21] = { ["x"] = -631.62, ["y"] = -236.92, ["z"] = 38.06, ["hash"] = 1425919976, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Admin", ["other"] = 20 },
	[22] = { ["x"] = -14.14, ["y"] = -1441.17, ["z"] = 31.11, ["hash"] = 520341586, ["lock"] = true, ["text"] = false, ["distance"] = 10, ["press"] = 1.5, ["perm"] = "Admin" },
	[23] = { ["x"] = 981.72, ["y"] = -102.78, ["z"] = 74.85, ["hash"] = 190770132, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "TheLost" },
	[24] = { ["x"] = 1846.049, ["y"] = 2604.733, ["z"] = 45.579, ["hash"] = 741314661, ["lock"] = true, ["text"] = true, ["distance"] = 30, ["press"] = 10.0, ["perm"] = "Police" },
	[25] = { ["x"] = 1819.475, ["y"] = 2604.743, ["z"] = 45.577, ["hash"] = 741314661, ["lock"] = true, ["text"] = true, ["distance"] = 30, ["press"] = 10.0, ["perm"] = "Police" },
	[26] = { ["x"] = 488.89, ["y"] = -1017.49, ["z"] = 28.15, ["hash"] = 2691149580, ["lock"] = true, ["text"] = true, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "Police" },
--	[27] = { ["x"] = 1274.47, ["y"] = -1720.43, ["z"] = 54.76, ["hash"] = 1145337974, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true },
	[28] = { ["x"] = 1595.79, ["y"] = 6451.34, ["z"] = 26.07, ["hash"] = -1428884643, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Avalanches", ["sound"] = true },
	[29] = { ["x"] = 1580.38, ["y"] = 6458.34, ["z"] = 26.07, ["hash"] = 861832298, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Avalanches", ["sound"] = true }
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
		TriggerClientEvent("sound:source",source,"doorlock",0.1)
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