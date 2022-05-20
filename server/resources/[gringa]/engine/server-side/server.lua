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
Tunnel.bindInterface("engine",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local vehFuels = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentFuel(price)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.paymentBank(user_id,parseInt(price)) then
			return true
		else
			TriggerClientEvent("Notify",source,"vermelho","Dólares insuficientes.",3000)
		end
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("engine:tryFuel")
AddEventHandler("engine:tryFuel",function(vehicle,fuel)
	vehFuels[vehicle] = fuel
	TriggerClientEvent("engine:syncFuel",-1,vehicle,fuel)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("engine:syncFuelPlayers",source,vehFuels)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local motos = {}
local carros = {}
local aluguel = {}
local stockVeh = {}
local lockReq = {}
local stealVehs = {}
local testDriveTime = 15000
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEGLOBALTHREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local vehicles = vRP.vehicleGlobal()
	for k,v in pairs(vehicles) do
		if v[4] == "cars" then
			table.insert(carros,{ k = k, name = v[1], price = v[3], chest = parseInt(v[2]), tax = parseInt((v[3])*(v[6])) })
		elseif v[4] == "bikes" then
			table.insert(motos,{ k = k, name = v[1], price = v[3], chest = parseInt(v[2]), tax = parseInt((v[3])*(v[6])) })
		elseif v[4] == "rental" then
			table.insert(aluguel,{ k = k, name = v[1], price = v[5], chest = parseInt(v[2]), tax = parseInt((v[3])*(v[6])) })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookdealership = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATIVELOGS
-----------------------------------------------------------------------------------------------------------------------------------------
function creativelogs(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARROS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Carros()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return carros
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOTOS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Motos()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return motos
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALUGUEL
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Aluguel()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return aluguel
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POSSUIDOS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Possuidos()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehList = {}
		local vehicles = vRP.query("vRP/get_vehicle",{ user_id = parseInt(user_id) })
		for k,v in pairs(vehicles) do
			table.insert(vehList,{ k = v.vehicle, work = v.work, name = vRP.vehicleName(v.vehicle), price = parseInt(vRP.vehiclePrice(v.vehicle)*0.7), chest = parseInt(vRP.vehicleChest(v.vehicle)), tax = parseInt(vRP.vehiclePrice(v.vehicle)*vRP.vehicleTax(v.vehicle)) })
		end
		
		return vehList
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUYDEALER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.buyDealer(name)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local vehName = tostring(name)
		local maxVehs = vRP.query("vRP/con_maxvehs",{ user_id = parseInt(user_id) })
		local myGarages = vRP.getInformation(user_id)
		if vRP.getPremium(user_id) then
			if parseInt(maxVehs[1].qtd) >= parseInt(myGarages[1].garage) then
				TriggerClientEvent("Notify",source,"amarelo","Você atingiu o máximo de veículos em sua garagem.",5000)
				return
			end
		else
			if parseInt(maxVehs[1].qtd) >= parseInt(myGarages[1].garage) then
				TriggerClientEvent("Notify",source,"amarelo","Você atingiu o máximo de veículos em sua garagem.",5000)
				return
			end
		end

		local vehicle = vRP.query("vRP/get_vehicles",{ user_id = parseInt(user_id), vehicle = vehName })
		if vehicle[1] then
			TriggerClientEvent("Notify",source,"amarelo","Você já possui um <b>"..vRP.vehicleName(vehName).."</b>.",5000)
			return
		else
			
			if vRP.vehicleType(name) == "rental" then
				local status = vRP.request(source,"Comprar veículo pagando <b>$"..vRP.format(parseInt(vRP.vehicleGems(name))).." Gemas</b>?",60)
				if status then
					if vRP.remGmsId(user_id,parseInt(vRP.vehicleGems(vehName))) then
						vRP.execute("vRP/add_vehicle",{ user_id = parseInt(user_id), vehicle = vehName, plate = vRP.generatePlateNumber(), phone = vRP.getPhone(user_id), work = tostring(false) })
						vRP.execute("vRP/set_rental_time",{ user_id = parseInt(user_id), vehicle = vehName, premiumtime = parseInt(os.time()+30*24*60*60) })
						TriggerClientEvent("Notify",source,"verde","Compra concluída.",3000)
						creativelogs(webhookdealership,"```[NOME]: "..identity.name.." "..identity.name2.." \n[ID]: "..user_id.." \n[COMPROU CARRO VIP]: "..vRP.vehicleName(name).." [POR]: R$ "..vRP.format(parseInt(vRP.vehiclePrice(name)*0.75)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					else
						TriggerClientEvent("Notify",source,"vermelho","Gemas insuficientes.",5000)
					end
				end
			else
				local status = vRP.request(source,"Comprar veículo pagando <b>$"..vRP.format(parseInt(vRP.vehiclePrice(name))).." Dólares</b>?",60)
				if status then
					if vRP.paymentBank(user_id,parseInt(vRP.vehiclePrice(vehName))) then
						vRP.execute("vRP/add_vehicle",{ user_id = parseInt(user_id), vehicle = vehName, plate = vRP.generatePlateNumber(), phone = vRP.getPhone(user_id), work = tostring(false) })
						TriggerClientEvent("Notify",source,"verde","Compra concluída.",3000)
						creativelogs(webhookdealership,"```[NOME]: "..identity.name.." "..identity.name2.." \n[ID]: "..user_id.." \n[COMPROU CARRO NORMAL]: "..vRP.vehicleName(name).." [POR]: R$ "..vRP.format(parseInt(vRP.vehiclePrice(name)*0.75)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					else
						TriggerClientEvent("Notify",source,"vermelho","Dólares insuficientes.",5000)
					end
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELLDEALER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.sellDealer(name)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)	
	if user_id then
		if vRP.vehicleType(name) ~= nil or vRP.vehicleType(name) == "rental" then
			if not lockReq[user_id] or lockReq[user_id] <= os.time() then
				lockReq[user_id] = os.time() + 300
				local vehName = tostring(name)
				local getInvoice = vRP.getInvoice(user_id)
				if getInvoice[1] ~= nil then
					TriggerClientEvent("Notify",source,"amarelo","Encontramos faturas pendentes.",5000)
					return
				end
				
				vRP.execute("vRP/rem_srv_data",{ dkey = "custom:"..parseInt(user_id)..":"..vehName })
				vRP.execute("vRP/rem_srv_data",{ dkey = "chest:"..parseInt(user_id)..":"..vehName })
				vRP.execute("vRP/rem_vehicle",{ user_id = parseInt(user_id), vehicle = vehName })
				vRP.addBank(user_id,parseInt(vRP.vehiclePrice(name)*0.75))
				TriggerClientEvent("Notify",source,"verde","Venda concluida.",3000)
				creativelogs(webhookdealership,"ini```[NOME]: "..identity.name.." "..identity.name2.." \n[ID]: "..user_id.." \n[VENDEU]: "..vRP.vehicleName(name).." [POR]: R$ "..vRP.format(parseInt(vRP.vehiclePrice(name)*0.75)).." "..os.date("\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S").." \r```")
			else
				TriggerClientEvent("Notify",source,"azul","Aguarde 5 minutos para vender novamente.",5000)
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não pode vender este veículo.",5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.startDrive()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return testDriveTime
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.removeDrive()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return true
	end
end