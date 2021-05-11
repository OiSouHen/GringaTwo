-----------------------------------------------------------------------------------------------------------------------------------------
-- COORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local localidades = {
    [1] = { -- Lixeiro
        notifycoord = {-341.2,-1567.73,25.23},
        header = function()
            if IsControlJustPressed(1,38) then 
                TriggerEvent("Notify","job-garbageman1","<div style='opacity: 0.7;'><i>Aviso de Trabalho</i></div>Para trabalhar de <b>Lixeiro</b> você precisa do caminhão de lixo.<br>Inicie e encerre seu turno de lixeiro mentalizando <b>/lixeiro</b>.",15000)
                TriggerEvent("vrp_sound:source","juntos",0.5)
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