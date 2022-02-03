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
Tunnel.bindInterface("inspect",cRP)
vCLIENT = Tunnel.getInterface("inspect")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local wbhsaquearshop = "https://discord.com/api/webhooks/880338361120866314/DmBYV5FJsGOuEAcSjVfRkXANv5L9T1oed49c06KX9VD-oNtyeBrO5ynnh7gST-supv9l"
local wbhsaqueartake = "https://discord.com/api/webhooks/880318407759777832/1neUoxXgUeBWRL5c7UWJ3LeKF7Igjy14LMcOKlA9rQKYOdrVrwLPiMraUq2-2tHh6x7s"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local opened = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVISTAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("revistar",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		local nplayer = vRPclient.nearestPlayer(source,5)
		if nplayer then
			local nuser_id = vRP.getUserId(nplayer)
			if not vRP.hasPermission(nuser_id,"Police") then
				if vRP.hasPermission(user_id,"Police") then
					vCLIENT.toggleCarry(nplayer,source)
					
					local weapons = vRPclient.replaceWeapons(nplayer)
					for k,v in pairs(weapons) do
						vRP.giveInventoryItem(nuser_id,k,1)
						if v.ammo > 0 then
							vRP.giveInventoryItem(nuser_id,vRP.itemAmmoList(k),v.ammo)
						end
					end
					
					opened[user_id] = parseInt(nuser_id)
					vCLIENT.openInspect(source)
				else
					if vRPclient.getHealth(nplayer) > 101 then
						local request = vRP.request(nplayer,"Você permite uma Revista?",30)
						if request then
							vRPclient._playAnim(nplayer,true,{"random@arrests@busted","idle_a"},true)
							vCLIENT.toggleCarry(nplayer,source)
							
							local weapons = vRPclient.replaceWeapons(nplayer)
							for k,v in pairs(weapons) do
								vRP.giveInventoryItem(nuser_id,k,1)
								if v.ammo > 0 then
									vRP.giveInventoryItem(nuser_id,vRP.itemAmmoList(k),v.ammo)
								end
							end

							opened[user_id] = parseInt(nuser_id)
							vCLIENT.openInspect(source)
						else
							TriggerClientEvent("Notify",source,"vermelho","Pedido de revista recusado.",5000)
						end
					else
						vCLIENT.toggleCarry(nplayer,source)
						
						local weapons = vRPclient.replaceWeapons(nplayer)
						for k,v in pairs(weapons) do
							vRP.giveInventoryItem(nuser_id,k,1)
							vRP.execute("vRP/del_weapon", { user_id = nuser_id, weapon = k })
							if v.ammo > 0 then
								vRP.giveInventoryItem(nuser_id,vRP.itemAmmoList(k),v.ammo)
							end
						end
						
						opened[user_id] = parseInt(nuser_id)
						vCLIENT.openInspect(source)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAQUEAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("saquear",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		local nplayer = vRPclient.nearestPlayer(source,5)
		if nplayer then
			local nuser_id = vRP.getUserId(nplayer)
			if vRPclient.getHealth(nplayer) <= 101 then
				vRPclient._playAnim(nplayer,true,{"random@arrests@busted","idle_a"},true)
				vCLIENT.toggleCarry(nplayer,source)
				
				local weapons = vRPclient.replaceWeapons(nplayer)
				for k,v in pairs(weapons) do
					vRP.giveInventoryItem(nuser_id,k,1)
					if v.ammo > 0 then
						vRP.giveInventoryItem(nuser_id,vRP.itemAmmoList(k),v.ammo)
					end
				end
				
				vRP.wantedTimer(user_id,120)
				opened[user_id] = parseInt(nuser_id)
				vCLIENT.openInspect(source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.openChest()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if opened[user_id] ~= nil then
			local ninventory = {}
			local myInv = vRP.getInventory(user_id)
			for k,v in pairs(myInv) do
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

					if porcentage < 0 then
						porcentage = porcentage*-1
					end

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
				v.unity = vRP.itemUnityList(v.item)
				v.economy = vRP.itemEconomyList(v.item)
				v.peso = vRP.itemWeightList(v.item)
				v.index = vRP.itemIndexList(v.item)
				v.key = v.item
				v.slot = k

				ninventory[k] = v
			end

			local uinventory = {}
			local othInv = vRP.getInventory(opened[user_id])
			for k,v in pairs(othInv) do
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
					
					if porcentage < 0 then
						porcentage = porcentage*-1
					end
					
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
				v.unity = vRP.itemUnityList(v.item)
				v.economy = vRP.itemEconomyList(v.item)
				v.peso = vRP.itemWeightList(v.item)
				v.index = vRP.itemIndexList(v.item)
				v.key = v.item
				v.slot = k

				uinventory[k] = v
			end

			local identity = vRP.getUserIdentity(user_id)
			return ninventory,uinventory,vRP.computeInvWeight(user_id),vRP.getBackpack(user_id),vRP.computeInvWeight(opened[user_id]),vRP.getBackpack(opened[user_id]),{ identity.name.." "..identity.name2,user_id,parseInt(identity.bank),parseInt(vRP.getGmsId(user_id)),identity.phone,identity.registration }
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inspect:populateSlot")
AddEventHandler("inspect:populateSlot",function(itemName,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
			vRP.giveInventoryItem(user_id,itemName,amount,false,target)
			TriggerClientEvent("inspect:Update",source,"updateChest")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inspect:updateSlot")
AddEventHandler("inspect:updateSlot",function(itemName,slot,target,amount)
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

		TriggerClientEvent("inspect:Update",source,"updateChest")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUMSLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inspect:sumSlot")
AddEventHandler("inspect:sumSlot",function(itemName,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local inv = vRP.getInventory(user_id)
		if inv then
			if inv[tostring(target)] and inv[tostring(target)].item == itemName then
				if vRP.tryGetInventoryItem(opened[user_id],itemName,amount,false,slot) then
					vRP.giveInventoryItem(user_id,itemName,amount,false,target)
					TriggerClientEvent("inspect:Update",source,"updateChest")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUM2SLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inspect:sum2Slot")
AddEventHandler("inspect:sum2Slot",function(itemName,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local inv = vRP.getInventory(opened[user_id])
		if inv[tostring(target)] and inv[tostring(target)].item == item then
			if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
				vRP.giveInventoryItem(opened[user_id],itemName,amount,false,target)
				TriggerClientEvent("inspect:Update",source,"updateChest")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.storeItem(itemName,slot,amount,target)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		if user_id then
			if vRP.computeInvWeight(opened[user_id]) + vRP.itemWeightList(itemName) * parseInt(amount) <= vRP.getBackpack(opened[user_id]) then
				if vRP.itemSubTypeList(itemName) then
					if vRP.getInventoryItemAmount(opened[user_id],itemName) > 0 then
						TriggerClientEvent("Notify",source,"amarelo","O jogador já possui esse tipo de item.",5000)
					else
						local durability = vRP.getInventoryItemDurability(user_id,itemName)
						if vRP.tryGetInventoryItem(user_id,itemName,amount,true,slot) then
							vRP.giveInventoryItem(opened[user_id],itemName,amount,false,target,parseInt(durability))
							TriggerClientEvent("inspect:Update",source,"updateChest")
						end
					end
				else
					if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
						vRP.giveInventoryItem(opened[user_id],itemName,amount,true,target)
						TriggerClientEvent("inspect:Update",source,"updateChest")
					end
				end
			else
				TriggerClientEvent("Notify",source,"negado","Mochila cheia.",5000)
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.takeItem(itemName,slot,amount,target)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		if user_id then
			if vRP.computeInvWeight(user_id) + vRP.itemWeightList(itemName) * parseInt(amount) <= vRP.getBackpack(user_id) then
				if vRP.itemSubTypeList(itemName) then
					if vRP.getInventoryItemAmount(user_id,itemName) > 0 then
						TriggerClientEvent("Notify",source,"negado","Você já possui esse tipo de item.",5000)
					else
						local durability = vRP.getInventoryItemDurability(opened[user_id],itemName)
						if vRP.tryGetInventoryItem(opened[user_id],itemName,amount,true,slot) then
							vRP.giveInventoryItem(user_id,itemName,amount,false,target,parseInt(durability))
							TriggerClientEvent("inspect:Update",source,"updateChest")
						end
					end
				else
					if vRP.tryGetInventoryItem(opened[user_id],itemName,amount,true,slot) then
						vRP.giveInventoryItem(user_id,itemName,amount,false,target)
						TriggerClientEvent("inspect:Update",source,"updateChest")
					end
				end
			else
				TriggerClientEvent("Notify",source,"negado","Mochila cheia.",5000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETINSPECT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.resetInspect()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local nplayer = vRPclient.nearestPlayer(source,5)
		if nplayer then
			vRPclient._stopAnim(nplayer,false)
			vCLIENT.toggleCarry(nplayer,source)
		end

		if opened[user_id] ~= nil then
			opened[user_id] = nil
		end
		vRPclient._stopAnim(source,false)
	end
end