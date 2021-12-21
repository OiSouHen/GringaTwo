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
local recordsLog = ""
local finesLog = ""
local serviceLog = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDWEBHOOKMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:SERVICEPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("police:servicePolice")
AddEventHandler("police:servicePolice",function(servicePolice)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if vRP.hasPermission(user_id,"Police") then
			vRP.removePermission(source,"Police")
			TriggerEvent("blipsystem:serviceExit",source)
			TriggerClientEvent("tencode:StatusService",source,false)
			TriggerClientEvent("Notify",source,"azul","Saiu de serviço.",3000)
			SendWebhookMessage(serviceLog,"```prolog\n[ID]: "..user_id.."\n[ATIVIDADE]: Saiu de serviço(Polícia)"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			vRP.execute("vRP/upd_group",{ user_id = user_id, permiss = "Police", newpermiss = "waitPolice" })
			TriggerClientEvent("police:updateService",source,false)
		elseif vRP.hasPermission(user_id,"waitPolice") then
			vRP.insertPermission(source,"Police")
			TriggerClientEvent("tencode:StatusService",source,true)
			TriggerEvent("blipsystem:serviceEnter",source,"Polícia",53)
			TriggerClientEvent("Notify",source,"azul","Entrou em serviço.",3000)
			SendWebhookMessage(serviceLog,"```prolog\n[ID]: "..user_id.."\n[ATIVIDADE]: Entrou em serviço(Polícia)"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			vRP.execute("vRP/upd_group",{ user_id = user_id, permiss = "waitPolice", newpermiss = "Police" })
			TriggerClientEvent("police:updateService",source,true)
		end
	end
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
					TriggerClientEvent("NotifyPush",v,{ time = os.date("%H:%M:%S - %d/%m/%Y"), code = 20, title = "Ligação de um orelhão.", criminal = "Precia-se de um policial ou uma viatura.", x = x, y = y, z = z, rgba = {0,150,90} })
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/tablet_prison","INSERT INTO vrp_prison(user_id,prison,multa,text,date,nuser_id) VALUES(@user_id,@prison,@multa,@text,@date,@nuser_id)")
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
			vRP.execute("vRP/tablet_prison",{ user_id = parseInt(data.passaporte), prison = parseInt(data.services), multa = parseInt(data.fines), text = tostring(data.reason), date = os.date("%d.%m.%Y").." ás "..os.date("%H:%M"), nuser_id = user_id })
            vCLIENT.syncPrison(nplayer,1679.94,2513.07,45.56)
        end
		
		if identity then
		    TriggerClientEvent("Notify",source,"verde","<b>"..identity.name.." "..identity.name2.."</b> enviado para a prisão.",5000)
			SendWebhookMessage(recordsLog,"```prolog\n[ID]: "..parseInt(nuser_id).."\n[NOME]: "..identity.name.." "..identity.name2.."\n[SERVIÇOS]: "..parseInt(services).."\n[CRIMES]: "..data.reason.."\n[POR]: "..identity2.name.." "..identity2.name2.." \r```")
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
			SendWebhookMessage(finesLog,"```prolog\n[ID]: "..parseInt(nuser_id).."\n[NOME]: "..identity.name.." "..identity.name2.."\n[VALOR]: $"..vRP.format(parseInt(value)).."\n[POR]: "..identity2.name.." "..identity2.name2.." \r```")
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/get_prison","SELECT * FROM vrp_prison WHERE user_id = @user_id ")
vRP.prepare("vRP/update_port","UPDATE vrp_users SET porte = @porte WHERE id = @user_id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHUSER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.searchUser(passaporte)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(parseInt(passaporte))
	local identity2 = vRP.getUserIdentity(parseInt(user_id))
	local rows = vRP.query("vRP/get_prison", { user_id = passaporte })
	local result = {}
	
	if identity then
		local fines = vRP.getFines(passaporte)
		local name = identity2.name.." "..identity2.name2
		local name2 = identity.name.." "..identity.name2
		local result2 = 0
		
		for k,v in pairs(fines) do
			result2 = result2 + v.price
		end
		
		result[1] = true
		result[2] = name
		result[3] = identity.phone
		result[4] = result2
		local porte = false
		
		if identity.porte == "sim" then
			porte = true
		end
		
		result[6] = porte
		result[5] = {}
		
		if rows then
			for k,v in pairs(rows) do
				local namepolice = vRP.getUserIdentity(v.nuser_id).name.." "..vRP.getUserIdentity(v.nuser_id).name2
				table.insert(result[5],{ police = namepolice, services = v.prison, fines = v.multa, date = v.date, text = v.text })
			end
		end
		
		if vRP.wantedReturn(passaporte) then
			result[7] = true
		else
			result[7] = false
		end
	else
		
		result[1] = false
	end
	
	return result
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updatePort(passaporte)
	local source = source
	local user_id = vRP.getUserId(source)
	
	if user_id then
		local identity = vRP.getUserIdentity(passaporte)

		if identity.porte == "não" then
			vRP.execute("vRP/update_port",{ user_id = passaporte, porte = "sim" })
		else
			vRP.execute("vRP/update_port",{ user_id = passaporte, porte = "não" })
		end
		TriggerClientEvent("police:Update",source,"reloadSearch",passaporte)
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
				TriggerClientEvent("Notify",source,"amarelo","<b>"..identity.name.." "..identity.name2.."</b> teve sua pena reduzida em <b>"..parseInt(services).."</b> serviços</b>.",5000)
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
				vRPclient.teleport(source,1846.49,2584.38,45.66)
			end
		else
			vCLIENT.syncPrison(source,parseInt(consult[1].locate))
			TriggerClientEvent("Notify",source,"azul","Ainda restam <b>"..parseInt(consult[1].prison).." serviços</b>.",5000)
			
		if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			Wait(1)
		else
			local random = math.random(100)
			if parseInt(random) >= 90 then
				vRP.giveInventoryItem(user_id,"glassbottle",math.random(3),true)
			elseif parseInt(random) >= 79 and parseInt(random) <= 89 then
				vRP.giveInventoryItem(user_id,"elastic",math.random(3),true)
			elseif parseInt(random) >= 68 and parseInt(random) <= 78 then
				vRP.giveInventoryItem(user_id,"plasticbottle",math.random(3),true)
			elseif parseInt(random) >= 57 and parseInt(random) <= 67 then
				vRP.giveInventoryItem(user_id,"metalcan",math.random(3),true)
			elseif parseInt(random) >= 46 and parseInt(random) <= 56 then
				vRP.giveInventoryItem(user_id,"battery",math.random(3),true)
			elseif parseInt(random) >= 40 and parseInt(random) <= 45 then
				vRP.giveInventoryItem(user_id,"scrapmetal",math.random(3),true)
			elseif parseInt(random) >= 34 and parseInt(random) <= 39 then
				vRP.giveInventoryItem(user_id,"wheatflour",math.random(1),true)
			elseif parseInt(random) >= 24 and parseInt(random) <= 29 then
				vRP.giveInventoryItem(user_id,"titanium",math.random(1),true)
			elseif parseInt(random) >= 18 and parseInt(random) <= 23 then
				vRP.giveInventoryItem(user_id,"syringe",math.random(1),true)
			elseif parseInt(random) >= 12 and parseInt(random) <= 17 then
				vRP.giveInventoryItem(user_id,"fabric",math.random(2),true)
			elseif parseInt(random) >= 6 and parseInt(random) <= 11 then
				vRP.giveInventoryItem(user_id,"keys",math.random(1),true)
			elseif parseInt(random) >= 1 and parseInt(random) <= 5 then
				vRP.giveInventoryItem(user_id,"WEAPON_MACHETE",math.random(1),true)
			end
			return true
		end
			
			vRP.upgradeStress(user_id,1)
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
		TriggerClientEvent("Notify",source,"azul","Ainda restam <b>"..parseInt(consult[1].prison).." serviços</b>.",5000)
		vCLIENT.syncPrison(source,parseInt(consult[1].locate))
		vRPclient.teleport(source,1679.94,2513.07,45.56)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATENAME
-----------------------------------------------------------------------------------------------------------------------------------------
local plateName = { "Lucas","James","John","Robert","Michael","William","David","Richard","Charles","Joseph","Thomas","Christopher","Daniel","Paul","Mark","Donald","George","Kenneth","Steven","Edward","Brian","Ronald","Anthony","Kevin","Jason","Matthew","Gary","Timothy","Jose","Larry","Jeffrey","Frank","Scott","Eric","Stephen","Andrew","Raymond","Gregory","Joshua","Jerry","Dennis","Walter","Patrick","Peter","Harold","Douglas","Henry","Carl","Arthur","Ryan","Roger","Joe","Juan","Jack","Albert","Jonathan","Justin","Terry","Gerald","Keith","Samuel","Willie","Ralph","Lawrence","Nicholas","Roy","Benjamin","Bruce","Brandon","Adam","Harry","Fred","Wayne","Billy","Steve","Louis","Jeremy","Aaron","Randy","Howard","Eugene","Carlos","Russell","Bobby","Victor","Martin","Ernest","Phillip","Todd","Jesse","Craig","Alan","Shawn","Clarence","Sean","Philip","Chris","Johnny","Earl","Jimmy","Antonio","Mary","Patricia","Linda","Barbara","Elizabeth","Jennifer","Maria","Susan","Margaret","Dorothy","Lisa","Nancy","Karen","Betty","Helen","Sandra","Donna","Carol","Ruth","Sharon","Michelle","Laura","Sarah","Kimberly","Deborah","Jessica","Shirley","Cynthia","Angela","Melissa","Brenda","Amy","Anna","Rebecca","Virginia","Kathleen","Pamela","Martha","Debra","Amanda","Stephanie","Carolyn","Christine","Marie","Janet","Catherine","Frances","Ann","Joyce","Diane","Alice","Julie","Heather","Teresa","Doris","Gloria","Evelyn","Jean","Cheryl","Mildred","Katherine","Joan","Ashley","Judith","Rose","Janice","Kelly","Nicole","Judy","Christina","Kathy","Theresa","Beverly","Denise","Tammy","Irene","Jane","Lori","Rachel","Marilyn","Andrea","Kathryn","Louise","Sara","Anne","Jacqueline","Wanda","Bonnie","Julia","Ruby","Lois","Tina","Phyllis","Norma","Paula","Diana","Annie","Lillian","Emily","Robin" }
local plateName2 = { "Hen","Smith","Johnson","Williams","Jones","Brown","Davis","Miller","Wilson","Moore","Taylor","Anderson","Thomas","Jackson","White","Harris","Martin","Thompson","Garcia","Martinez","Robinson","Clark","Rodriguez","Lewis","Lee","Walker","Hall","Allen","Young","Hernandez","King","Wright","Lopez","Hill","Scott","Green","Adams","Baker","Gonzalez","Nelson","Carter","Mitchell","Perez","Roberts","Turner","Phillips","Campbell","Parker","Evans","Edwards","Collins","Stewart","Sanchez","Morris","Rogers","Reed","Cook","Morgan","Bell","Murphy","Bailey","Rivera","Cooper","Richardson","Cox","Howard","Ward","Torres","Peterson","Gray","Ramirez","James","Watson","Brooks","Kelly","Sanders","Price","Bennett","Wood","Barnes","Ross","Henderson","Coleman","Jenkins","Perry","Powell","Long","Patterson","Hughes","Flores","Washington","Butler","Simmons","Foster","Gonzales","Bryant","Alexander","Russell","Griffin","Diaz","Hayes" }
local plateSave = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:RUNPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("police:runPlate")
AddEventHandler("police:runPlate",function()
    local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if vRP.hasPermission(user_id,"Police") then
			if vRPclient.getHealth(source) > 101 then
				local vehicle,vehNet,vehPlate = vRPclient.vehList(source,7)
				if vehicle then
					local plateUser = vRP.getVehiclePlate(vehPlate)
					if plateUser then
						local identity = vRP.getUserIdentity(plateUser)
						if identity then
							TriggerClientEvent("Notify",source,"default","<b>Passaporte:</b> "..identity.id.."<br><b>Nome:</b> "..identity.name.." "..identity.name2.."<br><b>Nº:</b> "..identity.phone,10000)
						end
					else
						if not plateSave[vehPlate] then
							plateSave[vehPlate] = { math.random(5000,9999),plateName[math.random(#plateName)].." "..plateName2[math.random(#plateName2)],vRP.generatePhoneNumber() }
						end
						
						TriggerClientEvent("Notify",source,"default","<b>Passaporte:</b> "..plateSave[vehPlate][1].."<br><b>Nome:</b> "..plateSave[vehPlate][2].."<br><b>Placa:</b> "..plateSave[vehPlate][3],10000)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:RUNARREST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("police:runArrest")
AddEventHandler("police:runArrest",function()
    local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if vRP.hasPermission(user_id,"Police") then
			if vRPclient.getHealth(source) > 101 then
				local vehicle,vehNet,vehPlate,vehName = vRPclient.vehList(source,7)
				if vehicle then
					local plateUser = vRP.getVehiclePlate(vehPlate)
					local inVehicle = vRP.query("vRP/get_vehicles",{ user_id = parseInt(plateUser), vehicle = vehName })
					if inVehicle[1] then
						if inVehicle[1].arrest <= 0 then
							vRP.execute("vRP/set_arrest",{ user_id = parseInt(plateUser), vehicle = vehName, arrest = 1, time = parseInt(os.time()) })
							TriggerClientEvent("Notify",source,"verde","Veículo detido.",3000)
						else
							TriggerClientEvent("Notify",source,"amarelo","O veículo já está detido.",5000)
						end
					end
				end
			end
		end
	end
end)