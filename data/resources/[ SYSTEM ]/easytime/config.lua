Config = {}

Config.UseESX = false
Config.Command = 'changetime'
Config.Notification_Type = 'notify'
Config.Language = 'BR'

Config.TimeCycleSpeed = 30000
Config.DynamicWeather = true
Config.DynamicWeather_time = 30
Config.RainChance = 5
Config.SnowChance = 1
Config.ThunderChance = 10

Config.WeatherGroups = {
    [1] = {'CLEAR', 'OVERCAST','EXTRASUNNY', 'CLOUDS'},  -- clear
    [2] = {'CLEARING', 'RAIN', 'NEUTRAL', 'THUNDER'},    -- rain
    [3] = {'SMOG', 'FOGGY'},                             -- foggy
    [4] = {'SNOWLIGHT', 'SNOW', 'BLIZZARD', 'XMAS'},     -- snow
}