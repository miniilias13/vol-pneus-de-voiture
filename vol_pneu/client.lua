client_scripts {
    'client.lua'
}
server_scripts {
    'server.lua'
}

-- Côté client : Gestion des animations et notifications
RegisterNetEvent('VolDePneu:DebutVol')
AddEventHandler('VolDePneu:DebutVol', function(duree)
    local ped = PlayerPedId()
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WELDING", 0, true)
    Citizen.Wait(duree)
    ClearPedTasksImmediately(ped)
end)

RegisterNetEvent('VolDePneu:NotificationProches')
AddEventHandler('VolDePneu:NotificationProches', function(player, coords, distance)
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    if #(pedCoords - coords) <= distance then
        TriggerEvent('chat:addMessage', { args = { "^3Alerte", "Quelqu'un est en train de voler les pneus d'une voiture près de vous !" } })
    end
end)
