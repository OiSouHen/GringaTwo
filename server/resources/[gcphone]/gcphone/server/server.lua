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
Tunnel.bindInterface("gcphone",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GCPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("gcphone/remMessageId","DELETE FROM phone_messages WHERE id = @id")
vRP.prepare("gcphone/getChatMessagesId","SELECT * FROM phone_chat ORDER BY id DESC")
vRP.prepare("gcphone/cleanPhoneCallbyOwner","DELETE FROM phone_calls WHERE owner = @owner")
vRP.prepare("gcphone/remAllMessage","DELETE FROM phone_messages WHERE receiver = @receiver")
vRP.prepare("gcphone/getPhoneContacts","SELECT * FROM phone_contacts WHERE identifier = @identifier")
vRP.prepare("gcphone/remAllPhoneContacts","DELETE FROM phone_contacts WHERE identifier = @identifier")
vRP.prepare("gcphone/removeCallDays","DELETE FROM phone_calls WHERE (DATEDIFF(CURRENT_DATE,time) > 3)")
vRP.prepare("gcphone/addChatMessages","INSERT INTO phone_chat(channel,message) VALUES(@channel,@message)")
vRP.prepare("gcphone/cleanPhoneCallsbyNumber","DELETE FROM phone_calls WHERE owner = @owner AND num = @num")
vRP.prepare("gcphone/removeMessageDays","DELETE FROM phone_messages WHERE (DATEDIFF(CURRENT_DATE,time) > 3)")
vRP.prepare("gcphone/remPhoneContacts","DELETE FROM phone_contacts WHERE id = @id AND identifier = @identifier")
vRP.prepare("gcphone/getHistoryCalls","SELECT * FROM phone_calls WHERE owner = @owner ORDER BY time DESC LIMIT 20")
vRP.prepare("gcphone/getChatMessages","SELECT * FROM phone_chat WHERE channel = @channel ORDER BY time DESC LIMIT 30")
vRP.prepare("gcphone/updatePhoneContacts","UPDATE phone_contacts SET number = @number, display = @display WHERE id = @id")
vRP.prepare("gcphone/remMessageNumber","DELETE FROM phone_messages WHERE receiver = @receiver AND transmitter = @transmitter")
vRP.prepare("gcphone/insertPhoneCalls","INSERT INTO phone_calls(owner,num,incoming,accepts) VALUES(@owner,@num,@incoming,@accepts)")
vRP.prepare("gcphone/addPhoneContacts","INSERT INTO phone_contacts(identifier,number,display) VALUES(@identifier,@number,@display)")
vRP.prepare("gcphone/updateReadMessage","UPDATE phone_messages SET isRead = 1 WHERE receiver = @receiver AND transmitter = @transmitter")
vRP.prepare("gcphone/getPhoneMessagesId","SELECT * FROM phone_messages WHERE transmitter = @transmitter AND receiver = receiver ORDER BY id DESC LIMIT 1")
vRP.prepare("gcphone/insertPhoneMessages","INSERT INTO phone_messages(transmitter,receiver,message,isRead,owner) VALUES(@transmitter,@receiver,@message,@owner,@owner)")
vRP.prepare("gcphone/getPhoneMessages","SELECT phone_messages.* FROM phone_messages LEFT JOIN users ON users.id = @identifier WHERE phone_messages.receiver = users.phone")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local userPhones = {}
local phoneEncoders = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkPhone()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"cellphone") >= 1 then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFYCONTACTCHANGE
-----------------------------------------------------------------------------------------------------------------------------------------
function notifyContactChange(source,user_id)
	local myContacts = vRP.query("gcphone/getPhoneContacts",{ identifier = parseInt(user_id) })
	TriggerClientEvent("gcPhone:contactList",source,myContacts)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCONTACT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("gcPhone:addContact")
