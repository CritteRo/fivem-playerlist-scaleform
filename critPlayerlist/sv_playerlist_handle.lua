onlinePlayers = {}

function updatePlayers()
    local row = 0
    onlinePlayers = {}
    for _,player in ipairs(GetPlayers()) do
        onlinePlayers[row] = {name = GetPlayerName(player), id = player, crew = "", rightText = "", rank = "", showJP = false, txd = 'CHAR_BLANK_ENTRY'}
        row = row + 1
    end
end

AddEventHandler('critPlayerlist.UpdateClient', function()
    local src = source
    updatePlayers()
    TriggerClientEvent('critPlayerList:GetPlayers', -1, onlinePlayers)
end)

RegisterCommand('update', function(source, args)
    TriggerEvent('critPlayerlist.UpdateClient')
end)

RegisterNetEvent('playerJoining')
AddEventHandler('playerJoining', function(arg1)
    TriggerEvent('critPlayerlist.UpdateClient')
end)

AddEventHandler('playerDropped', function(source, reason)
    TriggerEvent('critPlayerlist.UpdateClient')
end)