local colors = {
	{ name = "Black", colorindex = 0 },
	{ name = "Carbon Black", colorindex = 147 },
	{ name = "Hraphite", colorindex = 1 },
	{ name = "Anhracite Black", colorindex = 11 },
	{ name = "Black Steel", colorindex = 2 },
	{ name = "Dark Steel", colorindex = 3 },
	{ name = "Silver", colorindex = 4 },
	{ name = "Bluish Silver", colorindex = 5 },
	{ name = "Rolled Steel", colorindex = 6 },
	{ name = "Shadow Silver", colorindex = 7 },
	{ name = "Stone Silver", colorindex = 8 },
	{ name = "Midnight Silver", colorindex = 9 },
	{ name = "Cast Iron Silver", colorindex = 10 },
	{ name = "Red", colorindex = 27 },
	{ name = "Torino Red", colorindex = 28 },
	{ name = "Formula Red", colorindex = 29 },
	{ name = "Lava Red", colorindex = 150 },
	{ name = "Blaze Red", colorindex = 30 },
	{ name = "Grace Red", colorindex = 31 },
	{ name = "Garnet Red", colorindex = 32 },
	{ name = "Sunset Red", colorindex = 33 },
	{ name = "Cabernet Red", colorindex = 34 },
	{ name = "Wine Red", colorindex = 143 },
	{ name = "Candy Red", colorindex = 35 },
	{ name = "Hot Pink", colorindex = 135 },
	{ name = "Pfsiter Pink", colorindex = 137 },
	{ name = "Salmon Pink", colorindex = 136 },
	{ name = "Sunrise Orange", colorindex = 36 },
	{ name = "Orange", colorindex = 38 },
	{ name = "Bright Orange", colorindex = 138 },
	{ name = "Gold", colorindex = 99 },
	{ name = "Bronze", colorindex = 90 },
	{ name = "Yellow", colorindex = 88 },
	{ name = "Race Yellow", colorindex = 89 },
	{ name = "Dew Yellow", colorindex = 91 },
	{ name = "Dark Green", colorindex = 49 },
	{ name = "Racing Green", colorindex = 50 },
	{ name = "Sea Green", colorindex = 51 },
	{ name = "Olive Green", colorindex = 52 },
	{ name = "Bright Green", colorindex = 53 },
	{ name = "Gasoline Green", colorindex = 54 },
	{ name = "Lime Green", colorindex = 92 },
	{ name = "Midnight Blue", colorindex = 141 },
	{ name = "Galaxy Blue", colorindex = 61 },
	{ name = "Dark Blue", colorindex = 62 },
	{ name = "Saxon Blue", colorindex = 63 },
	{ name = "Blue", colorindex = 64 },
	{ name = "Mariner Blue", colorindex = 65 },
	{ name = "Harbor Blue", colorindex = 66 },
	{ name = "Diamond Blue", colorindex = 67 },
	{ name = "Surf Blue", colorindex = 68 },
	{ name = "Nautical Blue", colorindex = 69 },
	{ name = "Racing Blue", colorindex = 73 },
	{ name = "Ultra Blue", colorindex = 70 },
	{ name = "Light Blue", colorindex = 74 },
	{ name = "Chocolate Brown", colorindex = 96 },
	{ name = "Bison Brown", colorindex = 101 },
	{ name = "Creeen Brown", colorindex = 95 },
	{ name = "Feltzer Brown", colorindex = 94 },
	{ name = "Maple Brown", colorindex = 97 },
	{ name = "Beechwood Brown", colorindex = 103 },
	{ name = "Sienna Brown", colorindex = 104 },
	{ name = "Saddle Brown", colorindex = 98 },
	{ name = "Moss Brown", colorindex = 100 },
	{ name = "Woodbeech Brown", colorindex = 102 },
	{ name = "Straw Brown", colorindex = 99 },
	{ name = "Sandy Brown", colorindex = 105 },
	{ name = "Bleached Brown", colorindex = 106 },
	{ name = "Schafter Purple", colorindex = 71 },
	{ name = "Spinnaker Purple", colorindex = 72 },
	{ name = "Midnight Purple", colorindex = 142 },
	{ name = "Bright Purple", colorindex = 145 },
	{ name = "Cream", colorindex = 107 },
	{ name = "Ice White", colorindex = 111 },
	{ name = "Frost White", colorindex = 112 }
}

