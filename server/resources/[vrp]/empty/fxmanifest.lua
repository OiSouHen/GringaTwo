fx_version "bodacious"
game "gta5"

ui_page "web-side/index.html"

files {
	"web-side/*"
}

client_scripts {
	"@vrp/lib/utils.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server-side/*"
}