function Core.Functions.SetMoney(source, type, amount)
    local user = Core.GetUserBySource(source)
    if not user then return end
    if type == "cash" then
        if(amount < 0) then user.cash = 0
            else user.cash = amount
        end
    elseif type == "bank" then
        user.bank = amount
    end

    TriggerClientEvent("hud:updateData", source, {
        cashMoney = user.cash,
        plusMoney = 0,
        minusMoney = 0
    })

    exports["oxmysql"]:update("UPDATE users SET cash = ?, bank = ? WHERE id = ?", { user.cash, user.bank, user.id })

end

function Core.Functions.AddMoney(source, type, amount)
    local user = Core.GetUserBySource(source)
    if not user then return end

    if type == "cash" then
        user.cash = user.cash + amount
    elseif type == "bank" then
        user.bank = user.bank + amount
    end

    TriggerClientEvent("hud:updateData", source, {
        cashMoney = user.cash,
        plusMoney = amount,
        minusMoney = 0
    })

    exports["oxmysql"]:update("UPDATE users SET cash = ?, bank = ? WHERE id = ?", { user.cash, user.bank, user.id })
end

function Core.Functions.RemoveMoney(source, type, amount)
    local user = Core.GetUserBySource(source)
    if not user then return end

    if type == "cash" then
        if(amount > user.cash) then user.cash = 0
            else user.cash = user.cash - amount
        end
    elseif type == "bank" then
        user.bank = user.bank - amount
    end

    TriggerClientEvent("hud:updateData", source, {
        cashMoney = user.cash,
        plusMoney = 0,
        minusMoney = amount
    })

    exports["oxmysql"]:update("UPDATE users SET cash = ?, bank = ? WHERE id = ?", { user.cash, user.bank, user.id })
end

RegisterCommand("addmoney", function(source, args)
    local amount = tonumber(args[1])
    if amount then
        Core.Functions.AddMoney(tonumber(source), "cash", amount)
    end
end)

RegisterCommand("removemoney", function(source, args)
    local amount = tonumber(args[1])
    if amount then
        Core.Functions.RemoveMoney(tonumber(source), "cash", amount)
    end
end)

RegisterCommand("setmoney", function(source, args)
    local amount = tonumber(args[1])
    if amount then
        Core.Functions.SetMoney(tonumber(source), "cash", amount)
    end
end)