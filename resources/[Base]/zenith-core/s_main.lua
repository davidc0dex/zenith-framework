Core = {
    Users = { },
    Functions = { }
}

function registerCallback(cbName, cb)
    RegisterServerEvent("core:s_callback:" .. cbName, function(...)
        local player = source
        if cb then
            local result = table.pack(cb(player, ...))
            TriggerClientEvent("core:s_callback:" .. cbName, player, table.unpack(result))
        end
    end)
end

local __clientCallbackHandlers = {}

RegisterServerEvent("core:c_callback_result")
AddEventHandler("core:c_callback_result", function(cbName, requestId, ...)
    local player = source
    local key = cbName .. ":" .. tostring(player) .. ":" .. requestId

    if __clientCallbackHandlers[key] then
        __clientCallbackHandlers[key](...)
        __clientCallbackHandlers[key] = nil
    end
end)

function triggerClientCallback(player, cbName, cb, ...)
    local requestId = tostring(GetGameTimer()) .. tostring(math.random(1, 999999))
    local key = cbName .. ":" .. tostring(player) .. ":" .. requestId

    __clientCallbackHandlers[key] = cb

    TriggerClientEvent("core:c_callback:" .. cbName, player, requestId, ...)
end
