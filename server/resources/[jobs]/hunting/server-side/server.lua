local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_cacador",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
function emP.Quantidade()
    local source = source
    if quantidade[source] == nil then
        quantidade[source] = math.random(3)
    end
end

function emP.checkPayment(item)
    emP.Quantidade()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.getToken(user_id) > 0 then
            TriggerClientEvent("Notify",source,"importante","Não estamos contratando pessoas com <b>Ficha Criminal</b>, caso queira trabalhar<br>conosco procure as autoridades e efetue a limpeza da mesma.",10000)
            return false
        end

        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(item)*parseInt(quantidade[source]) <= vRP.getInventoryMaxWeight(user_id) then
            vRP.giveInventoryItem(user_id,item,parseInt(quantidade[source]))
            if math.random(100) >= 98 then
                vRP.giveInventoryItem(user_id,"etiqueta",1)
            end
            quantidade[source] = nil
            return true
        end
    end
end