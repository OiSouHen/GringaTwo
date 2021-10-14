TokoVoipConfig = {
	refreshRate = 100,
	networkRefreshRate = 2000,
	playerListRefreshRate = 5000,
	minVersion = "1.2.4",
	distance = {5,10,20,},
	headingType = 1,
	radioKey = 137,
	keySwitchChannels = 212,
	keySwitchChannelsSecondary = 118,
	keyProximity = 212,
	radioClickMaxChannel = 1050,

	plugin_data = {
		TSChannel = "Conectado",
		TSPassword = "Havai@1234",
		TSChannelWait = "Aguardando",
		TSServer = "177.54.156.227:10010",
		local_click_on = true,
		local_click_off = true,
		remote_click_on = true,
		remote_click_off = true,
		enableStereoAudio = false,
		localName = "",
		localNamePrefix = "["..GetPlayerServerId(PlayerId()).."]",
	}
};

AddEventHandler("onClientResourceStart", function(resource)
	if (resource == GetCurrentResourceName()) then
		Citizen.CreateThread(function()
			TokoVoipConfig.plugin_data.localName = " Havaiano"
		end);
		TriggerEvent("initializeVoip");
	end
end)
