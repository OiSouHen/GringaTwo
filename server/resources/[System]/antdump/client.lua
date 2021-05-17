local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("antdump",src)
Proxy.addInterface("antdump",src)
acClient = Tunnel.getInterface("antdump")

RegisterNUICallback("loadNuis", function(data, cb)
	acClient.pegaTrouxa()
end)


