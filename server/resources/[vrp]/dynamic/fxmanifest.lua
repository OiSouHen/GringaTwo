fx_version "bodacious"
game "gta5"

ui_page "web-side/index.html"

client_scripts {
	"@vrp/server-side/garages.lua",
	"@vrp/server-side/inventory.lua",
	"@PolyZone/client.lua",
	"@vrp/lib/utils.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/server-side/garages.lua",
	"@vrp/server-side/inventory.lua",
	"@vrp/lib/utils.lua",
	"server-side/*"
}

files {
	"web-side/*",
	"web-side/**/*"
}

exports {
	"AddButton","SetTitle"
}