TokoVoip = {};
TokoVoip.__index = TokoVoip;
local lastTalkState = false

function TokoVoip.init(self, config)
	local self = setmetatable(config, TokoVoip);
	self.config = json.decode(json.encode(config));
	self.lastNetworkUpdate = 0;
	self.lastPlayerListUpdate = self.playerListRefreshRate;
	self.playerList = {};
	return (self);
end

function TokoVoip.loop(self)
	Citizen.CreateThread(function()
		while (true) do
			Citizen.Wait(self.refreshRate);
			self:processFunction();
			self:sendDataToTS3();

			self.lastNetworkUpdate = self.lastNetworkUpdate + self.refreshRate;
			self.lastPlayerListUpdate = self.lastPlayerListUpdate + self.refreshRate;
			if (self.lastNetworkUpdate >= self.networkRefreshRate) then
				self.lastNetworkUpdate = 0;
				self:updateTokoVoipInfo();
			end
			if (self.lastPlayerListUpdate >= self.playerListRefreshRate) then
				self.playerList = GetActivePlayers();
				self.lastPlayerListUpdate = 0;
			end
		end
	end);
end

function TokoVoip.sendDataToTS3(self) -- Send usersdata to the Javascript Websocket
	self:updatePlugin("updateTokoVoip", self.plugin_data);
end

function TokoVoip.updateTokoVoipInfo(self,forceUpdate)
	local info = self.mode

	if (info == self.screenInfo and not forceUpdate) then
		return
	end

	self.screenInfo = info
	self:updatePlugin("updateTokovoipInfo",info)
end

function TokoVoip.updatePlugin(self, event, payload)
	exports.tokovoip:doSendNuiMessage(event, payload);
end

function TokoVoip.updateConfig(self)
	local data = self.config;
	data.plugin_data = self.plugin_data;
	data.pluginVersion = self.pluginVersion;
	data.pluginStatus = self.pluginStatus;
	data.pluginUUID = self.pluginUUID;
	self:updatePlugin("updateConfig", data);
end

function TokoVoip.initialize(self)
	self:updateConfig()
	self:updatePlugin("initializeSocket",nil)

	Citizen.CreateThread(function()
		while true do
			local ped = PlayerPedId()

			if IsControlJustPressed(1,self.keyProximity) then
				if not self.mode then
					self.mode = 2
				end

				self.mode = self.mode + 1

				if self.mode > 3 then
					self.mode = 1
				end

				TriggerEvent("hud:VoiceMode",self.mode)
				setPlayerData(self.serverId,"voip:mode",self.mode,true)
				self:updateTokoVoipInfo()
			end

			if (IsControlPressed(1,self.radioKey) and self.plugin_data.radioChannel ~= -1) and not IsEntityInWater(ped) and not IsPlayerFreeAiming(PlayerId()) then
				self.plugin_data.radioTalking = true
				self.plugin_data.localRadioClicks = true

				if self.plugin_data.radioChannel > 1000 then
					self.plugin_data.localRadioClicks = false
				end

				if not getPlayerData(self.serverId,"radio:talking") then
					setPlayerData(self.serverId,"radio:talking",true,true)
				end

				self:updateTokoVoipInfo()

				if (not lastTalkState and self.myChannels[self.plugin_data.radioChannel]) then
					if (not IsPedInAnyVehicle(ped) and self.plugin_data.radioChannel < 1000) then
						RequestAnimDict("random@arrests")
						while not HasAnimDictLoaded("random@arrests") do
							RequestAnimDict("random@arrests")
							Citizen.Wait(10)
						end

						TaskPlayAnim(ped,"random@arrests","generic_radio_chatter",8.0,0.0,-1,49,0,0,0,0)
					end
					lastTalkState = true
				end
			else
				self.plugin_data.radioTalking = false
				if getPlayerData(self.serverId,"radio:talking") then
					setPlayerData(self.serverId,"radio:talking",false,true)
				end

				self:updateTokoVoipInfo()

				if lastTalkState then
					lastTalkState = false
					StopAnimTask(ped,"random@arrests","generic_radio_chatter",-4.0)
				end
			end

			Citizen.Wait(5)
		end
	end)
end

function TokoVoip.disconnect(self)
	self:updatePlugin("disconnect");
end
