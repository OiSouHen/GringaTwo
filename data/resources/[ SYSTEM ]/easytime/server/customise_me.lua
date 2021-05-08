local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
yRP = {}
Tunnel.bindInterface("easytime",yRP)

Config.Locales = {
    ['BR'] = {
        ['invalid_permissions'] = 'Você não tem permissões para isso.',
    }
}

function Notification(source, message)
    if Config.ServerNotification_Type == 'notify' then
	   TriggerEvent("Notify","car-mechanic","<div style='opacity: 0.7;'><i>Mensagem da Mecânica</i></div>"..message,5000)
    end
end