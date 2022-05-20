-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local permissions = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.hasPermission(user_id,perm)
	local consult = vRP.query("vRP/get_group",{ user_id = user_id, permiss = tostring(perm) })
	if consult[1] then
		return true
	else
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUMPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.numPermission(perm)
	local users = {}
	for k,v in pairs(permissions) do
		if v == perm then
			table.insert(users,parseInt(k))
		end
	end
	
	return users
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUMPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.insertPermission(source,perm)
	permissions[tostring(source)] = tostring(perm)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUMPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.removePermission(source,perm)
	if permissions[tostring(source)] then
		permissions[tostring(source)] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	if permissions[tostring(source)] then
		permissions[tostring(source)] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if user_id then
		if vRP.hasPermission(user_id,"Police") then
			vRP.execute("vRP/del_group",{ user_id = user_id, permiss = "Police" })
			Wait(1)
			vRP.execute("vRP/add_group",{ user_id = user_id, permiss = "waitPolice" })
		elseif vRP.hasPermission(user_id,"Paramedic") then
			vRP.execute("vRP/del_group",{ user_id = user_id, permiss = "Paramedic" })
			Wait(1)
			vRP.execute("vRP/add_group",{ user_id = user_id, permiss = "waitParamedic" })
		elseif vRP.hasPermission(user_id,"Mechanic") then
			vRP.execute("vRP/del_group",{ user_id = user_id, permiss = "Mechanic" })
			Wait(1)
			vRP.execute("vRP/add_group",{ user_id = user_id, permiss = "waitMechanic" })
		end
	end
end)