local Proxy = module("vrp", "lib/Proxy")
local vRP = Proxy.getInterface("vRP")

local API = exports["ghmattimysql"]

local function on_init(cfg)
    -- no init (external connection)
    return API ~= nil
end

local queries = {}

local function on_prepare(name, query)
    queries[name] = query
end

local function on_query(name, params, mode)
    local query = queries[name]

    local _params = {}
    _params._ = true -- force as dictionary

    for k, v in pairs(params) do
        _params["@" .. k] = v
    end

    local r = async()

    if mode == "execute" then
        API:execute(query, _params, function(data)
            r(data.affectedRows or 0)
        end)

    elseif mode == "scalar" then
        API:scalar(query, _params, function(scalar)
            r(scalar)
        end)
    else
        API:execute(query, _params, function(rows)
            if #rows == 0 and rows.affectedRows ~= nil and (rows.affectedRows > 0 or rows.changeRows > 0) then
                rows = {
                    [1] = rows
                }
            end

            r(rows, #rows)
        end)
    end

    return r:wait()
end

Citizen.CreateThread(function()
    vRP.registerDBDriver("ghmattimysql", on_init, on_prepare, on_query)
end)