-----------------------------------------------------------------------------------------------------------------------------------------
-- PHONE-NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("phonenotify:sendMessage")
AddEventHandler("phonenotify:sendMessage",function(status)
	SendNUIMessage({ notify = status })
end)