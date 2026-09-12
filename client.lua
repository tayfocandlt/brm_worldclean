local resourceName = GetCurrentResourceName()
local sceneStartedHere = false
local warnedSceneFailure = false
local refreshInterval = math.max(1000, tonumber(Config.RefreshIntervalMs) or 5000)

local function applyPopulationSettings()
    if not Config.DisablePopulation then return end

    SetCreateRandomCops(false)
    SetCreateRandomCopsNotOnScenarios(false)
    SetCreateRandomCopsOnScenarios(false)
    SetGarbageTrucks(false)
    SetDistantCarsEnabled(false)

    if Config.DisableRandomBoats then
        SetRandomBoats(false)
    end

    if Config.DisableRandomTrains then
        SetRandomTrains(false)
    end

    if Config.DisableMapVehicleGenerators then
        local area = Config.GeneratorBounds
        SetAllLowPriorityVehicleGeneratorsActive(false)
        SetAllVehicleGeneratorsActiveInArea(
            area.minX, area.minY, area.minZ,
            area.maxX, area.maxY, area.maxZ,
            false, true
        )
    end

    for _, scenario in ipairs(Config.DisabledScenarioTypes) do
        SetScenarioTypeEnabled(scenario, false)
    end

    for _, group in ipairs(Config.DisabledScenarioGroups) do
        SetScenarioGroupEnabled(group, false)
    end
end

local function applyDispatchSettings()
    if Config.DisableDispatch then
        for service = 1, 15 do
            EnableDispatchService(service, false)
        end
        SetDispatchCopsForPlayer(PlayerId(), false)
    end

    if Config.DisableWantedLevel then
        SetMaxWantedLevel(0)
        ClearPlayerWantedLevel(PlayerId())
    end
end

local function applyAudioSettings()
    if not Config.DisableAmbientAudio then return end

    SetAudioFlag('DisableFlightMusic', true)
    SetAudioFlag('PoliceScannerDisabled', true)
    DistantCopCarSirens(false)

    local scene = Config.AmbientAudioScene
    if scene ~= '' and not IsAudioSceneActive(scene) then
        if StartAudioScene(scene) then
            sceneStartedHere = true
        elseif not warnedSceneFailure then
            warnedSceneFailure = true
            print(('[%s] GTA ambiyans ses sahnesi baslatilamadi; KURULUM_TR.txt dosyasina bakin.'):format(resourceName))
        end
    end

    for _, emitter in ipairs(Config.DisabledStaticEmitters) do
        SetStaticEmitterEnabled(emitter, false)
    end
end

AddEventHandler('populationPedCreating', function()
    if Config.DisablePopulation then
        CancelEvent()
    end
end)

if Config.DisablePopulation then
    CreateThread(function()
        while true do
            SetPedDensityMultiplierThisFrame(0.0)
            SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
            SetVehicleDensityMultiplierThisFrame(0.0)
            SetRandomVehicleDensityMultiplierThisFrame(0.0)
            SetParkedVehicleDensityMultiplierThisFrame(0.0)
            Wait(0)
        end
    end)
end

CreateThread(function()
    while true do
        applyPopulationSettings()
        applyDispatchSettings()
        applyAudioSettings()
        Wait(refreshInterval)
    end
end)

AddEventHandler('onClientResourceStop', function(stoppedResource)
    if stoppedResource ~= resourceName then return end

    local scene = Config.AmbientAudioScene
    if sceneStartedHere and scene ~= '' and IsAudioSceneActive(scene) then
        StopAudioScene(scene)
    end
end)

RegisterCommand('bwc_status', function()
    local scene = Config.AmbientAudioScene
    local sceneActive = scene ~= '' and IsAudioSceneActive(scene) or false
    print(('[%s] v1.0.0 | population_off=%s dispatch_off=%s wanted_off=%s audio_off=%s scene_active=%s'):format(
        resourceName,
        tostring(Config.DisablePopulation),
        tostring(Config.DisableDispatch),
        tostring(Config.DisableWantedLevel),
        tostring(Config.DisableAmbientAudio),
        tostring(sceneActive)
    ))
    print(('[%s] Bu sonuc yerel ayarlari gosterir; OneSync ve qb-smallresources ayarlarini KURULUM_TR.txt ile kontrol edin.'):format(resourceName))
end, false)
