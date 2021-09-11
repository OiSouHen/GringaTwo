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
Tunnel.bindInterface("crafting",cRP)
vCLIENT = Tunnel.getInterface("crafting")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local craftList = {
	["lixeiroShop"] = {
		["list"] = {
			["aluminum"] = {
				["amount"] = 3,
				["destroy"] = true,
				["require"] = {
					["metalcan"] = 1
				}
			},
			["rubber"] = {
				["amount"] = 3,
				["destroy"] = true,
				["require"] = {
					["elastic"] = 1
				}
			},
			["copper"] = {
				["amount"] = 3,
				["destroy"] = true,
				["require"] = {
					["battery"] = 1
				}
			},
			["plastic"] = {
				["amount"] = 3,
				["destroy"] = true,
				["require"] = {
					["plasticbottle"] = 1
				}
			},
			["glass"] = {
				["amount"] = 3,
				["destroy"] = true,
				["require"] = {
					["glassbottle"] = 1
				}
			}
		}
	},
	["dressMaker"] = {
		["list"] = {
			["credential"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["dollars2"] = 250
				}
			},
			["lockpick"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 5,
					["plastic"] = 4,
					["rubber"] = 4,
					["glass"] = 4,
					["copper"] = 5
				}
			},
			["backpack"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["fabric"] = 25
				}
			},
			["fabric"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["animalpelt"] = 4,
					["rubber"] = 5
				}
			}
		}
	},
	["makeFoods"] = {
		["list"] = {
			["ketchup"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["emptybottle"] = 1,
					["tomato"] = 6
				}
			},
			["bananajuice"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["water"] = 1,
					["banana"] = 9
				}
			},
			["orangejuice"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["water"] = 1,
					["orange"] = 9
				}
			},
			["passionjuice"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["water"] = 1,
					["passion"] = 9
				}
			},
			["strawberryjuice"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["water"] = 1,
					["strawberry"] = 9
				}
			},
			["tangejuice"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["water"] = 1,
					["tange"] = 9
				}
			},
			["grapejuice"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["water"] = 1,
					["grape"] = 9
				}
			},
			["hamburger4"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["meatA"] = 1,
					["ketchup"] = 1,
					["bread"] = 2
				}
			},
			["hamburger2"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["meatB"] = 1,
					["ketchup"] = 1,
					["bread"] = 2
				}
			},
			["hamburger5"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["meatS"] = 1,
					["ketchup"] = 1,
					["bread"] = 2
				}
			},
			["hamburger3"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["meatC"] = 1,
					["ketchup"] = 1,
					["bread"] = 2
				}
			}
		}
	},
	["mechanicCraft"] = {
		["perm"] = "Mechanic",
		["list"] = {
			["ketchup"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["emptybottle"] = 1,
					["tomato"] = 6
				}
			}
		}
	},
	["fuelShop"] = {
		["list"] = {
			["WEAPON_PETROLCAN"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["dollars"] = 50
				}
			},
			["WEAPON_PETROLCAN_AMMO"] = {
				["amount"] = 250,
				["destroy"] = true,
				["require"] = {
					["dollars"] = 100
				}
			}
		}
	},
	["legalShop"] = {
		["list"] = {
			["lampshade"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["rubber"] = 2,
					["aluminum"] = 2,
					["glass"] = 2,
					["plastic"] = 2,
					["copper"] = 2
				}
			},
			["pliers"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["rubber"] = 3,
					["plastic"] = 3,
					["copper"] = 3
				}
			},
			["goldring"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["rubber"] = 2,
					["goldcoin"] = 4,
					["glass"] = 3,
					["plastic"] = 3,
					["copper"] = 3
				}
			},
			["silverring"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["silvercoin"] = 4,
					["glass"] = 3,
					["copper"] = 2
				}
			},
			["spray02"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 3,
					["rubber"] = 2,
					["plastic"] = 4
				}
			},
			["eraser"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["copper"] = 3,
					["rubber"] = 2,
					["plastic"] = 4
				}
			},
			["deck"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["copper"] = 3,
					["rubber"] = 2,
					["plastic"] = 3
				}
			},
			["bracelet"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["rubber"] = 2,
					["goldcoin"] = 4,
					["glass"] = 3,
					["plastic"] = 3,
					["copper"] = 3
				}
			},
			["slipper"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["rubber"] = 3,
					["fabric"] = 1
				}
			},
			["cup"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["rubber"] = 2,
					["aluminum"] = 2,
					["glass"] = 3,
					["silvercoin"] = 3
				}
			},
			["dices"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["copper"] = 1,
					["plastic"] = 4
				}
			},
			["spray01"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 3,
					["rubber"] = 2,
					["plastic"] = 4
				}
			},
			["spray03"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 3,
					["rubber"] = 2,
					["plastic"] = 4
				}
			},
			["spray04"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 3,
					["rubber"] = 2,
					["plastic"] = 4
				}
			},
			["floppy"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["copper"] = 2,
					["plastic"] = 5
				}
			},
			["domino"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["copper"] = 1,
					["plastic"] = 5
				}
			},
			["brush"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["copper"] = 3,
					["rubber"] = 2,
					["plastic"] = 4
				}
			},
			["horseshoe"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 3,
					["rubber"] = 2,
					["plastic"] = 4
				}
			},
			["switch"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["copper"] = 1,
					["plastic"] = 3
				}
			},
			["legos"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["copper"] = 1,
					["rubber"] = 2,
					["plastic"] = 8
				}
			},
			["blender"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["copper"] = 3,
					["rubber"] = 2,
					["plastic"] = 4
				}
			},
			["mouse"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["copper"] = 3,
					["rubber"] = 2,
					["plastic"] = 4
				}
			},
			["ominitrix"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["copper"] = 1,
					["rubber"] = 2,
					["plastic"] = 8
				}
			},
			["pan"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["copper"] = 2,
					["rubber"] = 2,
					["glass"] = 3,
					["plastic"] = 3,
					["aluminum"] = 3
				}
			},
			["playstation"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["rubber"] = 3,
					["glass"] = 3,
					["plastic"] = 3,
					["aluminum"] = 2
				}
			},
			["watch"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["rubber"] = 2,
					["goldcoin"] = 4,
					["glass"] = 3,
					["plastic"] = 3,
					["copper"] = 3
				}
			},
			["rimel"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["rubber"] = 2,
					["plastic"] = 4,
					["copper"] = 3
				}
			},
			["soap"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["rubber"] = 2,
					["plastic"] = 3,
					["copper"] = 3
				}
			},
			["keyboard"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["rubber"] = 2,
					["plastic"] = 4,
					["copper"] = 3
				}
			},
			["sneakers"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["rubber"] = 3,
					["fabric"] = 1
				}
			},
			["brick"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["glass"] = 1,
					["rubber"] = 2,
					["plastic"] = 1
				}
			},
			["fan"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["copper"] = 3,
					["rubber"] = 2,
					["plastic"] = 4
				}
			},
			["dildo"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["copper"] = 3,
					["rubber"] = 2,
					["plastic"] = 4
				}
			},
			["xbox"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 2,
					["glass"] = 3,
					["plastic"] = 3,
					["copper"] = 2
				}
			},
			["cellphone"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["mbattery"] = 1,
					["nbcellphone"] = 1
				}
			}
		}
	},
	["blackMarket"] = {
		["list"] = {
			["heroine"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["meth"] = 1,
					["cocaine"] = 1,
					["ecstasy"] = 1,
					["lean"] = 1
				}
			}
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPERM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestPerm(craftType)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if vRP.wantedReturn(user_id) and vRP.reposeReturn(user_id) then
			return false
		end

		if craftList[craftType]["perm"] ~= nil then
			if not vRP.hasPermission(user_id,craftList[craftType]["perm"]) then
				return false
			end
		end

		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestCrafting(craftType)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local inventoryShop = {}
		for k,v in pairs(craftList[craftType]["list"]) do
			local craftList = {}
			for k,v in pairs(v.require) do
				table.insert(craftList,{ name = vRP.itemNameList(k), amount = v })
			end

			table.insert(inventoryShop,{ name = vRP.itemNameList(k), amount = parseInt(v.amount), index = vRP.itemIndexList(k), key = k, weight = vRP.itemWeightList(k), list = craftList })
		end

		local inventoryUser = {}
		local inv = vRP.getInventory(user_id)
		if inv then
			for k,v in pairs(inv) do
				if string.sub(v.item,1,9) == "toolboxes" then
					local advFile = LoadResourceFile("logsystem","toolboxes.json")
					local advDecode = json.decode(advFile)

					v.durability = advDecode[v.item]
				end

				v.amount = parseInt(v.amount)
				v.name = vRP.itemNameList(v.item)
				v.peso = vRP.itemWeightList(v.item)
				v.index = vRP.itemIndexList(v.item)
				v.key = v.item
				v.slot = k

				inventoryUser[k] = v
			end
		end

		return inventoryShop,inventoryUser,vRP.computeInvWeight(user_id),vRP.getBackpack(user_id),{ identity.name.." "..identity.name2,parseInt(user_id),parseInt(identity.bank),parseInt(vRP.getGmsId(user_id)),identity.phone,identity.registration }
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONCRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.functionCrafting(shopItem,shopType,shopAmount,slot)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if shopAmount == nil then shopAmount = 1 end
		if shopAmount <= 0 then shopAmount = 1 end

		if craftList[shopType]["list"][shopItem] then
			for k,v in pairs(craftList[shopType]["list"][shopItem]["require"]) do
				if vRP.getInventoryItemAmount(user_id,k) < parseInt(v*shopAmount) then
					return
				end
				Citizen.Wait(1)
			end

			for k,v in pairs(craftList[shopType]["list"][shopItem]["require"]) do
				vRP.removeInventoryItem(user_id,k,parseInt(v*shopAmount))
				Citizen.Wait(1)
			end

			if string.sub(shopItem,1,9) == "toolboxes" then
				local advAmount = 0

				repeat
					Citizen.Wait(1)
					advAmount = advAmount + 1
					local advFile = LoadResourceFile("logsystem","toolboxes.json")
					local advDecode = json.decode(advFile)
					local number = 0

					repeat
						Citizen.Wait(1)
						number = number + 1
					until advDecode[tostring("toolboxes"..number)] == nil

					advDecode[tostring("toolboxes"..number)] = 10
					vRP.giveInventoryItem(user_id,tostring("toolboxes"..number),1,false)
					SaveResourceFile("logsystem","toolboxes.json",json.encode(advDecode),-1)
				until advAmount == shopAmount
			else
				vRP.giveInventoryItem(user_id,shopItem,craftList[shopType]["list"][shopItem]["amount"]*shopAmount,false,slot)
			end
		end

		vCLIENT.updateCrafting(source,"requestCrafting")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONDESTROY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.functionDestroy(shopItem,shopType,shopAmount,slot)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if shopAmount == nil then shopAmount = 1 end
		if shopAmount <= 0 then shopAmount = 1 end

		if craftList[shopType]["list"][shopItem] then
			if craftList[shopType]["list"][shopItem]["destroy"] then
				if vRP.tryGetInventoryItem(user_id,shopItem,craftList[shopType]["list"][shopItem]["amount"]) then
					for k,v in pairs(craftList[shopType]["list"][shopItem]["require"]) do
						if parseInt(v) <= 1 then
							vRP.giveInventoryItem(user_id,k,1)
						else
							vRP.giveInventoryItem(user_id,k,v/2)
						end
						Citizen.Wait(1)
					end
				end
			end
		end

		vCLIENT.updateCrafting(source,"requestCrafting")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:populateSlot")
AddEventHandler("crafting:populateSlot",function(itemName,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
			vRP.giveInventoryItem(user_id,itemName,amount,false,target)
			vCLIENT.updateCrafting(source,"requestCrafting")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:updateSlot")
AddEventHandler("crafting:updateSlot",function(itemName,slot,target,amount)
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

		vCLIENT.updateCrafting(source,"requestCrafting")
	end
end)