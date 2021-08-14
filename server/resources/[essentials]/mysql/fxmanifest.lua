fx_version "adamant"
games {"gta5"}

description "vRP ghmattimysql (JS) db driver bridge"

dependencies{
    "vrp",
    "ghmattimysql"
}

-- server scripts
server_scripts{
    "@vrp/lib/utils.lua",
    "init.lua"
}
