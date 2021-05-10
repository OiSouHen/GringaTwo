fx_version "bodacious"
game "gta5"

ui_page "web-side/index.html"

server_scripts {
	"lib/utils.lua",
	"base.lua",
	"queue.lua",
	"server-side/*"
}

client_scripts {
	"lib/utils.lua",
	"client-side/*"
}

files {
	"loading/index.html",	
    'loading/assets/js/ui.js',
	'loading/assets/img/background.jpg',
	'loading/assets/img/dlgames.png',
	'loading/assets/img/lsrp.png',
    'loading/assets/fonts/BebasNeue.otf',
    'loading/assets/fonts/BebasNeue.ttf',
	'loading/assets/css/style.css',
    'loading/index.js',
    'loading/musi.mp3',
	"web-side/*",
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	"lib/Luaseq.lua",
	"lib/Tools.lua"
}


loadscreen "loading/index.html"
--loadscreen_manual_shutdown "yes"