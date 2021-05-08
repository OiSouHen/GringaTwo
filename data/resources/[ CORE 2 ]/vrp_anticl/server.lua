-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local webhookexit = "SEU HEBHOOK DE COMBAT LOG"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

RegisterCommand("combat", function(source, args, rawcmd)
    TriggerClientEvent("pixel_antiCL:show", source)
end)

AddEventHandler("playerDropped", function(reason)
    local source = source
    local crds = GetEntityCoords(GetPlayerPed(source))
    local id = source
    local identifier = vRP.getUserId(source)
    if identifier then
        TriggerClientEvent("pixel_anticl", -1, id, crds, identifier, reason)
        SendWebhookMessage(webhookexit,"```prolog\n[ID]: "..identifier.." \n[IP]: "..GetPlayerEndpoint(source).." \n[=========SAIU DO SERVIDOR=========]\nREASON: "..reason.."\n"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
    end
end)