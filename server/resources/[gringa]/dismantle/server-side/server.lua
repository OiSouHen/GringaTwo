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
Tunnel.bindInterface("dismantle",cRP)
vCLIENT = Tunnel.getInterface("dismantle")
vGARAGE = Tunnel.getInterface("garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local timeList = 0
local maxVehlist = 20
local vehListActived = {}
local userList = {}
local serviceStatus = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local vehList = {
	[1] = "benson",
	[2] = "biff",
	[3] = "cerberus",
	[4] = "cerberus2",
	[5] = "cerberus3",
	[6] = "hauler",
	[7] = "hauler2",
	[8] = "mule",
	[9] = "mule2",
	[10] = "mule3",
	[11] = "mule4",
	[12] = "packer",
	[13] = "phantom",
	[14] = "phantom3",
	[15] = "pounder2",
	[16] = "terbyte",
	[17] = "blista",
	[18] = "brioso",
	[19] = "dilettante",
	[20] = "dilettante2",
	[21] = "issi2",
	[22] = "issi3",
	[23] = "issi4",
	[24] = "issi5",
	[25] = "panto",
	[26] = "prairie",
	[27] = "rhapsody",
	[28] = "cogcabrio",
	[29] = "exemplar",
	[30] = "f620",
	[31] = "felon",
	[32] = "felon2",
	[33] = "jackal",
	[34] = "oracle",
	[35] = "oracle2",
	[36] = "sentinel",
	[37] = "sentinel2",
	[38] = "windsor",
	[39] = "windsor2",
	[40] = "zion",
	[41] = "zion2",
	[42] = "previon",
	[43] = "bulldozer",
	[44] = "cutter",
	[45] = "dump",
	[46] = "guardian",
	[47] = "handler",
	[48] = "mixer",
	[49] = "mixer2",
	[50] = "rubble",
	[51] = "tiptruck",
	[52] = "tiptruck2",
	[53] = "akuma",
	[54] = "avarus",
	[55] = "bagger",
	[56] = "bati",
	[57] = "bati2",
	[58] = "bf400",
	[59] = "carbonrs",
	[60] = "chimera",
	[61] = "cliffhanger",
	[62] = "daemon",
	[63] = "daemon2",
	[64] = "defiler",
	[65] = "deathbike",
	[66] = "deathbike2",
	[67] = "diablous",
	[68] = "diablous2",
	[69] = "double",
	[70] = "enduro",
	[71] = "esskey",
	[72] = "faggio2",
	[73] = "faggio3",
	[74] = "fcr",
	[75] = "fcr2",
	[76] = "gargoyle",
	[77] = "hakuchou",
	[78] = "hakuchou2",
	[79] = "hexer",
	[80] = "innovation",
	[81] = "lectro",
	[82] = "manchez",
	[83] = "nemesis",
	[84] = "nightblade",
	[85] = "pcj",
	[86] = "ratbike",
	[87] = "ruffian",
	[88] = "sanchez",
	[89] = "sanchez2",
	[90] = "sanctus",
	[91] = "sovereign",
	[92] = "thrust",
	[93] = "vader",
	[94] = "vindicator",
	[95] = "vortex",
	[96] = "wolfsbane",
	[97] = "zombiea",
	[98] = "zombieb",
	[99] = "blade",
	[100] = "buccaneer",
	[101] = "buccaneer2",
	[102] = "chino",
	[103] = "chino2",
	[104] = "clique",
	[105] = "coquette3",
	[106] = "deviant",
	[107] = "dominator",
	[108] = "dominator2",
	[109] = "dominator3",
	[110] = "dominator4",
	[111] = "dominator5",
	[112] = "dukes",
	[113] = "dukes2",
	[114] = "faction",
	[115] = "faction2",
	[116] = "faction3",
	[117] = "ellie",
	[118] = "gauntlet",
	[119] = "gauntlet2",
	[120] = "hermes",
	[121] = "hotknife",
	[122] = "hustler",
	[123] = "impaler",
	[124] = "impaler2",
	[125] = "impaler3",
	[126] = "impaler4",
	[127] = "imperator",
	[128] = "imperator2",
	[129] = "lurcher",
	[130] = "moonbeam",
	[131] = "moonbeam2",
	[132] = "nightshade",
	[133] = "phoenix",
	[134] = "picador",
	[135] = "ruiner",
	[136] = "ruiner2",
	[137] = "ruiner3",
	[138] = "sabregt",
	[139] = "sabregt2",
	[140] = "slamvan",
	[141] = "slamvan2",
	[142] = "slamvan3",
	[143] = "slamvan4",
	[144] = "slamvan5",
	[145] = "stalion",
	[146] = "stalion2",
	[147] = "tampa",
	[148] = "tampa3",
	[149] = "tulip",
	[150] = "vamos",
	[151] = "vigero",
	[152] = "virgo",
	[153] = "virgo2",
	[154] = "virgo3",
	[155] = "voodoo",
	[156] = "voodoo2",
	[157] = "yosemite",
	[158] = "bfinjection",
	[159] = "bifta",
	[160] = "blazer",
	[161] = "blazer2",
	[162] = "blazer3",
	[163] = "blazer4",
	[164] = "blazer5",
	[165] = "bodhi2",
	[166] = "brawler"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- NORMALITENSLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local normalItensList = {
	[1] = "plastic",
	[2] = "glass",
	[3] = "copper",
	[4] = "rubber",
	[5] = "aluminum"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPECIALITENSLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local specialItensList = {
	[1] = "metalfragments"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEVEHLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.generateVehlist()
	vehListActived = {}
	local amountVehs = 0
	local vehSelected = 0
	repeat
		Wait(1)
		vehSelected = math.random(#vehList)
		if vehListActived[vehList[parseInt(vehSelected)]] == nil then
			amountVehs = amountVehs + 1
			vehListActived[vehList[parseInt(vehSelected)]] = true
		end
	until parseInt(amountVehs) == parseInt(maxVehlist)
	timeList = 60
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADVEHGENERATE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	cRP.generateVehlist()

	while true do
		if timeList > 0 then
			timeList = timeList - 1
			if timeList <= 0 then
				cRP.generateVehlist()
			end
		end
		Wait(60000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKVEHLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkVehlist()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"toolbox") >= 1 then
			local vehicle,vehNet,vehPlate,vehName = vRPclient.vehList(source,11)
			if vehicle then
				local plateId = vRP.getVehiclePlate(vehPlate)
				if not plateId then
					if vehListActived[vehName] then
						vehListActived[vehName] = nil
						return true,vehicle
					end
				else
					TriggerClientEvent("Notify",source,"default","Veículo protegido pela seguradora.",5000)
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","<b>Caixa de Ferramentas</b> não encontrada.",5000)
		end
		
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentMethod(vehicle)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local value = math.random(3500,7000)
		vRP.giveInventoryItem(user_id,"dollars",parseInt(value),true)
		vRP.giveInventoryItem(user_id,normalItensList[math.random(#normalItensList)],math.random(12,24),true)
		vRP.giveInventoryItem(user_id,specialItensList[math.random(#specialItensList)],math.random(6,12),true)
		
		local random = math.random(100)
		if parseInt(random) >= 90 then
			vRP.giveInventoryItem(user_id,"premiumplate",math.random(1),true)
		elseif parseInt(random) >= 79 and parseInt(random) <= 89 then
			vRP.giveInventoryItem(user_id,"plate",math.random(1),true)
		end
		
		vRP.upgradeStress(user_id,6)
		vRP.wantedTimer(user_id,250)
		vGARAGE.deleteVehicle(source,vehicle)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.acessList()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if userList[user_id] == nil then
			userList[user_id] = true
			serviceStatus = true
			TriggerClientEvent("Notify",source,"verde","Lista disponível.",3000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLE:INVOKEDISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dismantle:invokeDismantle")
AddEventHandler("dismantle:invokeDismantle",function(invokeDismantle)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if serviceStatus then
			if timeList > 0 and userList[user_id] then
				local vehListNames = ""
				for k,v in pairs(vehListActived) do
					vehListNames = vehListNames.."<b>"..vRP.vehicleName(k).."</b>, "
				end
				
				if vehListNames ~= "" then
					TriggerClientEvent("Notify",source,"azul",vehListNames.."a lista é atualizada em <b>"..parseInt(timeList).." minutos</b>, cada veículo entregue o mesmo é removido da sua lista atual.",30000)
				else
					TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..parseInt(timeList).." minutos</b>.",10000)
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você precisa iniciar o serviço.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	if userList[user_id] then
		userList[user_id] = nil
	end
end)