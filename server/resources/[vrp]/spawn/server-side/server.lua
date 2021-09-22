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
Tunnel.bindInterface("spawn",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUPCHARS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.setupChars()
	local source = source
	local steam = vRP.getSteam(source)
	local mychars = {}

	Citizen.Wait(500)

	local chars = vRP.query("vRP/get_characters",{ steam = steam })
	if chars then
		mychars['result'] = chars
	end
	return mychars
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETECHAR
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.deleteChar(id)
	local source = source
	local steam = vRP.getSteam(source)

	vRP.execute("vRP/remove_characters",{ id = parseInt(id) })
  
	Citizen.Wait(1000)

	return getPlayerCharacters(steam)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
local spawnLogin = {}
RegisterServerEvent("spawn:charChosen")
AddEventHandler("spawn:charChosen",function(id)
	local source = source
	TriggerEvent("baseModule:idLoaded",source,id,nil)
	TriggerEvent("CharacterSpawn", source, id)
	
	if spawnLogin[parseInt(id)] then
		 TriggerClientEvent("spawn:spawnChar",source,false)
	else
		spawnLogin[parseInt(id)] = true
		 TriggerClientEvent("spawn:spawnChar",source,true)	
	end
	
	TriggerClientEvent("hudActived",source,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATECHAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("spawn:createChar")
AddEventHandler("spawn:createChar",function(name,name2,sex)
	local source = source
	local steam = vRP.getSteam(source)
	local persons = getPlayerCharacters(steam)
	------------------------------------------ CONFIGURAR CHARS AO INVES DE PREMIUM
	if not vRP.getPremium2(steam) and parseInt(#persons) >= 1 then
		TriggerClientEvent("Notify",source,"importante","Você atingiu o limite de personagens.",5000)
		TriggerClientEvent("spawn:maxChars",source)
		return
	end

	vRP.execute("vRP/create_characters",{ steam = steam, name = name, name2 = name2 })

	local newId = 0
	local chars = getPlayerCharacters(steam)
	for k,v in pairs(chars) do
		if v.id > newId then
			newId = tonumber(v.id)
		end
	end

	Citizen.Wait(300)

	spawnLogin[parseInt(newId)] = true
	TriggerEvent("baseModule:idLoaded",source,newId,sex)
	TriggerEvent("CharacterSpawn", source, newId)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERCHARACTERS
-----------------------------------------------------------------------------------------------------------------------------------------
function getPlayerCharacters(steam)
	return vRP.query("vRP/get_characters",{ steam = steam })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('respawn',function(source,args,rawCommand)
-- 	local source = source
--     local user_id = vRP.getUserId(source)
-- 	if vRP.hasPermission(user_id,"Owner") then
-- 		TriggerClientEvent("spawn:setupChars",source)
-- 		TriggerClientEvent("hudActived",source,false)
-- 	end
-- end)

-- RegisterCommand('respawn2',function(source,args,rawCommand)
-- 	local source = source
-- 	TriggerClientEvent("spawn:spawnChar",source)
-- 	TriggerClientEvent("hudActived",source,false)
-- end)


-- RegisterCommand('respawnchar',function(source,args,rawCommand)
-- 	local source = source
-- 	local user_id = vRP.getUserId(source)
-- 	if user_id then
-- 		vRP.setUData(user_id,"spawnController",json.encode(0))
-- 		TriggerClientEvent("hudActived",source,false)
-- 		TriggerEvent("CharacterSpawn", source, user_id)
-- 	end
-- end)