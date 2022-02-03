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
Tunnel.bindInterface("skinshop",cRP)
vCLIENT = Tunnel.getInterface("skinshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSHARES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkShares()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if not vRP.wantedReturn(user_id) and not vRP.reposeReturn(user_id) then
            return true
        end
    end
	
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateClothes(clothes)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.setUData(user_id,"Clothings",clothes)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("skin",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") or vRP.hasPermission(user_id,"Owner") and args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.applySkin(nplayer,GetHashKey(args[2]))
				vRP.updateSelectSkin(parseInt(args[1]),GetHashKey(args[2]))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:DYNAMICMASK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:dynamicMask")
AddEventHandler("skinshop:dynamicMask",function(dynamicMask)
    TriggerClientEvent("skinshop:setMask",source)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:DYNAMICHAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:dynamicHat")
AddEventHandler("skinshop:dynamicHat",function(dynamicHat)
    TriggerClientEvent("skinshop:setHat",source)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:DYNAMICGLASSES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:dynamicGlasses")
AddEventHandler("skinshop:dynamicGlasses",function(dynamicGlasses)
    TriggerClientEvent("skinshop:setGlasses",source)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:dynamicTorso2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:dynamicTorso2")
AddEventHandler("skinshop:dynamicTorso2",function(dynamicTorso2)
    TriggerClientEvent("skinshop:setTorso2",source)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:DYNAMICARMS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:dynamicArms")
AddEventHandler("skinshop:dynamicArms",function(dynamicArms)
    TriggerClientEvent("skinshop:setArms",source)
end)