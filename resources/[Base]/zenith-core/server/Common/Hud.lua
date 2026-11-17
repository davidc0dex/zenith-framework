local onlinePlayers = 0

AddEventHandler("playerJoining", function()
    onlinePlayers = #GetPlayers()
    TriggerClientEvent("hud:updateData", -1, { onlinePlayers = onlinePlayers })
end)

AddEventHandler("playerDropped", function()
    onlinePlayers = #GetPlayers()
    TriggerClientEvent("hud:updateData", -1, { onlinePlayers = onlinePlayers })
end)

RegisterNetEvent("hud:requestStatus", function()
    local source = source
    local user = Core.GetUserBySource(source)
    if not user then return end
    TriggerClientEvent("hud:statusUpdate", source, {
        hunger = user.hunger ~= nil and user.hunger or PlayerData.Survival.hunger,
        thirst = user.thirst ~= nil and user.thirst or PlayerData.Survival.thirst,
    })
end)
