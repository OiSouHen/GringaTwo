-----------------------------------------------------------------------------------------------------------------------------------------
-- COORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local localidades = {
    [1] = { -- Lixeiro
        notifycoord = {78.04,-1536.51,29.47},
        header = function()
            if IsControlJustPressed(1,38) then 
                TriggerEvent("Notify","amarelo","Dê <b>/lixeiro</b> para iniciar ou finalizar o serviço.",5000)
            end
        end
    },
	[2] = { -- Transportador
        notifycoord = {354.72,269.84,103.02},
        header = function()
            if IsControlJustPressed(1,38) then 
                TriggerEvent("Notify","amarelo","Dê <b>/transportador</b> para iniciar ou finalizar o serviço.",5000)
            end
        end
    },
	[3] = { -- Motorista
        notifycoord = {453.68,-600.56,28.6},
        header = function()
            if IsControlJustPressed(1,38) then 
                TriggerEvent("Notify","amarelo","Dê <b>/motorista</b> para iniciar ou finalizar o serviço.",5000)
            end
        end
    },
	[4] = { -- Lenhador
        notifycoord = {-555.2,5364.38,70.43},
        header = function()
            if IsControlJustPressed(1,38) then 
                TriggerEvent("Notify","amarelo","Dê <b>/lenhador</b> para iniciar ou finalizar o serviço.",5000)
            end
        end
    },
	[5] = { -- Colheita
        notifycoord = {406.04,6526.17,27.75},
        header = function()
            if IsControlJustPressed(1,38) then 
                TriggerEvent("Notify","amarelo","Dê <b>/colheita</b> para iniciar ou finalizar o serviço.",5000)
            end
        end
    }
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
            if distance <= 1.5 then
                sleep = 4
                v.header()
            end
        end
        Citizen.Wait(sleep)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local innerTable = {}
	for k,v in pairs(localidades) do
		table.insert(innerTable,{ v.notifycoord[1],v.notifycoord[2],v.notifycoord[3],2,"E","Trabalhar","Pressione para conversar" })
	end

	TriggerEvent("hoverfy:insertTable",innerTable)
end)