AddEventHandler("gcPhone:addContact",function(display,phoneNumber)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.execute("gcphone/addPhoneContacts",{ identifier = parseInt(user_id), number = phoneNumber, display = display })
		notifyContactChange(source,user_id)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECONTACT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("gcPhone:updateContact")
AddEventHandler("gcPhone:updateContact",function(id,display,phoneNumber)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.execute("gcphone/updatePhoneContacts",{ number = phoneNumber, display = display, id = id })
		notifyContactChange(source,user_id)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETECONTACT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("gcPhone:deleteContact")
AddEventHandler("gcPhone:deleteContact",function(id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.execute("gcphone/remPhoneContacts",{ id = id, identifier = parseInt(user_id) })
		notifyContactChange(source,user_id)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("gcPhone:sendMessage")
AddEventHandler("gcPhone:sendMessage",function(phoneNumber,message)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and phoneNumber ~= nil then
		vRP.execute("gcphone/insertPhoneMessages",{ transmitter = userPhones[tostring(user_id)], receiver = phoneNumber, message = message, owner = 0 })
		local nuser_id = vRP.userPhone(phoneNumber)
		if nuser_id then
			local otherPlayer = vRP.userSource(nuser_id)
			if otherPlayer then
				local consult = vRP.query("gcphone/getPhoneMessagesId",{ transmitter = userPhones[tostring(user_id)], receiver = phoneNumber })
				TriggerClientEvent("gcPhone:receiveMessage",otherPlayer,consult[1])
			end
		end

		vRP.execute("gcphone/insertPhoneMessages",{ transmitter = phoneNumber, receiver = userPhones[tostring(user_id)], message = message, owner = 1 })
		local consult = vRP.query("gcphone/getPhoneMessagesId",{ transmitter = phoneNumber, receiver = userPhones[tostring(user_id)] })
		TriggerClientEvent("gcPhone:receiveMessage",source,consult[1])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("gcPhone:deleteMessage")
AddEventHandler("gcPhone:deleteMessage",function(msgId)
	vRP.execute("gcphone/remMessageId",{ id = parseInt(msgId) })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEMESSAGENUMBER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("gcPhone:deleteMessageNumber")
AddEventHandler("gcPhone:deleteMessageNumber",function(phoneNumber)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.execute("gcphone/remMessageNumber",{ receiver = userPhones[tostring(user_id)], transmitter = phoneNumber })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEALLMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("gcPhone:deleteAllMessage")
AddEventHandler("gcPhone:deleteAllMessage",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.execute("gcphone/remAllMessage",{ receiver = userPhones[tostring(user_id)] })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETREADMESSAGENUMBER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("gcPhone:setReadMessageNumber")
AddEventHandler("gcPhone:setReadMessageNumber",function(phoneNumber)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.execute("gcphone/updateReadMessage",{ receiver = userPhones[tostring(user_id)], transmitter = phoneNumber })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GCPHONE:DELETEALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("gcPhone:deleteALL")
AddEventHandler("gcPhone:deleteALL",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerClientEvent("gcPhone:allMessage",source,{})
		TriggerClientEvent("gcPhone:contactList",source,{})
		TriggerClientEvent("appelsDeleteAllHistorique",source,{})
		vRP.execute("gcphone/remAllPhoneContacts",{ identifier = parseInt(user_id) })
		vRP.execute("gcphone/remAllMessage",{ receiver = userPhones[tostring(user_id)] })
		vRP.execute("gcphone/cleanPhoneCallbyOwner",{ owner = userPhones[tostring(user_id)] })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDHISTORIQUECALL
-----------------------------------------------------------------------------------------------------------------------------------------
function sendHistoriqueCall(source,phoneNumber)
	local history = vRP.query("gcphone/getHistoryCalls",{ owner = phoneNumber })
	if history ~= nil then
		TriggerClientEvent("gcPhone:historiqueCall",source,history)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVECALLINGS
-----------------------------------------------------------------------------------------------------------------------------------------
function saveCallings(phoneInfos)
	if phoneInfos["extraData"] == nil then
		vRP.execute("gcphone/insertPhoneCalls",{ owner = phoneInfos["transmitter_num"], num = phoneInfos["receiver_num"], incoming = 1, accepts = phoneInfos["is_accepts"] })
		sendHistoriqueCall(phoneInfos["transmitter_src"],phoneInfos["transmitter_num"])
	end

	if phoneInfos["is_valid"] then
		local num = phoneInfos["transmitter_num"]
		if phoneInfos["hidden"] then
			num = "####-####"
		end

		vRP.execute("gcphone/insertPhoneCalls",{ owner = phoneInfos["receiver_num"], num = num, incoming = 0, accepts = phoneInfos["is_accepts"] })
		sendHistoriqueCall(phoneInfos["receiver_src"],phoneInfos["receiver_num"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GCPHONE:GETHISTORIQUECALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("gcPhone:getHistoriqueCall")
AddEventHandler("gcPhone:getHistoriqueCall",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		sendHistoriqueCall(source,userPhones[tostring(user_id)])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTCALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("gcPhone:startCall")
AddEventHandler("gcPhone:startCall",function(phoneNumber,rtcOffer,extraData)
	if phoneNumber == nil or phoneNumber == "" then
		return
	end

	local hidden = string.sub(phoneNumber,1,1)
	if hidden == "#" then
		phoneNumber = string.sub(phoneNumber,2)
	end

	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local nuser_id = vRP.userPhone(phoneNumber)
		if nuser_id and userPhones[tostring(user_id)] ~= phoneNumber then
			local otherPlayer = vRP.userSource(nuser_id)
			if otherPlayer then
				local indexCall = parseInt(1500 + user_id)
				phoneEncoders[indexCall] = { id = indexCall, transmitter_src = source, transmitter_num = userPhones[tostring(user_id)], receiver_src = otherPlayer, receiver_num = phoneNumber, is_valid = otherPlayer, is_accepts = false, hidden = hidden, rtcOffer = rtcOffer, extraData = extraData }

				TriggerClientEvent("gcPhone:waitingCall",source,phoneEncoders[indexCall],true)
				TriggerClientEvent("gcPhone:waitingCall",otherPlayer,phoneEncoders[indexCall],false)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GCPHONE:CANDIDATES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("gcPhone:candidates")
AddEventHandler("gcPhone:candidates",function(callId,candidates)
	local source = source

	if phoneEncoders[callId] ~= nil then
		local otherPlayer = phoneEncoders[callId]["transmitter_src"]
		if source == otherPlayer then 
			otherPlayer = phoneEncoders[callId]["receiver_src"]
		end

		TriggerClientEvent("gcPhone:candidates",otherPlayer,candidates)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GCPHONE:ACCEPTCALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("gcPhone:acceptCall")
AddEventHandler("gcPhone:acceptCall",function(infoCall,rtcAnswer)
	local id = infoCall["id"]

	if phoneEncoders[id] ~= nil then
		phoneEncoders[id]["receiver_src"] = infoCall["receiver_src"] or phoneEncoders[id]["receiver_src"]

		if phoneEncoders[id]["transmitter_src"] ~= nil and phoneEncoders[id]["receiver_src"] ~= nil then
			phoneEncoders[id]["is_accepts"] = true
			phoneEncoders[id]["rtcAnswer"] = rtcAnswer
			TriggerClientEvent("gcPhone:acceptCall",phoneEncoders[id]["transmitter_src"],phoneEncoders[id],true)
			TriggerClientEvent("gcPhone:acceptCall",phoneEncoders[id]["receiver_src"],phoneEncoders[id],false)
			saveCallings(phoneEncoders[id])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GCPHONE:REJECTCALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("gcPhone:rejectCall")
AddEventHandler("gcPhone:rejectCall",function(infoCall)
	local id = infoCall["id"]
	if phoneEncoders[id] ~= nil then
		if phoneEncoders[id]["transmitter_src"] ~= nil then
			TriggerClientEvent("gcPhone:rejectCall",phoneEncoders[id]["transmitter_src"])
		end

		if phoneEncoders[id]["receiver_src"] ~= nil then
			TriggerClientEvent("gcPhone:rejectCall",phoneEncoders[id]["receiver_src"])
		end

		if not phoneEncoders[id]["is_accepts"] then
			saveCallings(phoneEncoders[id])
		end

		TriggerEvent("gcPhone:removeCall",phoneEncoders)
		phoneEncoders[id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GCPHONE:APPELSDELETEHISTORIQUE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("gcPhone:appelsDeleteHistorique")
AddEventHandler("gcPhone:appelsDeleteHistorique",function(phoneNumber)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.execute("gcphone/cleanPhoneCallsbyNumber",{ owner = userPhones[tostring(user_id)], num = phoneNumber })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GCPHONE:APPELSDELETEALLHISTORIQUE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("gcPhone:appelsDeleteAllHistorique")
AddEventHandler("gcPhone:appelsDeleteAllHistorique",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.execute("gcphone/cleanPhoneCallbyOwner",{ owner = userPhones[tostring(user_id)] })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	local identity = vRP.userIdentity(user_id)
	if identity then
		userPhones[tostring(user_id)] = identity["phone"]

		TriggerClientEvent("gcPhone:myPhoneNumber",source,userPhones[tostring(user_id)])
		sendHistoriqueCall(source,userPhones[tostring(user_id)])

		local myContats = vRP.query("gcphone/getPhoneContacts",{ identifier = parseInt(user_id) })
		TriggerClientEvent("gcPhone:contactList",source,myContats)

		local myMessages = vRP.query("gcphone/getPhoneMessages",{ identifier = parseInt(user_id) })
		TriggerClientEvent("gcPhone:allMessage",source,myMessages)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GCPHONE:ALLUPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("gcPhone:allUpdate")
AddEventHandler("gcPhone:allUpdate",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.userIdentity(user_id)
		if identity then
			userPhones[tostring(user_id)] = identity["phone"]

			TriggerClientEvent("gcPhone:myPhoneNumber",source,userPhones[tostring(user_id)])
			sendHistoriqueCall(source,userPhones[tostring(user_id)])

			local myContats = vRP.query("gcphone/getPhoneContacts",{ identifier = parseInt(user_id) })
			TriggerClientEvent("gcPhone:contactList",source,myContats)

			local myMessages = vRP.query("gcphone/getPhoneMessages",{ identifier = parseInt(user_id) })
			TriggerClientEvent("gcPhone:allMessage",source,myMessages)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	if userPhones[tostring(user_id)] then
		userPhones[tostring(user_id)] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADREMOVEDAYS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	vRP.execute("gcphone/removeCallDays")
	vRP.execute("gcphone/removeMessageDays")
end)