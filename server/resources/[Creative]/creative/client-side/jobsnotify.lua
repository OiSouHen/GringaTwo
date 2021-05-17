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
			    DrawText3D(v.notifycoord[1],v.notifycoord[2],v.notifycoord[3],"~g~E~w~  CONVERSAR")
                sleep = 4
                v.header()
            end
        end
        Citizen.Wait(sleep)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(176,180,193,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/350
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,50,55,67,200)
end