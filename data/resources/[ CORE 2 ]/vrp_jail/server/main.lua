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
CNVcore = {}
Tunnel.bindInterface("vrp_prison",CNVcore)
vCLIENT = Tunnel.getInterface("vrp_prison")
vPLAYER = Tunnel.getInterface("vrp_player")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local records = ""
local fines = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("prender",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") then
			local nuser_id = vRP.prompt(source,"Passaporte:","")
			if nuser_id == "" then
				return
			end

			local services = vRP.prompt(source,"Quantidade de serviços que terá que fazer:","")
			if services == "" then
				return
			end

			local crimes = vRP.prompt(source,"Crimes:","")
			if crimes == "" then
				return
			end
				
			local identity = vRP.getUserIdentity(parseInt(nuser_id))
			local identity2 = vRP.getUserIdentity(parseInt(user_id))
			if identity then
				TriggerClientEvent("Notify",source,"sucesso","<b>"..identity.name.." "..identity.name2.."</b> enviado para a prisão <b>"..parseInt(services).." serviços</b>.",5000)
				vRP.createWeebHook(records,"```PASSPORT: "..parseInt(nuser_id).."\nNAME: "..identity.name.." "..identity.name2.."\nSERVICES: "..parseInt(services).."\nCRIMES: "..crimes.."\nBY: "..identity2.name.." "..identity2.name2.."```")
			end

			local nplayer = vRP.getUserSource(parseInt(nuser_id))
			if nplayer then
				vRP.execute("vRP/set_prison",{ user_id = parseInt(nuser_id), prison = parseInt(services), locate = parseInt(2) })
				vCLIENT.startPrisonLocomove(nplayer)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("rprender",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") then
			local nuser_id = vRP.prompt(source,"Passport:","")
			if nuser_id == "" then
				return
			end

			local services = vRP.prompt(source,"Services:","")
			if services == "" then
				return
			end

			local consult = vRP.getInformation(parseInt(nuser_id))
			if parseInt(consult[1].prison) <= parseInt(services) then
				vRP.execute("vRP/fix_prison",{ user_id = parseInt(nuser_id) })
			else
				vRP.execute("vRP/rem_prison",{ user_id = parseInt(nuser_id), prison = parseInt(services) })
			end

			local identity = vRP.getUserIdentity(parseInt(nuser_id))
			if identity then
				TriggerClientEvent("Notify",source,"sucesso","<b>"..identity.name.." "..identity.name2.."</b> teve sua pena reduzida em <b>"..parseInt(services).."</b> serviços</b>.",5000)
			end
		end
	end
end)

RegisterCommand("resgate",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.nearestPlayer(source,15)
	if nplayer then
		local user_idn = vRP.getUserId(nplayer)
		if vCLIENT.getVehiclePed(nplayer) then
			TriggerClientEvent("vrp_hud:toggleHood",nplayer,false)
			vRP.execute("vRP/resgate_prison",{ user_id = parseInt(user_idn) })
			vCLIENT.stopPrison2(nplayer)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REDUCEPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function CNVcore.reducePrison()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.execute("vRP/rem_prison",{ user_id = parseInt(user_id), prison = 2 })

		local consult = vRP.getInformation(user_id)
		if parseInt(consult[1].prison) <= 0 then
			vCLIENT.stopPrison(source)
			TriggerClientEvent("Notify",source,"sucesso","O trabalho acabou, você já pode sair e esperamos não vê-lo novamente.",5000)
			if parseInt(consult[1].locate) == 2 then
				--vRPclient.teleport(source,1867.27,2604.87,45.68)
				vCLIENT.goJailItem(source)
			end
		else
			vCLIENT.startPrison(source,parseInt(consult[1].locate))
			TriggerClientEvent("Notify",source,"sucesso","Você ainda tem <b>"..parseInt(consult[1].prison).." serviços</b>.",5000)
		end
	end
end

function CNVcore.saveItems()
	local source = source
	local user_id = vRP.getUserId(source)
    local data = { }
    if user_id then
        for k,v in pairs(vRP.getInventory(user_id)) do
            if v.amount > 0 then
                vRP.removeInventoryItem(user_id, v.item, v.amount, true)
				table.insert(data, { name = v.item, amount = v.amount })
				vRP.setSData("jailitens:"..parseInt(user_id),json.encode(data))
            end
		end
		TriggerClientEvent("Notify",source,"importante","Você poderá retirar seus pertences ná recepção assim que for liberado.",5000)
	end
end

function CNVcore.reclaimItems()
	local src = source
    local user_id = vRP.getUserId(src)

	local playerData = vRP.getSData("jailitens:"..parseInt(user_id))
	local result = json.decode(playerData) or {}

	if playerData then
		for k,v in pairs(result) do
			vRP.giveInventoryItem(user_id,v.name,parseInt(v.amount),true)
		end
		
		vRP.setSData("jailitens:"..parseInt(user_id),json.encode({}))
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
--------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	Citizen.Wait(2000)

	local consult = vRP.getInformation(user_id)
	if parseInt(consult[1].prison) <= 0 then
		return
	else
		TriggerClientEvent("Notify",source,"importante","Você ainda tem que cumprir <b>"..parseInt(consult[1].prison).." serviços</b>.",5000)
		vCLIENT.startPrison(source,parseInt(2))
		vRPclient.teleport(source,1677.72,2509.68,45.57)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("multar",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") then
			local nuser_id = vRP.prompt(source,"Passaporte:","")
			if nuser_id == "" or parseInt(nuser_id) <= 0 then
				return
			end

			local value = vRP.prompt(source,"Valor:","")
			if value == "" or parseInt(value) <= 0 then
				return
			end

			local reason = vRP.prompt(source,"Motivo:","")
			if reason == "" then
				return
			end

			local identity = vRP.getUserIdentity(parseInt(nuser_id))
			local identity2 = vRP.getUserIdentity(parseInt(user_id))
			if identity then
				vRP.setFines(parseInt(nuser_id),parseInt(value),parseInt(user_id),tostring(reason))
				vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
				TriggerClientEvent("Notify",source,"importante","Multa aplicada em <b>"..identity.name.." "..identity.name2.."</b> no valor de <b>$"..vRP.format(parseInt(value)).." dólares</b>.",5000)
				vRP.createWeebHook(fines,"```PASSPORT: "..parseInt(nuser_id).."\nNAME: "..identity.name.." "..identity.name2.."\nVALUE: $"..vRP.format(parseInt(value)).."\nCRIMES: "..reason.."\nBY: "..identity2.name.." "..identity2.name2.."```")
			end
		end
	end
end)