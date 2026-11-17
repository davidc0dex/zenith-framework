Citizen.CreateThread(function()
    local appId = ServerInfo.DiscordRichPresence.ApplicationId;
    local buttons = ServerInfo.DiscordRichPresence.Buttons;

    while true do
        SetDiscordAppId(appId);
        for indx, btnData in pairs(buttons) do SetDiscordRichPresenceAction(btnData.id, btnData.label, btnData.url); end

        SetDiscordRichPresenceAsset(ServerInfo.DiscordRichPresence.Asset);
        SetDiscordRichPresenceAssetText(ServerInfo.DiscordRichPresence.AssetText);

        SetRichPresence("Online: "..#GetActivePlayers().." din 128 jucatori");

        Citizen.Wait(30000);
    end
end)