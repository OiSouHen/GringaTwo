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

	Wait(500)

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
  
	Wait(1000)

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
	TriggerEvent("characterSpawn", source, id)
	
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
AddEventHandler("spawn:createChar",function(name,name2,sex,loc)
	local source = source
	local steam = vRP.getSteam(source)
	local persons = getPlayerCharacters(steam)

	if not vRP.getPremium2(steam) and parseInt(#persons) >= 1 then
		TriggerClientEvent("Notify",source,"importante","Você atingiu o limite de personagens.",5000)
		TriggerClientEvent("spawn:maxChars",source)
		return
	end

	vRP.execute("vRP/create_characters",{ steam = steam, name = name, name2 = name2, loc = loc })

	local newId = 0
	local chars = getPlayerCharacters(steam)
	for k,v in pairs(chars) do
		if v.id > newId then
			newId = tonumber(v.id)
		end
	end

	Wait(300)

	spawnLogin[parseInt(newId)] = true
	TriggerEvent("baseModule:idLoaded",source,newId,sex)
	TriggerEvent("characterSpawn", source, newId)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERCHARACTERS
-----------------------------------------------------------------------------------------------------------------------------------------
function getPlayerCharacters(steam)
	return vRP.query("vRP/get_characters",{ steam = steam })
end