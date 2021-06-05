-----------------------------------------------------------------------------------------------------------------------------------------
-- COORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local localidades = {
    [1] = { -- Lixeiro
	    name = "Lixeiro",
        notifycoord = {81.82,-1554.86,29.6},
        header = function()
            if IsControlJustPressed(1,38) then 
                TriggerEvent("Notify","amarelo","Dê <b>/lixeiro</b> para iniciar ou finalizar o serviço.",5000)
            end
        end
    },
	[2] = { -- Transportador
		name = "Transportador",
        notifycoord = {354.14,270.56,103.02},
        header = function()
            if IsControlJustPressed(1,38) then 
                TriggerEvent("Notify","amarelo","Dê <b>/transportador</b> para iniciar ou finalizar o serviço.",5000)
            end
        end
    },
	[3] = { -- Motorista
		name = "Motorista",
        notifycoord = {452.97,-607.75,28.59},
        header = function()
            if IsControlJustPressed(1,38) then 
                TriggerEvent("Notify","amarelo","Dê <b>/motorista</b> para iniciar ou finalizar o serviço.",5000)
            end
        end
    },
	[4] = { -- Lenhador
		name = "Lenhador",
        notifycoord = {-555.2,5364.38,70.43},
        header = function()
            if IsControlJustPressed(1,38) then 
                TriggerEvent("Notify","amarelo","Dê <b>/lenhador</b> para iniciar ou finalizar o serviço.",5000)
            end
        end
    },
	[5] = { -- Colheita
		name = "Colheita",
        notifycoord = {406.04,6526.17,27.75},
        header = function()
            if IsControlJustPressed(1,38) then 
                TriggerEvent("Notify","amarelo","Dê <b>/colheita</b> para iniciar ou finalizar o serviço.",5000)
            end
        end
    },
	[5] = { -- Minerador
		name = "Minerador",
        notifycoord = {-594.72,2090.05,131.65},
        header = function()
            if IsControlJustPressed(1,38) then 
                TriggerEvent("Notify","amarelo","Dê <b>/minerador</b> para iniciar ou finalizar o serviço.",5000)
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
            if distance <= 1 then
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
		table.insert(innerTable,{ v.notifycoord[1],v.notifycoord[2],v.notifycoord[3],2,"E",v["name"],"Pressione para conversar" })
	end

	TriggerEvent("hoverfy:insertTable",innerTable)
end)