-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("dynamic",cnVRP)
vSERVER = Tunnel.getInterface("dynamic")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local homesList = {}
local blips = {}
local casas = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("moremenu", function(source, args, raw)
    TriggerEvent("dynamic:Menu")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("moremenu","Abrir o menu","keyboard","f7")
-----------------------------------------------------------------------------------------------------------------------------------------
-- MENU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('dynamic:Menu', function()
    TriggerEvent('dynamic:sendMenu', {
        {
            id = 1,
            header = "Jogador",
            txt = "Pessoa mais próxima de você.",
            params = {
                event = "dynamic:player",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
		{
            id = 4,
            header = "Propriedades",
            txt = "Todas as funções das propriedades.",
            params = {
                event = "dynamic:homes",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
        {
            id = 5,
            header = "Outros",
            txt = "Todas as funções do personagem.",
            params = {
                event = "dynamic:others",
                args = {
                    number = 2,
                    id = 3
                }
            }
        },
    })
end)

RegisterNetEvent('dynamic:homes', function(data)
    TriggerEvent('dynamic:sendMenu', {
        {
            id = 1,
            header = "<i class='fas fa-chevron-left'></i> Voltar",
            txt = "Volte ao menu anterior.",
			params = {
                event = "dynamic:Menu"
            }
        },
        {
            id = 2,
            header = "Propriedades",
            txt = "Ativa/Desativa as propriedades no mapa.",
			params = {
                event = "dynamic:casas",
            }
        },
    })
end)

RegisterNetEvent('dynamic:player', function(data)
    TriggerEvent('dynamic:sendMenu', {
        {
            id = 1,
            header = "<i class='fas fa-chevron-left'></i> Voltar",
            txt = "Volte ao menu anterior.",
			params = {
                event = "dynamic:Menu"
            }
        },
        {
            id = 2,
            header = "Colocar no Veículo",
            txt = "Colocar pessoa no veículo mais próximo.",
			params = {
                event = "dynamic:cveiculo",
            }
        },
        {
            id = 3,
            header = "Remover do Veiculo",
            txt = "Remover pessoa do veículo mais proximo.",
			params = {
                event = "dynamic:rveiculo",
            }
        },
        {
            id = 4,
            header = "Checar Porta-Malas",
            txt = "Vericar pessoa dentro do mesmo.",
			params = {
                event = "dynamic:checktrunk",
            }
        }
    })
end)

RegisterNetEvent('dynamic:others', function(data)
    TriggerEvent('dynamic:sendMenu', {
        {
            id = 1,
            header = "<i class='fas fa-chevron-left'></i> Voltar",
            txt = "Volte ao menu anterior.",
			params = {
                event = "dynamic:Menu"
            }
        },
        {
            id = 2,
            header = "Informações",
            txt = "Todas as informações de sua identidade.",
			params = {
                event = "dynamic:myinfos",
            }
        }
    })
end)

RegisterNetEvent('dynamic:myinfos', function()
local infos = vSERVER.getInfos()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- cveiculo
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('dynamic:cveiculo', function()
    vSERVER.cveiculo()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- cveiculo
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('dynamic:rveiculo', function()
    vSERVER.rveiculo()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- checktrunk
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('dynamic:checktrunk', function()
    vSERVER.ctrunk()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEHOMES
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.updateHomes(status)
	homesList = status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CASAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('dynamic:casas', function(source,args)
	casas = not casas

	if casas then
		TriggerEvent("Notify","sucesso","Adicionado a marcação das residências.",3000)
		for k,v in pairs(homesList) do
			blips[k] = AddBlipForRadius(v[5],v[6],v[7],5.0)
			SetBlipAlpha(blips[k],255)
			SetBlipColour(blips[k],75)
		end
	else
		TriggerEvent("Notify","sucesso","Removido a marcação das residências.",3000)
		for k,v in pairs(blips) do
			if DoesBlipExist(v) then
				RemoveBlip(v)
			end
		end

		blips = {}
	end
end)

RegisterNUICallback("dataPost", function(data, cb)
    SetNuiFocus(false)
    TriggerEvent(data.event, data.args)
    cb('ok')
end)

RegisterNUICallback("cancel", function()
    SetNuiFocus(false)
end)

RegisterNetEvent('dynamic:sendMenu', function(data)
    if not data then return end
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "OPEN_MENU",
        data = data
    })
end)