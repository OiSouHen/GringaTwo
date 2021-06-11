-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("barbershop",cRP)
vCLIENT = Tunnel.getInterface("barbershop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkShares()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.wantedReturn(user_id) and not vRP.reposeReturn(user_id) then
			return true
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateSkin(myClothes)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.execute("vRP/updateSkin",{ user_id = parseInt(user_id), fathers = parseInt(myClothes[1]), kinship = parseInt(myClothes[2]), eyecolor = parseInt(myClothes[3]), skincolor = parseInt(myClothes[4]), acne = parseInt(myClothes[5]), stains = parseInt(myClothes[6]), freckles = parseInt(myClothes[7]), aging = parseInt(myClothes[8]), hair = parseInt(myClothes[9]), haircolor = parseInt(myClothes[10]), haircolor2 = parseInt(myClothes[11]), makeup = parseInt(myClothes[12]), makeupintensity = parseInt(myClothes[13]), makeupcolor = parseInt(myClothes[14]), lipstick = parseInt(myClothes[15]), lipstickintensity = parseInt(myClothes[16]), lipstickcolor = parseInt(myClothes[17]), eyebrow = parseInt(myClothes[18]), eyebrowintensity = parseInt(myClothes[19]), eyebrowcolor = parseInt(myClothes[20]), beard = parseInt(myClothes[21]), beardintentisy = parseInt(myClothes[22]), beardcolor = parseInt(myClothes[23]), blush = parseInt(myClothes[24]), blushintentisy = parseInt(myClothes[25]), blushcolor = parseInt(myClothes[26]), face00 = parseInt(myClothes[27]), face01 = parseInt(myClothes[28]), face04 = parseInt(myClothes[29]), face06 = parseInt(myClothes[30]), face08 = parseInt(myClothes[31]), face09 = parseInt(myClothes[32]), face10 = parseInt(myClothes[33]), face12 = parseInt(myClothes[34]), face13 = parseInt(myClothes[35]), face14 = parseInt(myClothes[36]), face15 = parseInt(myClothes[37]), face16 = parseInt(myClothes[38]), face17 = parseInt(myClothes[39]), face19 = parseInt(myClothes[40]), mothers = parseInt(myClothes[41]) })
	end
end