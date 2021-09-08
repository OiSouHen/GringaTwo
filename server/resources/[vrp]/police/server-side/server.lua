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
cRP = {}
Tunnel.bindInterface("police",cRP)
vCLIENT = Tunnel.getInterface("police")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOKS
-----------------------------------------------------------------------------------------------------------------------------------------
local records = ""
local fines = ""
local servicelog = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local policeService = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:SERVICEPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("police:servicePolice")
AddEventHandler("police:servicePolice",function(servicePolice)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") then
			vRP.removePermission(source,"Police")
			TriggerEvent("blipsystem:serviceExit",source)
			TriggerClientEvent("tencode:StatusService",source,false)
			TriggerClientEvent("Notify",source,"azul","Saiu de serviço.",3000)
			creativeLogs(servicelog,"```Passaporte: "..parseInt(user_id).."\nNome: "..identity.name.." "..identity.name2.."\nSaiu de serviço(Polícia).```")
			vRP.execute("vRP/upd_group",{ user_id = user_id, permiss = "Police", newpermiss = "waitPolice" })
			policeService = false
		elseif vRP.hasPermission(user_id,"waitPolice") then
			vRP.insertPermission(source,"Police")
			TriggerClientEvent("tencode:StatusService",source,true)
			TriggerEvent("blipsystem:serviceEnter",source,"Polícia",77)
			TriggerClientEvent("Notify",source,"azul","Entrou em serviço.",3000)
			creativeLogs(servicelog,"```Passaporte: "..parseInt(user_id).."\nNome: "..identity.name.." "..identity.name2.."\nEntrou em serviço(Polícia).```")
			vRP.execute("vRP/upd_group",{ user_id = user_id, permiss = "waitPolice", newpermiss = "Police" })
			policeService = true
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:UPDATESERVICESTATUS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("police:updateService")
AddEventHandler("police:updateService",function(status)
	policeService = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:CALLPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("police:callPolice")
AddEventHandler("police:callPolice",function()
	local source = source
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPositions(source)
	if user_id then
		local amountCops = vRP.numPermission("Police")
		if parseInt(#amountCops) <= 0 then
			TriggerClientEvent("Notify",source,"amarelo","Sistema indisponível no momento.",5000)
		else
			for k,v in pairs(amountCops) do
				async(function()
					TriggerClientEvent("NotifyPush",v,{ time = os.date("%H:%M:%S - %d/%m/%Y"), code = 31, title = "Ligação de um orelhão.", x = x, y = y, z = z, rgba = {0,150,90} })
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.initPrison(data)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local identity = vRP.getUserIdentity(parseInt(data.passaporte))
        local identity2 = vRP.getUserIdentity(parseInt(user_id))

        local nplayer = vRP.getUserSource(parseInt(data.passaporte))
        if nplayer then
            vRP.setFines(parseInt(data.passaporte),parseInt(data.fines),parseInt(user_id),tostring(data.reason))
            vRP.execute("vRP/set_prison",{ user_id = parseInt(data.passaporte), prison = parseInt(data.services), locate = parseInt(2) })
            vCLIENT.syncPrison(nplayer,1775.61,2495.13,50.43)
        end
		
		if identity then
		    TriggerClientEvent("Notify",source,"verde","<b>"..identity.name.." "..identity.name2.."</b> enviado para a prisão.",5000)
			creativeLogs(records,"```PASSPORT: "..parseInt(nuser_id).."\nNAME: "..identity.name.." "..identity.name2.."\nSERVICES: "..parseInt(services).."\nCRIMES: "..data.reason.."\nBY: "..identity2.name.." "..identity2.name2.."```")
		end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITFINE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.initFine(data)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local identity = vRP.getUserIdentity(parseInt(data.passaporte))
        local identity2 = vRP.getUserIdentity(parseInt(user_id))
		
		local nplayer = vRP.getUserSource(parseInt(data.passaporte))
        if nplayer then
            vRP.setFines(parseInt(data.passaporte),parseInt(data.fines),parseInt(user_id),tostring(data.reason))
			vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
        end
		
        if identity then
            TriggerClientEvent("Notify",source,"verde","<b>"..identity.name.." "..identity.name2.."</b> recebeu multa de <b>$"..vRP.format(parseInt(data.fines)).." dólares</b>.",5000)
			creativeLogs(fines,"```PASSPORT: "..parseInt(nuser_id).."\nNAME: "..identity.name.." "..identity.name2.."\nVALUE: $"..vRP.format(parseInt(value)).."\nBY: "..identity2.name.." "..identity2.name2.."```")
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.searchUser(data)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(data.passaporte)
    if data.passaporte and user_id then
        local name =  identity.name.." "..identity.name2
        local rg = identity.registration
        local phone = identity.phone
        local gender = "M"
        local fines = 0
        local consult = vRP.getFines(data.passaporte)
        for k,v in pairs(consult) do
            fines = parseInt(fines) + parseInt(v.price)
        end
--        local data = vRP.query("vRP/get_pol",{ user_id = data.passaporte })
        return {identity.register, name, rg , phone , gender, 10, data }
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("rprender",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") then
			local nuser_id = vRP.prompt(source,"Passaporte da pessoa:","")
			if nuser_id == "" then
				return
			end

			local services = vRP.prompt(source,"Serviços que a pessoa precisa fazer:","")
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
				TriggerClientEvent("Notify",source,"amarelo","<b>"..identity.name.." "..identity.name2.."</b> teve sua pena reduzida em <b>"..parseInt(services).."</b> serviços</b>.",3000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKKEY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkKey()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.wantedReturn(user_id) then
            return false
        end

        if vRP.tryGetInventoryItem(user_id,"key",1) then
            vCLIENT.stopPrison(source)
            vRP.execute("vRP/resgate_prison",{ user_id = parseInt(user_id) })
            return true
		else
			TriggerClientEvent("Notify",source,"vermelho","Você não tem uma <b>Chaves</b>.",3000)
        end
        return false
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.callPolice()
	local copAmount = vRP.numPermission("Police")
	for k,v in pairs(copAmount) do
		async(function()
			TriggerClientEvent("Notify",v,"amarelo","Encontramos um fugitivo do presídio.",5000)
		end)
	end
	return parseInt(race)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REDUCEPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.reducePrison()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.execute("vRP/rem_prison",{ user_id = parseInt(user_id), prison = 1 })

		local consult = vRP.getInformation(user_id)
		if parseInt(consult[1].prison) <= 0 then
			vCLIENT.stopPrison(source)
			TriggerClientEvent("Notify",source,"verde","Você está fora da prisão.",3000)
			
			if parseInt(consult[1].locate) == 2 then
				vRPclient.teleport(source,1843.63,2594.67,46.02)
			end
		else
			vCLIENT.syncPrison(source,parseInt(consult[1].locate))
			TriggerClientEvent("Notify",source,"azul","Ainda restam <b>"..parseInt(consult[1].prison).." serviços</b>.",3000)
			
			local random = math.random(1000)
			if parseInt(random) >= 500 then
				vRP.giveInventoryItem(user_id,"key",1,true)
			end
			
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
--------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	Citizen.Wait(1000)

	local consult = vRP.getInformation(user_id)
	if parseInt(consult[1].prison) <= 0 then
		return
	else
		TriggerClientEvent("Notify",source,"azul","Ainda restam <b>"..parseInt(consult[1].prison).." serviços</b>.",3000)
		vCLIENT.syncPrison(source,parseInt(consult[1].locate))
		vRPclient.teleport(source,1775.61,2495.13,50.43)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOGS
-----------------------------------------------------------------------------------------------------------------------------------------
function creativeLogs(webhook,message)
	if webhook ~= "" then
		PerformHttpRequest(webhook,function(err,text,headers) end,"POST",json.encode({ content = message }),{ ['Content-Type'] = "application/json" })
	end
end