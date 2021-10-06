-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("chest",cRP)
vCLIENT = Tunnel.getInterface("chest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local chestOpen = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
local chest = {
	["Police"] = { 350,"Police" },
	["Police"] = { 350,"Police" },
	["Police"] = { 350,"Police" },
	["Police"] = { 350,"Police" },
	["Corrections"] = { 100,"Police" },
	["Paramedic"] = { 250,"Paramedic" },
	["Paramedic"] = { 250,"Paramedic" },
	["Paramedic"] = { 250,"Paramedic" },
	["Mechanic"] = { 500,"Mechanic" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINTPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkIntPermissions(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.wantedReturn(parseInt(user_id)) then
			return false
		end

		if vRP.hasPermission(parseInt(user_id),chest[chestName][2]) then
			chestOpen[user_id] = chestName
			return true
		end
	end
	
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.chestClose()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if chestOpen[user_id] then
			chestOpen[user_id] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.openChest()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local myinventory = {}
		local mychestopen = {}
		local mychestname = chestOpen[parseInt(user_id)]
		if mychestname ~= nil then

			local inv = vRP.getInventory(parseInt(user_id))
			if inv then
				for k,v in pairs(inv) do
					if string.sub(v.item,1,9) == v.item then
						local advFile = LoadResourceFile("logsystem","toolboxes.json")
						local advDecode = json.decode(advFile)

						v.durability = advDecode[v.item]
					end
					
					if v.item and v.timestamp then
						local actualTime = os.time()
						local finalTime = v.timestamp
						local durabilityInSeconds = vRP.itemDurabilityList(v.item)
						local startTime = (v.timestamp - durabilityInSeconds)
						
						local actualTimeInSeconds = (actualTime - startTime)
						local porcentage = (actualTimeInSeconds/durabilityInSeconds)-1
						if porcentage < 0 then porcentage = porcentage*-1 end
						if porcentage <= 0.0 then
							porcentage = 0.0
						elseif porcentage >= 100.0 then
							porcentage = 100.0
						end
						
						if porcentage then
							v.durability = porcentage
						end
					end

					v.amount = parseInt(v.amount)
					v.name = vRP.itemNameList(v.item)
					v.desc = vRP.itemDescList(v.item)
					v.tipo = vRP.itemTipoList(v.item)
					v.color = vRP.itemColor(v.item)
					v.unity = vRP.itemUnityList(v.item)
					v.economy = vRP.itemEconomyList(v.item)
					v.peso = vRP.itemWeightList(v.item)
					v.index = vRP.itemIndexList(v.item)
					v.key = v.item
					v.slot = k

					myinventory[k] = v
				end
			end

			local data = vRP.getSData("chest:"..mychestname)
			local sdata = json.decode(data) or {}
			if data then
				for k,v in pairs(sdata) do
					table.insert(mychestopen,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), desc = vRP.itemDescList(k), tipo = vRP.itemTipoList(k), index = vRP.itemIndexList(k), unity = vRP.itemUnityList(k), economy = vRP.itemEconomyList(k), key = k, peso = vRP.itemWeightList(k) })
				end
			end

			return myinventory,mychestopen,vRP.computeInvWeight(user_id),vRP.getBackpack(user_id),vRP.computeChestWeight(sdata),chest[mychestname][1],{ identity.name.." "..identity.name2,parseInt(user_id),identity.phone,identity.registration }
		end
	end
	
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
local noStore = {
	["water"] = true,
	["dirtywater"] = true,
	["coffee"] = true,
	["hamburger"] = true,
	["cola"] = true,
	["tacos"] = true,
	["fries"] = true,
	["soda"] = true,
	["hotdog"] = true,
	["sandwich"] = true,
	["chocolate"] = true,
	["donut"] = true,
	["ritmoneury"] = true,
	["sinkalmy"] = true,
	["absolut"] = true,
	["chandon"] = true,
	["dewars"] = true,
	["hennessy"] = true,
	["identity"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:populateSlot")
AddEventHandler("chest:populateSlot",function(itemName,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
			vRP.giveInventoryItem(user_id,itemName,amount,false,target)
			TriggerClientEvent("chest:Update",source,"updateChest")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:updateSlot")
AddEventHandler("chest:updateSlot",function(itemName,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		local inv = vRP.getInventory(user_id)
		if inv then
			if inv[tostring(slot)] and inv[tostring(target)] and inv[tostring(slot)].item == inv[tostring(target)].item then
				if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
					vRP.giveInventoryItem(user_id,itemName,amount,false,target)
				end
			else
				vRP.swapSlot(user_id,slot,target)
			end
		end

		TriggerClientEvent("chest:Update",source,"updateChest")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:sumSlot")
AddEventHandler("chest:sumSlot",function(itemName,slot,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local inv = vRP.getInventory(user_id)
		if inv then
			if inv[tostring(slot)] and inv[tostring(slot)].item == itemName then
				if vRP.tryChestItem(user_id,"chest:"..tostring(chestOpen[parseInt(user_id)]),itemName,amount,slot) then
					TriggerClientEvent("chest:Update",source,"updateChest")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.storeItem(itemName,slot,amount)
	if itemName then
		local source = source
		local user_id = vRP.getUserId(source)
		if user_id then
			if noStore[itemName] then
				TriggerClientEvent("Notify",source,"importante","Você não pode armazenar este item em baús.",500)
				return
			end

			if vRP.storeChestItem(user_id,"chest:"..tostring(chestOpen[parseInt(user_id)]),itemName,amount,chest[tostring(chestOpen[parseInt(user_id)])][1],slot) then
				TriggerClientEvent("chest:Update",source,"updateChest")
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.takeItem(itemName,slot,amount)
	if itemName then
		local source = source
		local user_id = vRP.getUserId(source)
		if user_id then
			if vRP.tryChestItem(user_id,"chest:"..tostring(chestOpen[parseInt(user_id)]),itemName,amount,slot) then
				TriggerClientEvent("chest:Update",source,"updateChest")
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	if chestOpen[user_id] then
		chestOpen[user_id] = nil
	end
end)