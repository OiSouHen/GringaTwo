-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("tablet",cnVRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local twitter = {}
local anonimo = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTTWITTER
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.requestMedia(media)
	if media == "Twitter" then
		return twitter
	elseif media == "Anonimo" then
		return anonimo
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTTWITTER
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.messageMedia(message,page)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local text = ""
		local identity = vRP.getUserIdentity(user_id)
		if identity then
			if page == "Anonimo" then
				text = "<b>Anônimo</b> <i>("..os.date("%H")..":"..os.date("%M")..")</i><b>:</b> "..message
			else
				text = "<i><b>"..identity.name.." "..identity.name2.."</b> - "..os.date("%H")..":"..os.date("%M")..":</i><br>"..message
			end

			if page == "Twitter" then
				if vRP.getPremium(user_id) then
					table.insert(twitter,{ text = text, back = true })
					TriggerClientEvent("tablet:updateMedia", -1, page, text, true )
				else
					table.insert(twitter,{ text = text })
					TriggerClientEvent("tablet:updateMedia", -1, page, text, false )
				end
				TriggerClientEvent("Notify",-1,"rosa","<b>@"..identity.name..""..identity.name2.."</b> públicou um novo Tweet.",1000)
				TriggerClientEvent("sound:source",source,"softtick",0.5)
			elseif page == "Anonimo" then
				table.insert(anonimo,{ text = text })
				TriggerClientEvent("tablet:updateMedia", -1, page, text, false )
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local twitterFile = LoadResourceFile("logsystem","twitter.json")
	local anonimoFile = LoadResourceFile("logsystem","anonimo.json")

	twitter = json.decode(twitterFile)
	anonimo = json.decode(anonimoFile)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:KICKALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:KickAll")
AddEventHandler("admin:KickAll",function()
	SaveResourceFile("logsystem","twitter.json",json.encode(twitter),-1)
end)