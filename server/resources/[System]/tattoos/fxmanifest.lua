fx_version 'adamant'
game {'gta5'}

ui_page "nui/index.html"

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}

client_scripts {
	"@vrp/lib/utils.lua",
	"cfg/tattoos.lua",
	"client.lua"
}

files {
	"nui/index.html",
	"nui/index.js",
	"nui/style.css",
	"nui/assets/*.png"
}