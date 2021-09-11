-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
vBARBER = Tunnel.getInterface("barbershop")
vTATTOOS = Tunnel.getInterface("tattoos")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("admin",cRP)
vCLIENT = Tunnel.getInterface("admin")
vHOMES = Tunnel.getInterface("homes")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookkick = "YOURWEEBHOOKHERE"
local webhookfac = "YOURWEEBHOOKHERE"
local webhookkeys = "YOURWEEBHOOKHERE"
local webhookcds = "YOURWEEBHOOKHERE"
local webhookblacklist = "YOURWEEBHOOKHERE"
local webhookgive = "YOURWEEBHOOKHERE"
local webhookban = "YOURWEEBHOOKHERE"
local webhookadminwl = "YOURWEEBHOOKHERE"
local webhookunwl = "YOURWEEBHOOKHERE"
local webhookadmingod = "YOURWEEBHOOKHERE"
local webhookinfernao = "YOURWEEBHOOKHERE"
local webhooktroxao = "YOURWEEBHOOKHERE"
local webhookaddcar = "YOURWEEBHOOKHERE"
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDWEBHOOKMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	local identity = vRP.getUserIdentity(user_id)
	if identity then
		vCLIENT.setDiscord(source,"#"..user_id.." "..identity.name.." "..identity.name2)
		TriggerClientEvent(source,"active:checkcam",true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ney",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if user_id then
        if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
            if args[1] then
                local nplayer = vRP.getUserSource(parseInt(args[1]))
                if nplayer then
                    TriggerClientEvent("ney",nplayer,args[1])
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("clearinv",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
        if args[1] then
            local tuser_id = tonumber(args[1])
            local tplayer = vRP.getUserSource(tonumber(tuser_id))
            local tplayerID = vRP.getUserId (tonumber(tplayer))
                if tplayerID ~= nil then
                local identity = vRP.getUserIdentity(user_id)
                    vRP.clearInventory(tuser_id)
					TriggerClientEvent("Notify",tuser_id,"amarelo","Seu inventário foi limpo.",5000)
                    TriggerClientEvent("Notify",source,"verde","Limpou inventario do ID "..args[1].."</b>.",5000)
                else
                    TriggerClientEvent("Notify",source,"vermelho","Algo deu errado.",3000)
            end
        else
            vRP.clearInventory(user_id)
            TriggerClientEvent("Notify",source,"amarelo","Você limpou seu inventário.",5000)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("skin",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"Owner") then
		TriggerClientEvent("skinmenu",args[1],args[2])
		TriggerClientEvent("Notify",source,"amarelo","Setada skin <b>"..args[2].."</b> no passaporte <b>"..parseInt(args[1]).."</b>.",5000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
			if args[1] and args[2] and vRP.itemNameList(args[1]) ~= nil then
				vRP.giveInventoryItem(user_id,args[1],parseInt(args[2]),true)
				SendWebhookMessage(webhookgive,"```prolog\n[ID]: "..user_id.."\n[PEGOU]: "..args[1].." \n[QUANTIDADE]: "..parseInt(args[2]).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDMONEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("addmoney",function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") and args[1] and args[2] then
            local identity = vRP.getUserIdentity(parseInt(args[1]))

            vRP.addBank(parseInt(args[1]),parseInt(args[2]))
            TriggerClientEvent("Notify",source,"verde","Dado <b>$"..args[2].." dólares</b> para <b>"..identity.name.." ["..args[1].."]</b>",5000)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMINDEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("admindebug",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or  vRP.hasPermission(user_id,"Admin") then
			TriggerClientEvent("ToggleDebug",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("plate",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") and args[1] and args[2] and args[3] then
			vRP.execute("vRP/update_plate_vehicle",{ user_id = parseInt(args[1]), vehicle = args[2], plate = args[3] })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("addcar",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") and args[1] and args[2] then
			vRP.execute("vRP/add_vehicle",{ user_id = parseInt(args[1]), vehicle = args[2], plate = vRP.generatePlateNumber(), phone = vRP.getPhone(args[1]), work = tostring(false) })
			TriggerClientEvent("Notify",args[1],"azul","Recebido <b>"..args[2].."</b> em sua garagem.",5000)
			TriggerClientEvent("Notify",source,"amarelo","Adicionado <b>"..args[2].."</b> na garagem de ID <b>"..args[1].."</b>.",10000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAPUZ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hood",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") and args[1] then
			TriggerClientEvent("hud:toggleHood",source,args[1])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.enablaNoclip()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
			vRPclient.noClip(source)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kick",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") and parseInt(args[1]) > 0 then
			vRP.kick(parseInt(args[1]),"Você foi expulso da cidade.")
			SendWebhookMessage(webhookkick,"```prolog\n[ID]: "..user_id.."\n[KICKOU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ban",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") and parseInt(args[1]) > 0 then
			local identity = vRP.getUserIdentity(parseInt(args[1]))
			if identity then
				vRP.kick(user_id,"Você foi banido da Cidade.")
				vRP.execute("vRP/set_banned",{ steam = tostring(identity.steam), banned = 1 })
				SendWebhookMessage(webhookban,"```prolog\n[ID]: "..user_id.." \n[BANIU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("wl",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
			vRP.execute("vRP/set_whitelist",{ steam = tostring(args[1]), whitelist = 1 })
			SendWebhookMessage(webhookadminwl,"```prolog\n[ID]: "..user_id.."\n[APROVOU WL]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNWL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unwl",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") and parseInt(args[1]) > 0 then
			local identity = vRP.getUserIdentity(parseInt(args[1]))
			if identity then
				vRP.kick(user_id,"Você perdeu a sua Whitelist na Cidade.")
				vRP.execute("vRP/set_whitelist",{ steam = tostring(identity.steam), whitelist = 0 })
				SendWebhookMessage(webhookunwl,"```prolog\n[ID]: "..user_id.."\n[RETIROU WL]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VIPCOINS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("gems",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") and parseInt(args[1]) > 0 and parseInt(args[2]) > 0 then
			local identity = vRP.getUserIdentity(parseInt(args[1]))
			if identity then
				vRP.addGmsId(args[1],args[2])
				TriggerClientEvent("Notify",source,"amarelo","Entregado <b>"..args[2].." Gemas</b> para ["..args[1].."]<b>"..identity.name.."</b>.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unban",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") and parseInt(args[1]) > 0 then
			local identity = vRP.getUserIdentity(parseInt(args[1]))
			if identity then
				vRP.execute("vRP/set_banned",{ steam = tostring(identity.steam), banned = 0 })
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpcds",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
			local fcoords = vRP.prompt(source,"Cordenadas:","")
			if fcoords == "" then
				return
			end

			local coords = {}
			for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
				table.insert(coords,parseInt(coord))
			end
			vRPclient.teleport(source,coords[1] or 0,coords[2] or 0,coords[3] or 0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cds",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
			local x,y,z,h = vRPclient.getPositions(source)
			vRP.prompt(source,"Cordenadas:",x..","..y..","..z..","..h)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("group",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") then
			if not vRP.hasPermission(parseInt(args[1]),tostring(args[2])) then
				vRP.insertPermission(parseInt(args[1]),tostring(args[2]))
				vRP.execute("vRP/add_group",{ user_id = parseInt(args[1]), permiss = tostring(args[2]) })
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ungroup",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") then
			if vRP.hasPermission(parseInt(args[1]),tostring(args[2])) then
				vRP.removePermission(parseInt(args[1]),tostring(args[2]))
				vRP.execute("vRP/del_group",{ user_id = parseInt(args[1]), permiss = tostring(args[2]) })
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tptome",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") and parseInt(args[1]) > 0 then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.teleport(nplayer,vRPclient.getPositions(source))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpto",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") and parseInt(args[1]) > 0 then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.teleport(source,vRPclient.getPositions(nplayer))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpway",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
			vCLIENT.teleportWay(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMBO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limbo",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRPclient.getHealth(source) <= 101 then
			vCLIENT.teleportLimbo(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hash",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") then
			local vehicle = vRPclient.nearVehicle(source,7)
			if vehicle then
				vCLIENT.vehicleHash(source,vehicle)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELNPCS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("delnpcs",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
			vCLIENT.deleteNpcs(source)
			TriggerClientEvent("Notify",source,"amarelo","NPCs próximos deletados.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tuning",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
			TriggerClientEvent("admin:vehicleTuning",source)
			TriggerClientEvent("Notify",source,"amarelo","Veículo tunado.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cone",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"Admin") or vRP.hasPermission(user_id,"Police") or vRP.hasPermission(user_id,"Paramedic") then
		TriggerClientEvent("cone",source,args[1])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARREIRA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("barreira",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"Admin") or vRP.hasPermission(user_id,"Police") or vRP.hasPermission(user_id,"Paramedic") then
		TriggerClientEvent("barreira",source,args[1])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIXALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fixall",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
			local vehicle,vehNet = vRPclient.vehList(source,11)
			if vehicle then
			    TriggerClientEvent("inventory:repairTires",-1,vehNet,true)
				TriggerClientEvent("inventory:repairVehicle",-1,vehNet,true)
				TriggerClientEvent("Notify",source,"amarelo","Veículo totalmente arrumado.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIXCAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fixcar",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
			local vehicle,vehNet = vRPclient.vehList(source,11)
			if vehicle then
				TriggerClientEvent("inventory:repairVehicle",-1,vehNet,true)
				TriggerClientEvent("Notify",source,"amarelo","Lataria e Motor arrumados.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIXTIRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fixtires",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
			local vehicle,vehNet = vRPclient.vehList(source,11)
			if vehicle then
				TriggerClientEvent("inventory:repairTires",-1,vehNet,true)
				TriggerClientEvent("Notify",source,"amarelo","Pneus arrumados.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:CLEARAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:clearArea")
AddEventHandler("admin:clearArea",function(clearArea)
	local user_id = vRP.getUserId(source)
	if user_id then
		local x,y,z = vRPclient.getPositions(source)
		TriggerClientEvent("syncarea",-1,x,y,z,100)
		TriggerClientEvent("Notify",source,"amarelo","Área próxima limpada.",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONLINES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("onlines",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
		local users = vRP.getUsers()
		local players = ""
		local quantidade = 0
		for k,v in pairs(users) do
			if k ~= #users then
				players = players..", "
			end
			players = players..k
			quantidade = quantidade + 1
		end

		TriggerClientEvent("chatMessage",source,"IDS Onlines:",{1, 136, 0},players)
		TriggerClientEvent("Notify",source,"amarelo","Atualmente <b>"..quantidade.."</b> onlines.",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.buttonTxt()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
			local x,y,z,h = vRPclient.getPositions(source)
			vRP.updateTxt(user_id..".txt",x..","..y..","..z..","..h)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("announce",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
			local message = vRP.prompt(source,"Mensagem:","")
			if message == "" then
				return
			end
			TriggerClientEvent("Notify",-1,"default",message,60000)
			TriggerClientEvent("sounds:source",-1,"announce",0.5)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("itemall",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") then
			local users = vRP.getUsers()
			for k,v in pairs(users) do
				vRP.giveInventoryItem(parseInt(k),tostring(args[1]),parseInt(args[2]),true)
			end
		end
	end
end)