local metalcolors = {
	{ name = "Brushed Steel", colorindex = 117 },
	{ name = "Brushed Black Steel", colorindex = 118 },
	{ name = "Brushed Aluminum", colorindex = 119 },
	{ name = "Pure Gold", colorindex = 158 },
	{ name = "Brushed Gold", colorindex = 159 }
}

local mattecolors = {
	{ name = "Black", colorindex = 12 },
	{ name = "Gray", colorindex = 13 },
	{ name = "Light Gray", colorindex = 14 },
	{ name = "Ice White", colorindex = 131 },
	{ name = "Blue", colorindex = 83 },
	{ name = "Dark Blue", colorindex = 82 },
	{ name = "Midnight Blue", colorindex = 84 },
	{ name = "Midnight Purple", colorindex = 149 },
	{ name = "Schafter Purple", colorindex = 148 },
	{ name = "Red", colorindex = 39 },
	{ name = "Dark Red", colorindex = 40 },
	{ name = "Orange", colorindex = 41 },
	{ name = "Yellow", colorindex = 42 },
	{ name = "Lime Green", colorindex = 55 },
	{ name = "Green", colorindex = 128 },
	{ name = "Frost Green", colorindex = 151 },
	{ name = "Foliage Green", colorindex = 155 },
	{ name = "Olive Darb", colorindex = 152 },
	{ name = "Dark Earth", colorindex = 153 },
	{ name = "Desert Tan", colorindex = 154 }
}

