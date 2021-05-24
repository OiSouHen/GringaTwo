local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "antdump")

src = {}
Tunnel.bindInterface("antdump",src)
Proxy.addInterface("antdump",src)

local loaded = {}
function src.pegaTrouxa()
    local source = source
    local user_id = vRP.getUserId(source)

    local fields2 = {}
    table.insert(fields2, { name = "ChomeInspector:", value = 'ID => **'..user_id..'** \nFoi pego tentando roubar o Html/Client da cidade.', inline = true });
    PerformHttpRequest("https://discord.com/api/webhooks/843507629535526984/h5cUbCNHF6Ie_L5mFr1JcvVvP8-KElfodsKBheLGlKe-Lqu8GVxzKVJ2BqKPU3aWtmKb", function(err, text, headers) end, 'POST', json.encode({username = "In Game Log System", content = nil, embeds = {{color = 16754176, fields = fields2,}}}), { ['Content-Type'] = 'application/json' }) 
    print("Tentativa de Acesso ao Chrome Inspector! ID: "..user_id)
    vRP.kick(source,"Administração Mandou um Beijo <3")    
    vRP.setBanned(user_id,true)

end

