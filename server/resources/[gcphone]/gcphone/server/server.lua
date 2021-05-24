local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
gcp = {}
Tunnel.bindInterface("gcphone",gcp)

function gcp.checkCelular()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"cellphone") >= 1 then
			return true
		else
			return false
		end
	end
end

math.randomseed(os.time())

function getPhoneRandomNumber()
  local numBase0 = math.random(1000,9999)
	local numBase1 = math.random(0,9999)
	local num = string.format("%03d-%03d",numBase0,numBase1)
	return num
end

function getNumberPhone(identifier)
	local result = MySQL.Sync.fetchAll("SELECT vrp_users.phone FROM vrp_users WHERE vrp_users.id = @identifier",{ ['@identifier'] = identifier })
	if result[1] ~= nil then
		return result[1].phone
	end
	return nil
end

function getIdentifierByPhoneNumber(phone_number) 
	local result = MySQL.Sync.fetchAll("SELECT vrp_users.id FROM vrp_users WHERE vrp_users.phone = @phone_number",{ ['@phone_number'] = phone_number })
	if result[1] ~= nil then
		return result[1].id
	end
	return nil
end

function getPlayerID(source)
	local player = vRP.getUserId(source)
	return player
end

function getIdentifiant(id)
	for _, v in ipairs(id) do
		return v
	end
end

function getOrGeneratePhoneNumber(sourcePlayer,identifier,cb)
	local myPhoneNumber = getNumberPhone(identifier)
	if myPhoneNumber == '0' or myPhoneNumber == nil then
		repeat
			myPhoneNumber = getPhoneRandomNumber()
			local id = getIdentifierByPhoneNumber(myPhoneNumber)
		until id == nil
		MySQL.Async.insert("UPDATE vrp_users SET phone = @myPhoneNumber WHERE id = @identifier",{ ['@myPhoneNumber'] = myPhoneNumber, ['@identifier'] = identifier },function()
			cb(myPhoneNumber)
		end)
	else
		cb(myPhoneNumber)
	end
end

function getContacts(identifier)
	local result = MySQL.Sync.fetchAll("SELECT * FROM phone_users_contacts WHERE phone_users_contacts.identifier = @identifier",{ ['@identifier'] = identifier })
	return result
end

function addContact(source,identifier,number,display)
	local sourcePlayer = tonumber(source)
	MySQL.Async.insert("INSERT INTO phone_users_contacts (`identifier`, `number`,`display`) VALUES(@identifier, @number, @display)",{
		['@identifier'] = identifier,
		['@number'] = number,
		['@display'] = display
	},function()
		notifyContactChange(sourcePlayer,identifier)
	end)
end

function updateContact(source,identifier,id,number,display)
	local sourcePlayer = tonumber(source)
	MySQL.Async.insert("UPDATE phone_users_contacts SET number = @number, display = @display WHERE id = @id",{ 
		['@number'] = number,
		['@display'] = display,
		['@id'] = id
	},function()
		notifyContactChange(sourcePlayer,identifier)
	end)
end

function deleteContact(source,identifier,id)
	local sourcePlayer = tonumber(source)
	MySQL.Sync.execute("DELETE FROM phone_users_contacts WHERE `identifier` = @identifier AND `id` = @id",{
		['@identifier'] = identifier,
		['@id'] = id
	})
	notifyContactChange(sourcePlayer,identifier)
end

function deleteAllContact(identifier)
	MySQL.Sync.execute("DELETE FROM phone_users_contacts WHERE `identifier` = @identifier",{
		['@identifier'] = identifier
	})
end

function notifyContactChange(source,identifier)
	local sourcePlayer = tonumber(source)
	local identifier = identifier
	if sourcePlayer ~= nil then 
		TriggerClientEvent("gcPhone:contactList",sourcePlayer,getContacts(identifier))
	end
end

RegisterServerEvent('gcPhone:addContact')
AddEventHandler('gcPhone:addContact',function(display,phoneNumber)
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(source)
	addContact(sourcePlayer,identifier,phoneNumber,display)
end)

RegisterServerEvent('gcPhone:updateContact')
AddEventHandler('gcPhone:updateContact',function(id,display,phoneNumber)
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(source)
	updateContact(sourcePlayer,identifier,id,phoneNumber,display)
end)

