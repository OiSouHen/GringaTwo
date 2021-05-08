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
cnVRP = {}
Tunnel.bindInterface("vrp_call",cnVRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDCODE
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.sendCode(service)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then

		local description = vRP.prompt(source,"Descrição do seu chamado:","")
		if description == "" then
			return
		end

		local x,y,z = vRPclient.getPositions(source)
		local identity = vRP.getUserIdentity(user_id)

		if parseInt(service) == 911 then
			players = vRP.numPermission("Police")
		elseif parseInt(service) == 112 then
			players = vRP.numPermission("Paramedic")
		elseif parseInt(service) == 443 then
			players = vRP.numPermission("Mechanic")	
		elseif parseInt(service) == 222 then
			players = vRP.numPermission("Taxi")
		end

	
		TriggerClientEvent("Notify",source,"sucesso","Chamado efetuado com sucesso, aguarde no local.",5000)

		local x,y,z = vRPclient.getPositions(source)
		local identity = vRP.getUserIdentity(user_id)
		for k,v in pairs(players) do
			local sourcecall = vRP.getUserSource(v)
			local identitys = vRP.getUserIdentity(v)
			if v and v ~= source then
				async(function()
				--	TriggerClientEvent("chatMessage",v,identity.name.." "..identity.name2,{107,182,84},description)
					local request = vRP.request(sourcecall,"Aceitar o chamado de <b>"..identity.name.." ("..description..")</b>?",30)
					if request then
						TriggerClientEvent("NotifyPush",sourcecall,{ time = os.date("%H:%M:%S - %d/%m/%Y"), text = description, code = 20, title = "Chamado", x = x, y = y, z = z, name = identity.name.." "..identity.name2, phone = identity.phone, rgba = {69,115,41} })
						if not answered then
							answered = true
							vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
							TriggerClientEvent("Notify",source,"importante","Chamado atendido por <b>"..identitys.name.." "..identitys.name2.."</b>, aguarde no local.",10000)
						else
							TriggerClientEvent("Notify",sourcecall,"negado","Chamado já foi atendido por outra pessoa.",5000)
							vRPclient.playSound(sourcecall,"CHECKPOINT_MISSED","HUD_MINI_GAME_SOUNDSET")
						end
					end
				end)
			end
		end
	end
end