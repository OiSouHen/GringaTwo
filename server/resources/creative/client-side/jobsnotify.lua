-----------------------------------------------------------------------------------------------------------------------------------------
-- COORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local localidades = {
    [1] = { -- Lixeiro
        notifycoord = {79.31,-1556.61,29.6},
        header = function()
            if IsControlJustPressed(1,38) then 
                TriggerEvent("Notify","amarelo","Dê <b>/lixeiro</b> para começar a trabalhar.",10000)
            end
        end
    },
} 
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        for k,v in pairs(localidades) do
            local distance = #(coords - vector3(v.notifycoord[1],v.notifycoord[2],v.notifycoord[3]))
            if distance <= 5 then
                sleep = 4
                v.header()
            end
        end
        Citizen.Wait(sleep)
    end
end)