LSC_Config = {}
LSC_Config.prices = {}
LSC_Config.prices = {
	windowtint = {
		{ name = "Pure Black", tint = 1, price = 2000 },
		{ name = "Darksmoke", tint = 2, price = 2000 },
		{ name = "Lightsmoke", tint = 3, price = 2000 },
		{ name = "Limo", tint = 4, price = 2000 },
		{ name = "Green", tint = 5, price = 2000 }
	},
	chrome = {
		colors = {
			{ name = "Chrome", colorindex = 120 }
		},
		price = 1000
	},
	classic = {
		colors = colors,
		price = 500
	},
	matte = {
		colors = mattecolors,
		price = 500
	},
	metallic = {
		colors = colors,
		price = 500
	},
	metal = {
		colors = metalcolors,
		price = 500
	},
	chrome2 = {
		colors = {
			{ name = "Chrome", colorindex = 120 }
		},
		price = 1000
	},
	classic2 = {
		colors = colors,
		price = 500
	},
	matte2 = {
		colors = mattecolors,
		price = 500
	},
	metallic2 = {
		colors = colors,
		price = 500
	},
	metal2 = {
		colors = metalcolors,
		price = 500
	},
	neonlayout = {
		{ name = "Front,Back and Sides", price = 2000 }
	},
	neoncolor = {
		{ name = "White", neon = {255,255,255}, price = 500 },
		{ name = "Blue", neon = {0,0,255}, price = 500 },
		{ name = "Electric Blue", neon = {0,150,255}, price = 500 },
		{ name = "Mint Green", neon = {50,255,155}, price = 500 },
		{ name = "Lime Green", neon = {0,255,0}, price = 500 },
		{ name = "Yellow", neon = {255,255,0}, price = 500 },
		{ name = "Golden Shower", neon = {204,204,0}, price = 500 },
		{ name = "Orange", neon = {255,128,0}, price = 500 },
		{ name = "Red", neon = {255,0,0}, price = 500 },
		{ name = "Pony Pink", neon = {255,102,255}, price = 500 },
		{ name = "Hot Pink",neon = {255,0,255}, price = 500 },
		{ name = "Purple", neon = {153,0,153}, price = 500 },
		{ name = "Brown", neon = {139,69,19}, price = 500 }
	},
	xenoncolor = {
		{ name = "White", xenon = 0, price = 1000 },
		{ name = "Blue", xenon = 1, price = 1000 },
		{ name = "Electric Blue", xenon = 2, price = 1000 },
		{ name = "Mint Green", xenon = 3, price = 1000 },
		{ name = "Lime Green", xenon = 4, price = 1000 },
		{ name = "Yellow", xenon = 5, price = 1000 },
		{ name = "Golden Shower", xenon = 6, price = 1000 },
		{ name = "Orange", xenon = 7, price = 1000 },
		{ name = "Red", xenon = 8, price = 1000 },
		{ name = "Pony Pink", xenon = 9, price = 1000 },
		{ name = "Hot Pink",xenon = 10, price = 1000 },
		{ name = "Purple", xenon = 11, price = 1000 },
		{ name = "Blacklight", xenon = 12, price = 1000 }
	},
	plates = {
		{ name = "Blue on White 1", plateindex = 0, price = 500 },
		{ name = "Blue On White 2", plateindex = 3, price = 500 },
		{ name = "Blue On White 3", plateindex = 4, price = 500 },
		{ name = "Yellow on Blue", plateindex = 2, price = 500 },
		{ name = "Yellow on Black", plateindex = 1, price = 500 }
	},
	wheelaccessories = {
		{ name = "Stock Tires", price = 500 },
		{ name = "Custom Tires", price = 500 },
		{ name = "White Tire Smoke", smokecolor = {254,254,254}, price = 500 },
		{ name = "Black Tire Smoke", smokecolor = {1,1,1}, price = 500 },
		{ name = "BLue Tire Smoke", smokecolor = {0,150,255}, price = 500 },
		{ name = "Yellow Tire Smoke", smokecolor = {255,255,50}, price = 500 },
		{ name = "Orange Tire Smoke", smokecolor = {255,153,51}, price = 500 },
		{ name = "Red Tire Smoke", smokecolor = {255,10,10}, price = 500 },
		{ name = "Green Tire Smoke", smokecolor = {10,255,10}, price = 500 },
		{ name = "Purple Tire Smoke", smokecolor = {153,10,153}, price = 500 },
		{ name = "Pink Tire Smoke", smokecolor = {255,102,178}, price = 500 },
		{ name = "Gray Tire Smoke",smokecolor = {128,128,128}, price = 500 }
	},
	wheelcolor = {
		colors = colors,
		price = 500
	},
	frontwheel = {
		{ name = "Stock", wtype = 6, mod = -1, price = 1000 },
		{ name = "Speedway", wtype = 6, mod = 0, price = 1000 },
		{ name = "Streetspecial", wtype = 6, mod = 1, price = 1000 },
		{ name = "Racer", wtype = 6, mod = 2, price = 1000 },
		{ name = "Trackstar", wtype = 6, mod = 3, price = 1000 },
		{ name = "Overlord", wtype = 6, mod = 4, price = 1000 },
		{ name = "Trident", wtype = 6, mod = 5, price = 1000 },
		{ name = "Triplethreat", wtype = 6, mod = 6, price = 1000 },
		{ name = "Stilleto", wtype = 6, mod = 7, price = 1000 },
		{ name = "Wires", wtype = 6, mod = 8, price = 1000 },
		{ name = "Bobber", wtype = 6, mod = 9, price = 1000 },
		{ name = "Solidus", wtype = 6, mod = 10, price = 1000 },
		{ name = "Iceshield", wtype = 6, mod = 11, price = 1000 },
		{ name = "Loops", wtype = 6, mod = 12, price = 1000 }
	},
	backwheel = {
		{ name = "Stock", wtype = 6, mod = -1, price = 1000 },
		{ name = "Speedway", wtype = 6, mod = 0, price = 1000 },
		{ name = "Streetspecial", wtype = 6, mod = 1, price = 1000 },
		{ name = "Racer", wtype = 6, mod = 2, price = 1000 },
		{ name = "Trackstar", wtype = 6, mod = 3, price = 1000 },
		{ name = "Overlord", wtype = 6, mod = 4, price = 1000 },
		{ name = "Trident", wtype = 6, mod = 5, price = 1000 },
		{ name = "Triplethreat", wtype = 6, mod = 6, price = 1000 },
		{ name = "Stilleto", wtype = 6, mod = 7, price = 1000 },
		{ name = "Wires", wtype = 6, mod = 8, price = 1000 },
		{ name = "Bobber", wtype = 6, mod = 9, price = 1000 },
		{ name = "Solidus", wtype = 6, mod = 10, price = 1000 },
		{ name = "Iceshield", wtype = 6, mod = 11, price = 1000 },
		{ name = "Loops", wtype = 6, mod = 12, price = 1000 }
	},
	sportwheels = {
		{ name = "Stock", wtype = 0, mod = -1, price = 1000 },
		{ name = "Inferno", wtype = 0, mod = 0, price = 1000 },
		{ name = "Deepfive", wtype = 0, mod = 1, price = 1000 },
		{ name = "Lozspeed", wtype = 0, mod = 2, price = 1000 },
		{ name = "Diamondcut", wtype = 0, mod = 3, price = 1000 },
		{ name = "Chrono", wtype = 0, mod = 4, price = 1000 },
		{ name = "Feroccirr", wtype = 0, mod = 5, price = 1000 },
		{ name = "Fiftynine", wtype = 0, mod = 6, price = 1000 },
		{ name = "Mercie", wtype = 0, mod = 7, price = 1000 },
		{ name = "Syntheticz", wtype = 0, mod = 8, price = 1000 },
		{ name = "Organictyped", wtype = 0, mod = 9, price = 1000 },
		{ name = "Endov1", wtype = 0, mod = 10, price = 1000 },
		{ name = "Duper7", wtype = 0, mod = 11, price = 1000 },
		{ name = "Uzer", wtype = 0, mod = 12, price = 1000 },
		{ name = "Groundride", wtype = 0, mod = 13, price = 1000 },
		{ name = "Spacer", wtype = 0, mod = 14, price = 1000 },
		{ name = "Venum", wtype = 0, mod = 15, price = 1000 },
		{ name = "Cosmo", wtype = 0, mod = 16, price = 1000 },
		{ name = "Dashvip", wtype = 0, mod = 17, price = 1000 },
		{ name = "Icekid", wtype = 0, mod = 18, price = 1000 },
		{ name = "Ruffeld", wtype = 0, mod = 19, price = 1000 },
		{ name = "Wangenmaster", wtype = 0, mod = 20, price = 1000 },
		{ name = "Superfive", wtype = 0, mod = 21, price = 1000 },
		{ name = "Endov2", wtype = 0, mod = 22, price = 1000 },
		{ name = "Slitsix", wtype = 0, mod = 23, price = 1000 }
	},
	importwheels = {
		{ name = "Stock", wtype = 0, mod = -1, price = 1000 },
		{ name = "Cosmo", wtype = 0, mod = 50, price = 2000 },
		{ name = "Supermesh", wtype = 0, mod = 51, price = 2000 },
		{ name = "Outsider", wtype = 0, mod = 52, price = 2000 },
		{ name = "Rollas", wtype = 0, mod = 53, price = 2000 },
		{ name = "Driffmeister", wtype = 0, mod = 54, price = 2000 },
		{ name = "Slicer", wtype = 0, mod = 55, price = 2000 },
		{ name = "Elquatro", wtype = 0, mod = 56, price = 2000 },
		{ name = "Dubbed", wtype = 0, mod = 57, price = 2000 },
		{ name = "Fivestar", wtype = 0, mod = 58, price = 2000 },
		{ name = "Slideways", wtype = 0, mod = 59, price = 2000 },
		{ name = "Apex", wtype = 0, mod = 60, price = 2000 },
		{ name = "Stancedeg", wtype = 0, mod = 61, price = 2000 },
		{ name = "Countersteer", wtype = 0, mod = 62, price = 2000 },
		{ name = "Endov1", wtype = 0, mod = 63, price = 2000 },
		{ name = "Endov2dish", wtype = 0, mod = 64, price = 2000 },
		{ name = "Guppez", wtype = 0, mod = 65, price = 2000 },
		{ name = "Chokadori", wtype = 0, mod = 66, price = 2000 },
		{ name = "Chicane", wtype = 0, mod = 67, price = 2000 },
		{ name = "Saisoku", wtype = 0, mod = 68, price = 2000 },
		{ name = "Dishedeight", wtype = 0, mod = 69, price = 2000 },
		{ name = "Fujiwara", wtype = 0, mod = 70, price = 2000 },
		{ name = "Zokusha", wtype = 0, mod = 71, price = 2000 },
		{ name = "Battlevill", wtype = 0, mod = 72, price = 2000 },
		{ name = "Rallymaster", wtype = 0, mod = 73, price = 2000 },
		{ name = "Enercy", wtype = 0, mod = 74, price = 2000 },
		{ name = "Benefactor", wtype = 0, mod = 75, price = 2000 },
		{ name = "Bippu", wtype = 0, mod = 76, price = 2000 },
		{ name = "Royalsix", wtype = 0, mod = 77, price = 2000 },
		{ name = "Fagorme", wtype = 0, mod = 78, price = 2000 },
		{ name = "Deluxe", wtype = 0, mod = 79, price = 2000 },
		{ name = "Icedout", wtype = 0, mod = 80, price = 2000 },
		{ name = "Cognscenti", wtype = 0, mod = 81, price = 2000 },
		{ name = "Empowered", wtype = 0, mod = 82, price = 2000 }
	},
	suvwheels = {
		{ name = "Stock", wtype = 3, mod = -1, price = 1000 },
		{ name = "Enercy", wtype = 3, mod = 0, price = 1000 },
		{ name = "Benefactor", wtype = 3, mod = 1, price = 1000 },
		{ name = "Cosmo", wtype = 3, mod = 2, price = 1000 },
		{ name = "Bippu", wtype = 3, mod = 3, price = 1000 },
		{ name = "Royalsix", wtype = 3, mod = 4, price = 1000 },
		{ name = "Fagorme", wtype = 3, mod = 5, price = 1000 },
		{ name = "Deluxe", wtype = 3, mod = 6, price = 1000 },
		{ name = "Icedout", wtype = 3, mod = 7, price = 1000 },
		{ name = "Cognscenti", wtype = 3, mod = 8, price = 1000 },
		{ name = "Lozspeedten", wtype = 3, mod = 9, price = 1000 },
		{ name = "Supernova", wtype = 3, mod = 10, price = 1000 },
		{ name = "Obeyrs", wtype = 3, mod = 11, price = 1000 },
		{ name = "Lozspeedballer", wtype = 3, mod = 12, price = 1000 },
		{ name = "Extra vaganzo", wtype = 3, mod = 13, price = 1000 },
		{ name = "Splitsix", wtype = 3, mod = 14, price = 1000 },
		{ name = "Empowered", wtype = 3, mod = 15, price = 1000 },
		{ name = "Sunrise", wtype = 3, mod = 16, price = 1000 },
		{ name = "Dashvip", wtype = 3, mod = 17, price = 1000 },
		{ name = "Cutter", wtype = 3, mod = 18, price = 1000 }
	},
	offroadwheels = {
		{ name = "Stock", wtype = 4, mod = -1, price = 1000 },
		{ name = "Raider", wtype = 4, mod = 0, price = 1000 },
		{ name = "Mudslinger", wtype = 4, modtype = 23, wtype = 4, mod = 1, price = 1000 },
		{ name = "Nevis", wtype = 4, mod = 2, price = 1000 },
		{ name = "Cairngorm", wtype = 4, mod = 3, price = 1000 },
		{ name = "Amazon", wtype = 4, mod = 4, price = 1000 },
		{ name = "Challenger", wtype = 4, mod = 5, price = 1000 },
		{ name = "Dunebasher", wtype = 4, mod = 6, price = 1000 },
		{ name = "Fivestar", wtype = 4, mod = 7, price = 1000 },
		{ name = "Rockcrawler", wtype = 4, mod = 8, price = 1000 },
		{ name = "Milspecsteelie", wtype = 4, mod = 9, price = 1000 },
	},
	tunerwheels = {
		{ name = "Stock", wtype = 5, mod = -1, price = 1000 },
		{ name = "Cosmo", wtype = 5, mod = 0, price = 1000 },
		{ name = "Supermesh", wtype = 5, mod = 1, price = 1000 },
		{ name = "Outsider", wtype = 5, mod = 2, price = 1000 },
		{ name = "Rollas", wtype = 5, mod = 3, price = 1000 },
		{ name = "Driffmeister", wtype = 5, mod = 4, price = 1000 },
		{ name = "Slicer", wtype = 5, mod = 5, price = 1000 },
		{ name = "Elquatro", wtype = 5, mod = 6, price = 1000 },
		{ name = "Dubbed", wtype = 5, mod = 7, price = 1000 },
		{ name = "Fivestar", wtype = 5, mod = 8, price = 1000 },
		{ name = "Slideways", wtype = 5, mod = 9, price = 1000 },
		{ name = "Apex", wtype = 5, mod = 10, price = 1000 },
		{ name = "Stancedeg", wtype = 5, mod = 11, price = 1000 },
		{ name = "Countersteer", wtype = 5, mod = 12, price = 1000 },
		{ name = "Endov1", wtype = 5, mod = 13, price = 1000 },
		{ name = "Endov2dish", wtype = 5, mod = 14, price = 1000 },
		{ name = "Guppez", wtype = 5, mod = 15, price = 1000 },
		{ name = "Chokadori", wtype = 5, mod = 16, price = 1000 },
		{ name = "Chicane", wtype = 5, mod = 17, price = 1000 },
		{ name = "Saisoku", wtype = 5, mod = 18, price = 1000 },
		{ name = "Dishedeight", wtype = 5, mod = 19, price = 1000 },
		{ name = "Fujiwara", wtype = 5, mod = 20, price = 1000 },
		{ name = "Zokusha", wtype = 5, mod = 21, price = 1000 },
		{ name = "Battlevill", wtype = 5, mod = 22, price = 1000 },
		{ name = "Rallymaster", wtype = 5, mod = 23, price = 1000 }
	},
	highendwheels = {
		{ name = "Stock", wtype = 7, mod = -1, price = 1000 },
		{ name = "Shadow", wtype = 7, mod = 0, price = 1000 },
		{ name = "Hyper", wtype = 7, mod = 1, price = 1000 },
		{ name = "Blade", wtype = 7, mod = 2, price = 1000 },
		{ name = "Diamond", wtype = 7, mod = 3, price = 1000 },
		{ name = "Supagee", wtype = 7, mod = 4, price = 1000 },
		{ name = "Chromaticz", wtype = 7, mod = 5, price = 1000 },
		{ name = "Merciechlip", wtype = 7, mod = 6, price = 1000 },
		{ name = "Obeyrs", wtype = 7, mod = 7, price = 1000 },
		{ name = "Gtchrome", wtype = 7, mod = 8, price = 1000 },
		{ name = "Cheetahr", wtype = 7, mod = 9, price = 1000 },
		{ name = "Solar", wtype = 7, mod = 10, price = 1000 },
		{ name = "Splitten", wtype = 7, mod = 11, price = 1000 },
		{ name = "Dashvip", wtype = 7, mod = 12, price = 1000 },
		{ name = "Lozspeedten", wtype = 7, mod = 13, price = 1000 },
		{ name = "Carboninferno", wtype = 7, mod = 14, price = 1000 },
		{ name = "Carbonshadow", wtype = 7, mod = 15, price = 1000 },
		{ name = "Carbonz", wtype = 7, mod = 16, price = 1000 },
		{ name = "Carbonsolar", wtype = 7, mod = 17, price = 1000 },
		{ name = "Carboncheetahr", wtype = 7, mod = 18, price = 1000 },
		{ name = "Carbonsracer", wtype = 7, mod = 19, price = 1000 }
	},
	lowriderwheels = {
		{ name = "Stock", wtype = 2, mod = -1, price = 1000 },
		{ name = "Flare", wtype = 2, mod = 0, price = 1000 },
		{ name = "Wired", wtype = 2, mod = 1, price = 1000 },
		{ name = "Triplegolds", wtype = 2, mod = 2, price = 1000 },
		{ name = "Bigworm", wtype = 2, mod = 3, price = 1000 },
		{ name = "Sevenfives", wtype = 2, mod = 4, price = 1000 },
		{ name = "Splitsix", wtype = 2, mod = 5, price = 1000 },
		{ name = "Freshmesh", wtype = 2, mod = 6, price = 1000 },
		{ name = "Leadsled", wtype = 2, mod = 7, price = 1000 },
		{ name = "Turbine", wtype = 2, mod = 8, price = 1000 },
		{ name = "Superfin", wtype = 2, mod = 9, price = 1000 },
		{ name = "Classicrod", wtype = 2, mod = 10, price = 1000 },
		{ name = "Dollar", wtype = 2, mod = 11, price = 1000 },
		{ name = "Dukes", wtype = 2, mod = 12, price = 1000 },
		{ name = "Lowfive", wtype = 2, mod = 13, price = 1000 },
		{ name = "Gooch", wtype = 2, mod = 14, price = 1000 }
	},
	musclewheels = {
		{ name = "Stock", wtype = 1, mod = -1, price = 1000 },
		{ name = "Classicfive", wtype = 1, mod = 0, price = 1000 },
		{ name = "Dukes", wtype = 1, mod = 1, price = 1000 },
		{ name = "Musclefreak", wtype = 1, mod = 2, price = 1000 },
		{ name = "Kracka", wtype = 1, mod = 3, price = 1000 },
		{ name = "Azrea", wtype = 1, mod = 4, price = 1000 },
		{ name = "Mecha", wtype = 1, mod = 5, price = 1000 },
		{ name = "Blacktop", wtype = 1, mod = 6, price = 1000 },
		{ name = "Dragspl", wtype = 1, mod = 7, price = 1000 },
		{ name = "Revolver", wtype = 1, mod = 8, price = 1000 },
		{ name = "Classicrod", wtype = 1, mod = 9, price = 1000 },
		{ name = "Spooner", wtype = 1, mod = 10, price = 1000 },
		{ name = "Fivestar", wtype = 1, mod = 11, price = 1000 },
		{ name = "Oldschool", wtype = 1, mod = 12, price = 1000 },
		{ name = "Eljefe", wtype = 1, mod = 13, price = 1000 },
		{ name = "Dodman", wtype = 1, mod = 14, price = 1000 },
		{ name = "Sixgun", wtype = 1, mod = 15, price = 1000 },
		{ name = "Mercenary", wtype = 1, mod = 16, price = 1000 }
	},
	trim = {
		colors = colors,
		price = 500
	},
	mods = {
		[48] = {
			startprice = 1000,
			increaseby = 0
		},
		[46] = {
			startprice = 1000,
			increaseby = 0
		},
		[45] = {
			startprice = 1000,
			increaseby = 0
		},
		[44] = {
			startprice = 1000,
			increaseby = 0
		},
		[43] = {
			startprice = 1000,
			increaseby = 0
		},
		[42] = {
			startprice = 1000,
			increaseby = 0
		},
		[41] = {
			startprice = 1000,
			increaseby = 0
		},
		[40] = {
			startprice = 1000,
			increaseby = 0
		},
		[39] = {
			startprice = 1000,
			increaseby = 0
		},
		[38] = {
			startprice = 1000,
			increaseby = 0
		},
		[37] = {
			startprice = 1000,
			increaseby = 0
		},
		[36] = {
			startprice = 1000,
			increaseby = 0
		},
		[35] = {
			startprice = 1000,
			increaseby = 0
		},
		[34] = {
			startprice = 1000,
			increaseby = 0
		},
		[33] = {
			startprice = 1000,
			increaseby = 0
		},
		[32] = {
			startprice = 1000,
			increaseby = 0
		},
		[31] = {
			startprice = 1000,
			increaseby = 0
		},
		[30] = {
			startprice = 1000,
			increaseby = 0
		},
		[29] = {
			startprice = 1000,
			increaseby = 0
		},
		[28] = {
			startprice = 1000,
			increaseby = 0
		},
		[27] = {
			startprice = 1000,
			increaseby = 0
		},
		[26] = {
			startprice = 1000,
			increaseby = 0
		},
		[25] = {
			startprice = 1000,
			increaseby = 0
		},
		[22] = {
			{ name = "Stock", mod = 0, price = 1000 },
			{ name = "Xenon", mod = 1, price = 2000 }
		},
		[18] = {
			{ name = "None", mod = 0, price = 20000 },
			{ name = "Turbo", mod = 1, price = 20000 }
		},
		[16] = {
			{ name = "Blindagem 20%", modtype = 16, mod = 0, price = 30000 },
			{ name = "Blindagem 40%", modtype = 16, mod = 1, price = 60000 },
			{ name = "Blindagem 60%", modtype = 16, mod = 2, price = 90000 },
			{ name = "Blindagem 80%", modtype = 16, mod = 3, price = 120000 },
			{ name = "Blindagem 100%", modtype = 16, mod = 4, price = 150000 }
		},
		[15] = {
			{ name = "Lowered Suspension", mod = 0, price = 20000 },
			{ name = "Street Suspension", mod = 1, price = 40000 },
			{ name = "Sport Suspension", mod = 2, price = 60000 },
			{ name = "Race Suspension", mod = 3, price = 80000 }
		},
		[14] = {
			{ name = "Truck Horn", mod = 0, price = 1000 },
			{ name = "Police Horn", mod = 1, price = 1000 },
			{ name = "Clown Horn", mod = 2, price = 1000 },
			{ name = "Musical Horn 1", mod = 3, price = 1000 },
			{ name = "Musical Horn 2", mod = 4, price = 1000 },
			{ name = "Musical Horn 3", mod = 5, price = 1000 },
			{ name = "Musical Horn 4", mod = 6, price = 1000 },
			{ name = "Musical Horn 5", mod = 7, price = 1000 },
			{ name = "Sad Trombone", mod = 8, price = 1000 },
			{ name = "Classical Horn 1", mod = 9, price = 1000 },
			{ name = "Classical Horn 2", mod = 10, price = 1000 },
			{ name = "Classical Horn 3", mod = 11, price = 1000 },
			{ name = "Classical Horn 4", mod = 12, price = 1000 },
			{ name = "Classical Horn 5", mod = 13, price = 1000 },
			{ name = "Classical Horn 6", mod = 14, price = 1000 },
			{ name = "Classical Horn 7", mod = 15, price = 1000 },
			{ name = "Scale Do", mod = 16, price = 1000 },
			{ name = "Scale Re", mod = 17, price = 1000 },
			{ name = "Scale Mi", mod = 18, price = 1000 },
			{ name = "Scale Fa", mod = 19, price = 1000 },
			{ name = "Scale Sol", mod = 20, price = 1000 },
			{ name = "Scale La", mod = 21, price = 1000 },
			{ name = "Scale Ti", mod = 22, price = 1000 },
			{ name = "Scale Do (High)", mod = 23, price = 1000 },
			{ name = "Jazz Horn 1", mod = 24, price = 1000 },
			{ name = "Jazz Horn 2", mod = 25, price = 1000 },
			{ name = "Jazz Horn 3", mod = 26, price = 1000 },
			{ name = "Jazz Horn Loop", mod = 27, price = 1000 },
			{ name = "Star Spangled Banner 1", mod = 28, price = 1000 },
			{ name = "Star Spangled Banner 2", mod = 29, price = 1000 },
			{ name = "Star Spangled Banner 3", mod = 30, price = 1000 },
			{ name = "Star Spangled Banner 4", mod = 31, price = 1000 },
			{ name = "Classical Horn Loop 1", mod = 32, price = 1000 },
			{ name = "Classical Horn 8", mod = 33, price = 1000 },
			{ name = "Classical Horn Loop 2", mod = 34, price = 1000 },
			{ name = "Halloween Loop 1", mod = 38, price = 1000 },
			{ name = "Halloween Loop 2", mod = 40, price = 1000 },
			{ name = "San Andreas Loop", mod = 42, price = 1000 },
			{ name = "Liberty City Loop", mod = 44, price = 1000 },
			{ name = "Festive Loop 1", mod = 46, price = 1000 },
			{ name = "Festive Loop 2", mod = 47, price = 1000 },
			{ name = "Festive Loop 3", mod = 48, price = 1000 }
		},
		[13] = {
			{ name = "Street Transmission", mod = 0, price = 20000 },
			{ name = "Sport Transmission", mod = 1, price = 40000 },
			{ name = "Race Transmission", mod = 2, price = 60000 }
		},
		[12] = {
			{ name = "Street Brakes", mod = 0, price = 30000 },
			{ name = "Sport Brakes", mod = 1, price = 40000 },
			{ name = "Race Brakes", mod = 2, price = 60000 }
		},
		[11] = {
			{ name = "Lowered Engine", mod = 0, price = 20000 },
			{ name = "Street Engine", mod = 1, price = 40000 },
			{ name = "Sports Engine", mod = 2, price = 60000 },
			{ name = "Race Engine", mod = 3, price = 80000 }
		},
		[10] = {
			startprice = 1000,
			increaseby = 0
		},
		[8] = {
			startprice = 1000,
			increaseby = 0
		},
		[7] = {
			startprice = 1000,
			increaseby = 0
		},
		[6] = {
			startprice = 1000,
			increaseby = 0
		},
		[5] = {
			startprice = 1000,
			increaseby = 0
		},
		[4] = {
			startprice = 1000,
			increaseby = 0
		},
		[3] = {
			startprice = 1000,
			increaseby = 0
		},
		[2] = {
			startprice = 1000,
			increaseby = 0
		},
		[1] = {
			startprice = 1000,
			increaseby = 0
		},
		[0] = {
			startprice = 1000,
			increaseby = 0
		}
	}
}

LSC_Config.menu = {
	controls = {
		menu_up = 27,
		menu_down = 173,
		menu_left = 174,
		menu_right = 175,
		menu_select = 201,
		menu_back = 177
	},
	position = "left",
	theme = "bluish",
	maxbuttons = 10,
	width = 0.24,
	height = 0.36
}