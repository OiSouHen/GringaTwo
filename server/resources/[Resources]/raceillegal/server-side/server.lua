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
Tunnel.bindInterface("raceillegal",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local itemList = {
	{ item = "credential" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKCONSUME
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkConsume()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(itemList) do
			if vRP.tryGetInventoryItem(user_id,v.item,parseInt(1)) then

				if v.item == "credential" then
				    local x,y,z = vRPclient.getPositions(source)
					local copAmount = vRP.numPermission("Police")
					for k,v in pairs(copAmount) do
						async(function()
							TriggerClientEvent("NotifyPush",v,{ time = os.date("%H:%M:%S - %d/%m/%Y"), code = 20, title = "Denúncia de Corrida Ilegal", x = x, y = y, z = z, rgba = {41,76,119} })
						end)
					end
				end
				return true
			else
				TriggerClientEvent("Notify",source,"amarelo","Você precisa de uma <b>Credencial</b> para correr.",5000)
			end
		end
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISHRACES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.finishRaces()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
	local identity = vRP.getUserIdentity(user_id)
		vRP.wantedTimer(user_id,600)
		vRP.giveInventoryItem(user_id,"dollars2",math.random(3500,7000),true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACEILLEGAL:EXPLOSIVEPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("raceillegal:explosivePlayers")
AddEventHandler("raceillegal:explosivePlayers",function()
	local source = source
	TriggerEvent("blipsystem:serviceExit",source)
end)