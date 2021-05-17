fx_version "bodacious"
game "gta5"

client_scripts {
	"@vrp/lib/utils.lua",
	"client/*.lua",
	"config/*.lua"
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	"@vrp/lib/utils.lua",
	"server/*.lua",
	"config/*.lua"
}