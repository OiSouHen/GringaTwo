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
-- INITSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.initSystem()
	local source = source
	local steam = vRP.getSteam(source)
	return getPlayerCharacters(steam)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
local spawnLogin = {}
function cRP.characterChosen(id)
	local source = source
	TriggerClientEvent("hudActived",source,true)
	TriggerEvent("baseModule:idLoaded",source,id,nil)
	TriggerEvent("character:characterSpawn",source,id)
end

RegisterServerEvent("spawn:charChosen")
AddEventHandler("spawn:charChosen",function(id)
	local source = source
	TriggerClientEvent("hudActived",source,true)
	TriggerEvent("baseModule:idLoaded",source,id,nil)
	TriggerEvent("character:characterSpawn",source,id)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATECHAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("spawn:createChar")
AddEventHandler("spawn:createChar",function(name,name2,sex)
	local source = source
	local steam = vRP.getSteam(source)
	local persons = getPlayerCharacters(steam)

	if not vRP.getPremium2(steam) and parseInt(#persons) >= 1 then
		TriggerClientEvent("Notify",source,"amarelo","Você atingiu o limite de personagens.",5000)
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

	local model = ""
	if sex == "M" then
		model = "mp_m_freemode_01"
	elseif sex == "F" then
		model = "mp_f_freemode_01"
	end

	spawnLogin[parseInt(newId)] = true
	TriggerEvent("baseModule:idLoaded",source,newId,model)
	
	Citizen.Wait(1000)
	
	TriggerEvent("character:characterSpawn",source,newId)
	TriggerClientEvent("hudActived",source,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERCHARACTERS
-----------------------------------------------------------------------------------------------------------------------------------------
function getPlayerCharacters(steam)
	return vRP.query("vRP/get_characters",{ steam = steam })
end