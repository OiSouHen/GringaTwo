local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_antdump",src)
Proxy.addInterface("vrp_antdump",src)
acClient = Tunnel.getInterface("vrp_antdump")

RegisterNUICallback("loadNuis", function(data, cb)
	acClient.pegaTrouxa()
end)


