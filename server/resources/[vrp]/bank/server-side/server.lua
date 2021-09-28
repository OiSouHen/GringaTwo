-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local gotit = 0
local deposited = 0
local wage = 0
local invoices = 0
local fined = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("bank",cRP)
vCLIENT = Tunnel.getInterface("bank")
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTWANTED
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestWanted()
	local source = source
 	local user_id = vRP.getUserId(source)
	if user_id then
 		if not vRP.wantedReturn(user_id) then
			return true
		end
		
 		return false
 	end
 end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestBank()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		return identity.bank
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTFINES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestFines()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local fines = {}
		local consult = vRP.getFines(user_id)
		for k,v in pairs(consult) do
			if v.nuser_id == 0 then
				table.insert(fines,{ id = v.id, user_id = parseInt(v.user_id), nuser_id = "Government", date = v.date, price = parseInt(v.price), text = tostring(v.text) })
			else
				local identity = vRP.getUserIdentity(v.nuser_id)
				table.insert(fines,{ id = v.id, user_id = parseInt(v.user_id), nuser_id = tostring(identity.name.." "..identity.name2), date = v.date, price = parseInt(v.price), text = tostring(v.text) })
			end
		end
		return fines
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINESPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.finesPayment(id,price)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if fined == 0 then
			fined = fined + 1
			vCLIENT.blockButtons(source,true)
				vCLIENT.blockButtons(source,false)
				if vRP.paymentBank(user_id,parseInt(price)) then
					TriggerClientEvent("Notify",source,"verde","Multa paga.",3000)
					TriggerClientEvent("bank:Update",source,"requestFines")
					vRP.execute("vRP/del_fines",{ id = parseInt(id), user_id = parseInt(user_id) })
				else
					TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente.",5000)
				end
		else
			TriggerClientEvent("bankCloseEvent",source)
			TriggerClientEvent("Notify",source,"azul","Aguarde para pagar outra multa.",5000)
		end
		
		if fined >= 1 then
			Wait(5000)
			fined = 0
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSALARY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestMySalarys()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local salary = {}
		local consult = vRP.getSalary(user_id)
		for k,v in pairs(consult) do
			table.insert(salary,{ id = v.id, user_id = parseInt(v.user_id),  date = v.date, price = parseInt(v.price) })
		end
		
		return salary
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALARYPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.salaryPayment(id,price)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if wage == 0 then
			vCLIENT.blockButtons(source,true)
			wage = wage + 1
				vRP.execute("vRP/del_salary",{ id = parseInt(id), user_id = parseInt(user_id) })
				vRP.addBank(user_id,tonumber(price))
				vCLIENT.blockButtons(source,false)
				TriggerClientEvent("Notify",source,"verde","Sálario sacado.",3000)
				TriggerClientEvent("bank:Update",source,"requestMySalarys")
		else
			TriggerClientEvent("bankCloseEvent",source)
			TriggerClientEvent("Notify",source,"azul","Aguarde para sacar outro sálario.",5000)
		end
		
		if wage >= 1 then 
			Citizen.Wait(5000)
			wage = 0
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTINVOICES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestInvoices()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local invoices = {}
		local consult = vRP.getInvoice(user_id)
		for k,v in pairs(consult) do
			if v.nuser_id == 0 then
				table.insert(invoices,{ id = v.id, user_id = parseInt(v.user_id), nuser_id = parseInt(v.nuser_id), name = "Governament", date = v.date, price = parseInt(v.price), text = tostring(v.text) })
			else
				local identity = vRP.getUserIdentity(v.nuser_id)
				table.insert(invoices,{ id = v.id, user_id = parseInt(v.user_id), nuser_id = parseInt(v.nuser_id), name = tostring(identity.name.." "..identity.name2), date = v.date, price = parseInt(v.price), text = tostring(v.text) })
			end
		end
		
		return invoices
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTINVOICES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestMyInvoices()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local invoices = {}
		local consult = vRP.getMyInvoice(user_id)
		for k,v in pairs(consult) do
			local identity = vRP.getUserIdentity(v.user_id)
			if identity then
				table.insert(invoices,{ name = tostring(identity.name.." "..identity.name2), date = v.date, price = parseInt(v.price), text = tostring(v.text) })
			end
		end
		
		return invoices
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVOICESPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.invoicesPayment(id,price,nuser_id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if invoices == 0 then
			invoices = invoices + 1
			vCLIENT.blockButtons(source,true)
				vCLIENT.blockButtons(source,false)
				if vRP.paymentBank(user_id,parseInt(price)) then
					TriggerClientEvent("Notify",source,"verde","Multa paga.",3000)
					if parseInt(nuser_id) > 0 then
						vRP.addBank(nuser_id,parseInt(price))
					end
					TriggerClientEvent("bank:Update",source,"requestInvoices")
					vRP.execute("vRP/del_invoice",{ id = parseInt(id), user_id = parseInt(user_id) })
				else
					TriggerClientEvent("bankCloseEvent",source)
					TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente.",5000)
				end
		else
			TriggerClientEvent("bankCloseEvent",source)
			TriggerClientEvent("Notify",source,"azul","Aguarde para pagar outra multa.",5000)
		end

		if invoices >= 1 then
			Wait(5000)
			invoices = 0
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANKDEPOSIT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.bankDeposit(amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if deposited == 0 then
			deposited = deposited + 1

			vCLIENT.blockButtons(source,true)
				vCLIENT.blockButtons(source,false)
				TriggerClientEvent("Notify",source,"verde","Dinheiro depositado.",3000)
				if parseInt(amount) > 0 then
					if vRP.tryGetInventoryItem(user_id,"dollars",parseInt(amount)) then
						vRP.addBank(user_id,parseInt(amount))
						TriggerClientEvent("bank:Update",source,"requestInicio")
					end
				end
		else
			TriggerClientEvent("bankCloseEvent",source)
			TriggerClientEvent("Notify",source,"azul","Aguarde para depositar novamente.",5000)
		end
		
		if deposited >= 1 then
			Wait(5000)
			deposited = 0
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANWITHDRAW
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.bankWithdraw(amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then

		local getInvoice = vRP.getInvoice(user_id)
		if getInvoice[1] ~= nil then
			TriggerClientEvent("Notify",source,"amarelo","Encontramos faturas pendentes.",3000)
			return
		end

		local getFines = vRP.getFines(user_id)
		if getFines[1] ~= nil then
			TriggerClientEvent("Notify",source,"amarelo","Encontramos multas pendentes.",3000)
			return
		end
		
		if gotit == 0 then
			gotit = gotit + 1
			if parseInt(amount) > 0 then
				if vRP.computeInvWeight(user_id) + vRP.itemWeightList("dollars") * parseInt(amount) <= vRP.getBackpack(user_id) then
					vCLIENT.blockButtons(source,true)
						vCLIENT.blockButtons(source,false)
						if vRP.withdrawCash(user_id,parseInt(amount)) then
							TriggerClientEvent("Notify",source,"verde","Dinheiro sacado.",3000)
							TriggerClientEvent("bank:Update",source,"requestInicio")
						else
							TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente.",5000)
						end
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
				end
			end
		else
			TriggerClientEvent("bankCloseEvent",source)
			TriggerClientEvent("Notify",source,"azul","Aguarde para efetuar outro saque.",5000)
		end

		if gotit >= 1 then 
			Wait(10000)
			gotit = 0
		end
	end
end