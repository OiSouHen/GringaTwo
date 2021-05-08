Config = {}

Config.Plants = {}

Config.GrowthTimer = 2-- In Minutes

Config.StartingThirst = 30.0
Config.StartingHunger = 30.0

Config.HungerIncrease = 15.0
Config.ThirstIncrease = 12.0

Config.Degrade = {min = 3, max = 5}
Config.QualityDegrade = {min = 8, max = 12}
Config.GrowthIncrease = {min = 10, max = 20}

Config.YieldRewards = {
    {type = "banana_kush", rewardMin = 5, rewardMax = 6, item = 'weed', label = 'Maconha pesada'},
    {type = "blue_dream", rewardMin = 4, rewardMax = 6, item = 'weed', label = 'Maconha de qualidade'},
    {type = "purplehaze", rewardMin = 3, rewardMax = 5, item = 'weed', label = 'Maconha fresca'},
    {type = "og_kush", rewardMin = 2, rewardMax = 3, item = 'weed', label = 'Maconha Natura'},
}

Config.MaxPlantCount = 6

Config.BadSeedReward = "weed_og-kush_seed" -- 125

Config.GoodSeedRewards = {
    [1] = "weed_bananakush_seed", -- 185
    [2] = "weed_bluedream_seed", -- 175
    [3] = "weed_purple-haze_seed", -- 190
}

Config.WeedStages = {
    [1] = "bkr_prop_weed_01_small_01c",
    [2] = "bkr_prop_weed_med_01a",
    [3] = "bkr_prop_weed_lrg_01a",
}

Config.SeedLocations = {
    {x = 2231.685, y = 5578.843, z = 54.066, h = 278.452},
    {x = 2227.496, y = 5579.036, z = 53.952, h = 284.76},
    {x = 2222.042, y = 5579.646, z = 53.934, h = 296.832},
    {x = 2214.249, y = 5575.106, z = 53.673, h = 162.243},
    {x = 2218.734, y = 5575.268, z = 53.717, h = 95.948},
    {x = 2223.127, y = 5574.872, z = 53.73, h = 113.047},
    {x = 2227.75, y = 5574.38, z = 53.814, h = 94.541},
    {x = 2233.955, y = 5574.232, z = 53.989, h = 159.559},
    {x = 2234.59, y = 5578.732, z = 54.117, h = 6.328},
    {x = 2234.148, y = 5576.116, z = 54.041, h = 328.206},
    {x = 2229.784, y = 5576.688, z = 53.939, h = 259.681},
    {x = 2224.872, y = 5576.866, z = 53.85, h = 270.137},
    {x = 2220.167, y = 5577.162, z = 53.844, h = 272.316},
    {x = 2216.635, y = 5577.483, z = 53.847, h = 35.148},
}