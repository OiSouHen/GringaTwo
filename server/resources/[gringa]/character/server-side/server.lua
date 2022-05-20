-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local userlogin = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERINFO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("characterSpawn")
AddEventHandler("characterSpawn", function(source,user_id) 
	if user_id then
		local data = vRP.getUData(user_id,"spawnController")
		local sdata = json.decode(data) or 0
		if sdata then
			TriggerClientEvent("spawn:spawnChar",source,false)
			Wait(1000)
			processSpawnController(source,sdata,user_id)
		end
		
		-- if vRP.hasPermission(user_id,"Police") then
			-- vRP.execute("vRP/del_group",{ user_id = user_id, permiss = "Police" })
			-- vRP.execute("vRP/add_group",{ user_id = user_id, permiss = "waitPolice" })
		-- end
	end
end)

function processSpawnController(source,statusSent,user_id)
	if statusSent == 2 then
		if not userlogin[user_id] then
			userlogin[user_id] = true
			doSpawnPlayer(source,user_id,true)
		else
			doSpawnPlayer(source,user_id,false)
		end
	elseif statusSent == 1 or statusSent == 0 then
		userlogin[user_id] = true
		local data = vRP.getUserDataTable(user_id)
		if data and data.skin then
			TriggerClientEvent("character:characterCreate",source, data.skin)	
		end
	end
end

RegisterServerEvent("character:finishedCharacter")
AddEventHandler("character:finishedCharacter",function(currentCharacterMode)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.setUData(user_id,"currentCharacterMode",json.encode(currentCharacterMode))
		vRP.setUData(user_id,"spawnController",json.encode(2))
		doSpawnPlayer(source,user_id,true)
		TriggerClientEvent("hudActived",source,true)
	end
end)

function doSpawnPlayer(source,user_id,firstspawn)
	TriggerClientEvent("character:normalSpawn",source,firstspawn)
	TriggerEvent("barbershop:init",user_id)	
end