RegisterServerEvent('gcPhone:deleteContact')
AddEventHandler('gcPhone:deleteContact',function(id)
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(source)
	deleteContact(sourcePlayer,identifier,id)
end)

function getMessages(identifier)
	local result = MySQL.Sync.fetchAll("SELECT phone_messages.* FROM phone_messages LEFT JOIN vrp_users ON vrp_users.id = @identifier WHERE phone_messages.receiver = vrp_users.phone",{ ['@identifier'] = identifier })
	return result
end

RegisterServerEvent('gcPhone:_internalAddMessage')
AddEventHandler('gcPhone:_internalAddMessage',function(transmitter,receiver,message,owner,cb)
	cb(_internalAddMessage(transmitter,receiver,message,owner))
end)

function _internalAddMessage(transmitter,receiver,message,owner)
    local Query = "INSERT INTO phone_messages (`transmitter`,`receiver`,`message`,`isRead`,`owner`) VALUES(@transmitter,@receiver,@message,@isRead,@owner);"
    local Query2 = 'SELECT * from phone_messages WHERE `id` = @id;'
	local Parameters = { ['@transmitter'] = transmitter, ['@receiver'] = receiver, ['@message'] = message, ['@isRead'] = owner, ['@owner'] = owner }
    local id = MySQL.Sync.insert(Query,Parameters)
    return MySQL.Sync.fetchAll(Query2,{ ['@id'] = id })[1]
end

local firstmessage = {}
local secondmessage = {}
local etapaecstasy = {}
local etapafueltech = {}
local etapalean = {}
local etapailegal = {}

-- RegisterServerEvent('gcPhone:auto-messageilegal')
-- AddEventHandler('gcPhone:auto-messageilegal',function(numero)
	-- local source = source
	-- local sourcePlayer = tonumber(source)
	-- local myPhone = "000-000"
	-- local otherIdentifier = getIdentifierByPhoneNumber(numero)
	-- if not firstmessage[source] then
		-- local mensagem = "Salve ta afim de saber sobre oq?\n 1 - Loc carro do ilegal\n 2 - farm ilegal"
		-- if otherIdentifier ~= nil and vRP.getUserSource(otherIdentifier) ~= nil then
			-- local tomess = _internalAddMessage(myPhone,numero,mensagem,0)
			-- TriggerClientEvent("gcPhone:receiveMessage",tonumber(vRP.getUserSource(otherIdentifier)),tomess)
			-- firstmessage[source] = true
		-- end
	-- end
-- end)

