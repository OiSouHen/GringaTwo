local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_antdump")

src = {}
Tunnel.bindInterface("vrp_antdump",src)
Proxy.addInterface("vrp_antdump",src)

local loaded = {}
function src.pegaTrouxa()
    local source = source
    local user_id = vRP.getUserId(source)

    local fields2 = {}
    table.insert(fields2, { name = "ChomeInspector:", value = 'ID => **'..user_id..'** \nFoi pego tentando roubar o Html/Client da cidade.', inline = true });
    PerformHttpRequest("https://discord.com/api/webhooks/791739985316282408/wTZcK1j1TgL463h04qZXczHWq4fFaRW4RhmoJg2m97S5Qa32xFKkFTWPlYtlMZTfv2YV", function(err, text, headers) end, 'POST', json.encode({username = "In Game Log System", content = nil, embeds = {{color = 16754176, fields = fields2,}}}), { ['Content-Type'] = 'application/json' }) 
    print("Tentativa de Acesso ao Chrome Inspector! ID: "..user_id)
    vRP.kick(source,"Administração Mandou um Beijo <3")    
    vRP.setBanned(user_id,true)

end

