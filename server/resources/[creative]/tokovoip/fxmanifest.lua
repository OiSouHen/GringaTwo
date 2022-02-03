fx_version "bodacious"
game "gta5"

ui_page "nui/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"src/c_utils.lua",
	"client_config.lua",
	"src/c_main.lua",
	"src/c_TokoVoip.lua",
	"src/nuiProxy.js"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server_config.lua",
	"src/s_main.lua",
	"src/s_utils.lua"
}

files {
	"nui/index.html",
	"nui/style.css",
	"nui/script.js",
	"nui/microphone.png",
}

export "setPlayerData"
export "getPlayerData"
export "refreshAllPlayerData"
export "addPlayerToRadio"
export "removePlayerFromRadio"
export "clientRequestUpdateChannels"
export "isPlayerInChannel"