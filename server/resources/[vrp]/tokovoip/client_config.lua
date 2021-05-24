TokoVoipConfig = {
	refreshRate = 100, -- Rate at which the data is sent to the TSPlugin
	networkRefreshRate = 2000, -- Rate at which the network data is updated/reset on the local ped
	playerListRefreshRate = 5000, -- Rate at which the playerList is updated
	minVersion = "1.2.4", -- Version of the TS plugin required to play on the server

	distance = {
		5, -- Whisper speech distance in gta distance units
		10, -- Normal speech distance in gta distance units
		40, -- Shout speech distance in gta distance units
	},
	headingType = 1, -- headingType 0 uses GetGameplayCamRot, basing heading on the camera's heading, to match how other GTA sounds work. headingType 1 uses GetEntityHeading which is based on the character's direction
	radioKey = 137, -- Keybind used to talk on the radio
	keySwitchChannels = 212, -- Keybind used to switch the radio channels
	keySwitchChannelsSecondary = 118, -- If set, both the keySwitchChannels and keySwitchChannelsSecondary keybinds must be pressed to switch the radio channels
	keyProximity = 212, -- Keybind used to switch the proximity mode,
	radioClickMaxChannel = 1050,

	plugin_data = {
		TSChannel = "Conectado LSRP",
		TSPassword = "46564863", -- TeamSpeak channel password (can be empty)
		TSChannelWait = "Aguardando",
		TSServer = "lsrp.ts3pro.top", -- TeamSpeak server address to be displayed on blocking screen
		TSChannelSupport = "",
		TSDownload = "", 
		TSChannelWhitelist = { 
			"Staffs"
		},
		local_click_on = true, -- Is local click on sound active
		local_click_off = true, -- Is local click off sound active
		remote_click_on = true, -- Is remote click on sound active
		remote_click_off = true, -- Is remote click off sound active
		enableStereoAudio = false, -- If set to true, positional audio will be stereo (you can hear people more on the left or the right around you)

		localName = "", -- If set, this name will be used as the user's teamspeak display name
		localNamePrefix = "[ "..GetPlayerServerId(PlayerId()).." ]", -- If set, this prefix will be added to the user's teamspeak display name
	}
};

AddEventHandler("onClientResourceStart", function(resource)
	if (resource == GetCurrentResourceName()) then	--	Initialize the script when this resource is started
		Citizen.CreateThread(function()
			TokoVoipConfig.plugin_data.localName = "" -- Set the local name
		end);
		TriggerEvent("initializeVoip"); -- Trigger this event whenever you want to start the voip
	end
end)
