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
Tunnel.bindInterface("shops",cRP)
vCLIENT = Tunnel.getInterface("shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local shops = {
	["departamentStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
		    ["absolut"] = 15,
			["notepad"] = 10,
			["coffee"] = 20,
			["chandon"] = 15,
			["chocolate"] = 15,
			["cigarette"] = 10,
			["cola"] = 15,
			["dewars"] = 15,
			["energetic"] = 15,
			["emptybottle"] = 30,
			["hamburger"] = 25,
			["hennessy"] = 15,
			["lighter"] = 175,
			["bread"] = 5,
			["sandwich"] = 15,
			["soda"] = 15,
			["tacos"] = 22
		}
	},
	["fishDepartament"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["chocolate"] = 15,
			["bait"] = 4,
			["fishingrod"] = 725
		}
	},
	["ammunationStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["WEAPON_BAT"] = 975,
			["WEAPON_MACHETE"] = 975,
			["WEAPON_FLASHLIGHT"] = 675,
			["WEAPON_HATCHET"] = 975,
			["WEAPON_BATTLEAXE"] = 975,
			["WEAPON_STONE_HATCHET"] = 975,
			["WEAPON_HAMMER"] = 725,
			["GADGET_PARACHUTE"] = 475,
			["WEAPON_KNUCKLE"] = 975,
			["WEAPON_GOLFCLUB"] = 975,
			["WEAPON_POOLCUE"] = 975
		}
	},
	["pharmacyStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["adrenaline"] = 975,
			["analgesic"] = 105,
			["bandage"] = 225,
			["gauze"] = 175,
			["medkit"] = 525,
			["ritmoneury"] = 475,
			["sinkalmy"] = 325
		}
	},
	["pharmacyParamedic"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Paramedic",
		["list"] = {
			["adrenaline"] = 675,
			["analgesic"] = 55,
			["bandage"] = 105,
			["gauze"] = 105,
			["medkit"] = 225,
			["ritmoneury"] = 275,
			["sinkalmy"] = 120
		}
	},
	["premiumStore"] = {
		["mode"] = "Buy",
		["type"] = "Premium",
		["list"] = {
			["premium01"] = 15,
			["premium02"] = 25,
			["premium03"] = 35,
			["premium04"] = 45,
			["premiumplate"] = 25,
			["premiumname"] = 25,
			["premiumgarage"] = 25,
			["premiumpersonagem"] = 25,
			["gemstone"] = 1
		}
	},
	["minerShop"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["amethyst"] = 25,
			["diamond"] = 55,
			["emerald"] = 75,
			["ruby"] = 35,
			["sapphire"] = 30,
			["turquoise"] = 15,
			["amber"] = 20
		}
	},
	["huntingStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["whistle"] = 325,
			["WEAPON_SWITCHBLADE"] = 525,
			["WEAPON_SNIPERRIFLE_AMMO"] = 9,
			["WEAPON_SNIPERRIFLE"] = 7250,
			["WEAPON_MUSKET_AMMO"] = 7,
			["WEAPON_MUSKET"] = 3250
		}
	},
	["huntingSell"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["banana"] = 6,
			["meatA"] = 40,
			["meatB"] = 45,
			["meatC"] = 50,
			["meatS"] = 55,
			["horndeer"] = 225,
			["orange"] = 6,
			["passion"] = 6,
			["strawberry"] = 6,
			["animalpelt"] = 50,
			["tange"] = 6,
			["tomato"] = 8,
			["grape"] = 6
		}
	},
	["fishingSell"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["codfish"] = 24,
			["catfish"] = 24,
			["shrimp"] = 22,
			["carp"] = 20,
			["horsefish"] = 20,
			["goldenfish"] = 25,
			["pacu"] = 26,
			["pirarucu"] = 25,
			["octopus"] = 22,
			["tambaqui"] = 25,
			["tilapia"] = 22
		}
	},
	["recyclingSell"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["aluminum"] = 12,
			["binoculars"] = 135,
			["notepad"] = 5,
			["rubber"] = 8,
			["cellphone"] = 285,
			["nbcellphone"] = 285,
			["cellphonedamaged"] = 240,
			["mbattery"] = 22,
			["key"] = 45,
			["copper"] = 12,
			["rope"] = 435,
			["camera"] = 135,
			["firecracker"] = 50,
			["emptybottle"] = 15,
			["bait"] = 2,
			["lighter"] = 75,
			["newspaper"] = 15,
			["goldcoin"] = 10,
			["silvercoin"] = 5,
			["plastic"] = 8,
			["tires"] = 100,
			["rose"] = 15,
			["divingsuit"] = 485,
			["radio"] = 485,
			["fabric"] = 75,
			["teddy"] = 35,
			["titanium"] = 225,
			["vape"] = 2375,
			["fishingrod"] = 365,
			["glass"] = 8
		}
	},
	["registryStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["identity"] = 75
		}
	},
	["mercadoCentral"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["binoculars"] = 275,
			["cellphone"] = 575,
			["mbattery"] = 35,
			["hat"] = 225,
			["rope"] = 875,
			["camera"] = 275,
			["firecracker"] = 100,
			["gloves"] = 225,
			["mask"] = 275,
			["rose"] = 25,
			["radio"] = 975,
			["tablet"] = 125,
			["teddy"] = 75,
			["vape"] = 4750,
			["glasses"] = 225
		}
	},
	["mcFridge"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["absolut"] = 11,
			["chandon"] = 15,
			["cola"] = 15,
			["dewars"] = 10,
			["energetic"] = 15,
			["fries"] = 15,
			["hennessy"] = 13,
			["donut"] = 15,
			["sandwich"] = 15,
			["soda"] = 15
		}
	},
	["coffeeMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["coffee"] = 20
		}
	},
	["sodaMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["soda"] = 15,
			["cola"] = 15
		}
	},
	["donutMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["donut"] = 15,
			["chocolate"] = 15
		}
	},
	["burgerMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hamburger"] = 25
		}
	},
	["hotdogMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hotdog"] = 15
		}
	},
	["waterMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["water"] = 30
		}
	},
	["policeStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Police",
		["list"] = {
			["handcuff"] = 725,
			["WEAPON_HEAVYPISTOL"] = 3750,
			["WEAPON_HEAVYPISTOL_AMMO"] = 14,
			["WEAPON_NIGHTSTICK"] = 425,
			["vest"] = 475,
			["WEAPON_COMBATPISTOL"] = 3250,
			["WEAPON_COMBATPISTOL_AMMO"] = 15,
			["gdtkit"] = 35,
			["gsrkit"] = 35,
			["WEAPON_CARBINERIFLE"] = 5250,
			["WEAPON_CARBINERIFLE_AMMO"] = 20,
			["WEAPON_CARBINERIFLE_MK2"] = 6250,
			["WEAPON_CARBINERIFLE_MK2_AMMO"] = 23,
			["WEAPON_SMG"] = 3250,
			["WEAPON_SMG_AMMO"] = 16,
			["WEAPON_SAWNOFFSHOTGUN"] = 4250,
			["WEAPON_SAWNOFFSHOTGUN_AMMO"] = 17,
			["coptablet"] = 125,
			["WEAPON_STUNGUN"] = 2250
		}
	},
	["mechanicTools"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["toolbox"] = 475,
			["WEAPON_WRENCH"] = 725,
			["lockpick"] = 525,
			["tires"] = 325,
			["WEAPON_CROWBAR"] = 725
		}
	},
	["mechanicBuy"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["toolbox"] = 425,
			["lockpick"] = 325,
			["tires"] = 225
		}
	},
	["oxyStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["oxy"] = 65
		}
	},
	["heroineStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["heroine"] = 3400
		}
	},
	["weaponsStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["WEAPON_ASSAULTRIFLE"] = 40250,
			["WEAPON_ASSAULTRIFLE_MK2"] = 42250,
			["WEAPON_SNSPISTOL"] = 10250,
			["WEAPON_PISTOL50"] = 15250,
			["WEAPON_SMG_MK2"] = 30250,
			["WEAPON_PISTOL_MK2"] = 12250,
			["WEAPON_SPECIALCARBINE"] = 40250,
			["WEAPON_SNSPISTOL_MK2"] = 12250,
			["WEAPON_APPISTOL"] = 14250,
			["WEAPON_BULLPUPRIFLE_MK2"] = 42250,
			["WEAPON_PISTOL"] = 12250,
			["WEAPON_VINTAGEPISTOL"] = 10250,
			["WEAPON_REVOLVER"] = 15250,
			["WEAPON_SAWNOFFSHOTGUN"] = 26250,
			["WEAPON_PUMPSHOTGUN"] = 38250,
			["WEAPON_BULLPUPRIFLE"] = 40250,
			["WEAPON_SPECIALCARBINE_MK2"] = 42250,
			["WEAPON_MINISMG"] = 28250,
			["WEAPON_ASSAULTSMG"] = 30250,
			["WEAPON_ADVANCEDRIFLE"] = 40250,
			["WEAPON_MACHINEPISTOL"] = 14250,
			["WEAPON_GUSENBERG"] = 30250,
			["WEAPON_MICROSMG"] = 28250
		}
	},
	["ilegalRares"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["credential"] = 250,
			["WEAPON_ASSAULTRIFLE_AMMO"] = 44,
			["WEAPON_ASSAULTRIFLE_MK2_AMMO"] = 44,
			["WEAPON_SNSPISTOL_AMMO"] = 36,
			["WEAPON_PISTOL50_AMMO"] = 36,
			["WEAPON_SMG_MK2_AMMO"] = 40,
			["WEAPON_PISTOL_MK2_AMMO"] = 36,
			["WEAPON_SPECIALCARBINE_AMMO"] = 44,
			["WEAPON_SNSPISTOL_MK2_AMMO"] = 36,
			["WEAPON_APPISTOL_AMMO"] = 36,
			["WEAPON_BULLPUPRIFLE_MK2_AMMO"] = 44,
			["WEAPON_PISTOL_AMMO"] = 36,
			["WEAPON_VINTAGEPISTOL_AMMO"] = 36,
			["WEAPON_REVOLVER_AMMO"] = 36,
			["WEAPON_SAWNOFFSHOTGUN_AMMO"] = 50,
			["WEAPON_PUMPSHOTGUN_AMMO"] = 50,
			["WEAPON_BULLPUPRIFLE_AMMO"] = 44,
			["WEAPON_SPECIALCARBINE_MK2_AMMO"] = 44,
			["WEAPON_MINISMG_AMMO"] = 40,
			["WEAPON_ASSAULTSMG_AMMO"] = 40,
			["WEAPON_ADVANCEDRIFLE_AMMO"] = 44,
			["WEAPON_MACHINEPISTOL_AMMO"] = 36,
			["WEAPON_GUSENBERG_AMMO"] = 40,
			["WEAPON_MICROSMG_AMMO"] = 40
		}
	},
	["ilegalToys"] = {
		["mode"] = "Buy",
		["type"] = "Sell",
		["list"] = {
			["eraser"] = 75,
			["deck"] = 75,
			["vest2"] = 125,
			["credential"] = 250,
			["dices"] = 40,
			["floppy"] = 55,
			["domino"] = 65,
			["horseshoe"] = 85,
			["legos"] = 85,
			["ominitrix"] = 85
		}
	},
	["ilegalHouse"] = {
		["mode"] = "Buy",
		["type"] = "Sell",
		["list"] = {
			["lampshade"] = 115,
			["cup"] = 125,
			["switch"] = 35,
			["blender"] = 85,
			["mouse"] = 85,
			["pan"] = 125,
			["playstation"] = 100,
			["dish"] = 85,
			["keyboard"] = 85,
			["brick"] = 30,
			["fan"] = 85,
			["xbox"] = 100
		}
	},
	["ilegalCosmetics"] = {
		["mode"] = "Buy",
		["type"] = "Sell",
		["list"] = {
			["goldring"] = 125,
			["silverring"] = 85,
			["spray02"] = 85,
			["bracelet"] = 95,
			["slipper"] = 75,
			["spray01"] = 85,
			["spray03"] = 85,
			["spray04"] = 85,
			["brush"] = 85,
			["watch"] = 100,
			["rimel"] = 85,
			["soap"] = 75,
			["sneakers"] = 115,
			["dildo"] = 85
		}
	},
	["ilegalCriminal"] = {
		["mode"] = "Buy",
		["type"] = "Sell",
		["list"] = {
			["pliers"] = 75,
			["goldbar"] = 875,
			["card05"] = 625,
			["card01"] = 525,
			["card02"] = 525,
			["card03"] = 575,
			["card04"] = 425,
			["lockpick2"] = 75,
			["pager"] = 225,
			["pendrive"] = 575
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPERM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestPerm(shopType)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.wantedReturn(user_id) then
			return false
		end

		if shops[shopType]["perm"] ~= nil then
			if not vRP.hasPermission(user_id,shops[shopType]["perm"]) then
				return false
			end
		end
		
		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestShop(name)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local inventoryShop = {}
		for k,v in pairs(shops[name]["list"]) do
			table.insert(inventoryShop,{ price = parseInt(v), name = vRP.itemNameList(k), desc = vRP.itemDescList(k), tipo = vRP.itemTipoList(k), color = vRP.itemColor(k), unity = vRP.itemUnityList(k), economy = vRP.itemEconomyList(k), index = vRP.itemIndexList(k), key = k, weight = vRP.itemWeightList(k) })
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

				inventoryUser[k] = v
			end
		end

		return inventoryShop,inventoryUser,vRP.computeInvWeight(user_id),vRP.getBackpack(user_id),{ identity.name.." "..identity.name2,parseInt(user_id),parseInt(identity.bank),parseInt(vRP.getGmsId(user_id)),identity.phone,identity.registration }
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSHOPTYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getShopType(name)
    return shops[name].mode
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.functionShops(shopType,shopItem,shopAmount,slot)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if shopAmount == nil then shopAmount = 1 end
		if shopAmount <= 0 then shopAmount = 1 end
		local inv = vRP.getInventory(user_id)
		if inv then
			if shops[shopType]["mode"] == "Buy" then
				if vRP.computeInvWeight(parseInt(user_id)) + vRP.itemWeightList(shopItem) * parseInt(shopAmount) <= vRP.getBackpack(parseInt(user_id)) then
					if shops[shopType]["type"] == "Cash" then
						if shops[shopType]["list"][shopItem] then

							if vRP.itemSubTypeList(shopItem) then
								if vRP.getInventoryItemAmount(user_id,shopItem) > 0 then
									TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",5000) return
								end
							end
							
							if vRP.paymentBank(parseInt(user_id),parseInt(shops[shopType]["list"][shopItem]*shopAmount)) then
								if inv[tostring(slot)] then
									vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false)
								else
									vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false,slot)
								end						
							else
								TriggerClientEvent("Notify",source,"vermelho","Dólares insuficientes.",3000)
							end
						end
					elseif shops[shopType]["type"] == "Consume" then
						if vRP.tryGetInventoryItem(parseInt(user_id),shops[shopType]["item"],parseInt(shops[shopType]["list"][shopItem]*shopAmount)) then
							if inv[tostring(slot)] then
								vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false)
							else
								vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false,slot)
							end
						else
							TriggerClientEvent("Notify",source,"vermelho",""..vRP.itemNameList(shops[shopType]["item"]).." insuficientes.",3000)
						end
					elseif shops[shopType]["type"] == "Premium" then
						local identity = vRP.getUserIdentity(parseInt(user_id))
						local consult = vRP.getInfos(identity.steam)
						if parseInt(consult[1].gems) >= parseInt(shops[shopType]["list"][shopItem]*shopAmount) then
							if inv[tostring(slot)] then
								vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false)
							else
								vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false,slot)
							end
							vRP.remGmsId(user_id,parseInt(shops[shopType]["list"][shopItem]*shopAmount))
						else
							TriggerClientEvent("Notify",source,"vermelho","Gemas insuficientes.",3000)
						end
					end
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
				end
			elseif shops[shopType]["mode"] == "Sell" then
				if shops[shopType]["list"][shopItem] then
					if shops[shopType]["type"] == "Cash" then

						if vRP.tryGetInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),true,slot) then	
							vRP.giveInventoryItem(parseInt(user_id),"dollars",parseInt(shops[shopType]["list"][shopItem]*shopAmount),false)
						end
					elseif shops[shopType]["type"] == "Consume" then
						if vRP.tryGetInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),true,slot) then
							vRP.giveInventoryItem(parseInt(user_id),shops[shopType]["item"],parseInt(shops[shopType]["list"][shopItem]*shopAmount),false)
						end
					end
				end
			end
		end

		TriggerClientEvent("shops:Update",source,"requestShop")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:populateSlot")
AddEventHandler("shops:populateSlot",function(itemName,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
			vRP.giveInventoryItem(user_id,itemName,amount,false,target)
			TriggerClientEvent("shops:Update",source,"requestShop")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:updateSlot")
AddEventHandler("shops:updateSlot",function(itemName,slot,target,amount)
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

		TriggerClientEvent("shops:Update",source,"requestShop")
	end
end)