ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('bombe_de_peinture', function(source)
	TriggerClientEvent('startMenu', source)
end)

RegisterServerEvent("DEN:RemoveItem")
AddEventHandler("DEN:RemoveItem", function()
	local src = source
   	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer.getInventoryItem('bombe_de_peinture').count >= 1 then

   		xPlayer.removeInventoryItem('bombe_de_peinture', 1)
   		xPlayer.showNotification("~g~Vous avez utilisé une bombe de peinture")
		PeintureLogs("Bombe de peinture - Utilisation", "le joueur " ..xPlayer.name.." **("..xPlayer.identifier..")** a utilisé une bombe de peinture", ConfigWebhook.UsePeinture, 16711680)
	else
		xPlayer.showNotification("~r~Vous n'avez pas de bombe de peinture")
		PeintureLogs("Bombe de peinture - Suspicion de cheat", "le joueur " ..xPlayer.name.." **("..xPlayer.identifier..")** a tenté d'utiliser une bombe de peinture mais n'en avait pas", ConfigWebhook.Anticheat, 16711680)
		DropPlayer(src, "Car Spary Paint - Cheat Trigger")
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

  	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end