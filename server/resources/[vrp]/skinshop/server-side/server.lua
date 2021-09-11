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
-- GETUSEMASK
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getUseMask()
    local user_id = vRP.getUserId(source)
    local action = args[1]
    if user_id then
        if action then
            if action == false then
                local item,texture = vCLIENT.getMask(source)
                TriggerClientEvent("skinshop:setMask",source,{ item,texture })
            elseif action == true then
                TriggerClientEvent("skinshop:setMask",source)
            end
        else
            TriggerClientEvent("skinshop:setMask",source)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSEHAT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getUseHat()
    local user_id = vRP.getUserId(source)
    local action = args[1]
    if user_id then
        if action then
            if action == false then
                local item,texture = vCLIENT.getHat(source)
                TriggerClientEvent("skinshop:setHat",source,{ item,texture })
            elseif action == true then
                TriggerClientEvent("skinshop:setHat",source)
            end
        else
            TriggerClientEvent("skinshop:setHat",source)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSEGLASSES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getUseGlasses()
    local user_id = vRP.getUserId(source)
    local action = args[1]
    if user_id then
        if action then
            if action == false then
                local item,texture = vCLIENT.getGlasses(source)
                TriggerClientEvent("skinshop:setGlasses",source,{ item,texture })
            elseif action == true then
                TriggerClientEvent("skinshop:setGlasses",source)
            end
        else
            TriggerClientEvent("skinshop:setGlasses",source)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSEGLOVES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getUseGloves()
    local user_id = vRP.getUserId(source)
    local action = args[1]
    if user_id then
        if action then
            if action == false then
                local item,texture = vCLIENT.getGloves(source)
                TriggerClientEvent("skinshop:setArms",source,{ item,texture })
            elseif action == true then
                TriggerClientEvent("skinshop:setArms",source)
            end
        else
            TriggerClientEvent("skinshop:setArms",source)
        end
    end
end