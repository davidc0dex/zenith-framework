RegisterNetEvent("core:spawnPlayer", function(coords)
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Citizen.Wait(0) end

    local model = GetHashKey('mp_m_freemode_01')
    local player = PlayerId()

    if IsModelInCdimage(model) and IsModelValid(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do Citizen.Wait(10) end
        SetPlayerModel(player, model)
        SetModelAsNoLongerNeeded(model)
    end

    Citizen.Wait(100)
    local ped = PlayerPedId()

    local spawnX = coords.x or coords[1]
    local spawnY = coords.y or coords[2]
    local spawnZ = coords.z or coords[3]
    local heading = coords.heading or 180.0

    RequestCollisionAtCoord(spawnX, spawnY, spawnZ)
    SetEntityCoords(ped, spawnX, spawnY, spawnZ, false, false, false, true)
    SetEntityHeading(ped, heading)
    
    local timeOut = 0
    while not HasCollisionLoadedAroundEntity(ped) and timeOut < 2000 do
        Citizen.Wait(10)
        timeOut = timeOut + 10
    end

    local dbHealth = coords.health or 100
    local dbArmor = coords.armor or 0

    local maxHealth = GetEntityMaxHealth(ped)
    local targetHealth = 100 + math.floor((dbHealth / 100) * (maxHealth - 100))

    SetEntityHealth(ped, targetHealth)
    SetPedArmour(ped, math.floor(dbArmor))

    ClearPedBloodDamage(ped)
    FreezeEntityPosition(ped, false)

    SetPedHeadBlendData(ped, 0, 0, 0, 15, 0, 0, 0, 1.0, 0, false)
    SetPedComponentVariation(ped, 11, 0, 11, 0)
    SetPedComponentVariation(ped, 8, 15, 0, 0)
    SetPedComponentVariation(ped, 6, 1, 2, 0)
    SetPedHeadOverlayColor(ped, 1, 1, 0, 0)
    SetPedHeadOverlayColor(ped, 2, 1, 0, 0)
    SetPedHeadOverlayColor(ped, 4, 2, 0, 0)
    SetPedHeadOverlayColor(ped, 5, 2, 0, 0)
    SetPedHeadOverlayColor(ped, 8, 2, 0, 0)
    SetPedHeadOverlayColor(ped, 10, 1, 0, 0)
    SetPedHeadOverlay(ped, 1, 0, 0.0)
    SetPedHairColor(ped, 1, 1)
    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()
    DoScreenFadeIn(1000)
    Wait(1000)
    TriggerServerEvent("hud:requestStatus")
    TriggerEvent("core:notify", "success", "Bine ai venit pe server! Daca ai intrebari, nu ezita sa ne contactezi folosind comanda /calladmin.", 5000)
end)

CreateThread(function()
    Citizen.Wait(1500) 
    TriggerServerEvent("core:requestSpawnData")
end)

CreateThread(function()
    while true do
        SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
        SetPlayerHealthRechargeLimit(PlayerId(), 0.5)
        Wait(1000)
    end
end)