function addMessage(source,identifier,phone_number,message)
	local sourcePlayer = tonumber(source)
	local myPhone = getNumberPhone(identifier)

	local memess = _internalAddMessage(phone_number,myPhone,message,1)
	TriggerClientEvent("gcPhone:receiveMessage",sourcePlayer,memess)
	if phone_number == '000-000' then
		Wait(1250)
		if not firstmessage[source] then
			local mensagem = "Salve, Tenho as informações que você precisa 1 - Aceitar / 2 - Quero nao. ( ME RESPONDA APENAS COM NUMEROS )"
			--if sourcePlayer ~= nil and vRP.getUserSource(sourcePlayer) ~= nil then
				local tomess = _internalAddMessage(phone_number,myPhone,mensagem,0)
				TriggerClientEvent("gcPhone:receiveMessage",sourcePlayer,tomess)
				firstmessage[source] = true
			--end
		elseif firstmessage[source] and not secondmessage[source] and message == '1' then
			local mensagem = "Ta afim de saber oq? 1 - Loc da van do trafico 2 - Trafico de Ecstasy 3 - Trafico de Lean 4 - Trafico de Cpuchip 5 - Trocar o Cpuchip por Fueltech 6 - Loc pra vender as drogas e outros ilegais 7 - Comprar drogas prontas 8 - Compra de armas e ilegais."
			--if sourcePlayer ~= nil and vRP.getUserSource(sourcePlayer) ~= nil then
				local tomess = _internalAddMessage(phone_number,myPhone,mensagem,0)
				TriggerClientEvent("gcPhone:receiveMessage",sourcePlayer,tomess)
				secondmessage[source] = true
				vRP.paymentBank(identifier,tonumber(0))
			--end
		else
			if message == '1' or message == '2' or message == '3' or message == '4' or message == '5' or message == '6' or message == '7' or message == '8' then
				if not etapaecstasy[source] and not etapafueltech[source] and not etapalean[source] then
					if message == '1' or message == '5' or message == '6' or message == '7' then
						firstmessage[source] = false
						secondmessage[source] = false
					end
					if message == '1' then
						mensagem = 'Loc: 1754.52, -1649.07 \n Localizaçao da van. Mentalize /gangs para iniciar qualquer um dos farms'
					elseif message == '2' then
						mensagem = '1 - Primeira etapa 2 - Segunda etapa / Voce vai precisar da van e mentalizar /gangs'
						etapaecstasy[source] = true
					elseif message == '3' then
						mensagem = '1 - Primeira etapa 2 - Segunda etapa / Voce vai precisar da van e mentalizar /gangs'
						etapalean[source] = true
					elseif message == '4' then
						mensagem = '1 - Primeira etapa 2 - Segunda etapa / Voce vai precisar da van e mentalizar /gangs'
						etapafueltech[source] = true
					elseif message == '5' then
						mensagem = 'Loc: -882.09, -438.72 Só chegar la com 25 cpuchip.'
					elseif message == '6' then
						mensagem = 'Loc: 19.94, -1601.97 O dono de la conhece uns contatos, chegando la vai no armario que tem um gnomo e mentaliza /delivery que ele te entrega a lista'
					elseif message == '7' then
						mensagem = 'Loc: 911.13, 3644.9 Esse tiozao tem umas paradas da boa, mais so aceita outro tipo de dinheiro.'
					elseif message == '8' then
						mensagem = '1 - Pistolas, colete, muniçoes, lockpick, placa e outras coisinhas 2 - Armas pesadas, algemas, c4, capuz e corda.'
						etapailegal[source] = true
					end
				else
					if message == '1' or message == '2' then
						if etapaecstasy[source] then
							if message == '1' then
								mensagem = 'Loc: 1417.1, 6339.17 primeira etapa de ectasy, ta na mao'
							elseif message == '2' then
								mensagem = 'Loc: -159.89, -1636.28 fica no segundo andar.'
							end
						elseif etapafueltech[source] then
							if message == '1' then
								mensagem = 'Loc: 3725.43, 4525.73 primeira etapa do cocaina, ta na mao'
							elseif message == '2' then
								mensagem = 'Loc: 342.75,-2078.35  segunda etapa do cocaina, ta ae'
							end
						elseif etapalean[source] then
							if message == '1' then
								mensagem = 'Loc: -1593.11, 5202.99 primeira etapa de lean, ta na mao'
							elseif message == '2' then
								mensagem = 'Loc: 75.77, -1970.07 segunda etapa de lean, ta ae'
							end
						elseif etapailegal[source] then
							if message == '1' then
								mensagem = 'Loc: 68.94, -1569.98'
							elseif message == '2' then
								mensagem = 'Loc: 2662.4, 3468.26'
							end
						end
					else
						mensagem = 'Te dei 2 opçao só truta, tu é burro? Começa tudo dnovo.'
					end
					firstmessage[source] = false
					secondmessage[source] = false
					etapaecstasy[source] = false
					etapafueltech[source] = false
					etapalean[source] = false
					etapailegal[source] = false
				end
				--firstmessage[source] = false
				tomess = _internalAddMessage(phone_number,myPhone,mensagem,0)
				TriggerClientEvent("gcPhone:receiveMessage",sourcePlayer,tomess)
			end
		end
	else
		local otherIdentifier = getIdentifierByPhoneNumber(phone_number)
		--local myPhone = getNumberPhone(identifier)
		if otherIdentifier ~= nil and vRP.getUserSource(otherIdentifier) ~= nil then
			local tomess = _internalAddMessage(myPhone,phone_number,message,0)
			TriggerClientEvent("gcPhone:receiveMessage",tonumber(vRP.getUserSource(otherIdentifier)),tomess)
		else
			_internalAddMessage(myPhone,phone_number,message,0)
		end
	end
end


function setReadMessageNumber(identifier, num)
	local mePhoneNumber = getNumberPhone(identifier)
	MySQL.Sync.execute("UPDATE phone_messages SET phone_messages.isRead = 1 WHERE phone_messages.receiver = @receiver AND phone_messages.transmitter = @transmitter",{ 
		['@receiver'] = mePhoneNumber,
		['@transmitter'] = num
	})
