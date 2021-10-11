client_script "@ThnAC/natives.lua"
fx_version "bodacious"
game "gta5"

ui_page "web-side/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"server-side/*"
}

files {
	"web-side/*",
	"web-side/**/*"
}