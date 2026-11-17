mapBlips = {};

Citizen.CreateThread(function()
    for _, blipData in next, Blips do
        local blip = AddBlipForCoord(blipData.pos.x, blipData.pos.y, blipData.pos.z);
        SetBlipSprite(blip, blipData.blipId);
        SetBlipColour(blip, blipData.blipColor);
        SetBlipScale(blip, blipData.blipScale);
        SetBlipAsShortRange(blip, true);
        BeginTextCommandSetBlipName("STRING");
        AddTextComponentString(blipData.blipName);
        EndTextCommandSetBlipName(blip);
        table.insert(mapBlips, blip);
    end
end)