end

function deleteMessage(msgId)
	MySQL.Sync.execute("DELETE FROM phone_messages WHERE `id` = @id",{
		['@id'] = msgId
	})
end

function deleteAllMessageFromPhoneNumber(source,identifier,phone_number)
	local source = source
	local identifier = identifier
	local mePhoneNumber = getNumberPhone(identifier)
	MySQL.Sync.execute("DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber and `transmitter` = @phone_number",{ ['@mePhoneNumber'] = mePhoneNumber,['@phone_number'] = phone_number })
end

function deleteAllMessage(identifier)
	local mePhoneNumber = getNumberPhone(identifier)
	MySQL.Sync.execute("DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber",{
		['@mePhoneNumber'] = mePhoneNumber
	})
end

RegisterServerEvent('gcPhone:sendMessage')
AddEventHandler('gcPhone:sendMessage',function(phoneNumber,message)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    addMessage(sourcePlayer,identifier,phoneNumber,message)
end)

RegisterServerEvent('gcPhone:deleteMessage')
AddEventHandler('gcPhone:deleteMessage',function(msgId)
	deleteMessage(msgId)
end)

RegisterServerEvent('gcPhone:deleteMessageNumber')
AddEventHandler('gcPhone:deleteMessageNumber',function(number)
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(source)
	deleteAllMessageFromPhoneNumber(sourcePlayer,identifier,number)
end)

RegisterServerEvent('gcPhone:deleteAllMessage')
AddEventHandler('gcPhone:deleteAllMessage',function()
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(source)
	deleteAllMessage(identifier)
end)

RegisterServerEvent('gcPhone:setReadMessageNumber')
AddEventHandler('gcPhone:setReadMessageNumber',function(num)
	local sourcePlayer = tonumber(source)  
	local identifier = getPlayerID(source)
	setReadMessageNumber(identifier,num)
end)

RegisterServerEvent('gcPhone:deleteALL')
AddEventHandler('gcPhone:deleteALL',function()
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(source)
	deleteAllMessage(identifier)
	deleteAllContact(identifier)
	appelsDeleteAllHistorique(identifier)
	TriggerClientEvent("gcPhone:contactList",sourcePlayer,{})
	TriggerClientEvent("gcPhone:allMessage",sourcePlayer,{})
	TriggerClientEvent("appelsDeleteAllHistorique",sourcePlayer,{})
end)

local AppelsEnCours = {}
local lastIndexCall = 10

function getHistoriqueCall(num)
	local result = MySQL.Sync.fetchAll("SELECT * FROM phone_calls WHERE phone_calls.owner = @num ORDER BY time DESC LIMIT 120",{ ['@num'] = num })
	return result
end

function sendHistoriqueCall(src,num)
	local histo = getHistoriqueCall(num)
	TriggerClientEvent('gcPhone:historiqueCall',src,histo)
end

function saveAppels(appelInfo)
	if appelInfo.extraData == nil or appelInfo.extraData.useNumber == nil then
		MySQL.Async.insert("INSERT INTO phone_calls (`owner`,`num`,`incoming`,`accepts`) VALUES(@owner,@num,@incoming,@accepts)",{ ['@owner'] = appelInfo.transmitter_num, ['@num'] = appelInfo.receiver_num, ['@incoming'] = 1, ['@accepts'] = appelInfo.is_accepts },function()
			notifyNewAppelsHisto(appelInfo.transmitter_src,appelInfo.transmitter_num)
		end)
	end
	if appelInfo.is_valid == true then
		local num = appelInfo.transmitter_num
		if appelInfo.hidden == true then
			mun = "####-####"
		end
		MySQL.Async.insert("INSERT INTO phone_calls (`owner`, `num`,`incoming`, `accepts`) VALUES(@owner, @num, @incoming, @accepts)",{ ['@owner'] = appelInfo.receiver_num, ['@num'] = num, ['@incoming'] = 0, ['@accepts'] = appelInfo.is_accepts },function()
			if appelInfo.receiver_src ~= nil then
				notifyNewAppelsHisto(appelInfo.receiver_src,appelInfo.receiver_num)
			end
		end)
	end
end

