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
Tunnel.bindInterface("vrp_garbageman",cnVRP)
vCLIENT = Tunnel.getInterface("vrp_garbageman")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local saveList = {}
local garbageList = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
function garbageMakeList(status)
	garbageList = {
		[1] = { -601.29,-1788.53,24.28,294.79 },
		[2] = { -538.05,-1775.67,21.49,158.67 },
		[3] = { -362.25,-1860.7,20.54,272.57 },
		[4] = { -361.73,-1864.71,20.53,282.98 },
		[5] = { -361.01,-1869.01,20.53,278.21 },
		[6] = { -314.63,-2201.97,10.34,57.27 },
		[7] = { -961.22,-2772.21,14.4,146.01 },
		[8] = { -900.22,-2748.84,14.54,144.17 },
		[9] = { -905.72,-2750.23,14.69,139.23 },
		[10] = { -1050.82,-2084.96,13.38,234.84 },
		[11] = { -1052.06,-2086.38,13.35,216.42 },
		[12] = { -1054.28,-2088.7,13.3,232.03 },
		[13] = { -1150.68,-1968.87,13.17,122.09 },
		[14] = { -723.72,-1505.49,5.01,122.15 },
		[15] = { -722.52,-1508.58,5.01,107.34 },
		[16] = { -680.74,-1324.6,5.11,268.67 },
		[17] = { -681.07,-1322.48,5.11,267.51 },
		[18] = { -829.53,-1259.56,5.01,47.34 },
		[19] = { -921.81,-1160.57,4.77,211.14 },
		[20] = { -1075.81,-1273.09,5.85,27.44 },
		[21] = { -1150.74,-1265.55,6.9,15.35 },
		[22] = { -1152.75,-1266.28,6.79,23.3 },
		[23] = { -1146.63,-1379.17,4.88,111.16 },
		[24] = { -1000.88,-1461.47,4.98,298.25 },
		[25] = { -1000.88,-1463.43,4.98,214.22 },
		[26] = { -945.79,-1549.26,5.18,198.25 },
		[27] = { -943.84,-1548.36,5.18,193.04 },
		[28] = { -883.76,-1515.31,5.18,14.4 },
		[29] = { -885.5,-1516.05,5.18,17.23 },
		[30] = { -1293.45,-1294.86,4.36,101.53 },
		[31] = { -1332.48,-1193.37,4.9,1.12 },
		[32] = { -1326.02,-1087.33,6.96,29.6 },
		[33] = { -1324.26,-1086.4,6.96,28.29 },
		[34] = { -1256.25,-864.58,12.33,125.75 },
		[35] = { -1284.95,-830.56,17.1,29.56 },
		[36] = { -1285.1,-825.12,17.11,32.66 },
		[37] = { -1287.51,-800.0,17.62,307.11 },
		[38] = { -1299.27,-784.67,17.72,34.96 },
		[39] = { -1321.18,-774.91,20.01,127.44 },
		[40] = { -1351.71,-737.14,22.53,87.67 },
		[41] = { -1354.79,-720.48,23.75,309.66 },
		[42] = { -1856.74,-1209.08,13.02,337.15 },
		[43] = { -1858.96,-1208.25,13.02,329.36 },
		[44] = { -1844.75,-1181.97,13.02,237.49 },
		[45] = { -1843.76,-1180.24,13.02,235.16 },
		[46] = { -1840.82,-1177.36,13.02,237.53 },
		[47] = { -1839.28,-1174.97,13.02,237.86 },
		[48] = { -1988.77,-489.87,11.61,216.81 },
		[49] = { -1987.29,-487.55,11.68,317.04 },
		[50] = { -2134.2,-393.41,13.19,314.78 },
		[51] = { -2952.09,59.99,11.61,343.31 },
		[52] = { -2949.26,58.84,11.61,331.04 },
		[53] = { -3049.32,175.76,11.61,349.25 },
		[54] = { -3051.2,175.9,11.6,352.03 },
		[55] = { -3052.17,588.66,7.74,194.59 },
		[56] = { -3032.01,731.14,22.72,305.97 },
		[57] = { -2954.42,445.79,15.29,355.53 },
		[58] = { -2952.18,445.78,15.29,355.37 },
		[59] = { -2954.36,390.53,15.03,82.66 },
		[60] = { -2954.59,388.35,15.03,85.4 },
		[61] = { -2954.86,379.05,15.03,86.96 },
		[62] = { -3244.44,995.16,12.48,358.31 },
		[63] = { -2523.4,2302.07,33.29,187.48 },
		[64] = { -1924.99,2031.42,140.74,149.03 },
		[65] = { -1923.02,2030.51,140.74,160.22 },
		[66] = { -1113.15,2719.84,18.89,210.69 },
		[67] = { -1089.76,2722.95,19.04,133.23 },
		[68] = { 57.98,2797.2,57.88,141.09 },
		[69] = { 1381.44,3615.99,34.9,287.5 },
		[70] = { 1370.58,3609.44,34.9,103.11 },
		[71] = { 1401.27,3631.42,34.9,9.14 },
		[72] = { 1558.19,3804.26,34.26,22.61 },
		[73] = { 1722.68,3697.96,34.48,283.03 },
		[74] = { 1975.7,3786.98,32.18,32.42 },
		[75] = { 1967.76,3756.85,32.22,293.9 },
		[76] = { 1925.59,3744.67,32.52,300.28 },
		[77] = { 1903.81,3736.14,32.59,31.59 },
		[78] = { 1748.99,3708.88,34.17,105.69 },
		[79] = { 1692.01,3750.01,34.28,312.42 },
		[80] = { 2455.48,4054.64,38.07,63.69 },
		[81] = { 2501.29,4213.77,39.78,69.96 },
		[82] = { 2708.2,4308.42,46.4,124.08 },
		[83] = { 2673.39,3466.15,55.63,65.92 },
		[84] = { 2673.73,3293.75,55.25,241.78 },
		[85] = { 2672.67,3292.16,55.25,227.75 },
		[86] = { 2358.18,3139.12,48.21,346.25 },
		[87] = { 2041.33,3196.81,45.19,69.62 },
		[88] = { 2042.39,3198.67,45.19,55.31 },
		[89] = { 2056.18,3197.9,45.95,326.34 },
		[90] = { 2060.54,3194.98,45.84,329.23 },
		[91] = { 2062.95,3193.34,45.61,326.39 },
		[92] = { 2065.07,3189.81,45.61,328.87 },
		[93] = { 2064.47,3184.94,45.19,240.79 },
		[94] = { 1964.71,3030.6,47.06,144.17 },
		[95] = { 1979.92,3048.67,47.22,323.94 },
		[96] = { 1981.67,3047.59,47.22,327.11 },
		[97] = { 2540.71,2599.21,37.95,290.52 },
		[98] = { 2530.16,2641.44,37.95,359.35 },
		[99] = { 2533.27,2641.41,37.95,353.44 },
		[100] = { 2570.76,485.32,108.68,305.04 },
		[101] = { 2570.92,483.83,108.68,269.53 },
		[102] = { 2542.34,343.87,108.46,90.14 },
		[103] = { 2542.07,341.78,108.46,79.14 },
		[104] = { 2542.64,339.82,108.46,171.89 },
		[105] = { 2557.57,283.78,108.61,265.16 },
		[106] = { 2546.12,-310.54,93.0,2.95 },
		[107] = { 2544.04,-310.45,93.0,3.11 },
		[108] = { 2499.99,-305.24,93.0,354.26 },
		[109] = { 2508.67,-455.49,93.0,216.42 },
		[110] = { 2510.29,-454.01,93.0,218.48 },
		[111] = { 1710.31,-1586.3,112.54,182.05 },
		[112] = { 1708.18,-1586.97,112.53,186.35 },
		[113] = { 1732.55,-1641.1,112.58,273.58 },
		[114] = { 1733.31,-1643.18,112.59,275.29 },
		[115] = { 1688.38,-1745.07,112.23,7.36 },
		[116] = { 1690.43,-1744.35,112.24,8.53 },
		[117] = { 1441.68,-1676.08,65.44,296.62 },
		[118] = { 1384.97,-2042.26,52.0,25.96 },
		[119] = { 1383.18,-2043.37,52.0,28.43 },
		[120] = { 1387.23,-2224.39,61.1,21.65 },
		[121] = { 1421.7,-2319.88,67.02,344.11 },
		[122] = { 1081.34,-2413.43,30.18,181.39 },
		[123] = { 274.94,2573.78,45.2,217.29 },
		[124] = { 277.19,2575.14,45.17,205.36 },
		[125] = { 281.48,2576.66,45.65,119.86 },
		[126] = { 405.52,2624.67,44.46,241.51 },
		[127] = { 406.7,2626.6,44.48,257.28 },
		[128] = { 537.44,2666.21,42.29,267.35 },
		[129] = { 536.95,2668.02,42.26,287.77 },
		[130] = { 550.46,2652.01,42.74,185.65 },
		[131] = { 562.24,2670.86,42.13,105.86 },
		[132] = { 734.95,2593.63,73.86,277.78 },
		[133] = { 1020.9,2650.07,39.56,174.95 },
		[134] = { 1018.87,2649.96,39.61,160.24 },
		[135] = { 1065.21,2658.05,39.56,270.1 },
		[136] = { 1118.12,2626.07,38.0,173.6 },
		[137] = { 1120.26,2626.11,38.0,175.49 },
		[138] = { 1193.08,2631.96,37.81,177.56 },
		[139] = { 1176.49,2729.71,38.01,359.56 },
		[140] = { 1174.42,2729.7,38.01,355.5 },
		[141] = { 1742.06,6408.76,35.09,61.63 },
		[142] = { 1697.37,6440.74,32.69,153.62 },
		[143] = { 1596.91,6454.93,25.32,62.06 },
		[144] = { 1597.2,6460.13,25.32,152.09 },
		[145] = { 1462.3,6539.98,14.67,199.15 },
		[146] = { 404.34,6497.66,27.87,355.95 },
		[147] = { 180.43,6442.48,31.28,300.28 },
		[148] = { 178.97,6444.19,31.3,312.82 },
		[149] = { 171.59,6411.89,31.15,301.49 },
		[150] = { 146.87,6389.75,31.31,205.17 },
		[151] = { 145.13,6388.64,31.31,208.28 },
		[152] = { 106.36,6369.48,31.38,203.59 },
		[153] = { 85.57,6359.79,31.38,204.0 },
		[154] = { 69.47,6318.59,31.23,117.47 },
		[155] = { 71.29,6315.45,31.23,112.17 },
		[156] = { 35.65,6295.45,31.23,36.24 },
		[157] = { 33.08,6293.8,31.24,14.12 },
		[158] = { -97.97,6191.08,31.38,37.11 },
		[159] = { -75.37,6213.47,31.47,300.71 },
		[160] = { -129.91,6156.2,31.36,53.05 },
		[161] = { -127.82,6230.28,31.34,307.51 },
		[162] = { -120.39,6207.8,31.21,226.16 },
		[163] = { -102.34,6253.99,31.36,307.51 },
		[164] = { -23.16,6296.08,31.38,283.74 },
		[165] = { -23.79,6297.85,31.38,299.21 },
		[166] = { 9.69,6314.93,31.37,203.98 },
		[167] = { -438.56,5983.56,31.5,44.58 },
		[168] = { -435.62,5986.45,31.5,42.56 },
		[169] = { -434.3,5987.65,31.56,36.39 },
		[170] = { -385.91,6043.45,31.51,315.67 },
		[171] = { -384.33,6041.88,31.51,311.65 },
		[172] = { -404.95,6059.81,31.51,315.23 },
		[173] = { -376.99,6073.4,31.49,320.38 },
		[174] = { -343.41,6068.63,31.49,134.09 },
		[175] = { -318.56,6082.01,31.32,101.73 },
		[176] = { -307.87,6199.28,31.5,311.24 },
		[177] = { -303.26,6195.62,31.5,311.92 },
		[178] = { -294.37,6186.81,31.5,314.05 },
		[179] = { -273.65,6175.34,31.45,45.92 },
		[180] = { -268.73,6173.41,31.43,224.67 },
		[181] = { -267.04,6217.39,31.53,47.97 },
		[182] = { -254.53,6250.2,31.49,310.02 },
		[183] = { -256.18,6246.85,31.49,149.47 },
		[184] = { -205.34,6248.19,31.5,131.34 },
		[185] = { -201.91,6244.27,31.5,137.01 },
		[186] = { -162.8,6309.16,31.49,318.28 },
		[187] = { -160.76,6307.77,31.49,312.36 },
		[188] = { -153.83,6349.45,31.6,306.15 },
		[189] = { -138.18,6342.86,31.5,226.23 },
		[190] = { -125.34,6345.45,31.5,222.76 },
		[191] = { -115.74,6366.83,31.48,38.97 },
		[192] = { -117.07,6365.47,31.48,42.67 },
		[193] = { -49.89,6419.07,31.5,305.77 },
		[194] = { -57.97,6413.31,31.5,43.81 },
		[195] = { -52.46,6355.05,31.38,123.27 },
		[196] = { -20.0,6387.81,31.36,44.35 },
		[197] = { -35.89,6451.7,31.48,40.6 },
		[198] = { -46.68,6448.27,31.48,316.51 },
		[199] = { -14.3,6478.39,31.46,45.09 },
		[200] = { -6.14,6480.45,31.5,312.1 },
		[201] = { 32.27,6545.05,31.43,306.77 },
		[202] = { 33.96,6500.55,31.43,222.7 },
		[203] = { -29.13,6529.39,31.5,311.32 },
		[204] = { -79.93,6528.09,31.49,234.46 },
		[205] = { -102.14,6481.97,31.4,131.25 },
		[206] = { -103.64,6483.32,31.4,132.96 },
		[207] = { -136.47,6474.83,31.47,46.59 },
		[208] = { -191.14,6429.49,31.53,224.05 },
		[209] = { -189.33,6431.38,31.52,211.95 },
		[210] = { -286.85,6309.73,31.5,219.84 },
		[211] = { -311.94,6315.14,32.84,226.51 },
		[212] = { -338.51,6230.17,31.49,138.75 },
		[213] = { -337.09,6228.56,31.49,128.22 },
		[214] = { -435.99,6144.15,31.48,309.67 },
		[215] = { -408.46,6375.26,14.01,204.14 },
		[216] = { -683.39,5788.09,17.34,337.39 },
		[217] = { -842.58,5405.75,34.62,111.69 },
		[218] = { -2177.37,4259.31,48.96,230.98 },
		[219] = { -2175.71,4256.59,48.96,322.26 },
		[220] = { -2174.22,4259.32,48.96,147.45 },
		[221] = { -2228.46,4224.0,46.92,243.68 },
		[222] = { -2226.81,4221.45,47.03,328.99 },
		[223] = { -2223.99,4221.58,47.04,52.44 },
		[224] = { -2225.52,4224.2,47.08,155.6 },
		[225] = { 2440.37,4989.35,46.25,224.82 },
		[226] = { 2411.27,5049.36,46.13,221.08 },
		[227] = { 2323.99,4893.84,41.81,133.83 },
		[228] = { 2543.39,4680.41,33.82,42.42 },
		[229] = { 2539.78,4674.42,33.93,63.96 },
		[230] = { 2151.23,4781.25,41.01,25.91 },
		[231] = { 1946.97,4624.4,40.53,298.5 },
		[232] = { 1816.87,4585.29,36.09,183.41 },
		[233] = { 1771.76,4587.8,37.71,53.12 },
		[234] = { 1776.04,4605.3,37.29,183.68 },
		[235] = { 1712.93,4714.4,42.71,278.03 },
		[236] = { 1727.4,4786.98,41.91,89.75 },
		[237] = { 1732.0,4791.89,41.85,277.01 },
		[238] = { 1713.87,4811.16,41.95,352.04 },
		[239] = { 1711.39,4811.32,41.96,3.35 },
		[240] = { 1709.32,4816.95,42.03,265.94 },
		[241] = { 1706.52,4835.32,42.03,274.63 },
		[242] = { 1703.2,4847.67,42.1,78.95 },
		[243] = { 1703.32,4875.15,42.04,259.67 },
		[244] = { 1636.46,4875.75,42.04,95.37 },
		[245] = { 1639.08,4821.21,41.96,107.84 },
		[246] = { 1654.01,4829.04,42.02,6.45 },
		[247] = { 1659.97,4822.0,42.03,183.81 },
		[248] = { 1721.97,4935.58,42.09,316.06 },
		[249] = { 2869.97,4422.37,48.77,206.2 },
		[250] = { 2903.87,4365.7,50.34,106.67 },
		[251] = { 2904.7,4363.83,50.33,109.28 },
		[252] = { 2931.88,4295.67,50.33,290.19 },
		[253] = { 949.84,-117.29,74.36,307.77 },
		[254] = { 1182.19,-304.08,69.12,183.09 },
		[255] = { 1180.14,-304.48,69.09,184.84 },
		[256] = { 1177.81,-304.88,69.01,184.13 },
		[257] = { 1167.34,-316.29,69.33,104.28 },
		[258] = { 1167.79,-318.53,69.33,95.42 },
		[259] = { 1153.84,-380.65,67.33,74.92 },
		[260] = { 1153.15,-383.46,67.31,72.16 },
		[261] = { 1147.91,-402.63,67.3,72.47 },
		[262] = { 1147.52,-404.52,67.31,79.38 },
		[263] = { 1146.2,-409.19,67.3,74.49 },
		[264] = { 1144.71,-416.93,67.32,254.78 },
		[265] = { 1141.95,-425.2,67.3,60.31 },
		[266] = { 1141.22,-427.22,67.3,69.74 },
		[267] = { 1149.98,-437.68,67.01,162.45 },
		[268] = { 1132.65,-316.67,67.09,8.45 },
		[269] = { 1130.41,-317.16,67.08,6.76 },
		[270] = { 1119.66,-345.07,67.14,304.79 },
		[271] = { 1117.02,-346.74,67.08,116.49 },
		[272] = { 1239.31,-404.84,69.02,76.61 },
		[273] = { 1240.25,-400.63,69.01,81.73 },
		[274] = { 1242.75,-348.0,69.21,164.19 },
		[275] = { 1244.9,-348.41,69.21,158.68 },
		[276] = { 1237.73,-458.8,66.69,238.21 },
		[277] = { 1228.97,-474.06,66.54,66.76 },
		[278] = { 1226.4,-476.13,66.47,335.98 },
		[279] = { 1231.39,-482.92,66.54,253.14 },
		[280] = { 1229.41,-489.85,66.43,251.47 },
		[281] = { 1132.6,-790.45,57.6,328.33 },
		[282] = { 1140.58,-790.44,57.6,350.64 },
		[283] = { 1099.39,-775.48,58.35,181.31 },
		[284] = { 1080.61,-788.8,58.27,352.6 },
		[285] = { 1057.85,-787.04,58.27,347.53 },
		[286] = { 884.48,-181.6,73.59,50.2 },
		[287] = { 885.32,-180.0,73.62,51.19 },
		[288] = { 884.64,-171.48,77.12,334.94 },
		[289] = { 882.63,-170.26,77.12,321.35 },
		[290] = { 819.06,-98.01,80.6,87.09 },
		[291] = { 817.92,-100.02,80.6,49.25 },
		[292] = { 819.07,-122.7,80.26,150.59 },
		[293] = { 786.22,-85.2,80.6,264.46 },
		[294] = { 787.4,-83.4,80.6,230.61 },
		[295] = { 560.48,171.38,100.24,244.65 },
		[296] = { 525.18,158.58,99.08,80.39 },
		[297] = { 524.5,156.23,98.93,58.42 },
		[298] = { 383.5,239.06,103.04,69.32 },
		[299] = { 382.61,236.78,103.04,96.33 },
		[300] = { 372.86,212.74,103.12,88.1 },
		[301] = { 372.18,210.64,103.05,55.8 },
		[302] = { 398.55,355.33,102.47,16.24 },
		[303] = { 396.46,356.01,102.47,351.86 },
		[304] = { 393.08,354.5,102.53,139.83 },
		[305] = { 391.04,355.04,102.54,152.81 },
		[306] = { 374.85,355.77,102.64,236.15 },
		[307] = { 373.81,351.41,102.82,251.93 },
		[308] = { 345.43,354.59,105.3,82.4 },
		[309] = { 344.92,352.73,105.3,97.81 },
		[310] = { 349.8,340.71,105.21,252.44 },
		[311] = { 309.68,344.5,105.3,73.15 },
		[312] = { 294.19,365.01,105.47,165.19 },
		[313] = { 291.21,365.72,105.49,162.61 },
		[314] = { 259.25,377.61,105.53,223.57 },
		[315] = { 258.65,375.63,105.53,251.84 },
		[316] = { 221.01,390.86,106.76,345.12 },
		[317] = { 219.2,391.34,106.77,342.66 },
		[318] = { 207.73,336.93,105.55,171.27 },
		[319] = { 210.23,336.1,105.5,140.88 },
		[320] = { 195.29,341.31,106.06,115.65 },
		[321] = { 195.18,335.58,105.53,124.06 },
		[322] = { 194.16,321.06,105.4,100.13 },
		[323] = { 174.94,306.55,105.38,48.53 },
		[324] = { 174.16,304.98,105.37,102.61 },
		[325] = { 175.84,294.73,105.38,111.61 },
		[326] = { 102.04,318.2,112.1,143.35 },
		[327] = { 97.4,320.33,112.08,41.37 },
		[328] = { 116.4,327.14,112.13,249.52 },
		[329] = { 114.83,330.37,112.13,264.98 },
		[330] = { 124.42,314.53,112.15,6.05 },
		[331] = { 132.21,321.07,112.24,42.91 },
		[332] = { 147.64,311.94,112.16,287.66 },
		[333] = { 148.71,309.46,112.14,283.4 },
		[334] = { 158.76,305.68,112.13,16.53 },
		[335] = { 160.61,305.87,112.13,333.97 },
		[336] = { 128.34,273.19,109.98,95.59 },
		[337] = { 98.07,298.31,110.01,162.45 },
		[338] = { 87.76,310.43,110.02,64.2 },
		[339] = { 143.3,195.25,106.59,152.36 },
		[340] = { 134.81,170.14,105.1,48.43 },
		[341] = { 128.52,163.79,104.72,22.53 },
		[342] = { 126.23,165.53,104.73,1.82 },
		[343] = { 98.64,161.98,104.62,59.33 },
		[344] = { 97.76,159.75,104.66,102.33 },
		[345] = { 96.95,157.58,104.7,61.02 },
		[346] = { -61.15,202.76,101.98,92.92 },
		[347] = { 249.76,114.33,101.89,248.62 },
		[348] = { 238.23,131.65,102.6,358.98 },
		[349] = { 234.67,133.23,102.6,333.69 },
		[350] = { 253.74,126.48,102.32,350.78 },
		[351] = { 250.89,127.43,102.5,334.31 },
		[352] = { 224.52,114.12,93.44,335.62 },
		[353] = { 254.28,-18.45,73.64,161.08 },
		[354] = { 266.25,-25.13,73.53,185.33 },
		[355] = { 268.72,-26.08,73.53,147.63 },
		[356] = { 276.21,-56.55,70.16,64.86 },
		[357] = { 94.8,-0.56,68.25,341.48 },
		[358] = { 74.24,112.83,79.13,324.3 },
		[359] = { 76.59,110.96,79.14,1.08 },
		[360] = { -101.68,45.77,71.63,226.79 },
		[361] = { -66.66,207.82,96.54,264.87 },
		[362] = { -66.51,209.91,96.54,268.51 },
		[363] = { -180.96,243.23,92.79,352.63 },
		[364] = { -183.39,243.7,92.69,348.09 },
		[365] = { -205.82,219.48,88.02,15.12 },
		[366] = { -207.85,219.59,87.82,344.3 },
		[367] = { -178.66,204.05,87.81,202.99 },
		[368] = { -175.01,204.25,88.27,175.67 },
		[369] = { -279.97,200.75,85.68,114.81 },
		[370] = { -280.01,197.81,85.63,69.35 },
		[371] = { -393.05,294.58,85.37,87.71 },
		[372] = { -393.15,298.06,85.36,62.72 },
		[373] = { -410.08,300.74,83.23,246.19 },
		[374] = { -407.44,299.18,83.72,354.56 },
		[375] = { -407.79,295.01,83.72,276.33 },
		[376] = { -443.38,290.66,83.23,263.83 },
		[377] = { -460.85,305.09,83.25,111.35 },
		[378] = { -474.63,303.26,83.26,31.98 },
		[379] = { -476.93,303.45,83.26,359.29 },
		[380] = { -495.99,300.65,83.28,172.37 },
		[381] = { -506.34,306.27,83.25,357.57 },
		[382] = { -508.68,302.22,83.14,127.03 },
		[383] = { -547.09,286.5,83.03,79.94 },
		[384] = { -548.28,297.05,83.02,204.52 },
		[385] = { -557.49,310.01,83.71,101.28 },
		[386] = { -557.8,307.25,83.76,83.36 },
		[387] = { -592.24,339.89,85.61,302.43 },
		[388] = { -622.81,292.48,81.99,260.24 },
		[389] = { -622.75,294.54,82.14,270.26 },
		[390] = { -945.23,331.04,71.34,351.64 },
		[391] = { -943.14,331.13,71.34,344.75 },
		[392] = { -1232.22,386.72,75.38,252.5 },
		[393] = { -1231.4,383.71,75.35,284.63 },
		[394] = { -1820.46,803.57,138.57,124.27 },
		[395] = { -1344.81,-211.94,43.69,188.36 },
		[396] = { -1346.67,-213.3,43.68,210.98 },
		[397] = { -1309.07,-280.12,39.65,335.28 },
		[398] = { -1297.44,-282.22,38.84,204.38 },
		[399] = { -1294.91,-280.77,38.8,193.62 },
		[400] = { -1266.86,-271.23,38.83,228.08 },
		[401] = { -1264.7,-270.39,38.89,184.6 },
		[402] = { -1281.29,-279.53,38.3,118.35 },
		[403] = { -1280.01,-281.79,38.17,108.77 },
		[404] = { -1270.71,-288.58,37.72,298.76 },
		[405] = { -1156.85,-206.62,37.96,12.93 },
		[406] = { -1158.51,-207.24,37.96,82.1 },
		[407] = { -1158.75,-209.02,37.96,128.21 },
		[408] = { -1158.98,-211.05,37.96,79.79 },
		[409] = { -547.78,-42.72,42.71,247.75 },
		[410] = { -533.68,-44.92,42.46,86.63 },
		[411] = { -529.98,-45.95,42.26,179.46 },
		[412] = { -508.14,-48.6,40.61,345.21 },
		[413] = { -505.44,-48.67,40.43,328.48 },
		[414] = { -482.78,-55.3,40.0,340.0 },
		[415] = { -480.5,-55.29,40.0,352.8 },
		[416] = { -461.02,-48.98,44.52,355.79 },
		[417] = { -448.87,-49.48,44.52,247.38 },
		[418] = { -458.74,-58.68,44.52,283.62 },
		[419] = { -471.97,-64.02,44.52,158.23 },
		[420] = { -360.0,-144.36,38.25,270.63 },
		[421] = { -358.89,-146.41,38.25,302.81 },
		[422] = { -288.24,-95.36,47.21,54.8 },
		[423] = { -29.31,-96.78,57.29,300.67 },
		[424] = { -25.65,-89.05,57.26,276.12 },
		[425] = { -23.64,-82.93,57.26,325.62 },
		[426] = { -27.27,-78.0,57.26,343.74 },
		[427] = { -34.14,-88.36,57.26,14.38 },
		[428] = { -35.73,-90.46,57.26,65.5 },
		[429] = { 184.92,-160.82,56.32,138.79 },
		[430] = { 179.25,-157.08,56.32,31.63 },
		[431] = { 178.85,-158.74,56.32,64.35 },
		[432] = { 178.01,-160.92,56.32,65.44 },
		[433] = { 207.93,-166.03,56.35,23.1 },
		[434] = { 208.71,-167.53,56.33,146.01 },
		[435] = { 268.32,-183.79,61.58,107.28 },
		[436] = { 265.37,-183.0,61.58,156.7 },
		[437] = { 263.31,-182.39,61.58,156.07 },
		[438] = { 315.77,-215.99,54.09,99.78 },
		[439] = { 313.29,-213.34,54.09,134.65 },
		[440] = { 310.81,-212.91,54.09,153.16 },
		[441] = { 331.33,-220.35,54.09,183.4 },
		[442] = { 334.43,-222.01,54.09,104.03 },
		[443] = { 351.15,-195.94,57.22,158.41 },
		[444] = { 522.46,-162.47,56.22,263.87 },
		[445] = { 553.52,-159.52,57.04,264.51 },
		[446] = { 553.61,-157.24,57.04,259.63 },
		[447] = { 395.08,-330.06,46.95,244.47 },
		[448] = { 364.99,-314.79,46.73,43.87 },
		[449] = { 363.01,-316.0,46.73,72.27 },
		[450] = { 360.01,-331.69,46.77,59.23 },
		[451] = { 358.24,-328.48,46.74,159.95 },
		[452] = { 355.42,-345.84,46.73,332.58 },
		[453] = { 285.9,-615.22,43.43,184.94 },
		[454] = { 288.76,-616.27,43.46,154.28 },
		[455] = { 326.94,-615.86,29.3,53.58 },
		[456] = { 327.92,-612.96,29.3,69.38 },
		[457] = { 458.47,-550.44,28.5,259.46 },
		[458] = { 449.34,-574.14,28.5,344.49 },
		[459] = { 476.4,-600.3,28.5,232.44 },
		[460] = { 475.8,-603.89,28.5,270.32 },
		[461] = { 493.72,-633.15,24.89,10.89 },
		[462] = { 490.7,-632.76,24.9,350.2 },
		[463] = { 497.33,-587.81,24.76,131.1 },
		[464] = { 494.29,-587.43,24.75,176.09 },
		[465] = { 490.48,-998.64,27.79,86.17 },
		[466] = { 459.72,-1074.92,29.21,340.61 },
		[467] = { 478.84,-1062.35,29.22,330.83 },
		[468] = { 480.98,-1062.13,29.22,354.31 },
		[469] = { 454.76,-1073.69,29.22,223.33 },
		[470] = { 437.85,-1062.21,29.22,333.11 },
		[471] = { 439.95,-1061.86,29.22,359.66 },
		[472] = { 480.06,-1018.26,27.93,357.99 },
		[473] = { 468.46,-948.46,27.82,359.92 },
		[474] = { 466.09,-948.26,27.92,343.39 },
		[475] = { 453.45,-932.19,28.49,305.16 },
		[476] = { 453.08,-917.21,28.48,270.09 },
		[477] = { 396.73,-912.77,29.42,258.16 },
		[478] = { 379.77,-900.87,29.43,353.2 },
		[479] = { 412.62,-796.96,29.3,334.16 },
		[480] = { 412.35,-794.22,29.29,299.49 },
		[481] = { 395.08,-739.47,29.28,62.85 },
		[482] = { 414.16,-2013.19,23.61,237.52 },
		[483] = { 416.82,-2014.26,23.22,149.67 },
		[484] = { 413.34,-2047.75,22.32,229.5 },
		[485] = { 243.95,-825.05,29.96,316.17 },
		[486] = { 242.25,-824.29,30.0,337.97 },
		[487] = { 281.54,-1003.45,29.36,302.8 },
		[488] = { 279.4,-1003.83,29.36,85.23 },
		[489] = { 294.03,-995.45,29.28,328.66 },
		[490] = { 304.89,-1004.08,29.33,180.51 },
		[491] = { 341.69,-1076.69,29.54,265.08 },
		[492] = { 336.07,-1081.9,29.46,90.0 },
		[493] = { 341.54,-1102.87,29.41,78.91 },
		[494] = { 341.67,-1106.59,29.41,107.98 },
		[495] = { 153.8,-1048.51,29.25,25.43 },
		[496] = { 154.51,-1046.18,29.28,62.35 },
		[497] = { 151.9,-1065.54,29.2,317.64 },
		[498] = { 154.27,-1066.44,29.2,349.58 },
		[499] = { 172.7,-1073.96,29.2,230.52 },
		[500] = { 172.34,-1076.33,29.2,245.67 },
		[501] = { 125.83,-1087.4,29.21,145.38 },
		[502] = { 121.56,-1087.64,29.22,140.57 },
		[503] = { 130.14,-1054.88,29.2,340.98 },
		[504] = { 127.86,-1054.22,29.2,349.97 },
		[505] = { 115.59,-1049.59,29.21,334.83 },
		[506] = { 50.47,-1045.01,29.59,3.47 },
		[507] = { -4.27,-1083.83,26.68,258.33 },
		[508] = { -3.62,-1081.96,26.68,253.43 },
		[509] = { 18.26,-1119.65,28.92,337.17 },
		[510] = { 33.74,-1009.86,29.45,69.39 },
		[511] = { 50.6,-831.61,31.08,341.41 },
		[512] = { 74.27,-874.92,30.48,250.58 },
		[513] = { 298.11,-905.76,29.3,167.44 },
		[514] = { 300.05,-906.59,29.3,159.14 },
		[515] = { 291.98,-809.03,29.38,197.38 },
		[516] = { -362.39,-958.93,31.09,113.3 },
		[517] = { -362.45,-961.66,31.09,88.72 },
		[518] = { -350.37,-1072.77,22.94,34.97 },
		[519] = { -348.4,-1070.89,22.96,20.09 },
		[520] = { -346.5,-1068.94,22.98,46.61 },
		[521] = { 5.54,-729.68,32.11,252.93 },
		[522] = { -359.36,-641.71,31.72,353.4 },
		[523] = { -561.54,-710.0,32.99,174.93 },
		[524] = { -562.56,-707.95,33.01,69.78 },
		[525] = { -561.99,-703.84,33.02,72.0 },
		[526] = { -562.8,-702.15,33.02,340.02 },
		[527] = { -518.09,-868.18,29.33,116.96 },
		[528] = { -518.06,-870.42,29.14,69.62 },
		[529] = { -572.83,-902.44,25.7,258.44 },
		[530] = { -572.82,-903.92,25.7,169.09 },
		[531] = { -658.0,-890.2,24.69,58.61 },
		[532] = { -660.29,-890.38,24.64,358.74 },
		[533] = { -688.91,-891.2,24.5,83.95 },
		[534] = { -690.12,-917.16,23.68,186.89 },
		[535] = { -672.37,-950.15,21.28,344.72 },
		[536] = { -601.33,-981.43,22.33,258.62 },
		[537] = { -591.6,-979.26,22.33,212.89 },
		[538] = { -577.99,-981.56,22.38,86.6 },
		[539] = { -563.57,-974.23,22.18,351.33 },
		[540] = { -558.51,-977.08,22.18,266.31 },
		[541] = { -608.49,-1040.02,22.28,201.67 },
		[542] = { -611.23,-1040.16,22.28,177.63 },
		[543] = { -842.09,-1072.52,10.83,15.91 },
		[544] = { -840.85,-1071.04,10.85,14.24 },
		[545] = { -835.93,-1067.35,11.13,0.31 },
		[546] = { -833.71,-1066.13,11.25,21.61 },
		[547] = { -845.75,-1112.9,7.07,324.6 },
		[548] = { -847.15,-1110.89,7.07,338.72 },
		[549] = { -849.55,-1112.3,7.07,6.52 },
		[550] = { -883.38,-1142.23,5.78,170.03 },
		[551] = { -885.18,-1143.17,5.81,200.89 },
		[552] = { -1018.79,-1118.97,2.14,121.64 },
		[553] = { -1055.63,-1145.86,2.16,31.46 },
		[554] = { -1074.42,-1144.18,2.16,289.38 },
		[555] = { -1075.1,-1142.38,2.16,302.34 },
		[556] = { -1136.38,-1209.29,2.82,103.7 },
		[557] = { -1123.16,-1205.73,2.45,21.62 },
		[558] = { -1146.45,-1190.55,2.62,11.64 },
		[559] = { -1131.69,-1182.69,2.3,17.34 },
		[560] = { -1129.69,-1181.68,2.29,43.23 },
		[561] = { -1148.47,-1165.87,2.53,84.55 },
		[562] = { -1159.16,-1148.31,2.72,68.37 },
		[563] = { -1159.83,-1145.92,2.72,108.23 },
		[564] = { -1170.25,-1100.84,2.44,184.01 },
		[565] = { -1181.07,-1089.72,2.21,17.75 },
		[566] = { -1147.46,-955.34,2.66,195.08 },
		[567] = { -1127.41,-943.87,2.64,207.23 },
		[568] = { -1115.3,-967.03,2.17,127.33 },
		[569] = { -1126.54,-979.73,2.16,116.75 },
		[570] = { -1072.03,-1027.85,2.1,116.13 },
		[571] = { -1377.2,-638.44,28.68,261.81 },
		[572] = { -1387.82,-650.31,28.68,173.0 },
		[573] = { -1390.66,-649.62,28.68,166.29 },
		[574] = { -1396.22,-638.6,28.68,330.39 },
		[575] = { -1397.52,-636.85,28.68,355.1 },
		[576] = { -1406.95,-632.45,28.68,319.54 },
		[577] = { -1427.73,-645.05,28.68,201.51 },
		[578] = { -1417.72,-655.34,28.68,215.05 },
		[579] = { -1422.19,-662.07,28.68,196.7 },
		[580] = { -1434.0,-662.92,26.82,73.69 },
		[581] = { -1432.71,-661.32,26.82,329.43 },
		[582] = { -1431.19,-662.8,26.82,297.45 },
		[583] = { -1452.24,-676.34,26.47,58.45 },
		[584] = { -1453.93,-677.29,26.47,21.74 },
		[585] = { -1452.63,-679.11,26.47,110.06 },
		[586] = { -1506.56,-512.83,32.81,79.59 },
		[587] = { -1504.4,-510.8,32.81,31.52 },
		[588] = { -717.95,-881.56,23.63,47.19 },
		[589] = { -717.93,-882.77,23.66,81.27 },
		[590] = { -569.97,-858.63,26.47,270.89 },
		[591] = { -87.25,-1278.16,29.3,237.52 },
		[592] = { -87.3,-1287.52,29.3,253.29 },
		[593] = { -87.4,-1298.57,29.31,250.49 },
		[594] = { -87.17,-1330.28,29.3,274.01 },
		[595] = { -129.85,-1340.21,29.74,109.93 },
		[596] = { -150.95,-1342.54,29.99,6.65 },
		[597] = { -153.16,-1342.44,30.03,353.14 },
		[598] = { -77.36,-1383.6,29.32,173.62 },
		[599] = { 1.01,-1386.54,29.3,215.31 },
		[600] = { 2.81,-1386.5,29.3,181.81 },
		[601] = { -17.68,-1390.89,29.38,77.35 },
		[602] = { 13.31,-1410.83,29.33,338.85 },
		[603] = { 15.78,-1411.05,29.34,2.62 },
		[604] = { 66.66,-1408.5,29.36,243.88 },
		[605] = { 65.9,-1395.63,29.38,285.15 },
		[606] = { 65.97,-1392.43,29.39,266.22 },
		[607] = { 54.9,-1436.05,29.32,203.61 },
		[608] = { 53.44,-1437.8,29.32,216.19 },
		[609] = { 39.87,-1453.84,29.32,228.21 },
		[610] = { -1.53,-1481.5,30.32,236.81 },
		[611] = { -0.15,-1479.97,30.37,224.32 },
		[612] = { -10.03,-1486.02,30.24,31.31 },
		[613] = { -11.61,-1488.51,30.18,46.3 },
		[614] = { -27.36,-1499.19,30.44,223.2 },
		[615] = { -48.48,-1476.56,32.0,269.31 },
		[616] = { -33.48,-1472.0,31.34,183.09 },
		[617] = { -93.61,-1470.66,33.08,134.23 },
		[618] = { -114.4,-1452.95,33.46,129.19 },
		[619] = { -98.53,-1414.89,29.65,314.34 },
		[620] = { -98.52,-1412.3,29.63,275.68 },
		[621] = { -98.58,-1410.31,29.62,270.68 },
		[622] = { -153.88,-1414.22,30.87,84.67 },
		[623] = { -154.74,-1412.53,30.86,106.25 },
		[624] = { -167.1,-1413.56,30.98,40.81 },
		[625] = { -187.98,-1373.08,31.26,50.4 },
		[626] = { -189.76,-1374.14,31.26,54.91 },
		[627] = { -192.23,-1375.49,31.26,19.45 },
		[628] = { -241.55,-1471.41,31.5,330.19 },
		[629] = { -242.74,-1473.14,31.48,65.74 },
		[630] = { -243.91,-1475.0,31.46,64.96 },
		[631] = { -220.87,-1563.02,34.22,222.13 },
		[632] = { -219.5,-1561.47,34.23,261.16 },
		[633] = { -209.24,-1548.7,34.15,224.88 },
		[634] = { -192.72,-1533.04,33.83,223.56 },
		[635] = { -234.28,-1584.11,34.09,256.85 },
		[636] = { -234.47,-1586.27,34.11,279.56 },
		[637] = { -234.16,-1607.76,34.27,217.99 },
		[638] = { -228.61,-1636.8,33.73,144.53 },
		[639] = { -235.34,-1682.84,33.77,326.03 },
		[640] = { -235.44,-1685.79,33.73,275.46 },
		[641] = { -235.25,-1686.98,33.72,192.78 },
		[642] = { -201.83,-1692.9,34.12,303.06 },
		[643] = { -168.14,-1662.63,33.47,332.09 },
		[644] = { -161.6,-1669.76,33.18,233.29 },
		[645] = { -157.69,-1666.16,33.06,222.01 },
		[646] = { -140.56,-1628.37,32.86,20.43 },
		[647] = { -139.07,-1626.2,32.77,101.75 },
		[648] = { -122.66,-1621.48,32.14,252.27 },
		[649] = { -106.12,-1605.67,31.79,236.65 },
		[650] = { -101.42,-1581.8,31.71,13.75 },
		[651] = { -100.01,-1580.21,31.68,341.4 },
		[652] = { 8.88,-1596.98,29.3,228.33 },
		[653] = { 24.18,-1597.56,29.29,314.93 },
		[654] = { 22.63,-1596.24,29.29,291.25 },
		[655] = { 58.16,-1621.67,29.43,349.62 },
		[656] = { 56.18,-1624.04,29.42,83.82 },
		[657] = { 53.83,-1626.73,29.38,40.85 },
		[658] = { 122.47,-1597.89,29.6,322.42 },
		[659] = { 138.15,-1667.06,29.58,207.93 },
		[660] = { 130.62,-1671.51,29.38,16.21 },
		[661] = { 143.3,-1658.82,29.34,2.88 },
		[662] = { 148.03,-1652.64,29.3,28.71 },
		[663] = { 145.8,-1676.75,29.63,132.47 },
		[664] = { 147.12,-1699.01,29.61,166.98 },
		[665] = { 134.47,-1690.89,29.31,139.07 },
		[666] = { 191.91,-1730.45,29.3,289.19 },
		[667] = { 197.02,-1758.22,29.16,206.51 },
		[668] = { 227.93,-1769.0,28.71,58.3 },
		[669] = { 229.89,-1777.95,28.92,120.83 },
		[670] = { 224.17,-1772.95,29.02,121.35 },
		[671] = { 215.55,-1765.9,29.21,139.79 },
		[672] = { 192.06,-1812.44,28.72,308.4 },
		[673] = { 230.86,-1847.77,26.86,130.8 },
		[674] = { 285.61,-1812.75,27.13,17.83 },
		[675] = { 286.92,-1811.01,27.17,359.34 },
		[676] = { 190.27,-1915.81,22.63,135.67 },
		[677] = { 76.86,-1930.21,20.83,132.53 },
		[678] = { 42.7,-1877.85,22.42,147.13 },
		[679] = { 1.06,-1825.08,25.35,10.22 },
		[680] = { 2.67,-1822.96,25.36,52.45 },
		[681] = { -133.21,-1782.0,29.83,226.63 },
		[682] = { 269.76,-2047.26,17.91,42.08 },
		[683] = { 315.56,-2012.33,21.31,136.32 },
		[684] = { 298.3,-2018.25,20.51,201.7 },
		[685] = { 298.31,-2021.79,20.13,276.92 },
		[686] = { 339.37,-2032.06,21.72,171.74 },
		[687] = { 341.59,-2034.05,22.21,132.57 },
		[688] = { 339.88,-1974.03,24.28,140.99 },
		[689] = { 374.97,-1984.43,24.15,27.28 },
		[690] = { 372.38,-1983.26,24.61,338.05 }
	}

	saveList = garbageList
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINITIAL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	garbageMakeList(false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(120*60000)
		garbageMakeList(true)
		Citizen.Wait(1000)
		TriggerClientEvent("vrp_garbageman:insertBlips",-1,saveList)
		TriggerClientEvent("vrp_garbageman:updateGarbageList",-1,saveList)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARBAGEMAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("lixeiro",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		local inService = vCLIENT.getGarbageStatus(source)
		if inService then
			vCLIENT.stopGarbageman(source)
			TriggerClientEvent("Notify",source,"job-garbageman3","<div style='opacity: 0.7;'><i>Aviso de Trabalho</i></div>Você encerrou o seu turno de <b>Lixeiro</b>.",5000)
			TriggerClientEvent("vrp_sound:source",source,"juntos",0.5)
		else
			vCLIENT.startGarbageman(source)
			TriggerClientEvent("vrp_garbageman:insertBlips",source,saveList)
			TriggerClientEvent("vrp_garbageman:updateGarbageList",source,saveList)
			TriggerClientEvent("Notify",source,"job-garbageman2","<div style='opacity: 0.7;'><i>Aviso de Trabalho</i></div>Você iniciou o seu turno de <b>Lixeiro</b> com sucesso.",5000)
			TriggerClientEvent("vrp_sound:source",source,"quite",0.5)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.paymentMethod(garbageId)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
			TriggerClientEvent("Notify",source,"negado","A sua Mochila está cheia.",5000)
			TriggerClientEvent("vrp_sound:source",source,"when",0.5)
			return
		end
		
		local random = math.random(100)
		if parseInt(random) >= 81 then
			vRP.giveInventoryItem(user_id,"plastic",math.random(8),true)
		elseif parseInt(random) >= 61 and parseInt(random) <= 80 then
			vRP.giveInventoryItem(user_id,"glass",math.random(8),true)
		elseif parseInt(random) >= 41 and parseInt(random) <= 60 then
			vRP.giveInventoryItem(user_id,"rubber",math.random(6),true)
		elseif parseInt(random) >= 26 and parseInt(random) <= 40 then
			vRP.giveInventoryItem(user_id,"aluminum",math.random(5),true)
		elseif parseInt(random) >= 10 and parseInt(random) <= 25 then
			vRP.giveInventoryItem(user_id,"copper",math.random(5),true)
		end

		vRP.upgradeStress(user_id,1)
		saveList[parseInt(garbageId)] = nil
		TriggerClientEvent("vrp_sound:source",source,"takeThis",0.5)
		TriggerClientEvent("vrp_garbageman:updateGarbageList",-1,saveList)
		TriggerClientEvent("vrp_garbageman:removeGarbageBlips",-1,parseInt(garbageId))
	end
end