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
Tunnel.bindInterface("tablet",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local twitter = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTRACES
-----------------------------------------------------------------------------------------------------------------------------------------
--vRP.execute("vRP/show_winrace", { raceid = id } )

--function cRP.requestRanking(raceId)
--	local result = MySQL.Sync.fetchAll("SELECT * FROM vrp_races WHERE raceid = @raceId",{ ['@raceId'] = raceId })
--	local result = vRP.execute("vRP/show_winrace", { id = raceId, raceid = raceId } )
--	if result then
--		return result.raceId
--	end
--	return nil
--end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTMEDIA
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestMedia(media)
	if media == "Twitter" then
		return twitter
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MESSAGEMEDIA
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.messageMedia(message,page)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local text = ""
		local identity = vRP.getUserIdentity(user_id)
		if identity then
			if page == "Twitter" then
				text = "<b>@"..identity.name..""..identity.name2.."</b> · "..os.date("%H")..":"..os.date("%M").."<br>"..message
			end

			if page == "Twitter" then
				table.insert(twitter,{ text = text })
				TriggerClientEvent("tablet:updateMedia", -1, page, text, false)
				TriggerClientEvent("Notify",-1,"twitter","<b>@"..identity.name..""..identity.name2.."</b> públicou um novo Tweet.",1000)
--				TriggerClientEvent("sound:source",source,"softtick",0.5)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local twitterFile = LoadResourceFile("logsystem","twitter.json")

	twitter = json.decode(twitterFile)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:KICKALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:KickAll")
AddEventHandler("admin:KickAll",function()
	SaveResourceFile("logsystem","twitter.json",json.encode(twitter),-1)
end)