function notifyNewAppelsHisto(src,num)
	sendHistoriqueCall(src,num)
end

RegisterServerEvent('gcPhone:getHistoriqueCall')
AddEventHandler('gcPhone:getHistoriqueCall',function()
	local sourcePlayer = tonumber(source)
	local srcIdentifier = getPlayerID(source)
	local srcPhone = getNumberPhone(srcIdentifier)
	sendHistoriqueCall(sourcePlayer,num)
end)

RegisterServerEvent('gcPhone:internal_startCall')
AddEventHandler('gcPhone:internal_startCall',function(source,phone_number,rtcOffer,extraData)
	local rtcOffer = rtcOffer
	if phone_number == nil or phone_number == '' then
		return
	end

	local hidden = string.sub(phone_number,1,1) == '#'
	if hidden == true then
		phone_number = string.sub(phone_number,2)
	end

	local indexCall = lastIndexCall
	lastIndexCall = lastIndexCall + 1

	local sourcePlayer = tonumber(source)
	local srcIdentifier = getPlayerID(source)
	local srcPhone = ''

	if extraData ~= nil and extraData.useNumber ~= nil then
		srcPhone = extraData.useNumber
	else
		srcPhone = getNumberPhone(srcIdentifier)
	end

	local destPlayer = getIdentifierByPhoneNumber(phone_number)
	local is_valid = destPlayer ~= nil and destPlayer ~= srcIdentifier
	AppelsEnCours[indexCall] = { id = indexCall, transmitter_src = sourcePlayer, transmitter_num = srcPhone, receiver_src = nil, receiver_num = phone_number, is_valid = destPlayer ~= nil, is_accepts = false, hidden = hidden, rtcOffer = rtcOffer, extraData = extraData }
    
	if is_valid == true then
		if vRP.getUserSource(destPlayer) ~= nil then
			srcTo = tonumber(vRP.getUserSource(destPlayer))
			if srcTo ~= nill then
				AppelsEnCours[indexCall].receiver_src = srcTo
				TriggerClientEvent('gcPhone:waitingCall',sourcePlayer,AppelsEnCours[indexCall],true)
				TriggerClientEvent('gcPhone:waitingCall',srcTo,AppelsEnCours[indexCall],false)
			else
				TriggerClientEvent('gcPhone:waitingCall',sourcePlayer,AppelsEnCours[indexCall],true)
			end
		end
	else
		TriggerEvent('gcPhone:addCall',AppelsEnCours[indexCall])
		TriggerClientEvent('gcPhone:waitingCall',sourcePlayer,AppelsEnCours[indexCall],true)
	end
end)

RegisterServerEvent('gcPhone:startCall')
AddEventHandler('gcPhone:startCall',function(phone_number,rtcOffer,extraData)
	TriggerEvent('gcPhone:internal_startCall',source,phone_number,rtcOffer,extraData)
end)

RegisterServerEvent('gcPhone:candidates')
AddEventHandler('gcPhone:candidates',function(callId,candidates)
	if AppelsEnCours[callId] ~= nil then
		local source = source
		local to = AppelsEnCours[callId].transmitter_src
		if source == to then 
			to = AppelsEnCours[callId].receiver_src
		end
		TriggerClientEvent('gcPhone:candidates',to,candidates)
	end
end)

RegisterServerEvent('gcPhone:acceptCall')
AddEventHandler('gcPhone:acceptCall',function(infoCall,rtcAnswer)
	local id = infoCall.id
	if AppelsEnCours[id] ~= nil then
		AppelsEnCours[id].receiver_src = infoCall.receiver_src or AppelsEnCours[id].receiver_src
		if AppelsEnCours[id].transmitter_src ~= nil and AppelsEnCours[id].receiver_src ~= nil then
			AppelsEnCours[id].is_accepts = true
			AppelsEnCours[id].rtcAnswer = rtcAnswer
			TriggerClientEvent('gcPhone:acceptCall',AppelsEnCours[id].transmitter_src,AppelsEnCours[id],true)
			TriggerClientEvent('gcPhone:acceptCall',AppelsEnCours[id].receiver_src,AppelsEnCours[id],false)
			saveAppels(AppelsEnCours[id])
		end
	end
end)

