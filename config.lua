-- Ucretli sistemi kırdık loo --

Config = {}
Config.DisablePopulation = true
Config.DisableDispatch = true
Config.DisableWantedLevel = true
Config.DisableAmbientAudio = true
Config.DisableRandomBoats = true
Config.DisableRandomTrains = true
Config.DisableMapVehicleGenerators = true
Config.RefreshIntervalMs = 5000
Config.GeneratorBounds = {
    minX = -10000.0, minY = -10000.0, minZ = -1000.0,
    maxX = 10000.0, maxY = 12000.0, maxZ = 3000.0
}
Config.DisabledScenarioTypes = {
    'WORLD_VEHICLE_MILITARY_PLANES_SMALL',
    'WORLD_VEHICLE_MILITARY_PLANES_BIG',
    'WORLD_VEHICLE_HELI_LIFEGUARD',
    'WORLD_VEHICLE_AMBULANCE',
    'WORLD_VEHICLE_FIRE_TRUCK',
    'WORLD_VEHICLE_POLICE_NEXT_TO_CAR',
    'WORLD_VEHICLE_POLICE_CAR',
    'WORLD_VEHICLE_POLICE_BIKE',
    'WORLD_VEHICLE_BOAT_IDLE',
    'WORLD_VEHICLE_BOAT_IDLE_ALAMO',
    'WORLD_VEHICLE_BOAT_IDLE_MARQUIS'
}
Config.DisabledScenarioGroups = {
    'LSA_Planes',
    'SANDY_PLANES',
    'GRAPESEED_PLANES',
    'ng_planes'
}
Config.AmbientAudioScene = 'CHARACTER_CHANGE_IN_SKY_SCENE'
Config.DisabledStaticEmitters = {
    'LOS_SANTOS_VANILLA_UNICORN_01_STAGE',
    'LOS_SANTOS_VANILLA_UNICORN_02_MAIN_ROOM',
    'LOS_SANTOS_VANILLA_UNICORN_03_BACK_ROOM'
}
