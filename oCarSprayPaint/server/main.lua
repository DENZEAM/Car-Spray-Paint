

-- Fonction de traduction
function _U(entry)
    local locale = ConfigDBP.Locale
    if Locales[locale] and Locales[locale][entry] then
        return Locales[locale][entry]
    else
        return 'Translation [' .. locale .. '][' .. entry .. '] does not exist'
    end
end

ESX.RegisterUsableItem('paint_spray', function(source)
    TriggerClientEvent('startMenu', source)
end)

RegisterServerEvent("DEN:RemoveItem")
AddEventHandler("DEN:RemoveItem", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getInventoryItem('paint_spray').count >= 1 then
        xPlayer.removeInventoryItem('paint_spray', 1)
        xPlayer.showNotification(_U('used_spray'))
        PeintureLogs(_U('log_title_use'), "Player " .. xPlayer.name .. " **(" .. xPlayer.identifier .. ")** " .. _U('log_used_spray'), ConfigDBP.Webhook.UsePeinture, 16711680)
    else
        xPlayer.showNotification(_U('no_spray'))
        PeintureLogs(_U('log_title_cheat'), "Player " .. xPlayer.name .. " **(" .. xPlayer.identifier .. ")** " .. _U('log_tried_cheat'), ConfigDBP.Webhook.Anticheat, 16711680)
        DropPlayer(src, "Car Spray Paint - Cheat Trigger")
    end
end)

PeintureLogs = function(title, message, webhook, color)
    local content = {
        {
            ["color"] = color,
            ["title"] = title,
            ["description"] = message,
            ["footer"] = {["text"] = os.date("%Y/%m/%d %H:%M:%S")},
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Car Spray Paint", embeds = content}), { ['Content-Type'] = 'application/json' })
end
