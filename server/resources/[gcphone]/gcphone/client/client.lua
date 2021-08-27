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
Tunnel.bindInterface("gcphone",cRP)
vSERVER = Tunnel.getInterface("gcphone")
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYTOUCHECLOSEEVENT
-----------------------------------------------------------------------------------------------------------------------------------------
local KeyToucheCloseEvent = {
	{ code = 172, event = "ArrowUp" },
	{ code = 173, event = "ArrowDown" },
	{ code = 174, event = "ArrowLeft" },
	{ code = 175, event = "ArrowRight" },
	{ code = 176, event = "Enter" },
	{ code = 177, event = "Backspace" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local contacts = {}
local messages = {}
local inCall = false
local useMouse = false
local menuIsOpen = false
local ignoreFocus = false
local phoneActive = false
local tokovoipNumber = nil
local activePrison = false
local lastFrameIsOpen = false
local frontCamera = false
local showCamera = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCELPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("openCelphone",function(source,args)
	if not exports["inventory"]:blockInvents() or exports["player"]:blockCommands() or exports["player"]:handCuff()  then
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 and not IsEntityInWater(ped) and vSERVER.checkPhone() and not activePrison then
			if not menuIsOpen then
				menuIsOpen = true
				vRP._removeObjects("one")
				SendNUIMessage({ show = true })
				TriggerEvent("status:celular",true)
				vRP._createObjects("cellphone@","cellphone_text_in","prop_npc_phone_02",50,28422)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("radio:activePrison")
AddEventHandler("radio:activePrison",function(status)
	activePrison = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("gcphone:removePhone")
AddEventHandler("gcphone:removePhone",function()
	if menuIsOpen then
		menuIsOpen = false
		vRP._removeObjects("one")
		SendNUIMessage({ show = false })
		TriggerEvent("status:celular",false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCELPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("openCelphone","Abrir/Fechar o celular","keyboard","k")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if menuIsOpen then
			timeDistance = 4

			for _,value in ipairs(KeyToucheCloseEvent) do
				if IsControlJustPressed(1,value["code"]) then
					SendNUIMessage({ keyUp = value.event })
				end
			end

			local nuiFocus = useMouse and not ignoreFocus
			SetNuiFocus(nuiFocus,nuiFocus)
			lastFrameIsOpen = true
		else
			if lastFrameIsOpen then
				SetNuiFocus(false,false)
				lastFrameIsOpen = false
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("gcPhone:activePhone")
AddEventHandler("gcPhone:activePhone",function()
	if phoneActive then
		phoneActive = false
		TriggerEvent("Notify","azul","Desativado o modo avião.",3000)
	else
		phoneActive = true
		TriggerEvent("Notify","azul","Ativado o modo avião.",3000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MYPHONENUMBER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("gcPhone:myPhoneNumber")
AddEventHandler("gcPhone:myPhoneNumber",function(myPhoneNumber)
	SendNUIMessage({ event = "updateMyPhoneNumber", myPhoneNumber = myPhoneNumber })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTACTLIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("gcPhone:contactList")
AddEventHandler("gcPhone:contactList",function(_contacts)
	SendNUIMessage({ event = "updateContacts", contacts = _contacts })
	contacts = _contacts
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALLMESSAGES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("gcPhone:allMessage")
AddEventHandler("gcPhone:allMessage",function(allmessages)
	SendNUIMessage({ event = "updateMessages", messages = allmessages })
	messages = allmessages
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECEIVEMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("gcPhone:receiveMessage")
AddEventHandler("gcPhone:receiveMessage",function(message)
	SendNUIMessage({ event = "newMessage", message = message })

	if message["owner"] == 0 and vSERVER.checkPhone() and not IsEntityInWater(PlayerPedId()) and not phoneActive then
		PlaySoundFrontend(-1,"Menu_Accept","Phone_SoundSet_Default",false)
	end

	if message["owner"] == 0 and phoneActive then
		TriggerEvent("Notify","verde","Mensagem recebida.",3000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAITINGCALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("gcPhone:waitingCall")
AddEventHandler("gcPhone:waitingCall",function(infoCall,initiator)
	if not initiator and vSERVER.checkPhone() and not phoneActive then
		SendNUIMessage({ event = "waitingCall", infoCall = infoCall, initiator = initiator })
	end

	if not initiator and phoneActive then
		TriggerEvent("Notify","verde","Chamada recebida.",3000)
	end

	if initiator then
		inCall = true
		SendNUIMessage({ event = "waitingCall", infoCall = infoCall, initiator = initiator })
		vRP._createObjects("cellphone@","cellphone_text_to_call","prop_npc_phone_02",50,28422)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACCEPTCALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("gcPhone:acceptCall")
AddEventHandler("gcPhone:acceptCall",function(infoCall,initiator)
	exports["tokovoip_script"]:addPlayerToRadio(infoCall["id"])
	tokovoipNumber = infoCall["id"]

	inCall = true

	vRP._createObjects("cellphone@","cellphone_text_to_call","prop_npc_phone_02",50,28422)
	SendNUIMessage({ event = "acceptCall", infoCall = infoCall, initiator = initiator })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REJECTCALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("gcPhone:rejectCall")
AddEventHandler("gcPhone:rejectCall",function(infoCall)
	if tokovoipNumber ~= nil then
		exports["tokovoip_script"]:removePlayerFromRadio(tokovoipNumber)
		tokovoipNumber = nil
	end

	if inCall then
		inCall = false
		vRP._createObjects("cellphone@","cellphone_text_in","prop_npc_phone_02",50,28422)
	end

	SendNUIMessage({ event = "rejectCall", infoCall = infoCall })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HISTORIQUECALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("gcPhone:historiqueCall")
AddEventHandler("gcPhone:historiqueCall",function(historique)
	SendNUIMessage({ event = "historiqueCall", historique = historique })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTCALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("startCall",function(data,cb)
	TriggerServerEvent("gcPhone:startCall",data["numero"],data["rtcOffer"],data["extraData"])

	cb()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLNOTIFYPUSH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("gcPhone:callNotifyPush")
AddEventHandler("gcPhone:callNotifyPush",function(number)
	if not IsEntityInWater(PlayerPedId()) and vSERVER.checkPhone() then
		menuIsOpen = true
		SendNUIMessage({ show = true })
		TriggerEvent("status:celular",true)
		vRP._createObjects("cellphone@","cellphone_text_in","prop_npc_phone_02",50,28422)

		Citizen.Wait(1000)

		TriggerServerEvent("gcPhone:startCall",tostring(number),nil,nil)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACCEPTCALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("acceptCall",function(data,cb)
	TriggerServerEvent("gcPhone:acceptCall",data["infoCall"],data["rtcAnswer"])

	cb()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REJECTCALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rejectCall",function(data,cb)
	TriggerServerEvent("gcPhone:rejectCall",data["infoCall"])

	cb()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- IGNORECALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ignoreCall",function(data,cb)
	TriggerServerEvent("gcPhone:ignoreCall",data["infoCall"])

	cb()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFYUSERTC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("notififyUseRTC",function(use,cb)
	if tokovoipNumber ~= nil then
		exports["tokovoip_script"]:removePlayerFromRadio(tokovoipNumber)
		tokovoipNumber = nil
	end

	cb()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCANDIDATES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("onCandidates",function(data,cb)
	TriggerServerEvent("gcPhone:candidates",data["id"],data["candidates"])

	cb()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANDIDATES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("gcPhone:candidates")
AddEventHandler("gcPhone:candidates",function(candidates)
	SendNUIMessage({ event = "candidatesAvailable", candidates = candidates })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTOCALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("gcphone:autoCall")
AddEventHandler("gcphone:autoCall",function(number,extraData)
	if number ~= nil then
		SendNUIMessage({ event = "autoStartCall", number = number, extraData = extraData })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTOCALLNUMBER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("gcphone:autoCallNumber")
AddEventHandler("gcphone:autoCallNumber",function(data)
	TriggerEvent("gcphone:autoCall",data.number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTOACCEPTCALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("gcphone:autoAcceptCall")
AddEventHandler("gcphone:autoAcceptCall",function(infoCall)
	SendNUIMessage({ event = "autoAcceptCall", infoCall = infoCall })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("log",function(data,cb)
	cb()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("focus",function(data,cb)
	cb()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLUR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("blur",function(data,cb)
	cb()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPONSETEXT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("reponseText",function(data,cb)
	local text = data["text"] or ""

	DisplayOnscreenKeyboard(1,"FMMC_MPM_NA","",text,"","","",250)
	while UpdateOnscreenKeyboard() == 0 do
		DisableAllControlActions(0)
		Citizen.Wait(1)
	end

	if GetOnscreenKeyboardResult() then
		text = GetOnscreenKeyboardResult()
	end

	if text ~= nil and text ~= "" then
		cb(json.encode({ text = text }))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETMESSAGES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("getMessages",function(data,cb)
	cb(json.encode(messages))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MATHLEGTH
-----------------------------------------------------------------------------------------------------------------------------------------
function mathLegth(n)
	return math.ceil(n * 100) / 100
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sendMessage",function(data,cb)
	if data["message"] == "%pos%" then
		local myPos = GetEntityCoords(PlayerPedId())
		data["message"] = "Localização: "..mathLegth(myPos["x"])..", "..mathLegth(myPos["y"])
	end

	TriggerServerEvent("gcPhone:sendMessage",data["phoneNumber"],data["message"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("deleteMessage",function(data,cb)
	for k,v in ipairs(messages) do
		if v["id"] == id then
			table.remove(messages,k)
			TriggerServerEvent("gcPhone:deleteMessage",id)
			SendNUIMessage({ event = "updateMessages", messages = messages })
			break
		end
	end

	cb()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEMESSAGENUMBER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("deleteMessageNumber",function(data,cb)
	TriggerServerEvent("gcPhone:deleteMessageNumber",data["number"])

	cb()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEALLMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("deleteAllMessage",function(data,cb)
	TriggerServerEvent("gcPhone:deleteAllMessage")

	cb()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETREADMESSAGENUMBER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("setReadMessageNumber",function(data,cb)
	for k,v in ipairs(messages) do
		if v["transmitter"] == data["number"] then
			TriggerServerEvent("gcPhone:setReadMessageNumber",data["number"])
			v["isRead"] = 1
			break
		end
	end

	cb()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCONTACT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("addContact",function(data,cb) 
	TriggerServerEvent("gcPhone:addContact",data["display"],data["phoneNumber"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECONTACT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateContact",function(data,cb)
	TriggerServerEvent("gcPhone:updateContact",data["id"],data["display"],data["phoneNumber"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETECONTACT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("deleteContact",function(data,cb)
	TriggerServerEvent("gcPhone:deleteContact",data["id"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCONTACTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("getContacts",function(data,cb)
	cb(json.encode(contacts))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETGPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("setGPS",function(data,cb)
	SetNewWaypoint(tonumber(data["x"]),tonumber(data["y"]))

	cb()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLEVENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("callEvent",function(data,cb)
	local eventName = data["eventName"] or ""
	if string.match(eventName,"gcphone") then
		if data["data"] ~= nil then 
			TriggerEvent(data["eventName"],data["data"])
		else
			TriggerEvent(data["eventName"])
		end
	end

	cb()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEMOUSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("useMouse",function(number,cb)
	useMouse = number
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("deleteALL",function(data,cb)
	TriggerServerEvent("gcPhone:deleteALL")

	cb()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSEPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closePhone",function(data,cb)
	menuIsOpen = false
	SendNUIMessage({ show = false })
	TriggerEvent("status:celular",false)
	vRP._playAnim(true,{"cellphone@","cellphone_text_out"},false)
	Citizen.Wait(400)
	vRP._removeObjects("one")

	cb()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPELSDELETEHISTORIQUE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("appelsDeleteHistorique",function(data,cb)
	TriggerServerEvent("gcPhone:appelsDeleteHistorique",data["numero"])

	cb()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPELSDELETEALLHISTORIQUE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("appelsDeleteAllHistorique",function(data,cb)
	TriggerServerEvent("gcPhone:appelsDeleteAllHistorique")

	cb()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(res)
	if res == "gcphone" then
		TriggerServerEvent("gcPhone:allUpdate")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETIGNOREFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("setIgnoreFocus",function(data,cb)
	ignoreFocus = data["ignoreFocus"]
	cb()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FAKETAKEPHOTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("faketakePhoto",function(data,cb)
	SendNUIMessage({ show = false })
	menuIsOpen = false

	showCamera = true
	CreateMobilePhone(1)
	vRP._removeObjects("one")
	CellCamActivate(true,true)
	TriggerEvent("hudActived",false)
	TriggerEvent("status:celular",false)

	cb()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CELLFRONTCAMACTIVATE
-----------------------------------------------------------------------------------------------------------------------------------------
function CellFrontCamActivate(activate)
	return Citizen.InvokeNative(0x2491A93618B7D838,activate)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if showCamera then
			timeDistance = 4

			if IsControlJustPressed(1,177) then
				showCamera = false
				DestroyMobilePhone()
				CellCamActivate(false,false)

				menuIsOpen = true
				TriggerEvent("hudActived",true)
				SendNUIMessage({ show = true })
				TriggerEvent("status:celular",true)
				vRP._createObjects("cellphone@","cellphone_text_in","prop_npc_phone_02",50,28422)
			end

			if IsControlJustPressed(1,38) then
				frontCamera = not frontCamera
				CellFrontCamActivate(frontCamera)
			end
		end

		Citizen.Wait(timeDistance)
	end
end)