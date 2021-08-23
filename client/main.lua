local menuShown = false
ESX = nil
local PlayerData = {}
local location = vector3(-1081.97, -248.48, 37.76)
local inMarker = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

RegisterNUICallback("close", function()
    toggleUI(false)
end)

RegisterNUICallback("empty", function()
    ESX.ShowNotification("Deine ~r~Nachricht ~w~darf nicht ~r~leer ~w~sein!")
end)

RegisterNUICallback("send", function(data, cb)
    ESX.TriggerServerCallback("fc_lifeinvader:canBuy", function(canBuy)
        if canBuy then
            ESX.ShowNotification("Dein ~g~Kauf~w~ wurde getätigt.")
        end
    end, data.message)
    cb("ok")
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1.0)

        local distance = GetDistanceBetweenCoords(location, GetEntityCoords(PlayerPedId()))

        if distance < 5 then
            DrawMarker(27, location, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 227, 199, 16, 100, false, true, 2,
                true, false, false, false)
        end

        if distance < 2 then
            ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um auf ~r~Lifeinvader ~w~zuzugreifen!")
            inMarker = true
        else
            inMarker = false
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1.0)

        if inMarker and IsControlJustPressed(1, 51) then
            toggleUI(true)
        end
    end
end)

function toggleUI(shown)
    SetNuiFocus(shown, shown)

    menuShown = shown

    if shown then
        SendNUIMessage({
            action = "open"
        })
    else
        SendNUIMessage({
            action = "close"
        })
    end
end

RegisterNetEvent("fc_lifeinvader:announceMessage")
AddEventHandler("fc_lifeinvader:announceMessage", function(message)
    ESX.ShowAdvancedNotification('Lifeinvader', 'Benachrichtigung', message, "CHAR_LIFEINVADER", 1)
end)
