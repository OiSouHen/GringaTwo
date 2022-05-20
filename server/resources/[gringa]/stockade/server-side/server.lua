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
Tunnel.bindInterface("stockade",cRP)
vCLIENT = Tunnel.getInterface("stockade")
vTASKBAR = Tunnel.getInterface("taskbar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local stockadePlates = {}
local blockStockades = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkPolice(vehPlate)
	if blockStockades[vehPlate] ~= nil then
		return false
	end

	local source = source
	local police = vRP.numPermission("Police")
	
	if parseInt(#police) <= 2 then
		TriggerClientEvent("Notify",source,"amarelo","Sistema indisponível no momento.",5000)
		return false
	end
	
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WITHDRAWMONEY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.withdrawMoney(vehPlate,vehNet)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if stockadePlates[vehPlate] == nil then
			if vRP.getInventoryItemAmount(user_id,"WEAPON_CROWBAR") >= 1 and vRP.getInventoryItemAmount(user_id,"lockpick") >= 1 then
				local taskResult = vTASKBAR.taskThree(source)
				if taskResult then
					stockadePlates[vehPlate] = 30
					TriggerClientEvent("stockade:Destroy",-1,vehNet)
					TriggerClientEvent("Notify",source,"verde","Sistema violado.",3000)

					local x,y,z = vRPclient.getPositions(source)
					local copAmount = vRP.numPermission("Police")
					for k,v in pairs(copAmount) do
						async(function()
							TriggerClientEvent("NotifyPush",v,{ time = os.date("%H:%M:%S - %d/%m/%Y"), code = 31, title = "Crime em Progresso.", criminal = "Denúncia de Roubo ao Carro Forte", x = x, y = y, z = z, rgba = {105,52,136} })
						end)
					end
					else
					TriggerClientEvent("Notify",source,"vermelho","Você falhou.",3000)
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não possúi os itens necessários.",5000)
			end
		else
			if stockadePlates[vehPlate] > 0 then
				vRP.wantedTimer(user_id,30)
				vCLIENT.freezePlayers(source,true)
				TriggerClientEvent("cancelando",source,true)
				stockadePlates[vehPlate] = stockadePlates[vehPlate] - 1
				vRPclient._playAnim(source,false,{ task = "PROP_HUMAN_BUM_BIN" },true)
				
				TriggerClientEvent("Progress",source,5000,"Roubando...")
				Wait(5000)

				vRPclient._stopAnim(source,false)
				vCLIENT.freezePlayers(source,false)
				TriggerClientEvent("cancelando",source,false)
				
				if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
				    TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
				    Wait(1)
				else

				vRP.giveInventoryItem(user_id,"dollars",math.random(1000),true)
				vRP.upgradeStress(user_id,3)
				return true
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","O carro forte está vázio.",5000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INPUTVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("stockade:inputVehicle")
AddEventHandler("stockade:inputVehicle",function(vehPlate)
	blockStockades[vehPlate] = true
	TriggerClientEvent("stockade:Client",-1,blockStockades)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("stockade:Client",source,blockStockades)
end)