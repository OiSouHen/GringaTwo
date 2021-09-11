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
			["amethyst"] = 43,
			["diamond"] = 97,
			["emerald"] = 125,
			["ruby"] = 52,
			["sapphire"] = 48,
			["turquoise"] = 33,
			["amber"] = 37
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
	["departamentFishs"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["bait"] = 7,
			["fishingrod"] = 725
		}
	},
	["fishingSell"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["shrimp"] = 50,
			["octopus"] = 45,
			["carp"] = 40
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
			["energetic"] = 15,
			["cola"] = 15,
			["soda"] = 15,
			["absolut"] = 20,
			["chandon"] = 20,
			["dewars"] = 20,
			["hennessy"] = 20
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
			["soda"] = 15
		}
	},
	["colaMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
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
			["toolbox"] = 500,
			["WEAPON_WRENCH"] = 725,
			["lockpick"] = 400,
			["tires"] = 275,
			["WEAPON_CROWBAR"] = 725
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
			["TOKEN_WEAPON_PISTOL"] = 3795,
			["TOKEN_WEAPON_PISTOL_MK2"] = 3775,
			["TOKEN_WEAPON_APPISTOL"] = 4775,
			["TOKEN_WEAPON_HEAVYPISTOL"] = 3750,
			["TOKEN_WEAPON_SNSPISTOL"] = 3225,
			["TOKEN_WEAPON_SNSPISTOL_MK2"] = 3795,
			["TOKEN_WEAPON_VINTAGEPISTOL"] = 2775,
			["TOKEN_WEAPON_PISTOL50"] = 5225,
			["TOKEN_WEAPON_REVOLVER"] = 4225,
			["TOKEN_WEAPON_COMBATPISTOL"] = 3250,
			["TOKEN_WEAPON_COMPACTRIFLE"] = 12225,
			["TOKEN_WEAPON_MICROSMG"] = 12225,
			["TOKEN_WEAPON_MINISMG"] = 12225,
			["TOKEN_WEAPON_SMG"] = 3250,
			["TOKEN_WEAPON_ASSAULTSMG"] = 12225,
			["TOKEN_WEAPON_GUSENBERG"] = 12225,
			["TOKEN_WEAPON_MACHINEPISTOL"] = 4775,
			["TOKEN_WEAPON_CARBINERIFLE"] = 5250,
			["TOKEN_WEAPON_CARBINERIFLE_MK2"] = 6250,
			["TOKEN_WEAPON_ASSAULTRIFLE"] = 17775,
			["TOKEN_WEAPON_ASSAULTRIFLE_MK2"] = 18775,
			["TOKEN_WEAPON_MUSKET"] = 2750,
			["TOKEN_WEAPON_SNIPERRIFLE"] = 6750,
			["TOKEN_WEAPON_PUMPSHOTGUN"] = 4250,
			["TOKEN_WEAPON_PUMPSHOTGUN_MK2"] = 16775,
			["TOKEN_WEAPON_SAWNOFFSHOTGUN"] = 10775
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
			table.insert(inventoryShop,{ price = parseInt(v), name = vRP.itemNameList(k), desc = vRP.itemDescList(k), tipo = vRP.itemTipoList(k), unity = vRP.itemUnityList(k), economy = vRP.itemEconomyList(k), index = vRP.itemIndexList(k), key = k, weight = vRP.itemWeightList(k) })
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
									TriggerClientEvent("Notify",source,"vermelho","Você já possui esse tipo de item.",5000) return
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