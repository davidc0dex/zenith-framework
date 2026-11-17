local function __callback(cbName, _cb, ...)
    TriggerServerEvent("core:s_callback:" .. cbName, ...)
    return RegisterNetEvent("core:s_callback:" .. cbName, function(...)
        _cb(...)
    end)
end

function triggerCallback(cbName, cb, ...)
    local ev = false
    local f = function(...)
        if ev ~= false then
            RemoveEventHandler(ev)
        end
        if cb then cb(...) end
    end
    ev = __callback(cbName, f, ...)
    return ev
end

function registerClientCallback(cbName, cb)
    RegisterNetEvent("core:c_callback:" .. cbName)
    AddEventHandler("core:c_callback:" .. cbName, function(requestId, ...)
        if cb then
            local result = table.pack(cb(...))
            TriggerServerEvent("core:c_callback_result", cbName, requestId, table.unpack(result))
        end
    end)
end

RegisterNetEvent('client:copyClipboard', function(text)
    SendNUIMessage({
        action = 'copyClipboard';
        text = text;
    });
end)
RegisterCommand('coords', function()
    local coords = GetEntityCoords(PlayerPedId());
    TriggerEvent('client:copyClipboard', coords.x .. ',' .. coords.y .. ',' .. coords.z .. ',' .. GetEntityHeading(PlayerPedId()));
end, false)

local isRadarEnabled = false

CreateThread(function()
    DisplayRadar(false) 
    while true do
        local sleep = 500
        local ped = PlayerPedId()
        if DoesEntityExist(ped) then
            local inVehicle = IsPedInAnyVehicle(ped, false)
            if inVehicle ~= isRadarEnabled then
                isRadarEnabled = inVehicle
                DisplayRadar(isRadarEnabled)
                SendNUIMessage({ interface = "map", action = "displayRadar", show = isRadarEnabled })
            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('__cfx_internal:serverPrint', function(console)
    print(console)
end);