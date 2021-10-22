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
Tunnel.bindInterface("player",cRP)
vCLIENT = Tunnel.getInterface("player")
vTASKBAR = Tunnel.getInterface("taskbar")
vSKINSHOP = Tunnel.getInterface("skinshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local policeService = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHMENU:DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vehmenu:doors")
AddEventHandler("vehmenu:doors",function(doors)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
            local vehicle,vehNet = vRPclient.vehList(source,7)
            if vehicle then
                TriggerClientEvent("player:syncDoors",-1,vehNet,doors)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:WINSFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:winsFunctions")
AddEventHandler("player:winsFunctions",function(winsFunctions)
 	local user_id = vRP.getUserId(source)
 	if user_id then
 		if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
 			local vehicle,vehNet = vRPclient.vehList(source,7)
 			if vehicle then
 				TriggerClientEvent("player:syncWins",-1,vehNet,winsFunctions)
 			end
 		end
 	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:OUTFITFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:outfitFunctions")
AddEventHandler("player:outfitFunctions",function(outfitFunctions)
	local user_id = vRP.getUserId(source)
	if user_id then
	    if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
			vCLIENT.setRemoveoutfit(source)
	    end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NORTE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("norte",function(source,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.execute("vRP/update_nationality",{ id = user_id })
		TriggerClientEvent("Notify",source,"amarelo","Nacionalidade alterada para <b>Norte</b>.",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WECOLOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("wecolor",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if parseInt(args[1]) >= 0 and parseInt(args[1]) <= 7 then
			if vRP.getPremium(user_id) then
				vCLIENT.weColors(source,parseInt(args[1]))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WELUX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("welux",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getPremium(user_id) then
			vCLIENT.weLux(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMOTES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vCLIENT.getHandcuff(source) then
			if args[2] == "friend" then
				local identity = vRP.getUserIdentity(user_id)
				local nplayer = vRPclient.nearestPlayer(source,2)
				if nplayer then
					if vRPclient.getHealth(nplayer) > 101 and not vCLIENT.getHandcuff(nplayer) then
						local request = vRP.request(nplayer,"Aceitar animação de <b>"..identity.name.."?",60)
						if request then
							TriggerClientEvent("emotes",nplayer,args[1])
							TriggerClientEvent("emotes",source,args[1])
						end
					end
				end
			else
				TriggerClientEvent("emotes",source,args[1])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMOTES2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e2",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Paramedic") or vRP.hasPermission(user_id,"Police") or vRP.hasPermission(user_id,"Admin") then
			if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
				local nplayer = vRPclient.nearestPlayer(source,2)
				if nplayer then
					TriggerClientEvent("emotes",nplayer,args[1])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("premium",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		if identity then
			local consult = vRP.getInfos(identity.steam)
			if consult[1] and parseInt(os.time()) <= parseInt(consult[1].premium+24*consult[1].predays*60*60) then
				TriggerClientEvent("Notify",source,"azul",""..vRP.getTimers(parseInt(86400*consult[1].predays-(os.time()-consult[1].premium)))..".",10000)
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem benefícios ativos.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hood",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRPclient.getHealth(source) > 101 then
			local vehicle,vehNet = vRPclient.vehList(source,7)
			if vehicle then
				TriggerClientEvent("player:syncHood",-1,vehNet)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECEIVESALARY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:salary")
AddEventHandler("player:salary",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(parseInt(user_id),"premium01") then
			vRP.addBank(parseInt(user_id),525)
			TriggerClientEvent("Notify",source,"azul","Bônus de <b>$525</b> recebido.",5000)
		end
		
		if vRP.hasPermission(parseInt(user_id),"premium02") then
			vRP.addBank(parseInt(user_id),625)
			TriggerClientEvent("Notify",source,"azul","Bônus de <b>$625</b> recebido.",5000)
		end
		
		if vRP.hasPermission(parseInt(user_id),"premium03") then
			vRP.addBank(parseInt(user_id),725)
			TriggerClientEvent("Notify",source,"azul","Bônus de <b>$725</b> recebido.",5000)
		end
		
		if vRP.hasPermission(parseInt(user_id),"premium04") then
			vRP.addBank(parseInt(user_id),825)
			TriggerClientEvent("Notify",source,"azul","Bônus de <b>$825</b> recebido.",5000)
		end

		if vRP.hasPermission(parseInt(user_id),"Police") then
			vRP.addBank(parseInt(user_id),1235)
			TriggerClientEvent("Notify",source,"azul","Salário de <b>$1235</b> recebido.",5000)
		end

		if vRP.hasPermission(parseInt(user_id),"Mechanic") then
			vRP.addBank(parseInt(user_id),1085)
			TriggerClientEvent("Notify",source,"azul","Salário de <b>$1085</b> recebido.",5000)
		end

		if vRP.hasPermission(parseInt(user_id),"Paramedic") then
			vRP.addBank(parseInt(user_id),1475)
			TriggerClientEvent("Notify",source,"azul","Salário de <b>$1475</b> recebido.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETECHAR
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.deleteChar()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.execute("vRP/remove_characters",{ id = parseInt(user_id) })
		Citizen.Wait(1000)
		vRP.rejoinServer(source)
		Citizen.Wait(1000)
		TriggerClientEvent("spawn:setupChars",source)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("pr",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and args[1] then
		if vRP.hasPermission(user_id,"Police") then
			if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
				local identity = vRP.getUserIdentity(user_id)
				local police = vRP.numPermission("Police")
				for k,v in pairs(police) do
					async(function()
						TriggerClientEvent("chatMessage",v,identity.name.." "..identity.name2,{255,175,175},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hr",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and args[1] then
		if vRP.hasPermission(user_id,"Paramedic") then
			if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
				local identity = vRP.getUserIdentity(user_id)
				local police = vRP.numPermission("Paramedic")
				for k,v in pairs(police) do
					async(function()
						TriggerClientEvent("chatMessage",v,identity.name.." "..identity.name2,{255,175,175},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXTRAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("extras",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and args[1] then
		if vRP.hasPermission(user_id,"Police") and vRP.hasPermission("Paramedic") then
			if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
				vCLIENT.extraVehicle(args[1],source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CUFF
-----------------------------------------------------------------------------------------------------------------------------------------
local poCuff = {}
function cRP.cuffToggle()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") then
			if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) and poCuff[user_id] == nil then
				if not vRPclient.inVehicle(source) then
					local nplayer = vRPclient.nearestPlayer(source,2)
					if nplayer then
						if vCLIENT.getHandcuff(nplayer) then
							vCLIENT.toggleHandcuff(nplayer)
							vRPclient._stopAnim(nplayer,false)
							TriggerClientEvent("sounds:source",source,"uncuff",0.5)
							TriggerClientEvent("sounds:source",nplayer,"uncuff",0.5)
						else
							poCuff[user_id] = true
							
							local taskResult = vTASKBAR.taskHandcuff(nplayer)
							if not taskResult then
								vCLIENT.toggleHandcuff(nplayer)
								TriggerClientEvent("sounds:source",source,"cuff",0.5)
								TriggerClientEvent("sounds:source",nplayer,"cuff",0.5)
								vRPclient._playAnim(nplayer,true,{"mp_arresting","idle"},true)
							end
							
							poCuff[user_id] = nil
						end
					end
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFIRED
-----------------------------------------------------------------------------------------------------------------------------------------
local shotFired = {}
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(shotFired) do
			if shotFired[k] > 0 then
				shotFired[k] = v - 10
				if shotFired[k] <= 0 then
					shotFired[k] = nil
				end
			end
		end
		
		Citizen.Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOTSFIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.shotsFired()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if shotFired[user_id] == nil then
			if not vRP.hasPermission(user_id,"Police") then
				local distance = vCLIENT.shotDistance(source)

				if distance then
					shotFired[user_id] = 30
					local x,y,z = vRPclient.getPositions(source)
					local comAmount = vRP.numPermission("Police")
					for k,v in pairs(comAmount) do
						async(function()
							TriggerClientEvent("NotifyPush",v,{ code = 10, title = "Confronto em andamento.", x = x, y = y, z = z, criminal = "Disparos de arma de fogo.", blipColor = 6 })
						end)
					end
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARRY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.carryToggle()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") or vRP.hasPermission(user_id,"Paramedic") then
			if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
				local nplayer = vRPclient.nearestPlayer(source,2)
				if nplayer then
					vCLIENT.toggleCarry(nplayer,source)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARRY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("carregar2",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") or vRP.hasPermission(user_id,"Paramedic") then
			if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
				local nplayer = vRPclient.nearestPlayer(source,2)
				if nplayer then
					TriggerClientEvent("rope:toggleRope",source,nplayer)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("rv",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") or vRP.hasPermission(user_id,"Paramedic") or vRP.getInventoryItemAmount(user_id,"rope") >= 1 then
			if not vRPclient.inVehicle(source) then
				local vehicle,vehNet,vehPlate,vehName,vehLock = vRPclient.vehList(source,11)
				if vehicle then
					if vehLock ~= 1 then
						local nplayer = vRPclient.nearestPlayer(source,11)
						if nplayer then
							vCLIENT.removeVehicle(nplayer)
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cv",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") or vRP.hasPermission(user_id,"Paramedic") or vRP.getInventoryItemAmount(user_id,"rope") >= 1 then
			if not vRPclient.inVehicle(source) then
				local vehicle,vehNet,vehPlate,vehName,vehLock = vRPclient.vehList(source,11)
				if vehicle then
					if vehLock ~= 1 then
						local nplayer = vRPclient.nearestPlayer(source,2)
						if nplayer then
							vCLIENT.putVehicle(nplayer,args[1])
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("check",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") or vRP.hasPermission(user_id,"Admin") then
			if parseInt(args[1]) > 0 then
				local nuser_id = parseInt(args[1])
				local identity = vRP.getUserIdentity(nuser_id)
				if identity then
					local fines = 0
					local consult = vRP.getFines(nuser_id)
					for k,v in pairs(consult) do
						fines = parseInt(fines) + parseInt(v.price)
					end

					TriggerClientEvent("Notify",source,"default","<b>Passaporte:</b> "..identity.id.."<br><b>Nome:</b> "..identity.name.." "..identity.name2.."<br><b>RG:</b> "..identity.registration.."<br><b>Telefone:</b> "..identity.phone.."<br><b>Multas Pendentes:</b> $"..vRP.format(parseInt(fines)),30000)
				end
			else
				local nplayer = vRPclient.nearestPlayer(source,2)
				if nplayer then
					local nuser_id = vRP.getUserId(nplayer)
					if nuser_id then
						local identity = vRP.getUserIdentity(nuser_id)
						if identity then
							local fines = 0
							local consult = vRP.getFines(nuser_id)
							for k,v in pairs(consult) do
								fines = parseInt(fines) + parseInt(v.price)
							end

							TriggerClientEvent("Notify",source,"default","<b>Passaporte:</b> "..identity.id.."<br><b>Nome:</b> "..identity.name.." "..identity.name2.."<br><b>RG:</b> "..identity.registration.."<br><b>Telefone:</b> "..identity.phone.."<br><b>Multas Pendentes:</b> $"..vRP.format(parseInt(fines)),30000)
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
local preset = {
	["Police"] = {
		["1"] = {
			["homem"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 25, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 56, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 149, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 19, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			},
			["mulher"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 31, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 9, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 27, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 144, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 31, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			}
		},
		["2"] = {
			["homem"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 25, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 56, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 143, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 20, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			},
			["mulher"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 31, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 9, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 27, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 143, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 23, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			}
		},
		["3"] = {
			["homem"] = {
				["hat"] = { item = 13, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 25, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 56, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 74, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 19, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			},
			["mulher"] = {
				["hat"] = { item = 13, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 31, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 9, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 27, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 110, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 31, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			}
		},
		["4"] = {
			["homem"] = {
				["hat"] = { item = 13, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 25, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 56, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 24, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 20, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			},
			["mulher"] = {
				["hat"] = { item = 13, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 31, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 9, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 27, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 146, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 23, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			}
		},
		["5"] = {
			["homem"] = {
				["hat"] = { item = 13, texture = 2, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 25, texture = 2, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 56, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 200, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 20, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			},
			["mulher"] = {
				["hat"] = { item = 13, texture = 2, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 31, texture = 2, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 9, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 27, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 202, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 23, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			}
		}
	},
	["Paramedic"] = {
		["1"] = {
			["homem"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 20, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 7, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 96, texture = 1, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 32, texture = 7, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 126, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 79, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			},
			["mulher"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 23, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 7, texture = 3, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 101, texture = 1, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 58, texture = 7, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 96, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 91, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			}
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PRESETFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:presetFunctions")
AddEventHandler("player:presetFunctions",function(number)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if not vRP.wantedReturn(user_id) and not vRP.reposeReturn(user_id) then
			if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
				local model = vRPclient.getModelPlayer(source)
				if vRP.hasPermission(user_id,"Paramedic") and preset["Paramedic"][number] then
					if model == "mp_m_freemode_01" then
						TriggerClientEvent("updateRoupas",source,preset["Paramedic"][number]["homem"])
					elseif model == "mp_f_freemode_01" then
						TriggerClientEvent("updateRoupas",source,preset["Paramedic"][number]["mulher"])
					end
				elseif vRP.hasPermission(user_id,"Police") and preset["Police"][number] then
					if model == "mp_m_freemode_01" then
						TriggerClientEvent("updateRoupas",source,preset["Police"][number]["homem"])
					elseif model == "mp_f_freemode_01" then
						TriggerClientEvent("updateRoupas",source,preset["Police"][number]["mulher"])
					end
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTFIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("outfit",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.wantedReturn(user_id) and not vRP.reposeReturn(user_id) then
			if args[1] then
				if args[1] == "save" then
					local custom = vSKINSHOP.getCustomization(source)
					if custom then
						vRP.setSData("saveClothes:"..parseInt(user_id),json.encode(custom))
						TriggerClientEvent("Notify",source,"amarelo","Outfit salvo com sucesso.",3000)
					end
				end
			else
				local consult = vRP.getSData("saveClothes:"..parseInt(user_id))
				local result = json.decode(consult)
				if result then
					TriggerClientEvent("updateRoupas",source,result)
					TriggerClientEvent("Notify",source,"amarelo","Outfit aplicado com sucesso.",3000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREMIUMFIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("premiumfit",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.wantedReturn(user_id) and not vRP.reposeReturn(user_id) and vRP.getPremium(user_id) then
			if args[1] then
				if args[1] == "save" then
					local custom = vSKINSHOP.getCustomization(source)
					if custom then
						vRP.setSData("premClothes:"..parseInt(user_id),json.encode(custom))
						TriggerClientEvent("Notify",source,"amarelo","Premiumfit salvo com sucesso.",3000)
					end
				end
			else
				local consult = vRP.getSData("premClothes:"..parseInt(user_id))
				local result = json.decode(consult)
				if result then
					TriggerClientEvent("updateRoupas",source,result)
					TriggerClientEvent("Notify",source,"amarelo","Premiumfit aplicado com sucesso.",3000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WALKING
-----------------------------------------------------------------------------------------------------------------------------------------
local walking = {
	{ "move_m@alien" },
	{ "anim_group_move_ballistic" },
	{ "move_f@arrogant@a" },
	{ "move_m@brave" },
	{ "move_m@casual@a" },
	{ "move_m@casual@b" },
	{ "move_m@casual@c" },
	{ "move_m@casual@d" },
	{ "move_m@casual@e" },
	{ "move_m@casual@f" },
	{ "move_f@chichi" },
	{ "move_m@confident" },
	{ "move_m@business@a" },
	{ "move_m@business@b" },
	{ "move_m@business@c" },
	{ "move_m@drunk@a" },
	{ "move_m@drunk@slightlydrunk" },
	{ "move_m@buzzed" },
	{ "move_m@drunk@verydrunk" },
	{ "move_f@femme@" },
	{ "move_characters@franklin@fire" },
	{ "move_characters@michael@fire" },
	{ "move_m@fire" },
	{ "move_f@flee@a" },
	{ "move_p_m_one" },
	{ "move_m@gangster@generic" },
	{ "move_m@gangster@ng" },
	{ "move_m@gangster@var_e" },
	{ "move_m@gangster@var_f" },
	{ "move_m@gangster@var_i" },
	{ "anim@move_m@grooving@" },
	{ "move_f@heels@c" },
	{ "move_m@hipster@a" },
	{ "move_m@hobo@a" },
	{ "move_f@hurry@a" },
	{ "move_p_m_zero_janitor" },
	{ "move_p_m_zero_slow" },
	{ "move_m@jog@" },
	{ "anim_group_move_lemar_alley" },
	{ "move_heist_lester" },
	{ "move_f@maneater" },
	{ "move_m@money" },
	{ "move_m@posh@" },
	{ "move_f@posh@" },
	{ "move_m@quick" },
	{ "female_fast_runner" },
	{ "move_m@sad@a" },
	{ "move_m@sassy" },
	{ "move_f@sassy" },
	{ "move_f@scared" },
	{ "move_f@sexy@a" },
	{ "move_m@shadyped@a" },
	{ "move_characters@jimmy@slow@" },
	{ "move_m@swagger" },
	{ "move_m@tough_guy@" },
	{ "move_f@tough_guy@" },
	{ "move_p_m_two" },
	{ "move_m@bag" },
	{ "move_m@injured" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANDAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("andar",function(source,args,rawCommand)
	if args[1] then
		if vRPclient.getHealth(source) > 101 then
			vCLIENT.movementClip(source,walking[parseInt(args[1])][1])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FATURAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("faturas",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		local nuser_id = vRP.prompt(source,"Passaporte:","")
		if nuser_id == "" or parseInt(nuser_id) <= 0 then
			return
		end

		local price = vRP.prompt(source,"Valor da fatura:","")
		if price == "" or parseInt(price) <= 0 then
			return
		end

		local reason = vRP.prompt(source,"Descrição da fatura:","")
		if reason == "" then
			return
		end

		local nplayer = vRP.getUserSource(parseInt(nuser_id))
		if nplayer then
			local identity = vRP.getUserIdentity(user_id)
			local answered = vRP.request(nplayer,"Aceitar fatura no valor de <b>$"..vRP.format(parseInt(price)).." dólares</b>?",60)
			if answered then
				vRP.setInvoice(parseInt(nuser_id),parseInt(price),parseInt(user_id),tostring(reason))
				TriggerClientEvent("Notify",source,"verde","Fatura aceita.",3000)
			else
				TriggerClientEvent("Notify",source,"vermelho","Fatura rejeitada.",3000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand("extras",function(source,args,rawCommand)
	-- local user_id = vRP.getUserId(source)
	-- if user_id then
		-- if (vRP.hasPermission(user_id,"Police") or vRP.hasPermission(user_id,"Paramedic")) and parseInt(args[1]) > 0 then
			-- vCLIENT.toggleLivery(source,parseInt(args[1]))
		-- end
	-- end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("add",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if parseInt(args[2]) > 0 then
			if args[1] == "Police" then
				if vRP.hasPermission(user_id,"PolMaster") then
					vRP.execute("vRP/cle_group",{ user_id = parseInt(args[2]) })
					vRP.execute("vRP/add_group",{ user_id = parseInt(args[2]), permiss = tostring("waitPolice") })
					vRP.insertPermission(parseInt(args[2]),tostring("waitPolice"))
					TriggerClientEvent("Notify",source,"sucesso","Passaporte <b>"..vRP.format(parseInt(args[2])).."</b> adicionado com sucesso.",5000)
				end
			end

			if args[1] == "Paramedic" then
				if vRP.hasPermission(user_id,"ParMaster") then
					vRP.execute("vRP/cle_group",{ user_id = parseInt(args[2]) })
					vRP.execute("vRP/add_group",{ user_id = parseInt(args[2]), permiss = tostring("waitParamedic") })
					vRP.insertPermission(parseInt(args[2]),tostring("waitParamedic"))
					TriggerClientEvent("Notify",source,"sucesso","Passaporte <b>"..vRP.format(parseInt(args[2])).."</b> adicionado com sucesso.",5000)
				end
			end

			if args[1] == "Mechanic" then
				if vRP.hasPermission(user_id,"MecMaster") then
					vRP.execute("vRP/cle_group",{ user_id = parseInt(args[2]) })
					vRP.execute("vRP/add_group",{ user_id = parseInt(args[2]), permiss = tostring("waitMechanic") })
					vRP.insertPermission(parseInt(args[2]),tostring("waitMechanic"))
					TriggerClientEvent("Notify",source,"sucesso","Passaporte <b>"..vRP.format(parseInt(args[2])).."</b> adicionado com sucesso.",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("rem",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if parseInt(args[1]) > 0 then
			if vRP.hasPermission(user_id,"PolMaster") or vRP.hasPermission(user_id,"MecMaster") or vRP.hasPermission(user_id,"ParMaster") then
				vRP.execute("vRP/cle_group",{ user_id = parseInt(args[1]) })
				TriggerClientEvent("Notify",source,"sucesso","Passaporte <b>"..vRP.format(parseInt(args[1])).."</b> removido com sucesso.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("checktrunk",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRPclient.getHealth(source) > 101 and not vRPclient.inVehicle(source) and not vCLIENT.getHandcuff(source) then
			local nplayer = vRPclient.nearestPlayer(source,2)
			if nplayer then
				TriggerClientEvent("player:CheckTrunk",nplayer)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cam",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRPclient.getHealth(source) > 101 and vRP.hasPermission(user_id,"Police") then
			TriggerClientEvent("player:serviceCamera",source,tostring(args[1]))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETDISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
    local identity = vRP.getUserIdentity(user_id)
    if identity then
        vCLIENT.setDiscord(source,user_id.." - ".."Gringa Roleplay")
        TriggerClientEvent(source,"active:checkcam",true)
    end
end)