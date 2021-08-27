function TchatGetMessageChannel(channel,cb)
	local consult = vRP.query("gcphone/getChatMessages",{ channel = channel })
	return consult
end

function TchatAddMessage(channel,message)
	vRP.execute("gcphone/addChatMessages",{ channel = channel, message = message })

	local consult = vRP.query("gcphone/getChatMessagesId",{ channel = channel })
	TriggerClientEvent("gcPhone:tchat_receive",-1,consult[1])
end

RegisterServerEvent("gcPhone:tchat_channel")
AddEventHandler("gcPhone:tchat_channel",function(channel)
	local source = source
	local consult = vRP.query("gcphone/getChatMessages",{ channel = channel })
	TriggerClientEvent("gcPhone:tchat_channel",source,channel,consult)
end)

RegisterServerEvent("gcPhone:tchat_addMessage")
AddEventHandler("gcPhone:tchat_addMessage",function(channel,message)
	TchatAddMessage(channel,message)
end)