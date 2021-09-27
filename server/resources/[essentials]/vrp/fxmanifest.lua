fx_version "bodacious"
game "gta5"

ui_page "web-side/index.html"

server_scripts {
	"lib/utils.lua",
	"server-side/*",
	"base.lua",
	"queue.lua"
}

client_scripts {
	"lib/utils.lua",
	"client-side/*"
}

files {
    "web-side/*",
	"loading/*",
	"lib/*"
}

loadscreen "loading/index.html"