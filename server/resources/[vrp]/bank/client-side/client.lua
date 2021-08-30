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
Tunnel.bindInterface("bank",cRP)
vSERVER = Tunnel.getInterface("bank")
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALIDADES
-----------------------------------------------------------------------------------------------------------------------------------------
local localidades = {
	{ -1212.63,-330.80,37.78 },
	{ 149.85,-1040.71,29.37 },
	{ -2962.56,482.95,15.70 },
	{ -111.97,6469.19,31.62 },
	{ 1175.05,2706.90,38.09 },
	{ -351.02,-49.97,49.04 },
	{ 314.13,-279.09,54.17 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local innerTable = {}
	for k,v in pairs(localidades) do
		table.insert(innerTable,{ v[1],v[2],v[3],2,"E","Banco Fleeca","Pressione para abrir" })
	end

	TriggerEvent("hoverfy:insertTable",innerTable)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(localidades) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 1 then
					timeDistance = 4
					if IsControlJustPressed(1,38) then				
						SetNuiFocus(true,true)
						SendNUIMessage({ action = "showMenu" })
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANKCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("bankClose",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBANK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestBank",function(data,cb)
	local resultado = vSERVER.requestBank()
	while identity do
		Citizen.Wait(10)
	end
	if resultado then
		cb({ resultado = resultado })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTFINES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestFines",function(data,cb)
	local resultado = vSERVER.requestFines()
	while not resultado do
		resultado = vSERVER.requestFines()
		Citizen.Wait(10)
	end

	if resultado then
		cb({ resultado = resultado })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINESPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("finesPayment",function(data)
	if data.id ~= nil then
		vSERVER.finesPayment(data.id,data.price)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSALARY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMySalarys",function(data,cb)
	local resultado = vSERVER.requestMySalarys()
	while not resultado do
		resultado = vSERVER.requestMySalarys()
		Citizen.Wait(10)
	end

	if resultado then
		cb({ resultado = resultado })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALARYPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("salaryRecipe",function(data)
	if data.id ~= nil then
		vSERVER.salaryPayment(data.id,data.price)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTINVOICES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestInvoices",function(data,cb)
	local resultado = vSERVER.requestInvoices()
	while not resultado do
		resultado = vSERVER.requestInvoices()
		Citizen.Wait(10)
	end

	if resultado then
		cb({ resultado = resultado })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTMYINVOICES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMyInvoices",function(data,cb)
	local resultado = vSERVER.requestMyInvoices()
	while not resultado do
		resultado = vSERVER.requestMyInvoices()
		Citizen.Wait(10)
	end

	if resultado then
		cb({ resultado = resultado })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVOICESPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invoicesPayment",function(data)
	if data.id ~= nil then
		vSERVER.invoicesPayment(data.id,data.price,data.nuser_id)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANKDEPOSIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("bankDeposit",function(data)
	if parseInt(data.deposito) > 0 then
		vSERVER.bankDeposit(data.deposito)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANKWITHDRAW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("bankWithdraw",function(data)
	if parseInt(data.saque) > 0 then
		vSERVER.bankWithdraw(data.saque)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANK:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("bank:Update")
AddEventHandler("bank:Update",function(action)
	SendNUIMessage({ action = action })
end)