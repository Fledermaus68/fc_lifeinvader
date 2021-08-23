ESX = nil
local webHookUrl = "https://discord.com/api/webhooks/879167564033445928/ncbt6MyP-G2QV6k0P6sADcvj6rzDF3B3urf3ealCW82_sxmr0ThKVKly0CrXKGpfE3gn"

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("fc_lifeinvader:canBuy", function(source, cb, message)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        if xPlayer.getMoney() >= 500 then
            xPlayer.removeMoney(500)

            local steamName = GetPlayerIdentifier(xPlayer.source, 0)
            local currentLocalTime = os.time(os.date('*t'))

            sendToDiscord("<:fc:879171012988665866> Der Spieler **" .. xPlayer.name .. "** (" .. steamName .. ") hat gerade eine **Lifeinvader Nachricht** versendet!\n \n **Inhalt der Nachricht:** " .. message)

            local xPlayers = ESX.GetPlayers()

            for i=1, #xPlayers, 1 do
                local xTarget = ESX.GetPlayerFromId(xPlayers[i])
                TriggerClientEvent("fc_lifeinvader:announceMessage", xTarget.source, message)
            end
        cb(true)
        else
            -- Er kann es sich nicht leisten!
            xPlayer.showNotification("~r~Du kannst es dir nicht leisten, eine Nachricht abzusenden!")
            cb(false)
        end
    end
end)

function sendToDiscord(msg)
    PerformHttpRequest(webHookUrl, function(a,b,c)end, "POST", json.encode({embeds={{title="FiveCity - Lifeinvader", description=msg,color=1411549}}}), {["Content-Type"]="application/json"})
end