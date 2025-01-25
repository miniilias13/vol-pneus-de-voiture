-- Configuration
local volDePneu = {
    tempsPourVoler = 10000,
    objetsNecessaires = "clé_décrou",
    recompense = "pneu_usé",
    notificationDistance = 20.0
}

local function VerifierObjet(player, objet)
    return true -- Modifier selon votre système d'inventaire
end

local function NotifierProches(player, coords, distance)
    TriggerClientEvent('VolDePneu:NotificationProches', -1, player, coords, distance)
end

local function NotifierPolice(coords)
    local policePlayers = GetPlayersWithJob("police")
    for _, policePlayer in ipairs(policePlayers) do
        TriggerClientEvent('chat:addMessage', policePlayer, { args = { "^1Alerte Police", "Un vol de pneus est en cours près de ces coordonnées : " .. coords.x .. ", " .. coords.y } })
    end
end

RegisterCommand("volerpneu", function(source)
    local player = source
    local ped = GetPlayerPed(player)
    local veh = GetVehiclePedIsIn(ped, false)

    if veh ~= 0 then
        TriggerClientEvent('chat:addMessage', player, { args = { "^1Erreur", "Sortez d'abord du véhicule pour voler un pneu." } })
        return
    end

    local vehCible = GetVehiclePedIsTryingToEnter(ped)
    if vehCible == 0 then
        TriggerClientEvent('chat:addMessage', player, { args = { "^1Erreur", "Aucune voiture ciblée pour voler un pneu." } })
        return
    end

    if VerifierObjet(player, volDePneu.objetsNecessaires) then
        TriggerClientEvent('chat:addMessage', player, { args = { "^2Info", "Début du vol des pneus..." } })

        TriggerClientEvent('VolDePneu:DebutVol', player, volDePneu.tempsPourVoler)
        Citizen.Wait(volDePneu.tempsPourVoler)

        TriggerClientEvent('chat:addMessage', player, { args = { "^2Succès", "Vous avez volé un pneu !" } })
        TriggerClientEvent('inventory:addItem', player, volDePneu.recompense, 1)

        local coords = GetEntityCoords(ped)
        NotifierProches(player, coords, volDePneu.notificationDistance)
        NotifierPolice(coords)
    else
        TriggerClientEvent('chat:addMessage', player, { args = { "^1Erreur", "Vous n'avez pas l'outil nécessaire pour voler un pneu." } })
    end
end, false)

function GetPlayersWithJob(jobName)
    local players = {}
    for _, playerId in ipairs(GetPlayers()) do
        local job = "police"
        if job == jobName then
            table.insert(players, playerId)
        end
    end
    return players
end