RegisterServerEvent('gcPhone:rejectCall')
AddEventHandler('gcPhone:rejectCall',function(infoCall)
	local id = infoCall.id
	if AppelsEnCours[id] ~= nil then
		if AppelsEnCours[id].transmitter_src ~= nil then
			TriggerClientEvent('gcPhone:rejectCall',AppelsEnCours[id].transmitter_src)
		end
		if AppelsEnCours[id].receiver_src ~= nil then
			TriggerClientEvent('gcPhone:rejectCall',AppelsEnCours[id].receiver_src)
		end

		if AppelsEnCours[id].is_accepts == false then 
			saveAppels(AppelsEnCours[id])
		end
		TriggerEvent('gcPhone:removeCall',AppelsEnCours)
		AppelsEnCours[id] = nil
	end
end)

RegisterServerEvent('gcPhone:appelsDeleteHistorique')
AddEventHandler('gcPhone:appelsDeleteHistorique',function(numero)
	local sourcePlayer = tonumber(source)
	local srcIdentifier = getPlayerID(source)
	local srcPhone = getNumberPhone(srcIdentifier)
	MySQL.Sync.execute("DELETE FROM phone_calls WHERE `owner` = @owner AND `num` = @num",{
		['@owner'] = srcPhone,
		['@num'] = numero
	})
end)

function appelsDeleteAllHistorique(srcIdentifier)
	local srcPhone = getNumberPhone(srcIdentifier)
	MySQL.Sync.execute("DELETE FROM phone_calls WHERE `owner` = @owner",{ ['@owner'] = srcPhone })
end

RegisterServerEvent('gcPhone:appelsDeleteAllHistorique')
AddEventHandler('gcPhone:appelsDeleteAllHistorique',function()
	local sourcePlayer = tonumber(source)
	local srcIdentifier = getPlayerID(source)
	appelsDeleteAllHistorique(srcIdentifier)
end)

-- AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
-- 	if first_spawn then
-- 		local sourcePlayer = tonumber(source)
-- 		local identifier = getPlayerID(source)
-- 		getOrGeneratePhoneNumber(sourcePlayer,identifier,function(myPhoneNumber)
-- 			TriggerClientEvent("gcPhone:myPhoneNumber",sourcePlayer,myPhoneNumber)
-- 			TriggerClientEvent("gcPhone:contactList",sourcePlayer,getContacts(identifier))
-- 			TriggerClientEvent("gcPhone:allMessage",sourcePlayer,getMessages(identifier))
-- 		end)
-- 	end
-- end)

--====================================================================================
--  OnLoad tt daniel
--====================================================================================
AddEventHandler('vRP:playerSpawn',function(user_id,source,first_spawn)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(sourcePlayer)
    local num = getNumberPhone(identifier)
    local myBank = vRP.getBank(identifier)

    TriggerClientEvent("gcPhone:myPhoneNumber",sourcePlayer, num)
    TriggerClientEvent('gcPhone:set_bank', sourcePlayer, myBank)
    TriggerClientEvent("gcPhone:contactList",sourcePlayer, getContacts(identifier))
    TriggerClientEvent("gcPhone:allMessage",sourcePlayer, getMessages(identifier))
    sendHistoriqueCall(source, num)
end)

RegisterServerEvent('gcPhone:allUpdate')
AddEventHandler('gcPhone:allUpdate', function()
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    local user_id = vRP.getUserId(source)    
    local num = getNumberPhone(identifier)
    --local identity = vRP.getUserIdentity(user_id)
    local Bank = vRP.getBank(user_id)
    TriggerClientEvent("gcPhone:myPhoneNumber",sourcePlayer,num)
    --TriggerClientEvent("gcPhone:firstname", sourcePlayer, identity.name)
    --TriggerClientEvent("gcPhone:lastname", sourcePlayer, identity.firstname)
    TriggerClientEvent("gcPhone:contactList",sourcePlayer,getContacts(identifier))
    TriggerClientEvent("gcPhone:allMessage",sourcePlayer,getMessages(identifier))
    TriggerClientEvent("vRP:updateBalanceGc", sourcePlayer,Bank)
    sendHistoriqueCall(sourcePlayer,num)
    
end)

AddEventHandler('onMySQLReady',function()
	MySQL.Async.fetchAll("DELETE FROM phone_messages WHERE (DATEDIFF(CURRENT_DATE,time) > 10)")
end)


