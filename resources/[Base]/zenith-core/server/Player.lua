function Core.GetUserIdentifiers(source)
    local identifiers = GetPlayerIdentifiers(source)
    local tokens = GetPlayerTokens(source)
    local data = { license = nil, discord = nil, ip = nil, tokens = {} }

    for _, v in pairs(identifiers) do
        if string.find(v, 'license:') then 
            data.license = string.match(v, "license:(.+)")
        elseif string.find(v, 'discord:') then 
            data.discord = string.match(v, "discord:(.+)")
        elseif string.find(v, 'ip:') then 
            data.ip = string.match(v, "ip:(.+)")
        end
    end

    for i, token in ipairs(tokens) do data.tokens[i] = token end
    return data
end

function Core.GetWhitelistState() return ServerInfo.Whitelist end

function Core.GetUserId(source)
    local identifiers = Core.GetUserIdentifiers(source)
    if Core.Users[identifiers.license] then
        return Core.Users[identifiers.license].id
    end
    return nil
end

function Core.GetUserById(id)
    for license, data in pairs(Core.Users) do
        if data.id == id then
            return data
        end
    end
    return nil
end

function Core.GetUserBySource(source)
    for license, user in pairs(Core.Users) do
        if tonumber(user.source) == tonumber(source) then
            return user
        end
    end
    return nil
end

function Core.CreateUser(source, identifiers, callback)
    local user = {
        source = source,
        license = identifiers.license,
        discord = identifiers.discord,
        ip = identifiers.ip,
        tokens = identifiers.tokens,
        position = { 
            x = PlayerData.Respawn.coords.x, 
            y = PlayerData.Respawn.coords.y, 
            z = PlayerData.Respawn.coords.z, 
            heading = PlayerData.Respawn.heading 
        },
        health = PlayerData.Survival.health,
        armor = PlayerData.Survival.armor,
        hunger = PlayerData.Survival.hunger,
        thirst = PlayerData.Survival.thirst,
        cash = PlayerData.Money.cash,
        bank = PlayerData.Money.bank,
    }

    exports["oxmysql"]:insert("INSERT INTO users (license, discord, ip, cash, bank, health, armor, hunger, thirst, position) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", 
    { user.license, user.discord, user.ip, user.cash, user.bank, user.health, user.armor, user.hunger, user.thirst, json.encode(user.position) }, function(insertId)
        if insertId then
            user.id = insertId
            Core.Users[user.license] = user
            if callback then callback(true) end
        else
            if callback then callback(false) end
        end
    end)
end

function Core.PlayerConnecting(playerName, kick, deferrals)
    local source = source
    local identifiers = Core.GetUserIdentifiers(source)

    deferrals.defer()
    Citizen.Wait(50)
    deferrals.update("Se verifica datele de conectare...")
    
    if #GetPlayers() >= GetConvarInt("sv_maxclients", 32) then return deferrals.done("Serverul este plin!") end
    if not identifiers.license then return deferrals.done("Licenta nu a fost gasita!") end
    if not identifiers.discord then return deferrals.done("Trebuie sa ai Discord-ul deschis!") end
    deferrals.update("Se incarcă profilul tau...")

    exports["oxmysql"]:query("SELECT * FROM users WHERE license = ?", { identifiers.license }, function(result)
        if not result or #result == 0 then
            Core.CreateUser(source, identifiers, function(success)
                if success then
                    deferrals.done()
                else
                    deferrals.done("Eroare critică la generarea ID-ului tău în baza de date.")
                end
            end)
        else
            local dbData = result[1]
            local userPosition = { 
                x = PlayerData.Respawn.coords.x, 
                y = PlayerData.Respawn.coords.y, 
                z = PlayerData.Respawn.coords.z, 
                heading = PlayerData.Respawn.heading 
            }
            
            if dbData.position and dbData.position ~= "" then
                userPosition = json.decode(dbData.position)
            end

            local user = {
                id = dbData.id,
                source = source,
                license = dbData.license,
                discord = dbData.discord,
                ip = identifiers.ip,
                tokens = identifiers.tokens,
                position = userPosition,
                health = dbData.health,
                armor = dbData.armor,
                hunger = dbData.hunger ~= nil and dbData.hunger or PlayerData.Survival.hunger,
                thirst = dbData.thirst ~= nil and dbData.thirst or PlayerData.Survival.thirst,
                cash = dbData.cash,
                bank = dbData.bank
            }

            Core.Users[identifiers.license] = user
            deferrals.done()
        end
    end)
