-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local customize = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEFAULTCUSTOM
-----------------------------------------------------------------------------------------------------------------------------------------
for i = 0,19 do
	customize[i] = { 1,0 }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id, source)
	local data = vRP.getUserDataTable(user_id)
	if data then
		if data.customization then
			data.customization = nil
		end

		if data.position then
			if data.position.x == nil or data.position.y == nil or data.position.z == nil then
				data.position = { x = -26.9, y = -145.5, z = 56.98 }
			end 
		else
			data.position = { x = -26.9, y = -145.5, z = 56.98 }
		end
		vRPclient.teleport(source,data.position.x,data.position.y,data.position.z+0.5)

		if data.skin then
			vRPclient.applySkin(source, data.skin)
		end

		if data.health then
			vRPclient.setHealth(source,data.health)
			vRPclient.setArmour(source,data.armour)
			TriggerClientEvent("statusHunger",source,data.hunger)
			TriggerClientEvent("statusThirst",source,data.thirst)
			TriggerClientEvent("statusStress",source,data.stress)
		end

		if data.inventorys == nil then
			data.inventorys = {}
		end

		if data.weaps then
			vRPclient.giveWeapons(source,data.weaps,true)
		end

		vRPclient.playerReady(source)

		Wait(1000)

		local playerData = vRP.getUData(user_id,"Clothings")
		local resultData = json.decode(playerData)
		if resultData == nil then
			resultData = "clean"
		end
		
		TriggerClientEvent("skinshop:skinData",source,resultData)

        local consult = vRP.getUData(user_id,"Tattoos")
        local result = json.decode(consult)
		
        if result then
            TriggerClientEvent("tattoos:apply",source,result)
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPOSITIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.updatePositions(x,y,z)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data then
			data.position = { x = tvRP.mathLegth(x), y = tvRP.mathLegth(y), z = tvRP.mathLegth(z) }
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MATHLEGTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.mathLegth(n)
	return math.ceil(n*100)/100
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEOBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryDeleteObject")
AddEventHandler("tryDeleteObject",function(index)
	TriggerClientEvent("syncDeleteEntity",-1,index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryDeleteEntity")
AddEventHandler("tryDeleteEntity",function(index)
	TriggerClientEvent("syncDeleteEntity",-1,index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYCLEANENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryCleanEntity")
AddEventHandler("tryCleanEntity",function(index)
	TriggerClientEvent("syncCleanEntity",-1,index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GRIDCHUNK
-----------------------------------------------------------------------------------------------------------------------------------------
function gridChunk(x)
	return math.floor((x + 8192) / 128)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOCHANNEL
-----------------------------------------------------------------------------------------------------------------------------------------
function toChannel(v)
	return (v.x << 8) | v.y
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETGRIDZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getGridzone(x,y)
	local gridChunk = vector2(gridChunk(x),gridChunk(y))
	return toChannel(gridChunk)
end