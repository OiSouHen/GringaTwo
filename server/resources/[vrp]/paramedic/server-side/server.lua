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
Tunnel.bindInterface("paramedic",cRP)
vCLIENT = Tunnel.getInterface("paramedic")
vSURVIVAL = Tunnel.getInterface("survival")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOKS
-----------------------------------------------------------------------------------------------------------------------------------------
local servicelog = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local paramedicService = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:SERVICEPARAMEDIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("paramedic:serviceParamedic")
AddEventHandler("paramedic:serviceParamedic",function(serviceParamedic)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(source)
	if user_id then
		if vRP.hasPermission(user_id,"Paramedic") then
			vRP.removePermission(source,"Paramedic")
			TriggerEvent("blipsystem:serviceExit",source)
			TriggerClientEvent("Notify",source,"azul","Saiu de serviço.",3000)
			creativeLogs(servicelog,"```Passaporte: "..parseInt(user_id).."\nNome: "..identity.name.." "..identity.name2.."\nSaiu de serviço(Paramédico).```")
			vRP.execute("vRP/upd_group",{ user_id = user_id, permiss = "Paramedic", newpermiss = "waitParamedic" })
			paramedicService = false
		elseif vRP.hasPermission(user_id,"waitParamedic") then
			vRP.insertPermission(source,"Paramedic")
			TriggerEvent("blipsystem:serviceEnter",source,"Paramédico",83)
			TriggerClientEvent("Notify",source,"azul","Entrou em serviço.",3000)
			creativeLogs(servicelog,"```Passaporte: "..parseInt(user_id).."\nNome: "..identity.name.." "..identity.name2.."\nEntrou em serviço(Paramédico).```")
			vRP.execute("vRP/upd_group",{ user_id = user_id, permiss = "waitParamedic", newpermiss = "Paramedic" })
			paramedicService = true
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:UPDATESERVICESTATUS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("paramedic:updateService")
AddEventHandler("paramedic:updateService",function(status)
	paramedicService = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:CALLPARAMEDIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("paramedic:callParamedic")
AddEventHandler("paramedic:callParamedic",function()
	local source = source
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPositions(source)
	if user_id then
		local amountMecs = vRP.numPermission("Paramedic")
		if parseInt(#amountMecs) <= 0 then
			TriggerClientEvent("Notify",source,"amarelo","Sistema indisponível no momento.",5000)
		else
			for k,v in pairs(amountMecs) do
				async(function()
					TriggerClientEvent("NotifyPush",v,{ time = os.date("%H:%M:%S - %d/%m/%Y"), code = 31, title = "Ligação de um orelhão.", x = x, y = y, z = z, rgba = {0,150,90} })
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BONES
-----------------------------------------------------------------------------------------------------------------------------------------
local bones = {
	[11816] = "Pelvis",
	[58271] = "Coxa Esquerda",
	[63931] = "Panturrilha Esquerda",
	[14201] = "Pe Esquerdo",
	[2108] = "Dedo do Pe Esquerdo",
	[65245] = "Pe Esquerdo",
	[57717] = "Pe Esquerdo",
	[46078] = "Joelho Esquerdo",
	[51826] = "Coxa Direita",
	[36864] = "Panturrilha Direita",
	[52301] = "Pe Direito",
	[20781] = "Dedo do Pe Direito",
	[35502] = "Pe Direito",
	[24806] = "Pe Direito",
	[16335] = "Joelho Direito",
	[23639] = "Coxa Direita",
	[6442] = "Coxa Direita",
	[57597] = "Espinha Cervical",
	[23553] = "Espinha Toraxica",
	[24816] = "Espinha Lombar",
	[24817] = "Espinha Sacral",
	[24818] = "Espinha Cocciana",
	[64729] = "Escapula Esquerda",
	[45509] = "Braco Esquerdo",
	[61163] = "Antebraco Esquerdo",
	[18905] = "Mao Esquerda",
	[18905] = "Mao Esquerda",
	[26610] = "Dedo Esquerdo",
	[4089] = "Dedo Esquerdo",
	[4090] = "Dedo Esquerdo",
	[26611] = "Dedo Esquerdo",
	[4169] = "Dedo Esquerdo",
	[4170] = "Dedo Esquerdo",
	[26612] = "Dedo Esquerdo",
	[4185] = "Dedo Esquerdo",
	[4186] = "Dedo Esquerdo",
	[26613] = "Dedo Esquerdo",
	[4137] = "Dedo Esquerdo",
	[4138] = "Dedo Esquerdo",
	[26614] = "Dedo Esquerdo",
	[4153] = "Dedo Esquerdo",
	[4154] = "Dedo Esquerdo",
	[60309] = "Mao Esquerda",
	[36029] = "Mao Esquerda",
	[61007] = "Antebraco Esquerdo",
	[5232] = "Antebraco Esquerdo",
	[22711] = "Cotovelo Esquerdo",
	[10706] = "Escapula Direita",
	[40269] = "Braco Direito",
	[28252] = "Antebraco Direito",
	[57005] = "Mao Direita",
	[58866] = "Dedo Direito",
	[64016] = "Dedo Direito",
	[64017] = "Dedo Direito",
	[58867] = "Dedo Direito",
	[64096] = "Dedo Direito",
	[64097] = "Dedo Direito",
	[58868] = "Dedo Direito",
	[64112] = "Dedo Direito",
	[64113] = "Dedo Direito",
	[58869] = "Dedo Direito",
	[64064] = "Dedo Direito",
	[64065] = "Dedo Direito",
	[58870] = "Dedo Direito",
	[64080] = "Dedo Direito",
	[64081] = "Dedo Direito",
	[28422] = "Mao Direita",
	[6286] = "Mao Direita",
	[43810] = "Antebraço Direito",
	[37119] = "Antebraço Direito",
	[2992] = "Cotovelo Direito",
	[39317] = "Pescoco",
	[31086] = "Cabeca",
	[12844] = "Cabeca",
	[65068] = "Rosto"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLEEDING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("sangramento",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"Paramedic") then
        local nplayer = vRPclient.nearestPlayer(source,3)
        if nplayer then
            TriggerClientEvent("resetBleeding",nplayer)
            TriggerClientEvent("Notify",source,"verde","Sangramento estancado.",3000)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("diagnostico",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"Paramedic") then
		local nplayer = vRPclient.nearestPlayer(source,5)
		if nplayer then
			local hurt = false
			local diagnostic,bleeding = vCLIENT.getDiagnostic(nplayer)
			if diagnostic then
				local damaged = {}
				for k,v in pairs(diagnostic) do
					damaged[k] = bones[k]
				end

				if next(damaged) then
					hurt = true
					TriggerClientEvent("drawInjuries",source,nplayer,damaged)
				end
			end

			local text = ""
			if bleeding > 4 then
				text = "- <b>Sangramento</b><br>"
			end

			if diagnostic.taser then
				text = text .. "- <b>Taser</b><br>"
			end

			if diagnostic.vehicle then
				text = text .. "- <b>Acidente com veículo</b><br>"
			end

			if text ~= "" then
				TriggerClientEvent("Notify",source,"amarelo","Status do paciente:<br>" .. text,5000)
			elseif not hurt then
				TriggerClientEvent("Notify",source,"verde","Status do paciente:<br>- <b>Nada encontrado</b>",3000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TREAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tratamento",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"Paramedic") then
		local nplayer = vRPclient.nearestPlayer(source,5)
		if nplayer then
			if not vSURVIVAL.deadPlayer(nplayer) then
				vSURVIVAL._startCure(nplayer)
				TriggerClientEvent("resetBleeding",nplayer)
				TriggerClientEvent("resetDiagnostic",nplayer)
				TriggerClientEvent("Notify",source,"amarelo","Tratamento iniciado.",3000)
			end
		end
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