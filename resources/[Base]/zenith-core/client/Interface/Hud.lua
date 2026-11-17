local hudData = {}
local lastHealth = -1
local lastArmor = -1
local lastStamina = -1
local lastHunger = 100
local lastThirst = 100

local function updateStatusUI()
    local playerPed = PlayerPedId()
    local rawHealth = GetEntityHealth(playerPed)
    local maxHealth = GetEntityMaxHealth(playerPed)
    local healthPercent = 0
    
    if maxHealth > 100 then healthPercent = math.floor(((rawHealth - 100) / (maxHealth - 100)) * 100) end
    if healthPercent < 0 then healthPercent = 0 end
    local armorPercent = math.floor(GetPedArmour(playerPed))

    if healthPercent ~= lastHealth or armorPercent ~= lastArmor then
        lastHealth = healthPercent
        lastArmor = armorPercent

        SendNUIMessage({
            type = "hudStatus",
            health = healthPercent,
            armor = armorPercent
        })
    end
end

AddEventHandler('gameEventTriggered', function(eventName, args)
    if eventName == 'CEventNetworkEntityDamage' then
        local victim = args[1]
        if victim == PlayerPedId() then
            updateStatusUI()
        end
    end
end)

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local staminaPercent = math.floor(100.0 - GetPlayerSprintStaminaRemaining(PlayerId()))
        if staminaPercent ~= lastStamina then
            lastStamina = staminaPercent
            SendNUIMessage({ type = "hudStamina", stamina = staminaPercent })
        end
        Wait(150)
    end
end)


RegisterNetEvent("hud:statusUpdate", function(statusData)
    if not statusData then return end
    if statusData.hunger ~= nil then lastHunger = statusData.hunger end
    if statusData.thirst ~= nil then lastThirst = statusData.thirst end

    SendNUIMessage({
        type = "hudStatus",
        hunger = lastHunger,
        thirst = lastThirst
    })
end)

RegisterNetEvent("hud:updateData", function(data)
    for k, v in pairs(data) do hudData[k] = v end
    SendNUIMessage({ type = "updateHud", hudData = hudData })
end)

RegisterNetEvent("core:notify", function(type, message, duration)
    SendNUIMessage({
        type = "notify",
        notifyType = type,
        message = message,
        duration = duration or 5000
    })
end)

-- MINIMAP

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    SetMinimapClipType(0)
    RequestStreamedTextureDict("squaremap", false)
    local timeout = 100
    while not HasStreamedTextureDictLoaded("squaremap") and timeout > 0 do
        timeout = timeout - 1
        Wait(50)
    end
    if HasStreamedTextureDictLoaded("squaremap") then
        AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "squaremap", "radarmasksm")
        AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "squaremap", "radarmasksm")
    end
    local right = 0.008
    local up = 0.010
    SetMinimapComponentPosition("minimap", "L", "B", 0.0000 + (right - 0.001), -0.000 - up, 0.1638, 0.195)
    SetMinimapComponentPosition("minimap_mask", "L", "B", -0.1795 + right, 0.060 - up, 0.1538, 0.175)
    SetMinimapComponentPosition("minimap_blur", "L", "B", -0.0125 + right, 0.070 - up, 0.262, 0.300)
    SetBlipAlpha(GetNorthRadarBlip(), 0)
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Citizen.Wait(0)
    SetRadarBigmapEnabled(false, false)

    Citizen.Wait(100)

    while true do
        local ped = PlayerPedId();
        if IsPedArmed(ped, 6) then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
        DisplayAmmoThisFrame(false)
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
        SetRadarBigmapEnabled(false, false)  
        SetPlayerWantedLevel(tempPlayer, 0, false)
        SetPlayerWantedLevelNow(tempPlayer, false)
        SetPlayerWantedLevelNoDrop(tempPlayer, 0, false)
        SetPlayerHealthRechargeMultiplier(tempPlayer, 0.0)
        SetPedCanLosePropsOnDamage(ped, false, 0)
        DisplayCash(false)
        SetRadarZoom(1100)
        Citizen.Wait(1000)
    end
end)
