-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("trucker",cRP)
vSERVER = Tunnel.getInterface("trucker")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local timer = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentMethod()
    local src = source
    local user_id = vRP.getUserId(src)
    local value = math.random(2300,4000)
    if user_id then
        vRP.giveInventoryItem(user_id,"dollars",value,true)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SDKA
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.sdka(timer2)
    local src = source
    local user_id = vRP.getUserId(src)
    timer[user_id] = timer2
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMERSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.timersevice()
    local src = source
    local user_id = vRP.getUserId(src)
    if timer[user_id] ~= nil then
        fulltime = timer[user_id]
        hours = 0
        minutes = 0
        seconds = 0
        
        if fulltime/3600 >= 1 then
            hours = (fulltime-(fulltime%3600))/3600
            fulltime = fulltime - (fulltime-(fulltime%3600) )
            if hours < 10 then
                hours = "0" .. tostring(hours)
            end
        end

        if fulltime/60 >= 1 then
            minutes = (fulltime-(fulltime%60))/60
            fulltime = fulltime - (fulltime-(fulltime%60) )
            if minutes < 10 then
                minutes = "0" .. tostring(minutes)
            end
        end

        seconds = fulltime

        if seconds < 10 then
            seconds = "0" .. tostring(seconds)
            
        end

        TriggerClientEvent("Notify",src,"vermelho","Aguarde <b>".. string.sub(hours, 1, 2) .. ":" .. string.sub(minutes, 1, 2) .. ":" .. string.sub(seconds, 1, 2),5000)
        return false
    else 
        return true
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        if timer[k] ~= nil then
            timer[k] = timer[k] - 1
            if time[k] <= 0 then
                timer[k] = 0
            end
        end
        
        Citizen.Wait(1000)
    end
end)