end

AddEventHandler("playerConnecting", Core.PlayerConnecting)

AddEventHandler("playerJoining", function(source)
    local identifiers = Core.GetUserIdentifiers(source)
    if Core.Users[identifiers.license] then
        Core.Users[identifiers.license].source = source
    end
end)

RegisterNetEvent("core:requestSpawnData", function()
    local source = source
    local identifiers = Core.GetUserIdentifiers(source)

    local user = {}

    local result = exports["oxmysql"]:query_async("SELECT * FROM users WHERE license = ?", { identifiers.license })
    
    if result and result[1] then
        local dbData = result[1]
        local userPosition = {
            x = PlayerData.Respawn.coords.x,
            y = PlayerData.Respawn.coords.y,
            z = PlayerData.Respawn.coords.z,
            heading = PlayerData.Respawn.heading
        }
        
        if dbData.position and dbData.position ~= "" then
            userPosition = json.decode(dbData.position)
        end

        user = {
            id = dbData.id,
            source = source,
            license = dbData.license,
            discord = dbData.discord,
            ip = identifiers.ip,
            tokens = identifiers.tokens,
            position = userPosition,
            health = dbData.health,
            armor = dbData.armor,
            hunger = dbData.hunger ~= nil and dbData.hunger or PlayerData.Survival.hunger,
            thirst = dbData.thirst ~= nil and dbData.thirst or PlayerData.Survival.thirst,
            cash = dbData.cash,
            bank = dbData.bank
        }
        
        spawnData = {
            x = user.position.x,
            y = user.position.y,
            z = user.position.z,
            heading = user.position.heading,
            health = user.health,
            armor = user.armor
            -- character appereance data
        }

        TriggerClientEvent("core:spawnPlayer", source, spawnData)
    
        TriggerClientEvent("hud:updateData", source, {
            uID = user.id,
            onlinePlayers = #GetPlayers(),
            cashMoney = user.cash,
            bankMoney = user.bank,
            minusMoney = 0,
            plusMoney = 0
        })
        
        TriggerClientEvent("hud:statusUpdate", source, {
            health = user.health,
            armor = user.armor,
            hunger = user.hunger,
            thirst = user.thirst,
            stamina = 100
        })
    
        Core.Users[identifiers.license] = user
    end
end)

AddEventHandler("playerDropped", function()
    local player = source
    local dbId = Core.GetUserId(player)
    local ped = GetPlayerPed(player)
    local pos = GetEntityCoords(ped)

    if not pos or (math.abs(pos.x) < 1.0 and math.abs(pos.y) < 1.0) then return end

    local health = GetEntityMaxHealth(ped) > 100 and math.max(0, math.min(100, math.floor(((GetEntityHealth(ped) - 100) / (GetEntityMaxHealth(ped) - 100)) * 100))) or 100
    local armor = math.floor(GetPedArmour(ped))

    local identifiers = Core.GetUserIdentifiers(player)
    local user = Core.Users[identifiers.license]
    local hunger = user and user.hunger or PlayerData.Survival.hunger
    local thirst = user and user.thirst or PlayerData.Survival.thirst

    exports["oxmysql"]:execute("UPDATE users SET position = ?, health = ?, armor = ?, hunger = ?, thirst = ? WHERE id = ?", { 
        json.encode({ x = pos.x, y = pos.y, z = pos.z, heading = GetEntityHeading(ped) }), 
        health, 
        armor,
        hunger,
        thirst,
        dbId 
    })
    exports["oxmysql"]:execute("UPDATE users SET position = ?, health = ?, armor = ? WHERE id = ?", { 
        json.encode({ x = pos.x, y = pos.y, z = pos.z, heading = GetEntityHeading(ped) }), 
        health, 
        armor, 
        dbId 
    })
    
    local identifiers = Core.GetUserIdentifiers(player)
    if identifiers.license then Core.Users[identifiers.license] = nil end
end)
