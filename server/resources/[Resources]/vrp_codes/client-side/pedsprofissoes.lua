----------------------------------------------------------------------------------------------------------------------------------------
local localidades = {
    [1] = {
        blip = {452.96,-607.76,28.6},
        ped = {
            452.96,-607.76,28.6,267.89,0xE7565327,"cs_andreas","anim@heists@heist_corona@single_team","single_team_loop_boss"
        },
        text = "Pressione ~g~E~w~ para Informações",
        header = function()
            if IsControlJustPressed(1,38) then 
                TriggerEvent("Notify","importante","Mentalize /motorista para iniciar a rota logo apos retire seu veiculo na garagem")
				TriggerEvent("vrp_sound:source","quite",0.5)
            end
        end
    },
    [2] = {
        blip = {-427.38,-2786.41,6.01},
        ped = {
            -427.38,-2786.41,6.01,320.34,0xE7565327,"cs_andreas","anim@heists@heist_corona@single_team","single_team_loop_boss"
        },
        text = "Pressione ~g~E~w~ para Informações",
        header = function()
            if IsControlJustPressed(1,38) then 
                TriggerEvent("Notify","importante","Mentalize /motorista para iniciar a rota logo apos retire seu veiculo na garagem")
				TriggerEvent("vrp_sound:source","quite",0.5)
            end
        end
    },
} 
local localPeds = {}
Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped))
        for k,v in pairs(localidades) do
            local distance = Vdist2(x,y,z,v.ped[1],v.ped[2],v.ped[3])
            if distance <= 500.0 then
                if localPeds[k] == nil then
                    RequestModel(GetHashKey(v.ped[6]))
                    while not HasModelLoaded(GetHashKey(v.ped[6])) do
                        RequestModel(GetHashKey(v.ped[6]))
                        Citizen.Wait(10)
                    end
                    localPeds[k] = CreatePed(4,v.ped[5],v.ped[1],v.ped[2],v.ped[3]-1,v.ped[4],false,true)
                    SetEntityInvincible(localPeds[k],true)
                    FreezeEntityPosition(localPeds[k],true)
                    SetBlockingOfNonTemporaryEvents(localPeds[k],true)
                    if v.ped[7] ~= nil then
                        RequestAnimDict(v.ped[7])
                        while not HasAnimDictLoaded(v.ped[7]) do
                            RequestAnimDict(v.ped[7])
                            Citizen.Wait(10)
                        end
                        TaskPlayAnim(localPeds[k],v.ped[7],v.ped[8],8.0,0.0,-1,1,0,0,0,0)
                    end
                end
            else
                if localPeds[k] then
                    DeleteEntity(localPeds[k])
                    localPeds[k] = nil
                end
            end
        end
        Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        for k,v in pairs(localidades) do
            local distance = #(coords - vector3(v.blip[1],v.blip[2],v.blip[3]))
            if distance <= 5 then
                sleep = 4
				DrawText3D(v.blip[1],v.blip[2],v.blip[3],v.text)
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
    SetTextScale(0.50,0.50)
    SetTextColour(255,255,255,180)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 400
	DrawRect(_x,_y+0,1+factor,0,0,0,0,180)
end