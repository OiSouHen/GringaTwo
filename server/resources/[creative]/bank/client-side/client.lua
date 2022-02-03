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
-- BANKCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local bankcoords = {
	{ 241.45,225.37,106.29 },
	{ 243.2,224.79,106.29 },
	{ 246.54,223.56,106.29 },
	{ 248.37,222.91,106.29 },
	{ 251.77,221.74,106.29 },
	{ 253.54,221.11,106.29 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANK:OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("bank:openSystem")
AddEventHandler("bank:openSystem",function()
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped) then
		local coords = GetEntityCoords(ped)
		for k,v in pairs(bankcoords) do
			local distance = #(coords - vector3(v[1],v[2],v[3]))
			if distance <= 1 then
				SetNuiFocus(true,true)
				SendNUIMessage({ action = "showMenu" })
				vRP._playAnim(false,{"amb@prop_human_atm@male@base","base"},true)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANKCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("bankClose",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	vRP._stopAnim()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANKCLOSEEVENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("bankCloseEvent")
AddEventHandler("bankCloseEvent", function()
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKBUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
local blockButtons = false
function cRP.blockButtons(status)
	blockButtons = status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 300
		if blockButtons then
			timeDistance = 4
			DisableControlAction(1,73,true)
			DisableControlAction(1,38,true)
			DisableControlAction(1,75,true)
			DisableControlAction(1,29,true)
			DisableControlAction(1,47,true)
			DisableControlAction(1,105,true)
			DisableControlAction(1,187,true)
			DisableControlAction(1,189,true)
			DisableControlAction(1,190,true)
			DisableControlAction(1,188,true)
			DisableControlAction(1,311,true)
			DisableControlAction(1,245,true)
			DisableControlAction(1,257,true)
			DisableControlAction(1,288,true)
			DisablePlayerFiring(PlayerPedId(),true)
		end
		
		Citizen.Wait(timeDistance)
	end
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
-- REQUESTMYSALARYS
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
-- SALARYRECIPE
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